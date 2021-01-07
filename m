Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C812ECE42
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbhAGKyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbhAGKyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:54:46 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB86EC0612F9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 02:54:05 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id h186so3646591pfe.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 02:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S75Szc7++nY1TyducuLbqYdGcj1o18w6RuvL7vJegts=;
        b=NlAhefOS9cbbZeUSDvp5H44CBKSZnjtM+1I63yOXlOg8kwKE8bajQgPtyxL3+q9zUI
         rrQSq+fN9FNfdegsMaG84D6B7IcihOBKpS/b8sBxS4uZ106wIc7ilBIc3Fxp8z68Vh/1
         PtHaGY0YX61gr4Ar5p0SzO9tmt23QwvOaRiSRch1yt9wyEIYpmLT+OqP0vekaarerHEi
         jYOIVm4ZX3VMzP6bMbB5stQk9il/hEuOdijx2k4Njqvwqm40hetIwDqM2rQ5EWuzeVv7
         by1/51uk1WAxIEjytNKmSI+czFD2q5DjfstxG9TKns3bxq6Ua4IwulS9LG6//uys30pr
         Zxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S75Szc7++nY1TyducuLbqYdGcj1o18w6RuvL7vJegts=;
        b=ayxyzhJBPCMDS6/HDpN6x4ft6JUq3FlT3AAwv1ZYnfjDmZ64iTe9TA48DL9uggOW9H
         1/mDnuaJ8S1fo0QMQBfUtDzfUMmhxTQKvVhuAEmhiAM3TMLdSljKjJJuiY0yNod/gPS5
         Qp9BsKrECuwFpMPvu+aZ5sJC1KKALOW/MKE9rjuZqAIBxo2TWdPFMqfCVVc67DvwkrXA
         maH32kBDqwgETtYdfASnzt3+GKeAufvH6M04rx8LREaJMMFDbsdm3MGZCXz+/umT20tP
         ZQpYSOWPhEcHlAuChqfZf0x7C8CHIjhMgUF7R9raVcAlqw7eVIRaEztgatTwhhgQYyDE
         VEPw==
X-Gm-Message-State: AOAM531BTntRZBSgQAeepx9y6ChHuKmkISyhZqQBuQoR+yxbPX929uLN
        sHG1bNpV+fMkutNL/9VzIV17yQ==
X-Google-Smtp-Source: ABdhPJxvMoxAdiXUF/sT3MRBy8A6NSDnI4JDYJys+nX1MROceZswyy5lG8DDldOqE4mKpdZ/xJO7Sw==
X-Received: by 2002:a63:c702:: with SMTP id n2mr1279619pgg.382.1610016845156;
        Thu, 07 Jan 2021 02:54:05 -0800 (PST)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id p187sm5426042pfp.60.2021.01.07.02.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 02:54:04 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH v2 4/4] ASoC: rt5645: Enable internal microphone and JD on ECS EF20
Date:   Thu,  7 Jan 2021 18:53:29 +0800
Message-Id: <20210107105329.146988-5-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210107105329.146988-1-chiu@endlessos.org>
References: <20210107105329.146988-1-chiu@endlessos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ECS EF20 series laptops, the internal mic is on DMIC2/IN2P.
And they need the inv_hp_det to make jack detection to work as
exoected.

Signed-off-by: Chris Chiu <chiu@endlessos.org>
---
  v1 -> v2:
        - none

 sound/soc/codecs/rt5645.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index ca1bdb67ecc5..6628b7e5a583 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3656,6 +3656,12 @@ static const struct rt5645_platform_data kahlee_platform_data = {
 	.jd_mode = 3,
 };
 
+static const struct rt5645_platform_data ecs_ef20_platform_data = {
+	.dmic1_data_pin = RT5645_DMIC1_DISABLE,
+	.dmic2_data_pin = RT5645_DMIC_DATA_IN2P,
+	.inv_hp_pol = 1,
+};
+
 static const struct acpi_gpio_params ef20_hp_detect = { 1, 0, false };
 
 static const struct acpi_gpio_mapping cht_rt5645_ef20_gpios[] = {
@@ -3804,6 +3810,7 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "EF20"),
 		},
+		.driver_data = (void *)&ecs_ef20_platform_data,
 	},
 	{
 		.ident = "EF20EA",
@@ -3811,6 +3818,7 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
 		},
+		.driver_data = (void *)&ecs_ef20_platform_data,
 	},
 };
 
-- 
2.20.1

