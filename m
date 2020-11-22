Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D032BC5B3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 13:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgKVMry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 07:47:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:40460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbgKVMry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 07:47:54 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5BB22078D;
        Sun, 22 Nov 2020 12:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606049273;
        bh=X53NXA4jh+8pasL9eOJKbJri9ATWtPFDIOuBX04nt9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Le6LlQtEMDJUFIOh7oHVlDEmSwD6GbIEKECrZtLCx7veOInNMX669Xvs+siCHl5p9
         Nv3cZ9hmV+VVIAQs5vmiJNo6+zmhyPRleWNSZHNdfceX5qU+wO3SQVpngZq9Jnf+bf
         mon9NCjzFlGFCESyLsqCLxR/PmuBJkfkCJqjK8j4=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kgomV-00ChPX-Et; Sun, 22 Nov 2020 12:47:51 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Xu Qiang <xuqiang36@huawei.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Cc:     rui.xiang@huawei.com
Subject: Re: [PATCH -next] irq-chip/gic-v3-its: Fixed an issue where the ITS executes the residual commands in the queue again when the ITS wakes up from sleep mode.
Date:   Sun, 22 Nov 2020 12:47:48 +0000
Message-Id: <160604923575.224052.1351706430622290182.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107104226.14282-1-xuqiang36@huawei.com>
References: <20201107104226.14282-1-xuqiang36@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: xuqiang36@huawei.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, rui.xiang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Nov 2020 10:42:26 +0000, Xu Qiang wrote:
> On my platform, ITS_FLAGS_SAVE_SUSPEND_STATE is not set,thus do nothing
> in its suspend and resuse function.On the other hand,firmware stores
> GITS_CTRL,GITS_CBASER,GITS_CWRITER and GITS_BASER<n> in the suspend,
> and restores these registers in the resume. As a result, the ITS executes
> the residual commands in the queue.
> 
> Memory corruption may occur in the following scenarios:
> 
> [...]

Applied to irq/irqchip-next, thanks!

[1/1] irqchip/gic-v3-its: Unconditionally save/restore the ITS state on suspend
      commit: a51f7296f38f498c6f186c82ae3aa25ae10bb266

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


