Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946D92F8A3E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 02:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbhAPBLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 20:11:11 -0500
Received: from mout.gmx.net ([212.227.15.15]:58949 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbhAPBLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 20:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610759368;
        bh=btqIRTBlIF7ZyskJXnBkokLSwHrAtzmVQT1qlCS/DeQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=AgJ3s3W+QH4RUV3xi4QP+O1XXMc6AhvugL0NDMZD1l7ckAbPTLB7Tr1lVKZTFyFSX
         17hcgxDh2CiSdXEBRPQE+rySjjvhKp5LkO7BjoytBeBFBXWwP8iv4qGH8A7xJUILeV
         E+f7pXjNTW6JEgy6NTyC+BaPAI+MOtRhkt/bUhXI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.209]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3bSj-1m04oV0YDr-010buh; Sat, 16
 Jan 2021 02:09:28 +0100
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
Subject: [PATCH v2 1/2] dt-bindings: arm: Convert nuvoton,npcm750 binding to YAML
Date:   Sat, 16 Jan 2021 02:09:05 +0100
Message-Id: <20210116010907.3475405-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OV7/hltbT/tDW93LOCLudAWVCDl0VqWbae/oBNe/eCUWawkDkQ9
 H/X9rQ4CJFpmsISoHeQ+WeJgSgBgxcKbLcdYYYM0l1ifndpMOVDBFLHDQn89xFiWndic+cM
 Y3N5ijLhAvbnQf5GTKO40cHCR6jbyTNIqR9d+SkFmTNteVdTCmS8JXIxBP+WPZ5ABGXDnJB
 UUac260HFNvFoW4YBADfw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IQj4QauaFKE=:y9VxW/qAftr45HQO4OKHtr
 2VDtWsQX+6n6I+Qb8tW3ylZheMHAIq+BQZen9VN58npLkhg6WMJc0Qi8qiDfNlPgB8U0GPPLK
 RmrXULBpt5RAQxMlmYm2dPLetffbX5peOE/mTALxdHmVnTmqksAQre1iDh/B+b8j0+gWa3U8f
 ckG7Qvhc2An/irDFald64dyTTCxTrH+2FM47UsVo3Fr7u2c0A/lAOlGv95fpwVOscb5a3Jwck
 0wQeZhy4EMp4968HHbCYsP7TVmH6kapZZFewuz3WHQWXg/YVHXeLaWf+2mP9qdH6HCQ8sUA6R
 zOmRUrq/hyMF2lEhfgJfQTw6qX0nHX7619lAMEv87lio/7vsxrgBqf8a+5eUiQJG6vyi2bnWd
 vc5V/4/7N91OXkuFV5VwtDBV0HmNHni02kpGpoY5V6L274rL9Gk4iji84ql2AqKALp/5bFMkE
 ZyLLBxqRV6zweCEbBUqazUmJZvzNhtj+h1cmccTn8yjPrtpKQrvlMXIDfrJTN9O94HR+0+i6X
 5SQ0zLgIhWXMztmYl3Z1UwI0Tm+36iAeWyOKPXbmgzZrMTw/4MP/R/zaSAEV1mtO/0IqJo25+
 HEgN50EdQSOTAtIUrIMgHM41mzJDEt1jOP5gkiJMJbuAtFNlhhoH/M6uOb1RZsLa4TpH7WRHL
 Riz9EqQru44cIgiyB9pJDoMZy8Y98h7q3541wNlrlu9WZhcCiiuaQqfYCpbL3/8E1KVkHVwfM
 o7x8+pEd/lDgCAMPQomFIqaAwjuE69ATPKTpfbtpBSWzRH7ghCUdGZ3lOEL7nyS/lLAw9U4hJ
 c9GvJR4L2bNbiW2ZmoUv50lHbR4zb7bYvZGzpfpHYxPuDA0Wo8kseTOMKxKGAIkROiFZdr/rk
 i8VW2uQtUJmaCNMHZa+w==
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


v2:
- Fix indentation to satisfy yamllint
- Fix $schema line

v1:
- https://lore.kernel.org/lkml/20210108224008.705687-1-j.neuschaefer@gmx.n=
et/
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
index 0000000000000..894aefb70652a
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/arm/npcm/npcm.yaml
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/npcm/npcm.yaml#
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
+              - nuvoton,npcm750-evb         # NPCM750 evaluation board
+          - const: nuvoton,npcm750
+
+additionalProperties: true
=2D-
2.29.2

