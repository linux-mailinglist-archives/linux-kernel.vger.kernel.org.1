Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAC92FE201
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 06:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbhAUFsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 00:48:32 -0500
Received: from mail.v3.sk ([167.172.186.51]:43160 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728055AbhAUDmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 22:42:52 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 18356DF8E6;
        Thu, 21 Jan 2021 03:37:40 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id amaDJJxjbDOG; Thu, 21 Jan 2021 03:37:39 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A7817E0A82;
        Thu, 21 Jan 2021 03:37:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jSzjLEDEyX-9; Thu, 21 Jan 2021 03:37:39 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 579CBDF892;
        Thu, 21 Jan 2021 03:37:39 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>, SoC Team <soc@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 02/12] media: dt-bindings: marvell,mmp2-ccic: Allow power-domains property
Date:   Thu, 21 Jan 2021 04:41:20 +0100
Message-Id: <20210121034130.1381872-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121034130.1381872-1-lkundrak@v3.sk>
References: <20210121034130.1381872-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On MMP3 the camera interface is on a separate power island. This
property tells the driver to enable it when appropriate.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../devicetree/bindings/media/marvell,mmp2-ccic.yaml         | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/marvell,mmp2-ccic.ya=
ml b/Documentation/devicetree/bindings/media/marvell,mmp2-ccic.yaml
index 49bff738aca54..52eab686a1774 100644
--- a/Documentation/devicetree/bindings/media/marvell,mmp2-ccic.yaml
+++ b/Documentation/devicetree/bindings/media/marvell,mmp2-ccic.yaml
@@ -23,6 +23,9 @@ properties:
   interrupts:
     maxItems: 1
=20
+  power-domains:
+    maxItems: 1
+
   port:
     type: object
     additionalProperties: false
@@ -75,6 +78,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/clock/marvell,mmp2.h>
+    #include <dt-bindings/power/marvell,mmp2.h>
=20
     camera@d420a000 {
       compatible =3D "marvell,mmp2-ccic";
@@ -84,6 +88,7 @@ examples:
       clock-names =3D "axi";
       #clock-cells =3D <0>;
       clock-output-names =3D "mclk";
+      power-domains =3D <&soc_clocks MMP3_POWER_DOMAIN_CAMERA>;
=20
       port {
         camera0_0: endpoint {
--=20
2.29.2

