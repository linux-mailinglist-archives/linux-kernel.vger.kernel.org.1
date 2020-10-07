Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE52E2865C4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 19:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgJGRUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 13:20:18 -0400
Received: from mail-41104.protonmail.ch ([185.70.41.104]:14414 "EHLO
        mail-41104.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgJGRUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 13:20:15 -0400
Received: from mail-02.mail-europe.com (mail-02.mail-europe.com [51.89.119.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41104.protonmail.ch (Postfix) with ESMTPS id F321B20035BD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 17:20:12 +0000 (UTC)
Authentication-Results: mail-41104.protonmail.ch;
        dkim=pass (1024-bit key) header.d=connolly.tech header.i=@connolly.tech header.b="cb2YJNxi"
Date:   Wed, 07 Oct 2020 17:20:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1602091210;
        bh=d2j//6xhs2PPOH5F6O6PlO0HsUSK+06Ub5QJ1wgRpaw=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=cb2YJNxiQKsm2m9FIBm86iCX27qa+tPdLDIRE9nFqwdhBQjw86zUeHEMeeEMMkc8q
         2ocdyfAUvF/rs7eZk7BCbF51OlcJKsPwwiSkuIdX5rZoopoKQPGEPVFGb04D8J8Phe
         i8q7ljKNuiu9/A52qK3oC8+/CiGlWLhm9NOaYx9s=
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Caleb Connolly <caleb@connolly.tech>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: [PATCH 2/5] dt-bindings: panel: add documentation for oneplus6 panel
Message-ID: <20201007171807.285298-3-caleb@connolly.tech>
In-Reply-To: <20201007171807.285298-1-caleb@connolly.tech>
References: <20201007171807.285298-1-caleb@connolly.tech>
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

Document the OnePlus 6/T common panel driver, example from
arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi

Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 .../display/panel/panel-oneplus6.yaml         | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/panel-o=
neplus6.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/panel-oneplus6=
.yaml b/Documentation/devicetree/bindings/display/panel/panel-oneplus6.yaml
new file mode 100644
index 000000000000..23ba369cc2f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/panel-oneplus6.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/panel-oneplus6.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OnePlus 6/T panel driver
+
+description: |
+  The OnePlus 6 panel driver encompasses the display panels found in the
+  OnePlus 6 and 6T devices, the panels have almost identical behaviour and
+  are not used by any other devices.
+
+maintainers:
+  - Caleb Connolly <caleb@connolly.tech>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - samsung,sofef00
+      - samsung,s6e3fc2x01
+
+  reg: true
+  reset-gpios: true
+  port: true
+
+  vddio-supply:
+    description: VDDIO regulator
+
+required:
+  - compatible
+  - reset-gpios
+  - vddio-supply
+  - port
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    &dsi0 {
+      status =3D "okay";
+      vdda-supply =3D <&vdda_mipi_dsi0_1p2>;
+
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+
+      display_panel: panel@0 {
+        status =3D "okay";
+        compatible =3D "samsung,sofef00";
+
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+        reg =3D <0>;
+
+        vddio-supply =3D <&vreg_l14a_1p88>;
+
+        reset-gpios =3D <&tlmm 6 GPIO_ACTIVE_HIGH>;
+
+        pinctrl-names =3D "default";
+        pinctrl-0 =3D <&panel_reset_pins &panel_te_pin &panel_esd_pin>;
+
+        port {
+          panel_in: endpoint {
+            remote-endpoint =3D <&dsi0_out>;
+          };
+        };
+      };
+    };
+
+...
--=20
2.28.0


