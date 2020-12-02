Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A582CBCE8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbgLBMX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:23:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:52294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgLBMXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:23:55 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B2C6221FE;
        Wed,  2 Dec 2020 12:23:14 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kkRA8-00FKbJ-2J; Wed, 02 Dec 2020 12:23:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 02 Dec 2020 12:23:11 +0000
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
Subject: Re: [PATCH v2 0/3] Fix several bugs in KVM stage 2 translation
In-Reply-To: <74540986-6197-34bc-cd53-850472091ee3@huawei.com>
References: <20201201201034.116760-1-wangyanan55@huawei.com>
 <20201201205948.GA28178@willie-the-truck>
 <74540986-6197-34bc-cd53-850472091ee3@huawei.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <616980dcddd5c7e832c1068f6fa91449@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: wangyanan55@huawei.com, will@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, gshan@redhat.com, qperret@google.com, wanghaibin.wang@huawei.com, yezengruan@huawei.com, zhukeqian1@huawei.com, yuzenghui@huawei.com, jiangkunkun@huawei.com, wangjingyi11@huawei.com, lushenming@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yanan,

[...]

> BTW: there are two more things below that I want to talk about.
> 
> 1.  Recently, I have been focusing on the ARMv8.4-TTRem feature which
> is aimed at changing block size in stage 2 mapping.
> 
> I have a plan to implement this feature for stage 2 translation when
> splitting a block into tables or merging tables into a block.
> 
> This feature supports changing block size without performing
> *break-before-make*, which might have some improvement on performance.
> 
> What do you think about this?

It would be interesting if you can demonstrate some significant
performance improvements compared to the same workload with BBM.

I'm not completely convinced this would change much, given that
it is only when moving from a table to a block mapping that you
can elide BBM when the support level is 1 or 2. As far as I can
tell, this only happens in the "stop logging" case.

Is that something that happens often enough to justify the added
complexity? Having to handle TLB Conflict Abort is annoying, for
example.

> 2. Given that the issues we discussed before were found in practice
> when guest state changes from dirty logging to dirty logging canceled.
> 
> I could add a test file testing on this case to selftests/ or kvm unit
> tests/, if it's necessary.

That would be awesome, and I'd be very grateful if you did. It is the
second time we break this exact case, and having a reliable way to
verify it would definitely help.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
