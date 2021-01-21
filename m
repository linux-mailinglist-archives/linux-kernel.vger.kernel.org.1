Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8762FF277
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389288AbhAURwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389097AbhAURwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:52:37 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C01DC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:51:55 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b2so3550247edm.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OCYYVMv5s714jVuwCabaovHSIiuYo1Mak9GI7N7bfpA=;
        b=cuSirrQ1oaAAyphXl4bCIjli2fQoncNhitI0+YSQr3brIfsbP9VbBs3jzssRkA++JE
         LG1K19NciHMQYyvSknHr5rL/fS73Lz6NxQ8nGH+Nb+j2A/pHWblY+1UbzpLedlTywnSI
         ZxPmTnpt0Py/TXigz0VWFJxdtIKfzBpfQdwjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OCYYVMv5s714jVuwCabaovHSIiuYo1Mak9GI7N7bfpA=;
        b=VcgjWfUTt0td7/LVpY74CKNT+lW0nKwiEUMqRUrZbTHk7ovmToUCcuwfSmsjoTK8rf
         CIzKfkm8Mc9jzaH4Ro3S4sAy0l+uejK/LWwyAYfHwByZtFU1MetlkBh3EWzu8TT24wEs
         rNDAOdecH9xn5kUiEcpIcXqJNhx2Ct/H3QWOXbt6zYqJawDUy12j1nsUeenGLpUyiToQ
         jhWmguGDMJSQ44ArRJdbP0zDRU4EcnTd4jqfWYala15j0gketddOFWx3uIFruEgho/eo
         n2Duff1ZsEkvtyw789FIqKJne6nyp4mc3lwYJRZjRA9QeT5Iho4wodHPneRJowZfpQ3s
         bNvQ==
X-Gm-Message-State: AOAM531yg5AZXvN+2/4dxFLtgW5R4DqCLrXlb8IzC0CQVL2Nd05BHZpM
        iFITDPHYyHTG+6twTCkBced6JA==
X-Google-Smtp-Source: ABdhPJyAt+sWJ5YT6v7cdGLKqc6+7CG9j6StKNytrRLmmdUplw06fy1GOc3aYmBcNgxFrk+wwAdvSw==
X-Received: by 2002:a05:6402:1249:: with SMTP id l9mr201913edw.375.1611251514174;
        Thu, 21 Jan 2021 09:51:54 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id w16sm3232349edv.4.2021.01.21.09.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 09:51:53 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Mateusz Gorski <mateusz.gorski@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lukasz Majczak <lma@semihalf.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 2/2] ASoC: Intel: Skylake: Zero snd_ctl_elem_value
Date:   Thu, 21 Jan 2021 18:51:51 +0100
Message-Id: <20210121175151.139111-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
In-Reply-To: <20210121175151.139111-1-ribalda@chromium.org>
References: <20210121175151.139111-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear struct snd_ctl_elem_value before calling ->put() to avoid any data
leak.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 sound/soc/intel/skylake/skl-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index ffd37aaecdf1..76a04a883e63 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -3632,7 +3632,7 @@ static void skl_tplg_complete(struct snd_soc_component *component)
 		sprintf(chan_text, "c%d", mach->mach_params.dmic_num);
 
 		for (i = 0; i < se->items; i++) {
-			struct snd_ctl_elem_value val;
+			struct snd_ctl_elem_value val = {};
 
 			if (strstr(texts[i], chan_text)) {
 				val.value.enumerated.item[0] = i;
-- 
2.30.0.296.g2bfb1c46d8-goog

