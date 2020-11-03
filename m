Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C0A2A49B8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgKCPaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgKCP3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:29:43 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2635C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:29:42 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id s9so18990972wro.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MFpjk4zX/2wadqqqsM0maoUWA+IXg/GlxrDq3yCnAFA=;
        b=Qkv/V/csOn9qV3pYb6lVPgWvEdd3Ta8GDAq86IVNAUc3c0jR6XNImUocikmt93rRg2
         h1Gyw2dnX6+eku//9wJYPUfZDgdiZRw8yMNfhxwLvZyJR7/rgIpW8JHwUhGw+JQ+/01l
         JRpT/oiFbltYm10ijlqHJ5+3lKj2M+nEQSvVXJe+ieToN2rbOJSYzmNLewUITApjxA99
         KI71SXemg3k+zgI3lASOaj//Tf42Pjyc2/Da0Hc3n6eyPIypsQtkyzSNoDFQ8TpgLJfW
         O2nf19pS/jbIlnE9RfqOtyWG3BpGwjS5NSWttgumNXbln287Z4zPVmVQChWlnaCc47Uy
         Wm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MFpjk4zX/2wadqqqsM0maoUWA+IXg/GlxrDq3yCnAFA=;
        b=co6U6+1YwCkYG0R4UMg896RV+LoxmUUfDioAEEf9Ur8LtQiVI8+rWSsGuhsddNcnfa
         bUdsrGLz9xMumFCu030byyngQ+v56cb5GK+OK786YxrYdGoHblew3ZBDDt1U0hXlXbPo
         KNM+XfcTG9pQscHP62kRvdp6DB1Qb7VUATOd82vyr+wdH7nYuW0d9BUs3vt8Qm9EM0+m
         7UOGcoi/TMRFRMFyhngORaFufYDypP674CKYuiXowkcYCVViVeuv5pzz9P3aAuDi1zcR
         AMwrnfhGIBOqjeYySrYlxjd9PZT059J+Za7oB1h+l3ajIy7/xCL5FiwKy+gzVZdTvTqn
         LxQQ==
X-Gm-Message-State: AOAM533etggFDCcN6C6lfgJ43Qq72i/OEZ0Ckf/XA7VACXi7rmFMTiF0
        Rwi3/+2x3E8czvj0fXc8CFpBqQ==
X-Google-Smtp-Source: ABdhPJyApWsuQrwG87jrLEV9umSx+qWrIi0rU75XA05LIQc9vRCphOrnl1PsoRjfi3qvIDo9fZrhSA==
X-Received: by 2002:a5d:664b:: with SMTP id f11mr25450929wrw.195.1604417381575;
        Tue, 03 Nov 2020 07:29:41 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id j127sm3491779wma.31.2020.11.03.07.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:29:40 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH 24/25] soc: tegra: fuse: speedo-tegra210: Remove a group of set but unused variables
Date:   Tue,  3 Nov 2020 15:28:37 +0000
Message-Id: <20201103152838.1290217-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103152838.1290217-1-lee.jones@linaro.org>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/soc/tegra/fuse/speedo-tegra210.c: In function ‘tegra210_init_speedo_data’:
 drivers/soc/tegra/fuse/speedo-tegra210.c:105:56: warning: variable ‘soc_iddq’ set but not used [-Wunused-but-set-variable]
 drivers/soc/tegra/fuse/speedo-tegra210.c:105:46: warning: variable ‘gpu_iddq’ set but not used [-Wunused-but-set-variable]
 drivers/soc/tegra/fuse/speedo-tegra210.c:105:36: warning: variable ‘cpu_iddq’ set but not used [-Wunused-but-set-variable]

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/soc/tegra/fuse/speedo-tegra210.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/tegra/fuse/speedo-tegra210.c b/drivers/soc/tegra/fuse/speedo-tegra210.c
index 70d3f6e1aa33d..7f2cc09a00bbf 100644
--- a/drivers/soc/tegra/fuse/speedo-tegra210.c
+++ b/drivers/soc/tegra/fuse/speedo-tegra210.c
@@ -102,7 +102,7 @@ static int get_process_id(int value, const u32 *speedos, unsigned int num)
 
 void __init tegra210_init_speedo_data(struct tegra_sku_info *sku_info)
 {
-	int cpu_speedo[3], soc_speedo[3], cpu_iddq, gpu_iddq, soc_iddq;
+	int cpu_speedo[3], soc_speedo[3];
 	unsigned int index;
 	u8 speedo_revision;
 
@@ -122,9 +122,9 @@ void __init tegra210_init_speedo_data(struct tegra_sku_info *sku_info)
 	soc_speedo[1] = tegra_fuse_read_early(FUSE_SOC_SPEEDO_1);
 	soc_speedo[2] = tegra_fuse_read_early(FUSE_SOC_SPEEDO_2);
 
-	cpu_iddq = tegra_fuse_read_early(FUSE_CPU_IDDQ) * 4;
-	soc_iddq = tegra_fuse_read_early(FUSE_SOC_IDDQ) * 4;
-	gpu_iddq = tegra_fuse_read_early(FUSE_GPU_IDDQ) * 5;
+	tegra_fuse_read_early(FUSE_CPU_IDDQ);
+	tegra_fuse_read_early(FUSE_SOC_IDDQ);
+	tegra_fuse_read_early(FUSE_GPU_IDDQ);
 
 	/*
 	 * Determine CPU, GPU and SoC speedo values depending on speedo fusing
-- 
2.25.1

