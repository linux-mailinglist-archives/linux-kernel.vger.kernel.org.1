Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E82529ED9F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbgJ2Nv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:51:27 -0400
Received: from foss.arm.com ([217.140.110.172]:37804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgJ2Nv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:51:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED001139F;
        Thu, 29 Oct 2020 06:51:25 -0700 (PDT)
Received: from [10.57.54.223] (unknown [10.57.54.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BDDC3F719;
        Thu, 29 Oct 2020 06:51:24 -0700 (PDT)
Subject: Re: [PATCH] iommu/rockchip: check return value of
 of_find_device_by_node() in rk_iommu_of_xlate()
To:     "yukuai (C)" <yukuai3@huawei.com>, joro@8bytes.org,
        heiko@sntech.de, jeffy.chen@rock-chips.com
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20201029092202.900218-1-yukuai3@huawei.com>
 <98dec09e-08a1-6550-fa4e-85a8104b90e1@arm.com>
 <35ff5111-1270-fc88-788c-4fb9e38faa85@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d5442e6b-2a6b-a8f9-2056-2c0c81e88a01@arm.com>
Date:   Thu, 29 Oct 2020 13:51:23 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <35ff5111-1270-fc88-788c-4fb9e38faa85@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-29 13:19, yukuai (C) wrote:
> 
> On 2020/10/29 18:08, Robin Murphy wrote:
>> On 2020-10-29 09:22, Yu Kuai wrote:
>>> If of_find_device_by_node() failed in rk_iommu_of_xlate(), null pointer
>>> dereference will be triggered. Thus return error code if
>>> of_find_device_by_node() failed.
>>
>> How can that happen? (Given that ".suppress_bind_attrs = true")
>>
>> Robin.
> 
> I'm not sure if that could happen...
> 
> My thought is that it's better to do such checking to aviod any possible
> problem.

->of_xlate() is only invoked on the specific set of ops returned by 
iommu_ops_from_fwnode(). In turn, iommu_ops_from_fwnode() will only 
return those ops if the driver has successfully probed and called 
iommu_register_device() with the relevant DT node. For the driver to 
have been able to probe at all, a platform device associated with that 
DT node must have been created, and therefore of_find_device_by_node() 
cannot fail.

If there ever were some problem serious enough to break that fundamental 
assumption, then I *want* these drivers to crash right here, with a nice 
clear stack trace to start debugging from. So no, I firmly disagree that 
adding redundant code, which will never do anything except attempt to 
paper over catastrophic memory corruption, is "better". Sorry :)

Robin.
