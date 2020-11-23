Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72DE2C00EF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 09:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgKWHze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 02:55:34 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:47155 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbgKWHzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 02:55:33 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201123075530epoutp04a6e7a8c80e0519b46a01ed599db34993~KE_4Jdwbn2039720397epoutp04I
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 07:55:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201123075530epoutp04a6e7a8c80e0519b46a01ed599db34993~KE_4Jdwbn2039720397epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1606118130;
        bh=QaPoV2LoZTG2RgUzI5C1Hw6+KlJ9n9VMoWukaX1Jp4M=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=chFVYJrgY3HBNtxHXuJht2H5x/mdXQ9x4ucI57BRO9qWyzGoOguCxwM/S7US3/QJW
         bV55jgXSZPVzB//7jdCkBHcsfYSm/Khljwu2nCpHK1za59R2XhNg1L090ZOlJ7DNyY
         LYfCpSng6PPrHz946Loc8m3pZhrC9xqG8qNN/Vvk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20201123075530epcas2p4016b99ddd41098dedde209532a52b30c~KE_3_7Ygr3099330993epcas2p4T;
        Mon, 23 Nov 2020 07:55:30 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Cffb367SMzMqYkr; Mon, 23 Nov
        2020 07:55:27 +0000 (GMT)
X-AuditID: b6c32a46-1d9ff7000000dbf8-ac-5fbb6aee8105
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.36.56312.EEA6BBF5; Mon, 23 Nov 2020 16:55:26 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH net-next 1/2] dt-bindings: net: nfc: s3fwrn5: Support a UART
 interface
Reply-To: bongsu.jeon@samsung.com
Sender: Bongsu Jeon <bongsu.jeon@samsung.com>
From:   Bongsu Jeon <bongsu.jeon@samsung.com>
To:     "krzk@kernel.org" <krzk@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>
CC:     "linux-nfc@lists.01.org" <linux-nfc@lists.01.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20201123075526epcms2p59410a8ba942f8942f53a593d9df764d0@epcms2p5>
Date:   Mon, 23 Nov 2020 16:55:26 +0900
X-CMS-MailID: 20201123075526epcms2p59410a8ba942f8942f53a593d9df764d0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEJsWRmVeSWpSXmKPExsWy7bCmue67rN3xBhcfK1jMP3KO1eL8+Q3s
        Fhe29bFaXN41h81izobN7BbHFog5sHlsWtXJ5tE9+x+Lx+dNcgHMUQ2MNolFyRmZZakKqXnJ
        +SmZeem2SqEhbroWSgoZ+cUltkrRhhZGeoaWpnomlnpG5rFWhgYGRqZKCnmJuam2ShW6UN1K
        CkXJBUDVJanFJUWpyalAoSKH4pLE9FS94sTc4tK8dL3k/FwlhbLEnFKgPiV9O5uM1MSU1CKF
        hCeMGX+ePmYqOMBTMXWPTgNjB2cXIweHhICJxI2til2MXBxCAjsYJX41LmIBifMKCEr83SHc
        xcjJISwQIXG88SsTiC0koCjxv+McG0RcV+LF36NgNpuAtsTao41gNSICPhILdyxgApnJLPCC
        UWLrmkusIAkJAV6JGe1PWSBsaYnty7cyQtgaEj+W9TJD2KISN1e/ZYex3x+bD1UjItF67yxU
        jaDEg5+7oeKSEm/3zWMHWSYh0M4ocf7nDzYIZwajxKnNf6E69CUWn1sBdh6vgK/E+0tzwTaw
        CKhKnHl1GGqSi8SGpbfAbGYBeYntb+cwg0KCWUBTYv0ufUhgKUscucUCUcEn0XH4LzvMXzvm
        PWGCsFUlepu/MMH8OHl2C9R0D4mzl78xQwIxUOLQkk7GCYwKsxBBPQvJ3lkIexcwMq9iFEst
        KM5NTy02KjBCjudNjOB0qeW2g3HK2w96hxiZOBgPMUpwMCuJ8LbK7YwX4k1JrKxKLcqPLyrN
        SS0+xFgF9PFEZinR5Hxgws4riTc0MzAyMzU2MTY2NTElW9jUyMzMwNLUwtTMyEJJnDd0ZV+8
        kEB6YklqdmpqQWoRzHImDk6pBqaypcHTJ+hkxNl9KP/7TKkgen7+tF0bYvv87h885vn/7dZV
        azsc1ztWrPk7Jf8h085r7rl5jZdZzi/IaDz6QkPn013hdTqMMw5eTfHm4+SZn7f/Ukjfzpgy
        rr8dJ2bxdLQc7l43LTynVPd04uabvQ/CFMwyVQSOtSpN9fm3+R0jv5ug9XGNnpJv4idZtD1a
        T706UHV6e0ex6Y7NK36aRyepxBd/eCt86PGnm2kChyzmmjyfbllcamVyTvuq+pxnbWFyi/+/
        ZXM9dktr56o+mxkTVulstpPPSZcK+umskpNaE3ayVmv/mTmHZlpUVpRsVNPbfCYtbo3uEnEe
        vTM9Sk9X7wrsXyUrYljfGVtR1KDEUpyRaKjFXFScCACeEfVtZQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201123075526epcms2p59410a8ba942f8942f53a593d9df764d0
References: <CGME20201123075526epcms2p59410a8ba942f8942f53a593d9df764d0@epcms2p5>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since S3FWRN82 NFC Chip, The UART interface can be used.
S3FWRN82 supports I2C and UART interface.

Signed-off-by: Bongsu Jeon <bongsu.jeon@samsung.com>
---
 .../bindings/net/nfc/samsung,s3fwrn5.yaml     | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml b/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml
index cb0b8a560282..37b3e5ae5681 100644
--- a/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml
+++ b/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml
@@ -13,6 +13,7 @@ maintainers:
 properties:
   compatible:
     const: samsung,s3fwrn5-i2c
+    const: samsung,s3fwrn82-uart
 
   en-gpios:
     maxItems: 1
@@ -47,10 +48,19 @@ additionalProperties: false
 required:
   - compatible
   - en-gpios
-  - interrupts
-  - reg
   - wake-gpios
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,s3fwrn5-i2c
+    then:
+      required:
+        - interrupts
+        - reg
+
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
@@ -71,3 +81,17 @@ examples:
             wake-gpios = <&gpj0 2 GPIO_ACTIVE_HIGH>;
         };
     };
+  # UART example on Raspberry Pi
+  - |
+    &uart0 {
+        status = "okay";
+
+        s3fwrn82_uart {
+            compatible = "samsung,s3fwrn82-uart";
+
+            en-gpios = <&gpio 20 0>;
+            wake-gpios = <&gpio 16 0>;
+
+            status = "okay";
+        };
+    };
-- 
2.17.1

