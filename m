Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0CF2169D2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 12:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgGGKRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 06:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgGGKQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:16:59 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BE6C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:16:58 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so41530949wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pNlZaQWHbaIHYTs0iyc+dtmoOXHEctaupDIvIqecIP4=;
        b=yjtJryfpQL6B6O+GfgFViYidP0Zfm2TNnBAeSexpzgadJ0xpgfrAVW4b+dn87kGz6C
         EZ20LZ2Ach4spz+6mWWhfonGFfs2/rcy9nw1nAUr6v3gjXQ3E0cGVWpLruB6V7BWcVKA
         NCL298eJZDj7ZhP4xvIuCDI1BvtD35Mo5E9bGkX6iUv4iYAAQPpZP38IaOr9k6wvCT0n
         Jauv59h1FuWhqhRbx4pA4BUC4us6dOrcZW5shkE7d6GTM45WW2uOaKGiuBEwVYlhIvDm
         Ht9quBZq0GIUYGteKk4rPBi59T6GO0mAXIXQ0Kg0IC8E0hgNv6gc97KOTf9D6n8+RNH2
         QigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pNlZaQWHbaIHYTs0iyc+dtmoOXHEctaupDIvIqecIP4=;
        b=YklOEzA5NeLDOj1DzrQZwdx4zyzO+rFP0E6AnkTpPsNiszWTo6AE+q//WXo43wQmgM
         iANAK7sjHEmlLcRa6bn+sAalxkNafnXiX/DMUOij5OLzfwcVNMHsZMwt+q2WoM47A8WD
         HP4NGilD1A2TZhgwZ9lQh+PxYKjpj98Ko+7GHvpR7+GZLzeJyN5j0i81+IEQ/iuZFQPx
         rZaa+SOJ763cA/Cj0gRtXombn5TbGdSDL+zRWzLYpU5U6gNr6VvG+WXwiRdVqDq6Sexz
         Jc1UXMLt/PFM1tIFTXD135FWAAJVfgrH0vK/7IILq8zBJ3QKFdeTJz/ZJHzI1k/bDWeu
         rkxg==
X-Gm-Message-State: AOAM530i6oCAi/AK1MqqE2TMyEVTumX81L8zluYY9Fhz9//YQuOy47RZ
        JNQSG9JjqLHvRIFYthB9d23CYQ==
X-Google-Smtp-Source: ABdhPJwPGZGh7haWMlGt/1TcC8QGkDnJP2knf1a1NGX34zsnQYiFoWMcsNgAkfwT9eECzK95dCDJuA==
X-Received: by 2002:a5d:484b:: with SMTP id n11mr50993417wrs.320.1594117017437;
        Tue, 07 Jul 2020 03:16:57 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:16:56 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Vladimir Barinov <vbarinov@embeddedalley.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/28] ASoC: fsl: fsl_spdif: Use correct formatting when denoting struct documentation
Date:   Tue,  7 Jul 2020 11:16:21 +0100
Message-Id: <20200707101642.1747944-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects struct documentation to start with "struct $NAME".

Fixes the following W=1 kernel build warning(s):

 sound/soc/fsl/fsl_spdif.c:104: warning: cannot understand function prototype: 'struct fsl_spdif_priv '

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Vladimir Barinov <vbarinov@embeddedalley.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/fsl/fsl_spdif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 5b2689ae63d4d..7aa3bdec5b6b5 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -81,7 +81,7 @@ struct spdif_mixer_control {
 };
 
 /**
- * fsl_spdif_priv: Freescale SPDIF private data
+ * struct fsl_spdif_priv - Freescale SPDIF private data
  *
  * @fsl_spdif_control: SPDIF control data
  * @cpu_dai_drv: cpu dai driver
-- 
2.25.1

