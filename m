Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399002A9F87
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgKFVuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbgKFVt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:49:57 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F1AC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:49:56 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p19so1779415wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X9TskLA8s6lsCaAvrmgVECkRi2+nWhb2pEMdbcj9ssA=;
        b=pfSMSQscAEe73YfdvPqoah0YUiDgsKi5tci2ntaEc+AOw7EFT/Rjz/9yaQ8JOlnuqg
         sjsCyUHP2m7SSEbuESRncBhPT0/U3T3mBIzd8oVeLEgQ2vkMSiXn6iU/egwDLfoCiHID
         WmKn5aUfrKNLjV/95GLV+jN/7folMFY6MmdF8W3AabVdy+YgBrI2xYHqDVVSIRcuwwv9
         7dq40V4sfIu+gPKsuuqemhSRIdc1Eep9RErKn3hNocCTBW1i6HuUBuK9rWOqxqyRQcK7
         fTuXB9watBMFV0B7V0N9jyN5D+ISmPnGsOhSY4Me+8AK107zbLEUh25TPoiu4oaoxKn3
         ZN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X9TskLA8s6lsCaAvrmgVECkRi2+nWhb2pEMdbcj9ssA=;
        b=XAcUYCB+ORXwqwYwbsEbxiTbaR35WyF0n31/IafOUx9lcRB8cwHexD9W8g2ttNSKfp
         D1PGWJURpmExNbw9vtpxjWBCwqrgVxEp9zqzTv8z35ONtB6dAr1DJWjBUwy7gIJz8ZRx
         Cdmb1mBO8rS9RNSdh8oIVZyOXgoWCLk/VvBUSON9e54vMpKuyBLEtzLQmUCAIK54uq3I
         JjX1zT6LYOMv8On7s66bDsmQID/8vov8Gb/ze/uegMn+4rxuYqbir7JXY7cYQ2/dZVUr
         bMmYt45UK0u+V7u+M+3MRhBW+zqc6mgy8l2QTKhlE+v6mEcfzRHHcUPdxOGsQpUqEqgr
         OlJg==
X-Gm-Message-State: AOAM530Qwyuakjuc1vyvqKLul2IdT1DtzehuL1OeQrpvVoZbo3j/reAy
        ytl+u/Q6/0ZIgO4Lc9v+lYGT7Q==
X-Google-Smtp-Source: ABdhPJxn99JQzzfmUo/MAhbXVAzso9ShMGAbXLKB/8lXMZUdXlGssig7MHgAIaoRjLEwdk1EBgNFyw==
X-Received: by 2002:a1c:e056:: with SMTP id x83mr1688640wmg.83.1604699395695;
        Fri, 06 Nov 2020 13:49:55 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:49:54 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gareth Hughes <gareth@valinux.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 02/19] drm/r128/ati_pcigart: Source file headers are not good candidates for kernel-doc
Date:   Fri,  6 Nov 2020 21:49:32 +0000
Message-Id: <20201106214949.2042120-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106214949.2042120-1-lee.jones@linaro.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/r128/ati_pcigart.c:2: warning: Cannot understand  * file ati_pcigart.c

Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Gareth Hughes <gareth@valinux.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/r128/ati_pcigart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/r128/ati_pcigart.c b/drivers/gpu/drm/r128/ati_pcigart.c
index 3e76ae5a17eea..1234ec60c0aff 100644
--- a/drivers/gpu/drm/r128/ati_pcigart.c
+++ b/drivers/gpu/drm/r128/ati_pcigart.c
@@ -1,4 +1,4 @@
-/**
+/*
  * \file ati_pcigart.c
  * ATI PCI GART support
  *
-- 
2.25.1

