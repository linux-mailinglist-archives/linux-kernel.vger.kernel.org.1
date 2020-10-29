Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCA529EB3C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgJ2MEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgJ2MEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:04:24 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42FFC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 05:04:23 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c16so2176099wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 05:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/fBEwjdUnJetUpnGDQAmLObEbyNOiNUb8MREdQ0fM5Y=;
        b=F0jRz+malxZMdZurANKSbPQLjBRgPIMu32fGJrJT4SMfWEMZqnrsSevt/MVVUntbiu
         Rg9WVRh0NfdZk/8Zw85JD9SPg7qkz+EYs5k361RT8tPT4O40pvDdURcRu29XWHC4F6lb
         Ikmm64nW3+IKdpwjRdxuukpKgCEeyrKCe3qrB+qwoeofjCozErXjJYC7/lYggDgxJLl9
         46KDS0wcjh3fzldPKh2AfakkEWGm7xZdG9O3vB5s9rPNetoSf7la2UaWL0l8/K5DQlTR
         eInIeTXJVtcu90dQzOIHgb7hVX/edsokD1nbi/qd6iDgMlxgnrZq9reGKWLWF70qJ9Ck
         ht6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/fBEwjdUnJetUpnGDQAmLObEbyNOiNUb8MREdQ0fM5Y=;
        b=GOPAFlGrUBGu7MEPmuEojYAqryLOtmvUHGltcSvsUWhZR+wWJt7nPR6j88r3ASAQXu
         uDc4CukmyjOqYAKJNK9Mv60mr9SZgVzPlAy4kd8FOP8Mkz9rrXrCl6bsQcR8FTWZ6/gs
         QMzzqXLWfTtPAkrdEcFueAXgesTRnH/l77YgDOMeTYA7AmncwqNjGjdds0AZW4i0VqlU
         gW67wbyykWz1DxKqZRF29HFcp/8qVx35DwXyEyOmbgT5UZG8mvNFoKewUjyExIq3VqwK
         mCD5rGbCgxjut4/mGpA1PF43iKwXl48vkGx9qa2vEfbFix96aM7ggBhX7Sf32rLXLIxU
         MIHw==
X-Gm-Message-State: AOAM532vY6hEhajaTYWHUmcv4ckehP/12so26W0FAVB7M/kGBe3yFnxx
        XprdQkmfR90RUsZsI3H3tCk=
X-Google-Smtp-Source: ABdhPJyUNWoEn05cWcwLgOHPOMr7TIlKg16tY9g6oExp0v6KDfsq/ZM+MpdTp04ObHhlP33k6Z2Fmw==
X-Received: by 2002:a7b:c00b:: with SMTP id c11mr4012526wmb.96.1603973062311;
        Thu, 29 Oct 2020 05:04:22 -0700 (PDT)
Received: from localhost.localdomain ([109.175.166.67])
        by smtp.googlemail.com with ESMTPSA id i33sm4987218wri.79.2020.10.29.05.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 05:04:21 -0700 (PDT)
From:   Manuel Palenzuela <manuelpalenzuelamerino@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Manuel Palenzuela <manuelpalenzuelamerino@gmail.com>
Subject: [PATCH] Staging: rtl8723bs: core: rtw_cmd: Fixed four if-statement coding style issues
Date:   Thu, 29 Oct 2020 12:02:28 +0000
Message-Id: <20201029120228.7029-1-manuelpalenzuelamerino@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed four cases where the if-statement coding style wasn't following
the guidelines.

Signed-off-by: Manuel Palenzuela <manuelpalenzuelamerino@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 4cf09d947d32..55142faa2213 100644
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
@@ -908,7 +908,7 @@ u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueu
 		res = rtw_enqueue_cmd(cmdpriv, cmdobj);
 	} else {
 		/* no need to enqueue, do the cmd hdl directly and free cmd parameter */
-		if (H2C_SUCCESS != disconnect_hdl(padapter, (u8 *)param))
+		if (disconnect_hdl(padapter, (u8 *)param) != H2C_SUCCESS)
 			res = _FAIL;
 		kfree(param);
 	}
@@ -1249,7 +1249,7 @@ u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan, u8 enqueue, u8 swconf
 		res = rtw_enqueue_cmd(pcmdpriv, pcmdobj);
 	} else {
 		/* no need to enqueue, do the cmd hdl directly and free cmd parameter */
-		if (H2C_SUCCESS != set_chplan_hdl(padapter, (unsigned char *)setChannelPlan_param))
+		if (set_chplan_hdl(padapter, (unsigned char *)setChannelPlan_param) != H2C_SUCCESS)
 			res = _FAIL;
 
 		kfree(setChannelPlan_param);
-- 
2.26.2

