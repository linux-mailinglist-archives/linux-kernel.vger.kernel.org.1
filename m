Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691692865CC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 19:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgJGRVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 13:21:33 -0400
Received: from mail-41103.protonmail.ch ([185.70.41.103]:62750 "EHLO
        mail-41103.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbgJGRVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 13:21:32 -0400
Received: from mail-02.mail-europe.com (mail-02.mail-europe.com [51.89.119.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 8A07A2000424;
        Wed,  7 Oct 2020 17:21:09 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (1024-bit key) header.d=connolly.tech header.i=@connolly.tech header.b="hmQK3jEG"
Date:   Wed, 07 Oct 2020 17:20:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1602091265;
        bh=diIhVFPD9xUOq2n1qZyHi4LN1K0w3OUwHNY/r0C+Ldg=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=hmQK3jEGHbIv7edFg4jYgS0Z1XY82f/s1TInEiPQ8v4sU8az/UHe6O/qJ7FN+Bfum
         eDAghjnk47NpFjtqz07S2Eg9ygSxFuSQtbQo3Tn3NR6ReYMxsE8qOMIPNWNKKpKsBe
         hi3SKegyZnCzK1ruQRA9BoTRTC77/dC85PShDRV0=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Caleb Connolly <caleb@connolly.tech>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: [PATCH 3/5] arm64: dts: sdm845: add oneplus 6/t devices
Message-ID: <20201007171807.285298-4-caleb@connolly.tech>
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

Add initial support for the OnePlus 6 (enchilada) and 6T (fajita) based
on the sdm845-mtp DT. Support includes:

* Both display panels work
* Touch screen support with rmi4
* RTC support
* Remoteprocs boot and can be interacted with over QRTR.
* WLAN + Bluetooth both work, although bluetooth doesn't appear in
rfkill.
* Volume / power buttons and OnePlus Tri-State switch are functional
* USB gadget support is forced as it doesn't seem to be able to detect
USB cable connect/disconnect, perhaps to do with OnePlus' propriatery
fast charge IC.

The device successfully boots into Phosh using postmarketOS.

Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 arch/arm64/boot/dts/qcom/Makefile             |   2 +
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  | 860 ++++++++++++++++++
 .../dts/qcom/sdm845-oneplus-enchilada.dts     |  19 +
 .../boot/dts/qcom/sdm845-oneplus-fajita.dts   |  19 +
 4 files changed, 900 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/M=
akefile
index d8f1466e6758..a14f246e2367 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -30,6 +30,8 @@ dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm845-cheza-r2.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm845-cheza-r3.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm845-db845c.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm845-mtp.dtb
+dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm845-oneplus-enchilada.dtb
+dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm845-oneplus-fajita.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D sdm850-lenovo-yoga-c630.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D sm8150-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D sm8250-mtp.dtb
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm=
64/boot/dts/qcom/sdm845-oneplus-common.dtsi
new file mode 100644
index 000000000000..b0b09fe94f20
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -0,0 +1,860 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SDM845 OnePlus 6(T) (enchilada / fajita) common device tree source
+ *
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include "sdm845.dtsi"
+
+// Needed for some GPIO (like the volume buttons)
+#include "pm8998.dtsi"
+
+// For LEDs
+#include "pmi8998.dtsi"
+
+/ {
+
+=09aliases {
+=09=09hsuart0 =3D &uart6;
+=09};
+
+=09vph_pwr: vph-pwr-regulator {
+=09=09compatible =3D "regulator-fixed";
+=09=09regulator-name =3D "vph_pwr";
+=09=09regulator-min-microvolt =3D <3700000>;
+=09=09regulator-max-microvolt =3D <3700000>;
+=09};
+
+=09/*
+=09 * Apparently RPMh does not provide support for PM8998 S4 because it
+=09 * is always-on; model it as a fixed regulator.
+=09 */
+=09vreg_s4a_1p8: pm8998-smps4 {
+=09=09compatible =3D "regulator-fixed";
+=09=09regulator-name =3D "vreg_s4a_1p8";
+
+=09=09regulator-min-microvolt =3D <1800000>;
+=09=09regulator-max-microvolt =3D <1800000>;
+
+=09=09regulator-always-on;
+=09=09regulator-boot-on;
+
+=09=09vin-supply =3D <&vph_pwr>;
+=09};
+
+=09gpio_tristate_key: gpio-keys {
+=09=09compatible =3D "gpio-keys";
+=09=09label =3D "Tri-state key";
+
+=09=09pinctrl-names =3D "default";
+=09=09pinctrl-0 =3D <&tri_state_key_default>;
+
+=09=09state-top {
+=09=09=09label =3D "Tri-state key top";
+=09=09=09linux,code =3D <KEY_A>;
+=09=09=09// gpios =3D <&tlmm 40 GPIO_ACTIVE_LOW>;
+=09=09=09interrupt-parent =3D <&tlmm>;
+=09=09=09interrupts =3D <24 IRQ_TYPE_EDGE_FALLING>;
+=09=09=09debounce-interval =3D <500>;
+=09=09=09linux,can-disable;
+=09=09};
+
+=09=09state-middle {
+=09=09=09label =3D "Tri-state key middle";
+=09=09=09linux,code =3D <KEY_B>;
+=09=09=09// gpios =3D <&tlmm 42 GPIO_ACTIVE_LOW>;
+=09=09=09interrupt-parent =3D <&tlmm>;
+=09=09=09interrupts =3D <52 IRQ_TYPE_EDGE_FALLING>;
+=09=09=09debounce-interval =3D <500>;
+=09=09=09linux,can-disable;
+=09=09};
+
+=09=09state-bottom {
+=09=09=09label =3D "Tri-state key bottom";
+=09=09=09linux,code =3D <KEY_C>;
+=09=09=09// gpios =3D <&tlmm 26 GPIO_ACTIVE_LOW>;
+=09=09=09interrupt-parent =3D <&tlmm>;
+=09=09=09interrupts =3D <126 IRQ_TYPE_EDGE_FALLING>;
+=09=09=09debounce-interval =3D <500>;
+=09=09=09linux,can-disable;
+=09=09};
+=09};
+
+=09gpio_vol_keys: gpio-keys {
+=09=09compatible =3D "gpio-keys";
+=09=09label =3D "Volume keys";
+=09=09autorepeat;
+
+=09=09pinctrl-names =3D "default";
+=09=09pinctrl-0 =3D <&volume_down_gpio &volume_up_gpio>;
+
+=09=09vol-down {
+=09=09=09label =3D "Volume down";
+=09=09=09linux,code =3D <KEY_VOLUMEDOWN>;
+=09=09=09gpios =3D <&pm8998_gpio 5 GPIO_ACTIVE_LOW>;
+=09=09=09debounce-interval =3D <15>;
+=09=09};
+
+=09=09vol-up {
+=09=09=09label =3D "Volume up";
+=09=09=09linux,code =3D <KEY_VOLUMEUP>;
+=09=09=09gpios =3D <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
+=09=09=09debounce-interval =3D <15>;
+=09=09};
+=09};
+
+=09extcon_usb1: extcon-usb-1 {
+=09=09compatible =3D "linux,extcon-usb-gpio";
+=09=09id-gpio =3D <&tlmm 38 GPIO_ACTIVE_HIGH>;
+=09};
+};
+
+&apps_rsc {
+=09pm8998-rpmh-regulators {
+=09=09compatible =3D "qcom,pm8998-rpmh-regulators";
+=09=09qcom,pmic-id =3D "a";
+
+=09=09vdd-s1-supply =3D <&vph_pwr>;
+=09=09vdd-s2-supply =3D <&vph_pwr>;
+=09=09vdd-s3-supply =3D <&vph_pwr>;
+=09=09vdd-s4-supply =3D <&vph_pwr>;
+=09=09vdd-s5-supply =3D <&vph_pwr>;
+=09=09vdd-s6-supply =3D <&vph_pwr>;
+=09=09vdd-s7-supply =3D <&vph_pwr>;
+=09=09vdd-s8-supply =3D <&vph_pwr>;
+=09=09vdd-s9-supply =3D <&vph_pwr>;
+=09=09vdd-s10-supply =3D <&vph_pwr>;
+=09=09vdd-s11-supply =3D <&vph_pwr>;
+=09=09vdd-s12-supply =3D <&vph_pwr>;
+=09=09vdd-s13-supply =3D <&vph_pwr>;
+=09=09vdd-l1-l27-supply =3D <&vreg_s7a_1p025>;
+=09=09vdd-l2-l8-l17-supply =3D <&vreg_s3a_1p35>;
+=09=09vdd-l3-l11-supply =3D <&vreg_s7a_1p025>;
+=09=09vdd-l4-l5-supply =3D <&vreg_s7a_1p025>;
+=09=09vdd-l6-supply =3D <&vph_pwr>;
+=09=09vdd-l7-l12-l14-l15-supply =3D <&vreg_s5a_2p04>;
+=09=09vdd-l9-supply =3D <&vreg_bob>;
+=09=09vdd-l10-l23-l25-supply =3D <&vreg_bob>;
+=09=09vdd-l13-l19-l21-supply =3D <&vreg_bob>;
+=09=09vdd-l16-l28-supply =3D <&vreg_bob>;
+=09=09vdd-l18-l22-supply =3D <&vreg_bob>;
+=09=09vdd-l20-l24-supply =3D <&vreg_bob>;
+=09=09vdd-l26-supply =3D <&vreg_s3a_1p35>;
+=09=09vin-lvs-1-2-supply =3D <&vreg_s4a_1p8>;
+
+=09=09vreg_s2a_1p125: smps2 {
+=09=09=09regulator-min-microvolt =3D <1100000>;
+=09=09=09regulator-max-microvolt =3D <1100000>;
+=09=09};
+
+=09=09vreg_s3a_1p35: smps3 {
+=09=09=09regulator-min-microvolt =3D <1352000>;
+=09=09=09regulator-max-microvolt =3D <1352000>;
+=09=09};
+
+=09=09vreg_s5a_2p04: smps5 {
+=09=09=09regulator-min-microvolt =3D <1904000>;
+=09=09=09regulator-max-microvolt =3D <2040000>;
+=09=09};
+
+=09=09vreg_s7a_1p025: smps7 {
+=09=09=09regulator-min-microvolt =3D <900000>;
+=09=09=09regulator-max-microvolt =3D <1028000>;
+=09=09};
+
+=09=09vdd_qusb_hs0:
+=09=09vdda_hp_pcie_core:
+=09=09vdda_mipi_csi0_0p9:
+=09=09vdda_mipi_csi1_0p9:
+=09=09vdda_mipi_csi2_0p9:
+=09=09vdda_mipi_dsi0_pll:
+=09=09vdda_mipi_dsi1_pll:
+=09=09vdda_qlink_lv:
+=09=09vdda_qlink_lv_ck:
+=09=09vdda_qrefs_0p875:
+=09=09vdda_pcie_core:
+=09=09vdda_pll_cc_ebi01:
+=09=09vdda_pll_cc_ebi23:
+=09=09vdda_sp_sensor:
+=09=09vdda_ufs1_core:
+=09=09vdda_ufs2_core:
+=09=09vdda_usb1_ss_core:
+=09=09vdda_usb2_ss_core:
+=09=09vreg_l1a_0p875: ldo1 {
+=09=09=09regulator-min-microvolt =3D <880000>;
+=09=09=09regulator-max-microvolt =3D <880000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09};
+
+=09=09vddpx_10:
+=09=09vreg_l2a_1p2: ldo2 {
+=09=09=09regulator-min-microvolt =3D <1200000>;
+=09=09=09regulator-max-microvolt =3D <1200000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09=09regulator-always-on;
+=09=09};
+
+=09=09vreg_l3a_1p0: ldo3 {
+=09=09=09regulator-min-microvolt =3D <1000000>;
+=09=09=09regulator-max-microvolt =3D <1000000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09};
+
+=09=09vdd_wcss_cx:
+=09=09vdd_wcss_mx:
+=09=09vdda_wcss_pll:
+=09=09vreg_l5a_0p8: ldo5 {
+=09=09=09regulator-min-microvolt =3D <800000>;
+=09=09=09regulator-max-microvolt =3D <800000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09};
+
+=09=09vddpx_13:
+=09=09vreg_l6a_1p8: ldo6 {
+=09=09=09regulator-min-microvolt =3D <1856000>;
+=09=09=09regulator-max-microvolt =3D <1856000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09};
+
+=09=09vreg_l7a_1p8: ldo7 {
+=09=09=09regulator-min-microvolt =3D <1800000>;
+=09=09=09regulator-max-microvolt =3D <1800000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09};
+
+=09=09vreg_l8a_1p2: ldo8 {
+=09=09=09regulator-min-microvolt =3D <1200000>;
+=09=09=09regulator-max-microvolt =3D <1248000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09};
+
+=09=09vreg_l9a_1p8: ldo9 {
+=09=09=09regulator-min-microvolt =3D <1704000>;
+=09=09=09regulator-max-microvolt =3D <2928000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09};
+
+=09=09vreg_l10a_1p8: ldo10 {
+=09=09=09regulator-min-microvolt =3D <1704000>;
+=09=09=09regulator-max-microvolt =3D <2928000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09};
+
+=09=09vreg_l11a_1p0: ldo11 {
+=09=09=09regulator-min-microvolt =3D <1000000>;
+=09=09=09regulator-max-microvolt =3D <1048000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09};
+
+=09=09vdd_qfprom:
+=09=09vdd_qfprom_sp:
+=09=09vdda_apc1_cs_1p8:
+=09=09vdda_gfx_cs_1p8:
+=09=09vdda_qrefs_1p8:
+=09=09vdda_qusb_hs0_1p8:
+=09=09vddpx_11:
+=09=09vreg_l12a_1p8: ldo12 {
+=09=09=09regulator-min-microvolt =3D <1800000>;
+=09=09=09regulator-max-microvolt =3D <1800000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09};
+
+=09=09vddpx_2:
+=09=09vreg_l13a_2p95: ldo13 {
+=09=09=09regulator-min-microvolt =3D <1800000>;
+=09=09=09regulator-max-microvolt =3D <2960000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09};
+
+=09=09vreg_l14a_1p88: ldo14 {
+=09=09=09regulator-min-microvolt =3D <1800000>;
+=09=09=09regulator-max-microvolt =3D <1800000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09=09regulator-always-on;
+=09=09};
+
+=09=09vreg_l15a_1p8: ldo15 {
+=09=09=09regulator-min-microvolt =3D <1800000>;
+=09=09=09regulator-max-microvolt =3D <1800000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09};
+
+=09=09vreg_l16a_2p7: ldo16 {
+=09=09=09regulator-min-microvolt =3D <2704000>;
+=09=09=09regulator-max-microvolt =3D <2704000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09};
+
+=09=09vreg_l17a_1p3: ldo17 {
+=09=09=09regulator-min-microvolt =3D <1304000>;
+=09=09=09regulator-max-microvolt =3D <1304000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09};
+
+=09=09vreg_l18a_2p7: ldo18 {
+=09=09=09regulator-min-microvolt =3D <2704000>;
+=09=09=09regulator-max-microvolt =3D <2960000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09};
+
+=09=09vreg_l19a_3p0: ldo19 {
+=09=09=09regulator-min-microvolt =3D <2856000>;
+=09=09=09regulator-max-microvolt =3D <3104000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09};
+
+=09=09vreg_l20a_2p95: ldo20 {
+=09=09=09regulator-min-microvolt =3D <2704000>;
+=09=09=09regulator-max-microvolt =3D <2960000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09};
+
+=09=09vreg_l21a_2p95: ldo21 {
+=09=09=09regulator-min-microvolt =3D <2704000>;
+=09=09=09regulator-max-microvolt =3D <2960000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09};
+
+=09=09vreg_l22a_2p85: ldo22 {
+=09=09=09regulator-min-microvolt =3D <2864000>;
+=09=09=09regulator-max-microvolt =3D <3312000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09};
+
+=09=09vreg_l23a_3p3: ldo23 {
+=09=09=09regulator-min-microvolt =3D <3000000>;
+=09=09=09regulator-max-microvolt =3D <3312000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09};
+
+=09=09vdda_qusb_hs0_3p1:
+=09=09vreg_l24a_3p075: ldo24 {
+=09=09=09regulator-min-microvolt =3D <3088000>;
+=09=09=09regulator-max-microvolt =3D <3088000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09};
+
+=09=09vreg_l25a_3p3: ldo25 {
+=09=09=09regulator-min-microvolt =3D <3300000>;
+=09=09=09regulator-max-microvolt =3D <3312000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09};
+
+=09=09vdda_hp_pcie_1p2:
+=09=09vdda_hv_ebi0:
+=09=09vdda_hv_ebi1:
+=09=09vdda_hv_ebi2:
+=09=09vdda_hv_ebi3:
+=09=09vdda_mipi_csi_1p25:
+=09=09vdda_mipi_dsi0_1p2:
+=09=09vdda_mipi_dsi1_1p2:
+=09=09vdda_pcie_1p2:
+=09=09vdda_ufs1_1p2:
+=09=09vdda_ufs2_1p2:
+=09=09vdda_usb1_ss_1p2:
+=09=09vdda_usb2_ss_1p2:
+=09=09vreg_l26a_1p2: ldo26 {
+=09=09=09regulator-min-microvolt =3D <1200000>;
+=09=09=09regulator-max-microvolt =3D <1200000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09};
+
+=09=09vreg_l28a_3p0: ldo28 {
+=09=09=09regulator-min-microvolt =3D <2856000>;
+=09=09=09regulator-max-microvolt =3D <3008000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
+=09=09};
+
+=09=09vreg_lvs1a_1p8: lvs1 {
+=09=09=09regulator-min-microvolt =3D <1800000>;
+=09=09=09regulator-max-microvolt =3D <1800000>;
+=09=09};
+
+=09=09vreg_lvs2a_1p8: lvs2 {
+=09=09=09regulator-min-microvolt =3D <1800000>;
+=09=09=09regulator-max-microvolt =3D <1800000>;
+=09=09};
+=09};
+
+=09pmi8998-rpmh-regulators {
+=09=09compatible =3D "qcom,pmi8998-rpmh-regulators";
+=09=09qcom,pmic-id =3D "b";
+
+=09=09vdd-bob-supply =3D <&vph_pwr>;
+
+=09=09vreg_bob: bob {
+=09=09=09regulator-min-microvolt =3D <3312000>;
+=09=09=09regulator-max-microvolt =3D <3600000>;
+=09=09=09regulator-initial-mode =3D <RPMH_REGULATOR_MODE_AUTO>;
+=09=09=09regulator-allow-bypass;
+=09=09};
+=09};
+
+=09pm8005-rpmh-regulators {
+=09=09compatible =3D "qcom,pm8005-rpmh-regulators";
+=09=09qcom,pmic-id =3D "c";
+
+=09=09vdd-s1-supply =3D <&vph_pwr>;
+=09=09vdd-s2-supply =3D <&vph_pwr>;
+=09=09vdd-s3-supply =3D <&vph_pwr>;
+=09=09vdd-s4-supply =3D <&vph_pwr>;
+
+=09=09vreg_s3c_0p6: smps3 {
+=09=09=09regulator-min-microvolt =3D <600000>;
+=09=09=09regulator-max-microvolt =3D <600000>;
+=09=09};
+=09};
+};
+
+/* Reserved memory changes */
+/*
+ * The rmtfs memory region in downstream is 'dynamically allocated'
+ * but given the same address every time. hard code it here as this addres=
s is
+ * where the modem firmware expects it to be.
+ */
+/delete-node/ &rmtfs_mem;
+
+/ {
+=09reserved-memory {
+=09=09rmtfs_mem: memory@f5b01000 {
+=09=09=09compatible =3D "qcom,rmtfs-mem";
+=09=09=09reg =3D <0 0xf5b01000 0 0x200000>;
+=09=09=09no-map;
+
+=09=09=09qcom,client-id =3D <1>;
+=09=09=09qcom,vmid =3D <15>;
+=09=09};
+
+=09=09/*
+=09=09 * This must be reserved as the device will
+=09=09 * crash if memory is allocated here.
+=09=09 */
+=09=09removed_region: memory@88f00000 {
+=09=09=09no-map;
+=09=09=09reg =3D <0 0x88f00000 0 0x1c00000>;
+=09=09};
+
+=09=09ramoops: ramoops@ac300000 {
+=09=09=09compatible =3D "ramoops";
+=09=09=09reg =3D <0 0xac300000 0 0x400000>;
+=09=09=09record-size =3D <0x40000>;
+=09=09=09console-size =3D <0x40000>;
+=09=09=09ftrace-size =3D <0x40000>;
+=09=09=09pmsg-size =3D <0x200000>;
+=09=09=09devinfo-size =3D <0x1000>;
+=09=09=09ecc-size =3D <16>;
+=09=09};
+=09};
+};
+
+&gcc {
+=09protected-clocks =3D <GCC_QSPI_CORE_CLK>,
+=09=09=09   <GCC_QSPI_CORE_CLK_SRC>,
+=09=09=09   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
+=09=09=09   <GCC_LPASS_Q6_AXI_CLK>,
+=09=09=09   <GCC_LPASS_SWAY_CLK>;
+};
+
+&gpu {
+=09zap-shader {
+=09=09memory-region =3D <&gpu_mem>;
+=09=09firmware-name =3D "qcom/sdm845/oneplus6/a630_zap.mbn";
+=09};
+};
+
+&adsp_pas {
+=09status =3D "okay";
+=09firmware-name =3D "qcom/sdm845/oneplus6/adsp.mbn";
+};
+
+&cdsp_pas {
+=09status =3D "okay";
+=09firmware-name =3D "qcom/sdm845/oneplus6/cdsp.mbn";
+};
+
+/* Modem/wifi*/
+&mss_pil {
+=09status =3D "okay";
+=09firmware-name =3D "qcom/sdm845/oneplus6/mba.mbn", "qcom/sdm845/oneplus6=
/modem.mbn";
+};
+
+&uart6 {
+=09status =3D "okay";
+
+=09bluetooth {
+=09=09compatible =3D "qcom,wcn3990-bt";
+
+=09=09/* In subdir qca/ in /lib/firmware */
+=09=09firmware-name =3D "oneplus6/crnv21.bin";
+
+=09=09vddio-supply =3D <&vreg_s4a_1p8>;
+=09=09vddxo-supply =3D <&vreg_l7a_1p8>;
+=09=09vddrf-supply =3D <&vreg_l17a_1p3>;
+=09=09vddch0-supply =3D <&vreg_l25a_3p3>;
+=09=09max-speed =3D <3200000>;
+=09};
+};
+
+&qup_uart6_default {
+=09pinmux {
+=09=09 pins =3D "gpio45", "gpio46", "gpio47", "gpio48";
+=09=09 function =3D "qup6";
+=09};
+
+=09cts {
+=09=09pins =3D "gpio45";
+=09=09bias-pull-down;
+=09};
+
+=09rts-tx {
+=09=09pins =3D "gpio46", "gpio47";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09rx {
+=09=09pins =3D "gpio48";
+=09=09bias-pull-up;
+=09};
+};
+
+&ufs_mem_hc {
+=09status =3D "okay";
+
+=09reset-gpios =3D <&tlmm 150 GPIO_ACTIVE_LOW>;
+
+=09vcc-supply =3D <&vreg_l20a_2p95>;
+=09vcc-max-microamp =3D <600000>;
+};
+
+&ufs_mem_phy {
+=09status =3D "okay";
+
+=09vdda-phy-supply =3D <&vdda_ufs1_core>;
+=09vdda-pll-supply =3D <&vdda_ufs1_1p2>;
+};
+
+&usb_1 {
+=09status =3D "okay";
+
+=09/* disable USB3 clock requirement as we are in USB 2 mode */
+=09qcom,select-utmi-as-pipe-clk;
+};
+
+&usb_1_dwc3 {
+=09/*
+=09 * Can't detect USB cable being plugged / unplugged, so this is needed
+=09 * for gadget mode
+=09 */
+=09dr_mode =3D "peripheral";
+
+=09/* fastest mode for USB 2 */
+=09maximum-speed =3D "high-speed";
+
+=09extcon =3D <&extcon_usb1>;
+
+=09/* Remove USB3 phy */
+=09phys =3D <&usb_1_hsphy>;
+=09phy-names =3D "usb2-phy";
+};
+
+&usb_1_hsphy {
+=09status =3D "okay";
+
+=09vdd-supply =3D <&vdda_usb1_ss_core>;
+=09vdda-pll-supply =3D <&vdda_qusb_hs0_1p8>;
+=09vdda-phy-dpdm-supply =3D <&vdda_qusb_hs0_3p1>;
+
+=09qcom,imp-res-offset-value =3D <8>;
+=09qcom,hstx-trim-value =3D <QUSB2_V2_HSTX_TRIM_21_6_MA>;
+=09qcom,preemphasis-level =3D <QUSB2_V2_PREEMPHASIS_5_PERCENT>;
+=09qcom,preemphasis-width =3D <QUSB2_V2_PREEMPHASIS_WIDTH_HALF_BIT>;
+};
+
+&wifi {
+=09status =3D "okay";
+=09vdd-0.8-cx-mx-supply =3D <&vreg_l5a_0p8>;
+=09vdd-1.8-xo-supply =3D <&vreg_l7a_1p8>;
+=09vdd-1.3-rfa-supply =3D <&vreg_l17a_1p3>;
+=09vdd-3.3-ch0-supply =3D <&vreg_l25a_3p3>;
+
+=09qcom,snoc-host-cap-8bit-quirk;
+};
+
+&mdss {
+=09status =3D "okay";
+};
+
+&mdss_mdp {
+=09status =3D "okay";
+};
+
+&dsi0 {
+=09status =3D "okay";
+=09vdda-supply =3D <&vdda_mipi_dsi0_1p2>;
+
+=09#address-cells =3D <1>;
+=09#size-cells =3D <0>;
+
+=09display_panel: panel@0 {
+=09=09status =3D "disabled";
+
+=09=09#address-cells =3D <1>;
+=09=09#size-cells =3D <0>;
+=09=09reg =3D <0>;
+
+=09=09vddio-supply =3D <&vreg_l14a_1p88>;
+
+=09=09reset-gpios =3D <&tlmm 6 GPIO_ACTIVE_HIGH>;
+
+=09=09pinctrl-names =3D "default";
+=09=09pinctrl-0 =3D <&panel_reset_pins &panel_te_pin &panel_esd_pin>;
+
+
+=09=09port {
+=09=09=09panel_in: endpoint {
+=09=09=09=09remote-endpoint =3D <&dsi0_out>;
+=09=09=09};
+=09=09};
+=09};
+};
+
+&dsi0_out {
+=09remote-endpoint =3D <&panel_in>;
+=09data-lanes =3D <0 1 2 3>;
+};
+
+&dsi0_phy {
+=09status =3D "okay";
+=09vdds-supply =3D <&vdda_mipi_dsi0_pll>;
+};
+
+/* GENI device - does i2c, uart, spi and all that stuff */
+&qupv3_id_1 {
+=09status =3D "okay";
+};
+
+&qupv3_id_0 {
+=09status =3D "okay";
+};
+
+&i2c10 {
+=09=09status =3D "okay";
+=09=09clock-frequency =3D <100000>;
+
+=09=09bq27541_battery: bq27541-battery@55 {
+=09=09=09=09status =3D "okay";
+=09=09=09=09compatible =3D "ti,bq27541";
+=09=09=09=09reg =3D <0x55>;
+=09=09};
+};
+
+&i2c12 {
+=09status =3D "okay";
+
+=09touchscreen: synaptics-rmi4-i2c@20 {
+=09=09compatible =3D "syna,rmi4-i2c";
+=09=09reg =3D <0x20>;
+=09=09#address-cells =3D <1>;
+=09=09#size-cells =3D <0>;
+=09=09interrupts-extended =3D <&tlmm 125 0x2008>; // IRQF_ONESHOT | IRQF_T=
RIGGER_LOW
+
+=09=09pinctrl-names =3D "default";
+=09=09pinctrl-0 =3D <&ts_default_pins &ts_enable_1p8>;
+
+=09=09vdd-supply =3D <&vreg_l28a_3p0>;
+=09=09vio-supply =3D <&vreg_l6a_1p8>;
+
+=09=09syna,reset-delay-ms =3D <200>;
+=09=09syna,startup-delay-ms =3D <200>;
+
+=09=09rmi4-f01@1 {
+=09=09=09reg =3D <0x01>;
+=09=09=09syna,nosleep-mode =3D <1>;
+=09=09};
+
+=09=09rmi4_f12: rmi4-f12@12 {
+=09=09=09reg =3D <0x12>;
+=09=09=09touchscreen-x-mm =3D <68>;
+=09=09=09touchscreen-y-mm =3D <144>;
+=09=09=09syna,sensor-type =3D <1>;
+=09=09=09syna,rezero-wait-ms =3D <200>;
+=09=09};
+=09};
+};
+
+/* PINCTRL - additions to nodes defined in sdm845.dtsi */
+
+&qup_i2c12_default {
+=09 mux {
+=09=09 pins =3D "gpio49", "gpio50";
+=09=09 function =3D "qup12";
+=09 };
+=09 config {
+=09=09 pins =3D "gpio49", "gpio50";
+=09=09 drive-strength =3D <2>;
+=09=09bias-disable;
+=09 };
+};
+
+&qup_i2c10_default {
+=09pinconf {
+=09=09pins =3D "gpio55", "gpio56";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+};
+
+&qup_uart9_default {
+=09pinconf-tx {
+=09=09pins =3D "gpio4";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09pinconf-rx {
+=09=09pins =3D "gpio5";
+=09=09drive-strength =3D <2>;
+=09=09bias-pull-up;
+=09};
+};
+
+&pm8998_gpio {
+=09volume_down_gpio: pm8998_gpio5 {
+=09=09pinconf {
+=09=09=09pins =3D "gpio5";
+=09=09=09function =3D "normal";
+=09=09=09input-enable;
+=09=09=09bias-pull-up;
+=09=09=09qcom,drive-strength =3D <0>;
+=09=09};
+=09};
+
+=09volume_up_gpio: pm8998_gpio6 {
+=09=09pinconf {
+=09=09=09pins =3D "gpio6";
+=09=09=09function =3D "normal";
+=09=09=09input-enable;
+=09=09=09bias-pull-up;
+=09=09=09qcom,drive-strength =3D <0>;
+=09=09};
+=09};
+};
+
+&tlmm {
+=09gpio-reserved-ranges =3D <0 4>, <81 4>;
+
+=09sdc2_clk: sdc2-clk {
+=09=09pinconf {
+=09=09=09pins =3D "sdc2_clk";
+=09=09=09bias-disable;
+
+=09=09=09/*
+=09=09=09 * It seems that mmc_test reports errors if drive
+=09=09=09 * strength is not 16 on clk, cmd, and data pins.
+=09=09=09 */
+=09=09=09drive-strength =3D <16>;
+=09=09};
+=09};
+
+=09sdc2_cmd: sdc2-cmd {
+=09=09pinconf {
+=09=09=09pins =3D "sdc2_cmd";
+=09=09=09bias-pull-up;
+=09=09=09drive-strength =3D <16>;
+=09=09};
+=09};
+
+=09sdc2_data: sdc2-data {
+=09=09pinconf {
+=09=09=09pins =3D "sdc2_data";
+=09=09=09bias-pull-up;
+=09=09=09drive-strength =3D <16>;
+=09=09};
+=09};
+
+=09tri_state_key_default: tri_state_key_default {
+=09=09mux {
+=09=09=09pins =3D "gpio40", "gpio42", "gpio26";
+=09=09=09function =3D "gpio";
+=09=09};
+
+=09=09config {
+=09=09=09pins =3D "gpio40", "gpio42", "gpio26";
+=09=09=09drive-strength =3D <2>;
+=09=09=09bias-disable;
+=09=09};
+=09};
+
+=09ts_default_pins: ts-int {
+=09=09mux {
+=09=09=09pins =3D "gpio99", "gpio125";
+=09=09=09function =3D "gpio";
+=09=09};
+
+=09=09config {
+=09=09=09pins =3D "gpio99", "gpio125";
+=09=09=09drive-strength =3D <16>;
+=09=09=09bias-pull-up;
+=09=09};
+=09};
+
+=09ts_enable_1p8: ts-1p8 {
+=09=09mux {
+=09=09=09pins =3D "gpio88";
+=09=09=09function =3D "gpio";
+=09=09};
+
+=09=09config {
+=09=09=09pins =3D "gpio88";
+=09=09=09drive-strength =3D <16>;
+=09=09=09bias-pull-up;
+=09=09};
+=09};
+
+=09panel_reset_pins: panel-reset {
+=09=09mux {
+=09=09=09pins =3D "gpio6", "gpio25", "gpio26";
+=09=09=09function =3D "gpio";
+=09=09};
+
+=09=09config {
+=09=09=09pins =3D "gpio6", "gpio25", "gpio26";
+=09=09=09drive-strength =3D <8>;
+=09=09=09bias-disable =3D <0>;
+=09=09};
+=09};
+
+=09panel_te_pin: panel-te {
+=09=09mux {
+=09=09=09pins =3D "gpio10";
+=09=09=09function =3D "mdp_vsync";
+=09=09};
+
+=09=09config {
+=09=09=09pins =3D "gpio10";
+=09=09=09drive-strength =3D <2>;
+=09=09=09bias-disable;
+=09=09=09input-enable;
+=09=09};
+=09};
+
+=09panel_esd_pin: panel-esd {
+=09=09mux {
+=09=09=09pins =3D "gpio30";
+=09=09=09function =3D "gpio";
+=09=09};
+=09=09config {
+=09=09=09pins =3D "gpio30";
+=09=09=09drive-strength =3D <2>;
+=09=09=09bias-pull-down;
+=09=09=09input-enable;
+=09=09};
+=09};
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts b/arch/a=
rm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
new file mode 100644
index 000000000000..a62e211a2797
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SDM845 OnePlus 6 (enchilada) specific device tree
+ *
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+#include "sdm845-oneplus-common.dtsi"
+
+/ {
+=09model =3D "OnePlus 6";
+=09compatible =3D "oneplus,enchilada", "oneplus,oneplus6", "qcom,sdm845";
+};
+
+&display_panel {
+=09status =3D "okay";
+
+=09compatible =3D "samsung,sofef00";
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts b/arch/arm6=
4/boot/dts/qcom/sdm845-oneplus-fajita.dts
new file mode 100644
index 000000000000..d418389bb2d0
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SDM845 OnePlus 6T (fajita) specific device tree
+ *
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+#include "sdm845-oneplus-common.dtsi"
+
+/ {
+=09model =3D "OnePlus 6T";
+=09compatible =3D "oneplus,fajita", "oneplus,oneplus6", "qcom,sdm845";
+};
+
+&display_panel {
+=09status =3D "okay";
+
+=09compatible =3D "samsung,s6e3fc2x01";
+};
--=20
2.28.0


