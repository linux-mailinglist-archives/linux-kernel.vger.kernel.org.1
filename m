Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F48D2E0A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgLVNLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:11:41 -0500
Received: from mail2.protonmail.ch ([185.70.40.22]:56119 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbgLVNLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:11:39 -0500
Date:   Tue, 22 Dec 2020 13:10:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1608642652; bh=v7jA6sc513sAD18icYLuddF4/BJSlGCuHnXxaczNIDc=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=Hz0omsIsc+ajCRb++3eC4ohZT+Ps3CcV4ND5R+0wIIPeIOSTLiqNYyaEkSNpBzif0
         qDXAlg87qpPfm4x6Xos/lMymz8UdhRaZL8VVV+ym7+6XhwJ2JYqGBmCPSi4+1p6owm
         xMoH/CnEVDpwQvXTDJuUkrb84GYrsF9F3n6TpXGaUXIqVuf2ltAOCvCCbQIrhWPb+s
         hK1Ap+8y6ryxGE0jQvJDWor9HJB2iuLouSJmQV43zfWVCSobx8lsWh5cWgvRcZVeA8
         XBJkF3M5wTrq/baI0HfXF1fASb939OLr5HlIUztsiRElMXxRQmgyMInGVogKZajc2z
         19AILBYvmx+Ug==
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     =?utf-8?B?5ryG6bmP5oyv?= <aric.pzqi@ingenic.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Paul Cercueil <paul@crapouillou.net>,
        =?utf-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH phy] PHY: Ingenic: fix unconditional build of phy-ingenic-usb
Message-ID: <20201222131021.4751-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently drivers/phy/ingenic/Makefile adds phy-ingenic-usb to targets
not depending on actual Kconfig symbol CONFIG_PHY_INGENIC_USB, so this
driver always gets built[-in] on every system.
Add missing dependency.

Fixes: 31de313dfdcf ("PHY: Ingenic: Add USB PHY driver using generic PHY fr=
amework.")
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
---
 drivers/phy/ingenic/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/ingenic/Makefile b/drivers/phy/ingenic/Makefile
index 65d5ea00fc9d..1cb158d7233f 100644
--- a/drivers/phy/ingenic/Makefile
+++ b/drivers/phy/ingenic/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y=09=09+=3D phy-ingenic-usb.o
+obj-$(CONFIG_PHY_INGENIC_USB)=09=09+=3D phy-ingenic-usb.o
--=20
2.29.2


