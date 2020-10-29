Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CE729E4DD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732228AbgJ2HsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732205AbgJ2HoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:44:12 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75162C0613CF;
        Thu, 29 Oct 2020 00:44:11 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w65so1659588pfd.3;
        Thu, 29 Oct 2020 00:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ESVv+pY5jSD1d+HDXCLrZGsW+m8ltnbCHyHJOCs8m+I=;
        b=QXaJtgDUeYsx+AcGbv7NKaPCw/bNzWl7kGcmJ8UeBrLmEBrptvJTXdbPEdNcUqcjvS
         T9pUt8/HfBrbFIKq4OyEgYw6ozuCyIOATOKkehoUZPuZGvf6s6b4G80OhfbdlgCzmh8D
         7H3+BJFK+iK+v7/NKL6FUSbsJT6cGSzQ20a2NtQju6a40ATQ65huUbx76b+EmuzKG1//
         m0BZ+AYHX8/4e3HzYF0QIYp+pF/gDOSi3gU+oXDpHgv1Cha/xPY3eXzwhlqFnf0YTBeS
         nSlPC7+zT6IZJhLUiWJ5uODsK8PKb/XgShs/rfyHug0//TfXmQe++1QQWuVNm223KBsI
         WGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ESVv+pY5jSD1d+HDXCLrZGsW+m8ltnbCHyHJOCs8m+I=;
        b=D+WJM38rXTiivTICdmaQWhaBxpSFZOTARcdyPRAQQ8S6ioXEu+h/1XXBgUf+h/uhlS
         uv2EW3IW2fnQgXWtoKQH7DwMiO8sLYioK/5z6LO481Bdl2KAX+Kekd4bXVFQD4tHdcaA
         FIBy7gwCMX8GfEMrJwFPda1voUVtV8Xy1ya5VjoNh/GXdorP4bxQlbLsmv3HWSajGvA0
         /2za9e5h7LP7Ttj4iaPl9Zzyx3MrQ3GPb06D0ZEdrFmC0Ca6eyqucrGdlZxp/MWYgOFK
         X4cH6ITZQq5crhRMH+UM5eAKvuYAzclniFc3bkM7QDcCQ9lCVU+t9xYHEVnod2G3kyLW
         6lIA==
X-Gm-Message-State: AOAM532S3xPvkYb4GG06oN72wPsaA7pOoC6eY26QXwtuN970CxJAgSDg
        B02LCAr6DW7iP5yV+Nc5aeU=
X-Google-Smtp-Source: ABdhPJzfU3gWLWZn9sHRpVXg6rAqMMuzgyKIAJpqJHIJWbB6Z1zMoTjgOJ8HqL/1lFSZ4IlWTLfSpg==
X-Received: by 2002:a63:b819:: with SMTP id p25mr3005032pge.282.1603957451120;
        Thu, 29 Oct 2020 00:44:11 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id nm11sm1920467pjb.24.2020.10.29.00.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:44:10 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...),
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 09/25] ASoC: tegra: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:42:45 +0800
Message-Id: <20201029074301.226644-9-coiby.xu@gmail.com>
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
 sound/soc/tegra/tegra30_ahub.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
index 156e3b9d613c..9fc22d5e9f6e 100644
--- a/sound/soc/tegra/tegra30_ahub.c
+++ b/sound/soc/tegra/tegra30_ahub.c
@@ -629,7 +629,6 @@ static int tegra30_ahub_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int tegra30_ahub_suspend(struct device *dev)
 {
 	regcache_mark_dirty(ahub->regmap_ahub);
@@ -653,7 +652,6 @@ static int tegra30_ahub_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
 static const struct dev_pm_ops tegra30_ahub_pm_ops = {
 	SET_RUNTIME_PM_OPS(tegra30_ahub_runtime_suspend,
-- 
2.28.0

