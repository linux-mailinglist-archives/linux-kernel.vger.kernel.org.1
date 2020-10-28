Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD9929D671
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbgJ1WPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:15:08 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:48910 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731016AbgJ1WO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:14:58 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 285B93ADB50
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 20:30:55 +0000 (UTC)
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id F1501FF804;
        Wed, 28 Oct 2020 20:30:32 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ludovic.desroches@microchip.com
Subject: Re: [PATCH] ARM: configs: at91: sama5: resync with media changes
Date:   Wed, 28 Oct 2020 21:30:32 +0100
Message-Id: <160391702430.400062.2380353163121155502.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201016075109.287506-1-eugen.hristev@microchip.com>
References: <20201016075109.287506-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Oct 2020 10:51:09 +0300, Eugen Hristev wrote:
> The media tree Kconfig has changed recently, and a lot of modules were
> built unintentionally, like the dvb frontends and encoders.
> Resync the defconfig to build the sama5 drivers and tested sensors.

Applied, thanks!

[1/1] ARM: configs: at91: sama5: resync with media changes
      commit: fb533fc76d341ab73fc7e3cec0ab012bd2881ca7

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
