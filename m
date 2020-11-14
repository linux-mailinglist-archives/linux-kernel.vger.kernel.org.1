Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907F22B2DB9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 15:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgKNOzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 09:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgKNOzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 09:55:50 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53683C0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 06:55:50 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id w7so1680333pjy.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 06:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mgJIHW42nsS/z1sx4fpJMJA9O5TioT77D/sOkRQHJ6I=;
        b=eM6/M3MtrZoK/j86rf2ujJ0wFEdmBqQlzia+W3Afmbgl2xZdotx8I46PWtKPM71gRh
         j7iyaXuREmKlED7M8o35n2eyqTMUPQe34SeH3ur42rqIBANhrorxIhkYLlpau0eFgA1O
         1lh3D8Obfjd+4N1EGGNLaL8/TmXgjHjLAnfD8KUF+k6iDXFWh5iEj9P5m8V2K/v9kteW
         jQWZRDAileAXs43EM1I8hR4Pea2HvmfQByajr3e0RFgV8e2TvdtmyvW4pDI4SccBtZzm
         7jssxa2rdNLznSF/2mlD0vR7FhWZDDNPB7uDglRctEduTp/81xdEMZGkoiNDFGcJ4UPV
         mjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mgJIHW42nsS/z1sx4fpJMJA9O5TioT77D/sOkRQHJ6I=;
        b=DftqT5akq+axJkhlQw6z2lvZ+lVPWcFxtMk3T3ojYneuM5rFTX14Y0IjRLATnsW8yu
         Y0oXVXtxTRc3hHN071WQIJdg50yyF0wtIYRTALuL5pZakMQ05/TueBe6nmBYBKDYN/tq
         buPn0z5UBqwgUAIKs149jpZGuZ5LgWBT3Hdn+WZWugv1D7SnMjQ3DFrb8AIqIcP4Y9re
         koTV4t3UvSDEBp/8Rz7QMAD1iHnvfCjKKLv46boCBU/YnWTnLpNyV3s8valOPlypLIl8
         LEN9eiC0lQuQzd8t3ts2g3Ko5qoQTnxFcKrkw2MfazTEvOD9mxhbbgoguQIB4l63Klve
         6UDA==
X-Gm-Message-State: AOAM533GzzncyUy33jaC6nDBjGk2NirCtKKgzNaQSpJwHk1UosNqwScM
        Nw79ho4TOvRHgxNrpTC5Yw==
X-Google-Smtp-Source: ABdhPJxt82qXTu1pgZeffQyBTbkYCfV2KjvHuUI8000CDfN07Y29L3+AV6GGO9VotwUzvRSQAdDG4w==
X-Received: by 2002:a17:90b:1496:: with SMTP id js22mr2213683pjb.140.1605365749965;
        Sat, 14 Nov 2020 06:55:49 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id v191sm12753669pfc.19.2020.11.14.06.55.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Nov 2020 06:55:48 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com
Cc:     intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] i40e: remove the useless value assignment in i40e_clean_adminq_subtask
Date:   Sat, 14 Nov 2020 22:55:39 +0800
Message-Id: <1605365739-11642-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The variable ret is overwritten by the following call
i40e_clean_arq_element() and the assignment is useless, so remove it.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4f8a2154b93f..7d59fc2eded6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9356,7 +9356,7 @@ static void i40e_clean_adminq_subtask(struct i40e_pf *pf)
 			dev_dbg(&pf->pdev->dev, "ARQ: Update LLDP MIB event received\n");
 #ifdef CONFIG_I40E_DCB
 			rtnl_lock();
-			ret = i40e_handle_lldp_event(pf, &event);
+			i40e_handle_lldp_event(pf, &event);
 			rtnl_unlock();
 #endif /* CONFIG_I40E_DCB */
 			break;
-- 
2.20.0

