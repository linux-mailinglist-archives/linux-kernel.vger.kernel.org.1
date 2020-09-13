Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD50226806F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 19:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgIMRFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 13:05:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbgIMRFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 13:05:31 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 295D120723;
        Sun, 13 Sep 2020 17:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600016731;
        bh=ClKUpKsdj2rQSZ3L0fqEYBYWgnov+Gpr27YAKLyRTnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sp5TlpQdfXNHrFyPAu/BntUl3ajcrNM5nLbpc/mA86RFuxJtRWXsG6Qf7t+wnyz/2
         c/p011rq02l6B+DKEFVJjF+l9rnyWfALPIHtYhfadr/XkBGkxIZMrP4i9mpPvaJnIF
         08OKRe3prSKtud2wGiZXg926yqZdiNXY2zoi3hFs=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kHVRR-00BTQE-LS; Sun, 13 Sep 2020 18:05:29 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, jason@lakedaemon.net, tglx@linutronix.de,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        Anson Huang <Anson.Huang@nxp.com>, festevam@gmail.com
Cc:     will@kernel.org, catalin.marinas@arm.com, Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/2] irqchip/imx-intmux: Use dev_err_probe() to simplify error handling
Date:   Sun, 13 Sep 2020 18:05:16 +0100
Message-Id: <160001658182.6915.12925727924153070207.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <1597126576-18383-1-git-send-email-Anson.Huang@nxp.com>
References: <1597126576-18383-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, alexandru.elisei@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, jason@lakedaemon.net, tglx@linutronix.de, s.hauer@pengutronix.de, shawnguo@kernel.org, Anson.Huang@nxp.com, festevam@gmail.com, will@kernel.org, catalin.marinas@arm.com, Linux-imx@nxp.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Aug 2020 14:16:15 +0800, Anson Huang wrote:
> dev_err_probe() can reduce code size, uniform error handling and record the
> defer probe reason etc., use it to simplify the code.

Applied to irq/irqchip-next, thanks!

[1/2] irqchip/imx-intmux: Use dev_err_probe() to simplify error handling
      commit: c201f4325588a3b0109ba552a20bd4d4b1b5c6c8
[2/2] irqchip/imx-irqsteer: Use dev_err_probe() to simplify error handling
      commit: e0c45b107fc94c5a7a230b25cdbecab004ab1ed5

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


