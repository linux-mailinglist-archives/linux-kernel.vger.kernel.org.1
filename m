Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D22229E264
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404327AbgJ2CN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:13:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52620 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgJ1Vf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:35:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id c18so633064wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Bpjw93Tb7zPllCMy/3VsyrttzXCJxEWs9ocHC3M26Y=;
        b=Gme0y42grM92FRHVvRmwDUEjlULnK/pNpWWmNtYqVGQMGovp4vDc5dgPq9xSiJQrhV
         w1vOZXFy0kewx+g0un6EE30klHA6hNacIH06ueAt596VdZzX3iGboZq3HvV4IPDI71A2
         +YkME89QEXeTLZruOaTIc0EMFI3zOQvPulicmuJPUGMloDdxPrRZwQemGSmx533PR5Iz
         mJd7yNKrJhxfGSNFsY4RY6ReLYOYiXRyzoY8xvAYRWDUxkfJM0dwNVySO+6iYZKScsIc
         fWsDCzj5xpCpFftO0fq97BR8WgR2Qor+C/vsq10K0mr8t478un97VPoiknkS23R9HwgY
         O00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Bpjw93Tb7zPllCMy/3VsyrttzXCJxEWs9ocHC3M26Y=;
        b=CiDTTn6KC7QUPnnbb9j3sAI9WViE3wI4RFPtQIBcC+br51kvn/SWWnpW+c3Axag7VL
         0pjPz2fE12X+kjeg3t3vOhlG5xk6o/PgyU29kf53gEbu63lhc1JXqzo8+GRloDhytK7V
         /skvrZC9SbutvAlkThwpYR3WfvKMZHX4creytoJVW+N+zBWpNKE3adYYuzK5GPrFx+u6
         z0AIXGhk96JGNUfSzuyCihxWu64AhJA4ogibZgetN1DkW2VHpEIIiLKk1A7CrYaDSyZX
         YbvTiBe3vc1y+Yk2tjXfBCfCTc9UQgvRJz5EplrSXlX4/wEqvJqNa9+x1640iRT9LwVF
         VTtA==
X-Gm-Message-State: AOAM532vnqSJxHD1WXJHIZ/RfLehuS97KznihSpSGp/kouSJIZBC3vuy
        cZKxq33UJeT5ITbE/gHXVMLD0fGLcafZCICzz6Y=
X-Google-Smtp-Source: ABdhPJwZAu7rIRiWUuih15u0YaWbinrzs7DAmdGM34KS1+xoKXOTxwG+FlH3JdX/+aO9jv2ZXvVl/Q==
X-Received: by 2002:a05:600c:216:: with SMTP id 22mr770981wmi.149.1603920650878;
        Wed, 28 Oct 2020 14:30:50 -0700 (PDT)
Received: from localhost.localdomain ([109.175.166.68])
        by smtp.googlemail.com with ESMTPSA id q7sm1193478wrr.39.2020.10.28.14.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 14:30:50 -0700 (PDT)
From:   Manuel Palenzuela <manuelpalenzuelamerino@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Manuel Palenzuela <manuelpalenzuelamerino@gmail.com>
Subject: [PATCH] Staging: rtl8723bs: core: rtw_cmd: Fixed two if-statement coding style issues
Date:   Wed, 28 Oct 2020 21:28:37 +0000
Message-Id: <20201028212837.28030-1-manuelpalenzuelamerino@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed two cases where the if-statement coding style wasn't following the guidelines. (rtw_cmd.c)

Signed-off-by: Manuel Palenzuela <manuelpalenzuelamerino@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 4cf09d947d32..1723473005e7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -344,7 +344,7 @@ int rtw_enqueue_cmd(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 	cmd_obj->padapter = padapter;
 
 	res = rtw_cmd_filter(pcmdpriv, cmd_obj);
-	if (_FAIL == res) {
+	if (res == _FAIL) {
 		rtw_free_cmd_obj(cmd_obj);
 		goto exit;
 	}
@@ -460,7 +460,7 @@ int rtw_cmd_thread(void *context)
 
 		cmd_start_time = jiffies;
 
-		if (_FAIL == rtw_cmd_filter(pcmdpriv, pcmd)) {
+		if (rtw_cmd_filter(pcmdpriv, pcmd) == _FAIL) {
 			pcmd->res = H2C_DROPPED;
 			goto post_process;
 		}
-- 
2.26.2

