Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CE729E1D4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbgJ2CEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:04:07 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:49786 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgJ1Vm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:42:58 -0400
Received: from relay8-d.mail.gandi.net (unknown [217.70.183.201])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 6A7F63A438B;
        Wed, 28 Oct 2020 20:51:19 +0000 (UTC)
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id B18101BF208;
        Wed, 28 Oct 2020 20:50:56 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] ARM: dts: at91: at91-sama5d27_som1: fix EEPROM compatible
Date:   Wed, 28 Oct 2020 21:50:56 +0100
Message-Id: <160391824952.592530.7461952533170212017.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026104618.23415-1-brgl@bgdev.pl>
References: <20201026104618.23415-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Oct 2020 11:46:18 +0100, Bartosz Golaszewski wrote:
> AT24 compatibles require a vendor prefix. Use the default "atmel".

Applied, thanks!

[1/1] ARM: dts: at91: at91-sama5d27_som1: fix EEPROM compatible
      commit: c9dc33d13c813e20c6dcfd5a9f54122225ca46bb

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
