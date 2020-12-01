Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF26C2CA5CC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbgLAOfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:35:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbgLAOfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:35:45 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE00520758;
        Tue,  1 Dec 2020 14:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606833304;
        bh=ZU8wNgvKrhnfSOYGOGDVhvvPL5xVhi2ceBCrrCEpkn8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wQXK6/9ET6YsfgDUp8XRihFIu4QvGIJFhv9mQ6fBUBlwarTdbjL913Zqt8FFFNBqs
         tLosoDfzsZMBC+dN11c/+TbmeTbL+HYnHH4FsI9ZlDN9Qr3Vd8np9vzKCMMYZoaXTk
         gZ/GxwBLST5Jl5KjXJT/0beW7ncnN0qHvyuo18zo=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kk6kA-00F4Rb-Ar; Tue, 01 Dec 2020 14:35:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 01 Dec 2020 14:35:02 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     "wangyanan (Y)" <wangyanan55@huawei.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        Quentin Perret <qperret@google.com>,
        wanghaibin.wang@huawei.com, yezengruan@huawei.com,
        zhukeqian1@huawei.com, yuzenghui@huawei.com,
        jiangkunkun@huawei.com, wangjingyi11@huawei.com,
        lushenming@huawei.com
Subject: Re: [RFC PATCH 2/3] KVM: arm64: Fix handling of merging tables into a
 block entry
In-Reply-To: <2e92a511-496c-d446-95f4-6211ec8b4bb6@huawei.com>
References: <20201130121847.91808-1-wangyanan55@huawei.com>
 <20201130121847.91808-3-wangyanan55@huawei.com>
 <20201130133421.GB24837@willie-the-truck>
 <67e9e393-1836-eca7-4235-6f4a19fed652@huawei.com>
 <20201130160119.GA25051@willie-the-truck>
 <868a4403-10d3-80f3-4ae1-a490813c55e2@huawei.com>
 <20201201134606.GB26973@willie-the-truck>
 <2e92a511-496c-d446-95f4-6211ec8b4bb6@huawei.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <e9f00d1af54cf61c7469c7d905bff3e0@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: wangyanan55@huawei.com, will@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, gshan@redhat.com, qperret@google.com, wanghaibin.wang@huawei.com, yezengruan@huawei.com, zhukeqian1@huawei.com, yuzenghui@huawei.com, jiangkunkun@huawei.com, wangjingyi11@huawei.com, lushenming@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yanan,

On 2020-12-01 14:11, wangyanan (Y) wrote:
> On 2020/12/1 21:46, Will Deacon wrote:
>> On Tue, Dec 01, 2020 at 10:30:41AM +0800, wangyanan (Y) wrote:

[...]

>>> The point is at b.iii where the TLBI is not enough. There are many 
>>> page
>>> mappings that we need to merge into a block mapping.
>>> 
>>> We invalidate the TLB for the input address without level hint at 
>>> b.iii, but
>>> this operation just flush TLB for one page mapping, there
>>> 
>>> are still some TLB entries for the other page mappings in the cache, 
>>> the MMU
>>> hardware walker can still hit these entries next time.
>> Ah, yes, I see. Thanks. I hadn't considered the case where there are 
>> table
>> entries beneath the anchor. So how about the diff below?
>> 
>> Will
>> 
>> --->8
> 
> Hi, I think it's inappropriate to put the TLBI of all the leaf entries
> in function stage2_map_walk_table_post(),
> 
> because the *ptep must be an upper table entry when we enter
> stage2_map_walk_table_post().
> 
> We should make the TLBI for every leaf entry not table entry in the
> last lookup level,  just as I am proposing
> 
> to add the additional TLBI in function stage2_map_walk_leaf().

Could you make your concerns explicit? As far as I can tell, this should
address the bug you found, at least from a correctness perspective.

Are you worried about the impact of the full S2 invalidation? Or do you
see another correctness issue?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
