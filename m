Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BE92F18EE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388986AbhAKO4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731750AbhAKO4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:56:10 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14A8C0617A7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:54:51 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id y23so138135wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UWRvQWUwrPFkkVqrFhhi1pQBAFyO41MacdjI236ZA30=;
        b=OTgGzZIicbYeBkzWjZCwM3d578bQk3fsxekMNukcoFlVgUkoDrnf4nL9eHp/WaDVnv
         X1PCE72h78cVbouMZF7wC21HOukqg9pvdDR9lUDXoR+nvux+9C8BgDF1yfMDUBj+RIzG
         91FjnZkMHOdMlsOHiBidyoDvjJNiRwIII9UXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UWRvQWUwrPFkkVqrFhhi1pQBAFyO41MacdjI236ZA30=;
        b=r5WpeKhcbbcqCyMdRGxdlRo8cdIbxLPTzBWTOFVYxpmvtATL85o2lbICmfgpYDAlOW
         XldDZ0gwSbCN50Ba7FOwRpseESEl5seyXP1eNksdWJej7wfcINKQgvjj780NDceZR6TU
         XvoKHSwYfd+FWgl2xYoucsM6kJRxbHQbXPGdEMhfu9MNNmrjUjrRp/fxpdY7AELEaX0H
         NekuN6fIL1KXw95SbXdh0aW+PqpWf6TnAmTt1/xGp0rzNr/wK2MjMlKCNY4MQxjMWhwo
         XVv3BC2SsWdzg/Ox8L2SM8XIgtHxD9Fd7IB+b1hiftZaucQC+MzhwQbJ5UbeKBoRn69d
         j6qA==
X-Gm-Message-State: AOAM532bJMcttCUWMDaYp6xy+x5Rpe1I+2fCycGXngiG4ibMTDf77BHj
        mBakC40bX2PP3oGxymFp04amMlRbZuhlBYuwd7U=
X-Google-Smtp-Source: ABdhPJwE2ruvXuJCF4cZk406wM4rQwSTfy3+m5nY6ft6trpPAMaR6TDPibnZpXYKE3gt83lwxA+HsA==
X-Received: by 2002:a1c:dd07:: with SMTP id u7mr77572wmg.51.1610376890632;
        Mon, 11 Jan 2021 06:54:50 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id s133sm17780wmf.38.2021.01.11.06.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 06:54:50 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 4/9] media: fdp1: Do not zero reserved fields
Date:   Mon, 11 Jan 2021 15:54:40 +0100
Message-Id: <20210111145445.28854-5-ribalda@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210111145445.28854-1-ribalda@chromium.org>
References: <20210111145445.28854-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Core code already clears reserved fields of struct
v4l2_pix_format_mplane, check: 4e1e0eb0e074 ("media: v4l2-ioctl: Zero
v4l2_plane_pix_format reserved fields").

Cc: linux-renesas-soc@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/rcar_fdp1.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/media/platform/rcar_fdp1.c b/drivers/media/platform/rcar_fdp1.c
index c9448de885b6..01c1fbb97bf6 100644
--- a/drivers/media/platform/rcar_fdp1.c
+++ b/drivers/media/platform/rcar_fdp1.c
@@ -1439,8 +1439,6 @@ static void fdp1_compute_stride(struct v4l2_pix_format_mplane *pix,
 		pix->plane_fmt[i].sizeimage = pix->plane_fmt[i].bytesperline
 					    * pix->height / vsub;
 
-		memset(pix->plane_fmt[i].reserved, 0,
-		       sizeof(pix->plane_fmt[i].reserved));
 	}
 
 	if (fmt->num_planes == 3) {
@@ -1448,8 +1446,6 @@ static void fdp1_compute_stride(struct v4l2_pix_format_mplane *pix,
 		pix->plane_fmt[2].bytesperline = pix->plane_fmt[1].bytesperline;
 		pix->plane_fmt[2].sizeimage = pix->plane_fmt[1].sizeimage;
 
-		memset(pix->plane_fmt[2].reserved, 0,
-		       sizeof(pix->plane_fmt[2].reserved));
 	}
 }
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

