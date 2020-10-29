Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C7429E4AF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732870AbgJ2Ho5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgJ2HoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:44:20 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60402C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:44:20 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x13so1634456pfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OYt9DPsIOPNIqy5dqkJ5lCLLGf00bKzjgHV7/FKrm30=;
        b=bdYT7RCKiIF5bBkrbTYntlKdOqtia2YZXQxKoyrwimF4rI/i2LTRqUQwxtRz0JGJOK
         pJRd47FrtAMSOfTJ2MDoZXbTvtK/dw/1a/SMrHOhliTQlsu7NLGPDe6FLeTDqqVW7Zwd
         /u5vQxnES6QQW3KTbWdE8TQmp5yzB9TOuVCV3+wQNH26bIe0mim3pCggXrQDZPepbrDj
         239M/hFcPQOtqluGwkNXrQv286qOU6i4dX4LxERLdXOOYNY6SiEjhAywks7briuClUVH
         t2adBUU0kc1uK5VE5F5nq3FcryezcqR2epcnnBlciA/4MSZsn0D9Xrcl4vkglSHi7Slh
         KLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OYt9DPsIOPNIqy5dqkJ5lCLLGf00bKzjgHV7/FKrm30=;
        b=atCdXKZzbAB64IOFcw7Hnz4oFVnou1xaROxFYv+mxOpgIUZzlEZ6jL+bKJG2825LYN
         I3+x/pHwt3ZWBdUd3oykVNwVCQ23hMhJPfPYokHu02Im4AmLUpfeF5TnOzautVCAPG7+
         Z3VxG5+9vJuolvtlE089zDypCrK9zWxejyX7rUOV+TmYaGeuJyHR18Rf30X15mbbeO+u
         NVD4RIsjhsifN2HcXmq5Ur6TveoI+Xe63mCeMqfQpxPJml/NMkGWo9mONCgrE6SIRBpa
         U5np2s4kM8OPY3V3qfNrmjh3JG89thtQytqOC4PJzxPnkTNx5gz9/3t6E73Ts/K7pw/d
         WYsQ==
X-Gm-Message-State: AOAM5310WF2h98rRMieNiFeqkbHN3MrbfQp+N5Xx4UHI7P73gKznlVuF
        tJMoRj2R3xxdpqPjUK+4ZrK1mImcX2bZ5IrJ
X-Google-Smtp-Source: ABdhPJzgm6erpGiPMEQPgP+rXdOPNC3MCgogID7xTCjo1ei4Pu9gFwMcSe9ios3QobaPjrqK6DtEcw==
X-Received: by 2002:aa7:815a:0:b029:164:cc2e:2c56 with SMTP id d26-20020aa7815a0000b0290164cc2e2c56mr447859pfn.21.1603957460017;
        Thu, 29 Oct 2020 00:44:20 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id f8sm1541140pga.78.2020.10.29.00.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:44:19 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org (moderated list:INTEL ASoC DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 11/25] ASoC: hdac: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:42:47 +0800
Message-Id: <20201029074301.226644-11-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029074301.226644-1-coiby.xu@gmail.com>
References: <20201029074301.226644-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SET_SYSTEM_SLEEP_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 sound/soc/intel/skylake/skl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 8b993722f74e..da32d68080be 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -322,7 +322,6 @@ static int _skl_resume(struct hdac_bus *bus)
 }
 #endif
 
-#ifdef CONFIG_PM_SLEEP
 /*
  * power management
  */
@@ -400,7 +399,6 @@ static int skl_resume(struct device *dev)
 
 	return ret;
 }
-#endif /* CONFIG_PM_SLEEP */
 
 #ifdef CONFIG_PM
 static int skl_runtime_suspend(struct device *dev)
-- 
2.28.0

