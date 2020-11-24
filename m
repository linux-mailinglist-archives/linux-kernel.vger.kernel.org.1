Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B662C2E65
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 18:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390786AbgKXRXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 12:23:44 -0500
Received: from softboy.mntmn.com ([91.250.115.15]:60756 "EHLO
        softboy.mntmn.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390777AbgKXRXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:23:43 -0500
From:   "Lukas F. Hartmann" <lukas@mntre.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 softboy.mntmn.com D4821720ECC
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mntre.com;
        s=mntremail; t=1606238621;
        bh=w88HgVw33TppRmJTlbGBuvb+C//o7V65GBjnOWx40L4=;
        h=From:To:Cc:Subject:Date:From;
        b=Ap1UOOPbOSq1q5D32AHrfe5ALKdHaLMV+UmaJIMVcpJ+OFrABKA2ZRykjLsrq+Jmm
         h6CCKF/YCA0Co25KnP17FpVps8kN+ifWGBYgSpskLAv0UgLWDWCr94lny5zbmtjF91
         zgiMyexTSWb0mNz9wjS8YBhq+kaQIr8WLNkbU1S+GxyU9y9F+zd2A5HYSFKOKVBnVz
         V43r1WWVZ74cDwzK8Y3xUJl94ddtEbvdORPf0txgPua4qbpACiniKUOCaYZ2tR8Kkc
         Lu0+LnDLnD8Je2iUa0mSbfVaHZejvTAys9jVYjgHyKridh+vS8Hy0gRUz9ms+DNhKu
         i2M2kM5CnSBLg==
To:     lukas@mntre.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: wm8960: add DAC Slope switch
Date:   Tue, 24 Nov 2020 18:23:13 +0100
Message-Id: <20201124172313.981552-1-lukas@mntre.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WM8960 DAC has a "DAC Slope" switch that can toggle between two
different output filter curves. This patch adds support for it.

Signed-off-by: Lukas F. Hartmann <lukas@mntre.com>
---
 sound/soc/codecs/wm8960.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 660ec46ee..a15cd037d 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -126,6 +126,7 @@ struct wm8960_priv {
 	struct snd_soc_dapm_widget *rout1;
 	struct snd_soc_dapm_widget *out3;
 	bool deemph;
+	bool dacslope;
 	int lrclk;
 	int bclk;
 	int sysclk;
@@ -217,6 +218,33 @@ static int wm8960_put_deemph(struct snd_kcontrol *kcontrol,
 	return wm8960_set_deemph(component);
 }

+static int wm8960_put_dacslope(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8960_priv *wm8960 = snd_soc_component_get_drvdata(component);
+	unsigned int val = ucontrol->value.integer.value[0];
+
+	if (val > 1)
+		return -EINVAL;
+
+	wm8960->dacslope = val;
+
+	return snd_soc_component_update_bits(component, WM8960_DACCTL1,
+				   0x2, val<<1);
+}
+
+static int wm8960_get_dacslope(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8960_priv *wm8960 = snd_soc_component_get_drvdata(component);
+
+	ucontrol->value.integer.value[0] = wm8960->dacslope;
+	return 0;
+}
+
+
 static const DECLARE_TLV_DB_SCALE(adc_tlv, -9750, 50, 1);
 static const DECLARE_TLV_DB_SCALE(inpga_tlv, -1725, 75, 0);
 static const DECLARE_TLV_DB_SCALE(dac_tlv, -12750, 50, 1);
@@ -272,6 +300,9 @@ SOC_ENUM("DAC Polarity", wm8960_enum[1]),
 SOC_SINGLE_BOOL_EXT("DAC Deemphasis Switch", 0,
 		    wm8960_get_deemph, wm8960_put_deemph),

+SOC_SINGLE_BOOL_EXT("DAC Slope", 0,
+		    wm8960_get_dacslope, wm8960_put_dacslope),
+
 SOC_ENUM("3D Filter Upper Cut-Off", wm8960_enum[2]),
 SOC_ENUM("3D Filter Lower Cut-Off", wm8960_enum[3]),
 SOC_SINGLE("3D Volume", WM8960_3D, 1, 15, 0),
--
2.28.0
