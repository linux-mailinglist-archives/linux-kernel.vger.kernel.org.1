Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0D02D7C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 18:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394501AbgLKRHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 12:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732146AbgLKRHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 12:07:13 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB43C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 09:06:32 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r7so9755187wrc.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 09:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g8zX5fIH9uKJS0RZzLnoP4TzFB+P9VHxAQFkUoP/67o=;
        b=QPdgAmqayhSJPmy887Ad16AJkqcIS/QoRc1rogbiRUibbD7IewVil7Fbq0GrqbKdsM
         PfomXTQRE678qiS0L3z3u8hW33MVPEN5uwT0FR9Oo/je/6HVEuf/lh3VNMnfK7S62lEF
         7xgRmfSXLJPEEDiHxDplLx8DDAtjH6LOds3+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g8zX5fIH9uKJS0RZzLnoP4TzFB+P9VHxAQFkUoP/67o=;
        b=FACixEtFj8DWJqidyDOKxI5uVFMVJnr8XKUM3/H2v2qdV3eOn/2p3OcXiT0a+REXbn
         KF4QFXhU4NELz+0o/ENdhOpB8tI+M6MfQlofPmxpZ+Kyc2oIOoQok3YptE5sF4Yco72J
         G658Tea2049P8xeUTLj5KBLWzxG+tfWmhsDEccYSlKdHcEf0H20gEo5gULh/vEse8Ck/
         697+l1z7Kq0BorczsI+cJl2CvQONMRBTeWGBgvBYaEJjO2QGZthrOFoQivyQ9b9mnQf9
         zvLLOawD5NFlEhE7eYSrjcGQ9XZ8tShwC4p+EBQPRkOOrNkvoYoGQlMbtIF10uNUA4b4
         n7mQ==
X-Gm-Message-State: AOAM5332KQaEu3yEkF1/udVwY+PXe1BazyUYsZUcNm3AF1iao1nXHX2e
        bF/SBzW/jCgOMgWMiRbKtKv/37mBpiIu6w==
X-Google-Smtp-Source: ABdhPJyiv3j7K0H57fwiqhv5UkIV7W1Xa/63zhYkYCDfy2XnWY6xMQhBE6ef4VHZ7yxsWz1RrF49Sw==
X-Received: by 2002:adf:81a2:: with SMTP id 31mr14851609wra.381.1607706391726;
        Fri, 11 Dec 2020 09:06:31 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id h98sm17797100wrh.69.2020.12.11.09.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 09:06:31 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Mateusz Gorski <mateusz.gorski@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH] ASoC: Intel: Skylake: skl-topology: Fix OOPs ib skl_tplg_complete
Date:   Fri, 11 Dec 2020 18:06:29 +0100
Message-Id: <20201211170629.871085-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If dobj->control is not initialized we end up in an OOPs during
skl_tplg_complete:

[   26.553358] BUG: kernel NULL pointer dereference, address:
0000000000000078
[   26.561151] #PF: supervisor read access in kernel mode
[   26.566897] #PF: error_code(0x0000) - not-present page
[   26.572642] PGD 0 P4D 0
[   26.575479] Oops: 0000 [#1] PREEMPT SMP PTI
[   26.580158] CPU: 2 PID: 2082 Comm: udevd Tainted: G         C
5.4.81 #4
[   26.588232] Hardware name: HP Soraka/Soraka, BIOS
Google_Soraka.10431.106.0 12/03/2019
[   26.597082] RIP: 0010:skl_tplg_complete+0x70/0x144 [snd_soc_skl]

Fixes: 2d744ecf2b98 ("ASoC: Intel: Skylake: Automatic DMIC format configuration according to information from NHL")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 sound/soc/intel/skylake/skl-topology.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 40bee10b0c65..0955cbb4e918 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -3619,19 +3619,20 @@ static void skl_tplg_complete(struct snd_soc_component *component)
 
 	list_for_each_entry(dobj, &component->dobj_list, list) {
 		struct snd_kcontrol *kcontrol = dobj->control.kcontrol;
-		struct soc_enum *se =
-			(struct soc_enum *)kcontrol->private_value;
-		char **texts = dobj->control.dtexts;
+		struct soc_enum *se;
+		char **texts;
 		char chan_text[4];
 
-		if (dobj->type != SND_SOC_DOBJ_ENUM ||
-		    dobj->control.kcontrol->put !=
-		    skl_tplg_multi_config_set_dmic)
+		if (dobj->type != SND_SOC_DOBJ_ENUM || !kcontrol ||
+		    kcontrol->put != skl_tplg_multi_config_set_dmic)
 			continue;
+
+		se = (struct soc_enum *)kcontrol->private_value;
+		texts = dobj->control.dtexts;
 		sprintf(chan_text, "c%d", mach->mach_params.dmic_num);
 
 		for (i = 0; i < se->items; i++) {
-			struct snd_ctl_elem_value val;
+			struct snd_ctl_elem_value val = {};
 
 			if (strstr(texts[i], chan_text)) {
 				val.value.enumerated.item[0] = i;
-- 
2.29.2.576.ga3fc446d84-goog

