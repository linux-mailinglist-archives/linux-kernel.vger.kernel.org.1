Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779FD278D77
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgIYQAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:00:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbgIYQAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:00:44 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E28A1206C3;
        Fri, 25 Sep 2020 16:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601049644;
        bh=uIIL87tIwIEZnbvbUPdy6jgRjJkBVa8uUyrpu8sztP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TjDKge61VcKOvHscuEQ4m1vFY2wPoVRcFT/Sk64qOrqhXDhirKryV5KRdIQGCr+Ku
         qB89ollP5LwT0AE8xtJzQ3wzRhg1bt6A9KQJflujjODLtlsG/6NkRfMdE4DHMcPuFZ
         1HcATuCN3n9CFYGTbeYW4ojNdphiIaB6sUpKgzIk=
Received: from [185.69.144.225] (helo=localhost.localdomain)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kLq9K-00EuaQ-1k; Fri, 25 Sep 2020 17:00:42 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, parthiban@linumiz.com,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: Re: [PATCH v7 0/3] Add Actions Semi Owl family sirq support
Date:   Fri, 25 Sep 2020 17:00:03 +0100
Message-Id: <160104958260.38985.7668757349696744886.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600114378.git.cristian.ciocaltea@gmail.com>
References: <cover.1600114378.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.69.144.225
X-SA-Exim-Rcpt-To: robh+dt@kernel.org, afaerber@suse.de, cristian.ciocaltea@gmail.com, jason@lakedaemon.net, manivannan.sadhasivam@linaro.org, tglx@linutronix.de, linux-actions@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, parthiban@linumiz.com, sravanhome@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020 23:27:16 +0300, Cristian Ciocaltea wrote:
> This patch series adds support for the external interrupt controller
> (SIRQ) found in the Actions Semi Owl family of SoC's (S500, S700 and
> S900). The controller handles up to 3 external interrupt lines through
> dedicated SIRQ pins.
> 
> This is a rework of the patch series submitted some time ago by
> Parthiban Nallathambi:
> https://lore.kernel.org/lkml/20181126100356.2840578-1-pn@denx.de/
> 
> [...]

Applied to irq/irqchip-next, thanks!

[1/3] dt-bindings: interrupt-controller: Add Actions SIRQ controller binding
      commit: b2bd271c3961f35dd127c99c8f576d9fcc2cb0c4
[2/3] irqchip: Add Actions Semi Owl SIRQ controller
      commit: 27e9e554b01fea686929598556cb7f73a70fb964
[3/3] MAINTAINERS: Add entries for Actions Semi Owl SIRQ controller
      commit: aa524294ffb621cb51dbc0a0ccdb2929c0ca2bc1

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


