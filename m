Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665B826BF82
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgIPIjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgIPIjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:39:45 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09E592064E;
        Wed, 16 Sep 2020 08:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600245585;
        bh=1clANu14voIPCXXC3QG9ziaIGPjenTnl2O5fjKN0k3w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2nVMvOoP6lr/PkwoEKheM6mGttcimKexFXaBeZZDm22GHUGg4CM0/0yubQZeSkgA3
         xCEXtfgsPUdR8NpxEKBsJ4Vv7BBMLSdSr5cfBPSJzd+aJsFh3lo5/ptc9d8hkcnwsF
         RxMndthzhxq+TU2CWNNL2EcbaQ6hI0jPgyoHCNwE=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kISyd-00CIvQ-3e; Wed, 16 Sep 2020 09:39:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 16 Sep 2020 09:39:42 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     lushenming <lushenming@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org,
        "Wanghaibin (D)" <wanghaibin.wang@huawei.com>,
        yuzenghui <yuzenghui@huawei.com>
Subject: Re: [PATCH] irqchip/gic-v4.1: Optimize the delay time of the poll on
 the GICR_VPENDBASER.Dirty bit
In-Reply-To: <343E0E168479F04FACCB176989D12DE7EE3206@dggemi522-mbs.china.huawei.com>
References: <343E0E168479F04FACCB176989D12DE7EE1D2D@dggemi522-mbs.china.huawei.com>
 <a87d26bc52b25247dd23e5cb1cd56bad@kernel.org>
 <343E0E168479F04FACCB176989D12DE7EE3206@dggemi522-mbs.china.huawei.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <8c9f4731295af025302e084ba546b74b@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: lushenming@huawei.com, tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-16 08:04, lushenming wrote:
> Hi,
> 
> Our team just discussed this issue again and consulted our GIC hardware
> design team. They think the RD can afford busy waiting. So we still 
> think
> maybe 0 is better, at least for our hardware.
> 
> In addition, if not 0, as I said before, in our measurement, it takes 
> only
> hundreds of nanoseconds, or 1~2 microseconds, to finish parsing the VPT
> in most cases. So maybe 1 microseconds, or smaller, is more 
> appropriate.
> Anyway, 10 microseconds is too much.
> 
> But it has to be said that it does depend on the hardware 
> implementation.

Exactly. And given that the only publicly available implementation is
a software model, I am reluctant to change "performance" related things
based on benchmarks that can't be verified and appears to me as a micro
optimization.

> Besides, I'm not sure where are the start and end point of the total 
> scheduling
> latency of a vcpu you said, which includes many events. Is the parse 
> time of
> the VPT not clear enough?

Measure the time it takes from kvm_vcpu_load() to the point where the 
vcpu
enters the guest. How much, in proportion, do these 1/2/10ms represent?

Also, a better(?) course of action would maybe to consider whether we 
should
split the its_vpe_schedule() call into two distinct operations: one that
programs the VPE to be resident, and another that poll the Dirty bit 
*much
later* on the entry path, giving the GIC a chance to work in parallel 
with
the CPU on the entry path.

If your HW is a quick as you say it is, it would pretty much guarantee
a clear read of GICR_VPENDBASER without waiting.

         M.
-- 
Jazz is not dead. It just smells funny...
