Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A9A1FC7A1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 09:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgFQHir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 03:38:47 -0400
Received: from comms.puri.sm ([159.203.221.185]:50900 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbgFQHio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:38:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 05A07E0492;
        Wed, 17 Jun 2020 00:38:44 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qdT0Dw1YBvgR; Wed, 17 Jun 2020 00:38:43 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, kernel@puri.sm, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mchehab@kernel.org, Anson.Huang@nxp.com,
        agx@sigxcpu.org, angus@akkea.ca, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v3 2/2] MAINTAINERS: Add Purism Librem 5 section to the list
Date:   Wed, 17 Jun 2020 09:38:21 +0200
Message-Id: <20200617073821.16737-2-martin.kepplinger@puri.sm>
In-Reply-To: <20200617073821.16737-1-martin.kepplinger@puri.sm>
References: <20200617073821.16737-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add development information for the devicetree files for hardware
by Purism SPC.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b045b70e54df..0f6f18c477db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13881,6 +13881,13 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/admin-guide/media/pulse8-cec.rst
 F:	drivers/media/cec/usb/pulse8/
 
+PURISM LIBREM 5
+M:	Purism Kernel Team <kernel@puri.sm>
+S:	Supported
+B:	https://source.puri.sm/Librem5/linux-next/issues
+T:	https://source.puri.sm/Librem5/linux-next
+F:	arch/arm64/boot/dts/freescale/imx8mq-librem5*
+
 PVRUSB2 VIDEO4LINUX DRIVER
 M:	Mike Isely <isely@pobox.com>
 L:	pvrusb2@isely.net	(subscribers-only)
-- 
2.20.1

