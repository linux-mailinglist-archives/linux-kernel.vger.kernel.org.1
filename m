Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C58216EFA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 16:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgGGOjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 10:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbgGGOhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:37:54 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79381C08C5E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:37:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 17so46725423wmo.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3bZAeFSvmpf6EGc1Rrn0+wIXui3QoI3bJ6wz54zb8+8=;
        b=fHAcXDu+0UDjAnGsZCpwvS2l6qqAL8KmU4/hZ2TsI5PgHIV4qOmanuD2x2pHG+neQR
         rVDB6l2WKwx9LfjnXOERwPjwChvNC3rPwvPr+IZCPGw1hiH87JNKO9AYKyl98eB2EGUz
         EaMvmCzXOLeW7e/lm3xuIV1iuSBcuhwlYAnYJWnAcibJ0GskYWUh8FAWSVx+dzSMe7Jz
         jBt66d+DjwY3WlVfNoEWnRqDkhkUdC7RN3K82BNOCWsgmoSOCy83skF07gRV0M6X9XRK
         0HKwjDOHWQxu2qf4f+WgVopEsOm+Oursvksd+98NeUY3Xw6x/oVQqoKftaB0RuJU/SGk
         HRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3bZAeFSvmpf6EGc1Rrn0+wIXui3QoI3bJ6wz54zb8+8=;
        b=Hlnsg9+JrhPN6uLBF00gCd4sHvrUmWkn1ESPDgF7prL14LX3yeck4wvqBLZYea0YNf
         XaSFGJBXgF2KunKvGnpp+CSe6bsAxYF9RcMV9jCQwmxPtNvdYPLlANU5rchQ8PBxTK5d
         ydOvvATTf/E5boUMFs/xUUrcrDDmojp7We6uP2B3/t7ksJ70aUHofeQphUzOeeGd6eub
         YFiJ6BMjjhUtXALPAaynD9vV8QEl3dOKRq4+FwOgqMb07MWfE3Jeay9gANYXwpUgJRHU
         l15oQCrh8FPeqUOMNbm72XcfS66hBjvtou4w2ijheTqzefycM8ddQ19zeUjCU060WGu9
         4W0w==
X-Gm-Message-State: AOAM533Ur9uFBDkm8fD4rkSXAV57uPt3FlKWFaXBruHku+eFEB6z7xrw
        RyhrLiTfxvyD8LlOzz5hApV2uHsjOAQ=
X-Google-Smtp-Source: ABdhPJxrmoWb0AoG8dtrTzwDrsrwfZ+hGey8KGQBrgisAT3KZ2gvAURvfT4TDuU3PO43BZl1AP9usg==
X-Received: by 2002:a05:600c:2154:: with SMTP id v20mr4914902wml.185.1594132673269;
        Tue, 07 Jul 2020 07:37:53 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:37:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Markus Pargmann <mpa@pengutronix.de>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 06/28] ASoC: fsl: fsl_ssi_dbg: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Tue,  7 Jul 2020 15:37:20 +0100
Message-Id: <20200707143742.2959960-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document either of the demoted functions here.

Fixes the following W=1 kernel build warning(s):

 sound/soc/fsl/fsl_ssi_dbg.c:90: warning: Function parameter or member 'flag' not described in 'SIER_SHOW'
 sound/soc/fsl/fsl_ssi_dbg.c:90: warning: Function parameter or member 'name' not described in 'SIER_SHOW'
 sound/soc/fsl/fsl_ssi_dbg.c:99: warning: Function parameter or member 's' not described in 'fsl_ssi_stats_show'
 sound/soc/fsl/fsl_ssi_dbg.c:99: warning: Function parameter or member 'unused' not described in 'fsl_ssi_stats_show'

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Markus Pargmann <mpa@pengutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/fsl/fsl_ssi_dbg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi_dbg.c b/sound/soc/fsl/fsl_ssi_dbg.c
index 2a20ee23dc52d..2c46c55f0a882 100644
--- a/sound/soc/fsl/fsl_ssi_dbg.c
+++ b/sound/soc/fsl/fsl_ssi_dbg.c
@@ -78,7 +78,7 @@ void fsl_ssi_dbg_isr(struct fsl_ssi_dbg *dbg, u32 sisr)
 		dbg->stats.tfe0++;
 }
 
-/**
+/*
  * Show the statistics of a flag only if its interrupt is enabled
  *
  * Compilers will optimize it to a no-op if the interrupt is disabled
@@ -90,7 +90,7 @@ void fsl_ssi_dbg_isr(struct fsl_ssi_dbg *dbg, u32 sisr)
 	} while (0)
 
 
-/**
+/*
  * Display the statistics for the current SSI device
  *
  * To avoid confusion, only show those counts that are enabled
-- 
2.25.1

