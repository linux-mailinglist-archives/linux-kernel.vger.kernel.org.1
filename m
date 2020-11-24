Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739B62C240A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 12:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbgKXLYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 06:24:31 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:49129 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbgKXLYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:24:30 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id AAB6924034D;
        Tue, 24 Nov 2020 11:24:27 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     ludovic.desroches@microchip.com,
        "cristian.birsan@microchip.com" <cristian.birsan@microchip.com>,
        robh+dt@kernel.org, nicolas.ferre@microchip.com
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] ARM: dts: at91: add pincontrol node for USB Host
Date:   Tue, 24 Nov 2020 12:24:26 +0100
Message-Id: <160621703704.1091306.12505608015388486536.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201118120019.1257580-1-cristian.birsan@microchip.com>
References: <20201118120019.1257580-1-cristian.birsan@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Nov 2020 14:00:16 +0200, cristian.birsan@microchip.com wrote:
> The pincontrol node is needed for USB Host since Linux v5.7-rc1. Without
> it the driver probes but VBus is not powered because of wrong pincontrol
> configuration. The patch was tested on SAM9x60EK, SAMA5D4-EK and SAMA5D3-EK.
> 
> Cristian Birsan (3):
>   ARM: dts: sam9x60: add pincontrol for USB Host
>   ARM: dts: at91: sama5d4_xplained: add pincontrol for USB Host
>   ARM: dts: at91: sama5d3_xplained: add pincontrol for USB Host
> 
> [...]

Applied, thanks!

[1/3] ARM: dts: at91: sam9x60: add pincontrol for USB Host
      commit: 5ba6291086d2ae8006be9e0f19bf2001a85c9dc1
[2/3] ARM: dts: at91: sama5d4_xplained: add pincontrol for USB Host
      commit: be4dd2d448816a27c1446f8f37fce375daf64148
[3/3] ARM: dts: at91: sama5d3_xplained: add pincontrol for USB Host
      commit: e1062fa7292f1e3744db0a487c4ac0109e09b03d

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
