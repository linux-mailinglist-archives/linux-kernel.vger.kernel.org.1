Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C4C22E766
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 10:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgG0IPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 04:15:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgG0IPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 04:15:02 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13D4D20738;
        Mon, 27 Jul 2020 08:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595837702;
        bh=wNsYlGRYx0Axpox0Rm3jZGxBal/xwqeBwbF9ySgg41s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2O8vxB5QdBDM+NiSAXCFJN6dr1rh0QbNhi2HbXgrE+kZX7KANvKv2KqplIbRURPsO
         OI+OBV5Jz78DlQlee6k6w1U99nWWJTDKWh1LKXcKGsDWhzMJNdyco1WPLe+osJenSs
         3kUm+3kmYnx7HyKMGVuI+fs58EA7YLDc3uvuo+7E=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jzyHk-00FENM-HX; Mon, 27 Jul 2020 09:15:00 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     tglx@linutronix.de, Joakim Zhang <qiangqing.zhang@nxp.com>,
        shawnguo@kernel.org, s.hauer@pengutronix.de, jason@lakedaemon.net
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, festevam@gmail.com
Subject: Re: [PATCH V3 0/1] irqchip: intmux: implement intmux PM
Date:   Mon, 27 Jul 2020 09:14:48 +0100
Message-Id: <159583764131.244522.11919582439422415024.b4-ty@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727141734.24890-1-qiangqing.zhang@nxp.com>
References: <20200727141734.24890-1-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, qiangqing.zhang@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de, jason@lakedaemon.net, kernel@pengutronix.de, linux-kernel@vger.kernel.org, linux-imx@nxp.com, festevam@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020 22:17:33 +0800, Joakim Zhang wrote:
> This patch intends to implement intmux PM.
> 
> ChangeLogs:
> V2->V3:
> 	1. allocate u32 saved_reg for a per channel.
> 
> V1->V2:
> 	1. add more detailed commit message.
> 	2. use u32 for 32bit HW registers.
> 	3. fix kbuild failures.
> 	4. move trivial functions into their respective callers.
> 	5. squash two patches together.
> 
> [...]

Applied to irq/irqchip-next, thanks!

[1/1] irqchip/imx-intmux: Implement intmux runtime power management
      commit: bb403111e017a327737242eca40311921f833627

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


