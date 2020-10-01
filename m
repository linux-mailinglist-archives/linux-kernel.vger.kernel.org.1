Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243D227FF96
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 14:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732084AbgJAM45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 08:56:57 -0400
Received: from foss.arm.com ([217.140.110.172]:33456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731952AbgJAM44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 08:56:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CF3730E;
        Thu,  1 Oct 2020 05:56:56 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 009C13F6CF;
        Thu,  1 Oct 2020 05:56:54 -0700 (PDT)
Subject: Re: [PATCH -next] drm/panfrost: simplify the return expression of
 panfrost_devfreq_target()
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Qinglang Miao <miaoqinglang@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200921131021.91604-1-miaoqinglang@huawei.com>
 <8ae8a758-23ee-a413-5b25-b7beb8f4e254@arm.com>
 <CAKMK7uHQe3PBnNinaGn37s+Cgko1taKcCT3=Yy1uw63pRurOhw@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <8a73b5f0-a41e-d788-d422-45e360325d95@arm.com>
Date:   Thu, 1 Oct 2020 13:56:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uHQe3PBnNinaGn37s+Cgko1taKcCT3=Yy1uw63pRurOhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2020 12:25, Daniel Vetter wrote:
> On Thu, Oct 1, 2020 at 12:58 PM Steven Price <steven.price@arm.com> wrote:
>>
>> On 21/09/2020 14:10, Qinglang Miao wrote:
>>> Simplify the return expression.
>>>
>>> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
>>
>> Reviewed-by: Steven Price <steven.price@arm.com>
> 
> As committer/maintainer for this please indicate whether you'll merge
> this or not, with just an r-b patches are in an awkward limbo state.
> Since Qinglang isn't committer you probably want to merge their
> patches, for otherwise they get lost.
> -Daniel

Sorry, I should have said - I'll push this (and the other similar patch 
[1]) to drm-misc-next.

Steve

[1] 
https://lore.kernel.org/r/20200921131019.91558-1-miaoqinglang@huawei.com/
