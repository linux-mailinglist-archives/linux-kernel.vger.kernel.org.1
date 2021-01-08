Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485CC2EFB47
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 23:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbhAHWl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 17:41:58 -0500
Received: from mout.gmx.net ([212.227.17.22]:36005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbhAHWl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610145619;
        bh=NJp+hbPNk37tII+LPOXGY8ODHY3S8sdf4Zgnfzeqzds=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=lGuKEA9ik4wVcmkHJe/9j3tiy12BzGRnn8WUZE/cig+A0NNMoyn6eF8LnCKLH6HNy
         s09OJgbSjmBpIuLXnFDWDTReOAHoYeAqK00OUNEA01080JGvFrmQRYMFEvp9+idxZv
         fLzm/B1e5Nz9Qea5FZvCsYFSBWjCPN8U+MZGcY70=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.57]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7sDq-1ku8XZ1EBu-0054Cb; Fri, 08
 Jan 2021 23:40:19 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     devicetree@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: Convert nuvoton,npcm750 binding to YAML
Date:   Fri,  8 Jan 2021 23:40:06 +0100
Message-Id: <20210108224008.705687-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WWz1zPPZWYzoDcE8qrMIoeq4BF0tEdmNQs+psVnXi/ZQ5uwWwM7
 KwPuFz1+G7rvnQdbyQSaNZwugq77f481UJujPnBAIVhgB1S/TYpUMmdl9MOAgYFGEdrMEs/
 4T+m0C3D18rePH25Sy267SDxK2tizRc7XSZemYts+NI7pMf5jgZ9gWLV8G6lPnhPZMDkqco
 sf11uyGfiMIuOwdNYq7PQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xr89JIx1Uqo=:LezS2WenVd1CcciZkzRgyt
 GggwgryMBhsDN3/3AiwgzcMyMtE04dY203G92SX7lQ9SYPgQOKKxiYdF+9zQtjTWaABm5x9LY
 ydumC6I8dgvL7Fby8oLREAiz+feoLTcsorCILF2tDe0d4Li3WN2dwp6GP0naRIeUM6ar53T5Q
 +CHDW/7R+6AyFmrbZBWlPFWplbp1xUvSiHIa254EdyYjYj3OHBxIRUZuf3Ntck9U/3ha2yE/S
 sp+yrT36kQdmbIrbp3AkvxASr5yfXdTOspGt1ypCLAEDJ3k1MfZWeIhNW4uw/ndKzT5tkXHd2
 x07VZ8M8gjqD9vwdH0Go/fD+YF1yTMttzDyOSsL26W5maCdNHGJgUfzNeS8UEDGzMeWKeQ8cg
 eXr2E1GwRfVA1N+yI7UesZjaRxdwbE7GY4imy8vDgKa1h5kEFHacO7zMmeexWGMVOG92lZxfJ
 O+m4XejC/vc6l/xYlp4FaYuIMxfK2O2isFmx/+6XMNYa37L5DNDVQ4teMjkuyuQyYAC9pnEUg
 pXHHCIlEtpTLE4JAmWL+woj84u9oWh0I3Bs+6aXe1ZdCD4knzTQjNA6j37Jja4VkbHNmXkpH6
 krlr0wb0m93lbCy7q09S6IMhFfUWso3jtoo+wXMdo93W70aNqXhLrKoMPG7mN1PWf0kYkuolQ
 tCOIMbiSfAGHi7/sjPBG2Nbtvn94PmupvVoEdq4qyvKWwztOWBFMhbSfX7Mp+XJP/4fyGnODl
 c34uk0OVGpcyCIAO6hoYgpwgdkLzwAkGMOGVSXC9hP5+XUxNJZNBUnFOrrJSsUUPAc29S/cq9
 fJyVvbaVMtVp0N/7t8Ki0WnJTgfnwawwKBwVViVkANDyHEIbTzdOInPIx1QBo2AjZEb6a0Exy
 Qlz0XHM/HB+utJzi9jww==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The general trend is to have devicetree bindings in YAML format, to
allow automatic validation of bindings and devicetrees.

Convert the NPCM SoC family's binding to YAML before it accumulates more
entries.

The nuvoton,npcm750-evb compatible string is introduced to keep the
structure of the binding a little simpler.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

If someone else wants to be listed as the maintainer, please let me
know.
=2D--
 .../devicetree/bindings/arm/npcm/npcm.txt     |  6 -----
 .../devicetree/bindings/arm/npcm/npcm.yaml    | 23 +++++++++++++++++++
 2 files changed, 23 insertions(+), 6 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/npcm/npcm.txt
 create mode 100644 Documentation/devicetree/bindings/arm/npcm/npcm.yaml

diff --git a/Documentation/devicetree/bindings/arm/npcm/npcm.txt b/Documen=
tation/devicetree/bindings/arm/npcm/npcm.txt
deleted file mode 100644
index 2d87d9ecea85b..0000000000000
=2D-- a/Documentation/devicetree/bindings/arm/npcm/npcm.txt
+++ /dev/null
@@ -1,6 +0,0 @@
-NPCM Platforms Device Tree Bindings
=2D-----------------------------------
-NPCM750 SoC
-Required root node properties:
-	- compatible =3D "nuvoton,npcm750";
-
diff --git a/Documentation/devicetree/bindings/arm/npcm/npcm.yaml b/Docume=
ntation/devicetree/bindings/arm/npcm/npcm.yaml
new file mode 100644
index 0000000000000..e2cf790a2c63e
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/arm/npcm/npcm.yaml
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/npcm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NPCM Platforms Device Tree Bindings
+
+maintainers:
+  - Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: NPCM750 based boards
+        items:
+          - enum:
+            - nuvoton,npcm750-evb           # NPCM750 evaluation board
+          - const: nuvoton,npcm750
+
+additionalProperties: true
=2D-
2.29.2

