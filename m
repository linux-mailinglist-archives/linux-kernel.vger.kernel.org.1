Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C1E2FF199
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388720AbhAURRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388718AbhAURRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:17:30 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482EAC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:16:48 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id h16so3390100edt.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0/+GpgvuePk5y5rT7DgZg88TKWg6HgWIEtHm/4SPvYk=;
        b=TlAdl9kykmD1P8xdaBiLP/CVTJil6R0WRqGcjLGa0Xd7IvaLQ5CJNu9qjhbTLlA6lb
         ML325dhK8IoWKsPeX53W58GFHa5wrUYMu8XTItWGvwquES8Q2sgP1sbJhEq+hVHZnlyI
         c3kv1DYo487l03dws8dcvqF3PySCv5rZ0Ln7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0/+GpgvuePk5y5rT7DgZg88TKWg6HgWIEtHm/4SPvYk=;
        b=A6aqjJ8h4Tv3/uxSg/CAlmDk2PoqHTg8ebdnYZMZ3glQcge+pDXpyvMqw53Rt8gxlF
         QCF5A5VWQAsWLzEYWoePHNpnenTkTDJBUGByGgPh4UBjoNbBNomYmEar7Anuogmi1pzn
         PllHw6upna9kokjF3AAtP2Li3qfX7q7IOPFbI+ytsynCelxx5K+yBOf655bvu89j90+F
         9ZNHaUn8gkFGfqppeAeCWDjUXYg2maIr4Jzo5uuTTSS4fxp+0IrOkwSpo1mQ1dEtnJwC
         +oFK0pnWPK02ColMx+QuFB4LmbTUV3eTb1GWclwnWJiKTnwqkFF+JEcmRsI4yPb0cpcN
         4kLA==
X-Gm-Message-State: AOAM532d1i3L0A7EdUznJ94AcMtRKch+0n7kI+XFB6YcVqwu8TKcNOO+
        7e5lTtLlcQIS0XkgnxhGE0TzsA==
X-Google-Smtp-Source: ABdhPJz/J+IUoG7YQaX0WCLW1b3i8j2HWQ7beFCMR/3jjiug2pWQbt+8OMM7chkSS8NPU00ACx7AXA==
X-Received: by 2002:a50:85c4:: with SMTP id q4mr123923edh.7.1611249406933;
        Thu, 21 Jan 2021 09:16:46 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id q9sm2484024ejd.113.2021.01.21.09.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 09:16:46 -0800 (PST)
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
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lukasz Majczak <lma@semihalf.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 1/2] ASoC: Intel: Skylake: skl-topology: Fix OOPs ib skl_tplg_complete
Date:   Thu, 21 Jan 2021 18:16:43 +0100
Message-Id: <20210121171644.131059-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
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
 sound/soc/intel/skylake/skl-topology.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index ae466cd59292..1ef30ca45410 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -3619,15 +3619,16 @@ static void skl_tplg_complete(struct snd_soc_component *component)
 
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
-- 
2.30.0.296.g2bfb1c46d8-goog

