Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C702981AE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 13:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415761AbgJYMiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 08:38:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415754AbgJYMiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 08:38:02 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE4D320853;
        Sun, 25 Oct 2020 12:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603629481;
        bh=u9aO31NgT1SvFDW2GvB0R9LiOmuKo0V5PSlXi+W2nu8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Io5OkQe1OQQZAHZzvWPDWH8vgW/Y9GQ3GwZazyVF8EcOU4YMcRUllVwjGaE479BVe
         m5cJrsHu1wrrbTXTC0J7KYcGYEXvKSnWtbaeWhhnhMNmMJYMMoO8tMiFkjdAXV42m5
         Ap4xVLNHHMK1yLlQN4sA3EO6CFWsOAE38dRf+wn4=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kWfHb-0043br-GQ; Sun, 25 Oct 2020 12:37:59 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     jason@lakedaemon.net, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] irqchip/sifive-plic: Fix broken irq_set_affinity() callback
Date:   Sun, 25 Oct 2020 12:37:51 +0000
Message-Id: <160362942369.263990.3256848447079854839.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020081532.2377-1-greentime.hu@sifive.com>
References: <20201020081532.2377-1-greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: jason@lakedaemon.net, paul.walmsley@sifive.com, linux-riscv@lists.infradead.org, palmer@dabbelt.com, greentime.hu@sifive.com, linux-kernel@vger.kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Oct 2020 16:15:32 +0800, Greentime Hu wrote:
> It will always enable the interrupt after calling plic_set_affinity()
> however it should set to it previous setting. Staying disabled or enabled.
> 
> This patch can also fix this pwm hang issue in Unleashed board.
> 
> [  919.015783] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [  919.020922] rcu:     0-...0: (0 ticks this GP)
> idle=7d2/1/0x4000000000000002 softirq=1424/1424 fqs=105807
> [  919.030295]  (detected by 1, t=225825 jiffies, g=1561, q=3496)
> [  919.036109] Task dump for CPU 0:
> [  919.039321] kworker/0:1     R  running task        0    30      2 0x00000008
> [  919.046359] Workqueue: events set_brightness_delayed
> [  919.051302] Call Trace:
> [  919.053738] [<ffffffe000930d92>] __schedule+0x194/0x4de
> [  982.035783] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [  982.040923] rcu:     0-...0: (0 ticks this GP)
> idle=7d2/1/0x4000000000000002 softirq=1424/1424 fqs=113325
> [  982.050294]  (detected by 1, t=241580 jiffies, g=1561, q=3509)
> [  982.056108] Task dump for CPU 0:
> [  982.059321] kworker/0:1     R  running task        0    30      2 0x00000008
> [  982.066359] Workqueue: events set_brightness_delayed
> [  982.071302] Call Trace:
> [  982.073739] [<ffffffe000930d92>] __schedule+0x194/0x4de
> [..]

Applied to irq/irqchip-next, with some commit message adjustments.

[1/1] irqchip/sifive-plic: Fix broken irq_set_affinity() callback
      commit: a7480c5d725c4ecfc627e70960f249c34f5d13e8

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


