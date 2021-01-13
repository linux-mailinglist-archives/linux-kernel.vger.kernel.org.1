Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1DF2F4F24
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 16:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbhAMPr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 10:47:26 -0500
Received: from foss.arm.com ([217.140.110.172]:38358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbhAMPrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 10:47:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 260351FB;
        Wed, 13 Jan 2021 07:46:40 -0800 (PST)
Received: from [10.57.10.37] (unknown [10.57.10.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FB0B3F66E;
        Wed, 13 Jan 2021 07:46:38 -0800 (PST)
Subject: Re: [PATCH] drm/panfrost: Use delayed timer as default in devfreq
 profile
To:     Steven Price <steven.price@arm.com>
Cc:     linux-kernel@vger.kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, robh@kernel.org,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com
References: <20210105164111.30122-1-lukasz.luba@arm.com>
 <5a52797c-eb03-3dcc-932f-14a08828799e@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <66a4f0ca-81d4-7d1c-6415-ce366faea070@arm.com>
Date:   Wed, 13 Jan 2021 15:46:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5a52797c-eb03-3dcc-932f-14a08828799e@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/21 3:35 PM, Steven Price wrote:
> On 05/01/2021 16:41, Lukasz Luba wrote:
>> Devfreq framework supports 2 modes for monitoring devices.
>> Use delayed timer as default instead of deferrable timer
>> in order to monitor the GPU status regardless of CPU idle.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> Looks reasonable to me.
> 
> Reviewed-by: Steven Price <steven.price@arm.com>
> 
> I'll apply to drm-misc-next.

Thank you Steven!

Regards,
Lukasz
