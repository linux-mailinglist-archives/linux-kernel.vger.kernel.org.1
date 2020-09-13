Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28036268071
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 19:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgIMRFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 13:05:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgIMRFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 13:05:32 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6171206C9;
        Sun, 13 Sep 2020 17:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600016732;
        bh=4mSBB5yuCBsb8DtXJKT9RU48Hmo8YtN6lltG9KNfU8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FFfLcVBFgUrUWL7xMpiPycH4fqxj2z6l/o1EKkTGKFChr2nvAz9Kcy8L3kPgH0DaS
         GQfH5SexH/ZkGPMPzEYnjI+ZscIYWZgc4dRGrBZNAmrj5PIdfBW8z04ypghazAAL39
         5tFvhBvsU8JEM/aWeTPXgmhG1RJBJJVzr7v8+g2Q=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kHVRS-00BTQE-E2; Sun, 13 Sep 2020 18:05:30 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tero Kristo <t-kristo@ti.com>
Cc:     will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH 1/2] irqchip/ti-sci: Simplify with dev_err_probe()
Date:   Sun, 13 Sep 2020 18:05:17 +0100
Message-Id: <160001658182.6915.14152547552697841903.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902174615.24695-1-krzk@kernel.org>
References: <20200902174615.24695-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, alexandru.elisei@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, ssantosh@kernel.org, krzk@kernel.org, jason@lakedaemon.net, tglx@linutronix.de, t-kristo@ti.com, will@kernel.org, catalin.marinas@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Sep 2020 19:46:14 +0200, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and the error value gets printed.
> 
> There is also no need to assign NULL to 'intr->sci' as it is part of
> devm-allocated memory.

Applied to irq/irqchip-next, thanks!

[1/2] irqchip/ti-sci: Simplify with dev_err_probe()
      commit: ea6c25e6057c0b7c18337696be84b8f9751f19ec

Patch #2 didn't make a lot of sense, so not applied.

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


