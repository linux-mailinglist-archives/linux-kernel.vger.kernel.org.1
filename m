Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1733F2CBC3C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgLBMB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:01:59 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:44019 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgLBMB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:01:58 -0500
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id A39F4200012;
        Wed,  2 Dec 2020 12:01:16 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     nicolas.ferre@microchip.com, robh+dt@kernel.org,
        ludovic.desroches@microchip.com,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        sandeepsheriker.mallikarjun@microchip.com
Subject: Re: [PATCH 0/2] fixes for at91 devices
Date:   Wed,  2 Dec 2020 13:01:16 +0100
Message-Id: <160691044337.124469.1223039421087064881.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <1606903025-14197-1-git-send-email-claudiu.beznea@microchip.com>
References: <1606903025-14197-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Dec 2020 11:57:03 +0200, Claudiu Beznea wrote:
> I added here 2 fixes for AT91 devices.
> 
> Thank you,
> Claudiu Beznea
> 
> Claudiu Beznea (2):
>   ARM: dts: at91: sam9x60ek: remove bypass property
>   ARM: dts: at91: sama5d2: map securam as device
> 
> [...]

Applied, thanks!

[1/2] ARM: dts: at91: sam9x60ek: remove bypass property
      commit: d45879c1307f5b133c11e43e108bba459d17cee8
[2/2] ARM: dts: at91: sama5d2: map securam as device
      commit: b8af79e4b63c7e729ddbfe13eab20b1c97ffe442

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
