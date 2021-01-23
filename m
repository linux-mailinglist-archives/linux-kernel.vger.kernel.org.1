Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7614301535
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 13:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbhAWMdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 07:33:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:41748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbhAWMdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 07:33:36 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9591222BE8;
        Sat, 23 Jan 2021 12:32:55 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l3I61-009bUV-Lv; Sat, 23 Jan 2021 12:32:53 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sat, 23 Jan 2021 12:32:53 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eric.auger@redhat.com, tglx@linutronix.de, linuxarm@openeuler.org,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>
Subject: Re: [PATCH] genirq/msi: Make sure early activation of all PCI MSIs
In-Reply-To: <c084871426cb4c9b9e0fe0684ca4c276@huawei.com>
References: <20210121110247.20320-1-shameerali.kolothum.thodi@huawei.com>
 <87o8hij83d.wl-maz@kernel.org> <c084871426cb4c9b9e0fe0684ca4c276@huawei.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <f1aceff55b3580194b41b812ba7ffb76@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: shameerali.kolothum.thodi@huawei.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, eric.auger@redhat.com, tglx@linutronix.de, linuxarm@openeuler.org, prime.zeng@hisilicon.com, wangzhou1@hisilicon.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shameer,

On 2021-01-22 09:21, Shameerali Kolothum Thodi wrote:
> Hi Marc,
> 

[...]

>> I find this pretty complicated, and the I'd like to avoid injecting 
>> the PCI
>> MSI-vs-MSI-X concept in something that is supposed to be bus-agnostic.
> 
> Agree. That’s mainly because I was very skeptical(TBH, very limited in
> my knowledge
> on this msi core code) about changing the MSI-X activation logic here
> and just thought
> of limiting the impact to MSI case as a first attempt.
> 
>> What's wrong with the following (untested) patch, which looks much 
>> simpler?
> 
> Yes, had tried this as one of the early fix, but as said above was not
> very sure of
> the impact on other platforms. Tested this again and it works.
> 
> Please send it.

Actually, there is a better way, which is to have a proper iterator on
vectors instead of descriptors. With that and a bit of cleanup, the
patch[1] looks pretty neat.

Please give it a go.

Thanks,

         M.

[1] https://lore.kernel.org/r/20210123122759.1781359-1-maz@kernel.org
-- 
Jazz is not dead. It just smells funny...
