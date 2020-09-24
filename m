Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4199C276E89
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 12:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgIXKVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 06:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgIXKVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 06:21:00 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1C2C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 03:21:00 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k13so1640466pfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 03:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UnX/s8dZ825hFV3NINASU3thAKHqLnvKzLvNJDhsTxw=;
        b=nH3eZDk35EHcCWXWaKQIMkR+yP2F/bGhle8z+L+nODfmh49vfcG+D/AlVlDcNwF93h
         7Fa3DZyfzvLB2U5j7+Xjsa5/jBMi0ROHZCDnB4SoKEBoGbrPipDk+jFISQNbL4AGwCuy
         Om6S0Lwy7DhMMeb7B6X+UUluQOdKRvNTfcr1aiB/kVWRYwec26OpvHPbBBMM5M98Zemf
         5tpIzf6p8z2ouj7VU93SiovfoQvUiSpgIDFDiLSbDd949AzNO9OH44VfgxZHr7sImXgA
         z0OzZjfgKEWmVn8+zbHWU93BWyHGvCslNmiw74IzdzBFgrY9dYo415wMQ/BWvE62o7Gp
         5rQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UnX/s8dZ825hFV3NINASU3thAKHqLnvKzLvNJDhsTxw=;
        b=Tiw19yas/yF5iF+8iNeIfdoaZmlwosKl0TmdBwmdrOBK+S2iqi4sX7TV8+kMJtitbR
         7tQ444KALu7pBtUw8A5cTsLnGDERDDxoUTcRfsBimd1j9lP70WzRshHHFdn6MssBW6nP
         5df8GeDm+TnEPGzoYs23uxWZvJ881ESt4j42J6WlmZcX8YJb1cZosazhhUlVO3wVQ4Zl
         zI4zscoFbepLI9KMujfHSAFL7Vh1G1m8DRXfQvYpHnjwm2jFYIfsnU4wmmiuR8KWZv1x
         MOM1Ys2d4d12GN9WWARMvTrduyMJONuY91GaPMAzKbOAjxQBJsx3ybpi1HX8H/Gfk0zM
         kiYw==
X-Gm-Message-State: AOAM531wZIOzT0JIHJn3TdbMabVJatPbooXpjPNsdvHPUTFfM0UYe394
        qmqvKx4yzVnJ287FNF8cD8M=
X-Google-Smtp-Source: ABdhPJxT9eCCvF0ZzSCxtrU4pmvcGxqZZRohK+ny2zGL4Vs2ipJgBjlDxeOkt33NdOvh5FEuwFwlPQ==
X-Received: by 2002:a63:2f07:: with SMTP id v7mr3297305pgv.67.1600942860497;
        Thu, 24 Sep 2020 03:21:00 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
        by smtp.gmail.com with ESMTPSA id fz23sm1922444pjb.36.2020.09.24.03.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 03:21:00 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        greybus-dev@lists.linaro.org (moderated list:GREYBUS SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list),
        alsa-devel@alsa-project.org (moderated list:SOUND)
Subject: [PATCH 3/3] [PATCH] staging: greybus: __u8 is sufficient for snd_ctl_elem_type_t and snd_ctl_elem_iface_t
Date:   Thu, 24 Sep 2020 18:20:39 +0800
Message-Id: <20200924102039.43895-3-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924102039.43895-1-coiby.xu@gmail.com>
References: <20200924102039.43895-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use __8 to replace int and remove the unnecessary __bitwise type attribute.

Found by sparse,

$ make C=2 drivers/staging/greybus/
drivers/staging/greybus/audio_topology.c:185:24: warning: cast to restricted snd_ctl_elem_type_t
drivers/staging/greybus/audio_topology.c:679:14: warning: restricted snd_ctl_elem_iface_t degrades to integer
drivers/staging/greybus/audio_topology.c:906:14: warning: restricted snd_ctl_elem_iface_t degrades to integer

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 drivers/staging/greybus/audio_topology.c | 2 +-
 include/uapi/sound/asound.h              | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
index 56bf1a4f95ad..f6023ff390c2 100644
--- a/drivers/staging/greybus/audio_topology.c
+++ b/drivers/staging/greybus/audio_topology.c
@@ -182,7 +182,7 @@ static int gbcodec_mixer_ctl_info(struct snd_kcontrol *kcontrol,
 	/* update uinfo */
 	uinfo->access = data->access;
 	uinfo->count = data->vcount;
-	uinfo->type = (snd_ctl_elem_type_t)info->type;
+	uinfo->type = info->type;
 
 	switch (info->type) {
 	case GB_AUDIO_CTL_ELEM_TYPE_BOOLEAN:
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 535a7229e1d9..8e71a95644ab 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -950,7 +950,7 @@ struct snd_ctl_card_info {
 	unsigned char components[128];	/* card components / fine identification, delimited with one space (AC97 etc..) */
 };
 
-typedef int __bitwise snd_ctl_elem_type_t;
+typedef __u8 snd_ctl_elem_type_t;
 #define	SNDRV_CTL_ELEM_TYPE_NONE	((__force snd_ctl_elem_type_t) 0) /* invalid */
 #define	SNDRV_CTL_ELEM_TYPE_BOOLEAN	((__force snd_ctl_elem_type_t) 1) /* boolean type */
 #define	SNDRV_CTL_ELEM_TYPE_INTEGER	((__force snd_ctl_elem_type_t) 2) /* integer type */
@@ -960,7 +960,7 @@ typedef int __bitwise snd_ctl_elem_type_t;
 #define	SNDRV_CTL_ELEM_TYPE_INTEGER64	((__force snd_ctl_elem_type_t) 6) /* 64-bit integer type */
 #define	SNDRV_CTL_ELEM_TYPE_LAST	SNDRV_CTL_ELEM_TYPE_INTEGER64
 
-typedef int __bitwise snd_ctl_elem_iface_t;
+typedef __u8 snd_ctl_elem_iface_t;
 #define	SNDRV_CTL_ELEM_IFACE_CARD	((__force snd_ctl_elem_iface_t) 0) /* global control */
 #define	SNDRV_CTL_ELEM_IFACE_HWDEP	((__force snd_ctl_elem_iface_t) 1) /* hardware dependent device */
 #define	SNDRV_CTL_ELEM_IFACE_MIXER	((__force snd_ctl_elem_iface_t) 2) /* virtual mixer device */
-- 
2.28.0

