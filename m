Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 628DE1A18D6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 01:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgDGXvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 19:51:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38357 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgDGXvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 19:51:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id w3so1840692plz.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 16:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bBJzE53eaksNDmdb05BmcKfF0GccMZv3HofDPA/DfVk=;
        b=FGQruDooKcNpsi9j7VDoiO49bKy9eYmUHUDg3Gvocl/eigw6X5+mqz0bu9PkGMWfku
         rEjtJO1lF5c1bBFWT/73a2x8N/A55hSi/3+AQTK33LyC5Y+oeOmYC6yIHKDbZ83zW6ok
         AuI2LFX6DuokvAZumPkRW7cYl3BAladfRVSTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bBJzE53eaksNDmdb05BmcKfF0GccMZv3HofDPA/DfVk=;
        b=R37OYyAcZIzIg28ZaDHeblAmKOC8xhvsCVS+SlvcXTQ00+KGWXPVPxL78aLTDPBSI5
         PC6U4Zx8X6C2Tp1Vt9jl7M4t4Z/CvPAW3FSju21BB0yrnG+bnSQLmOsJ9JzRFK/n4104
         UKyusvr3KAZpvQZLNBx7QO/vMEpCPjmZVLmwU9/TjVaclxtdgCGzMvnu/xOik1zlp36i
         o9H1Bgn3ls8xevJPft//OBNxHbOaYF8eI6PQ62kJAovLBGGP/X6d/ihAJ3oa0Prle8P/
         y2Q0X6DKDH24AK7bn38P5OQDXVWSUxynf0wdxk4okgecQtHY9KRbz3xeaTtMQZ8oMSkP
         PDdw==
X-Gm-Message-State: AGi0Pua7ehFwMK9RjKUqWkBqyzOFRzaR2NVf0pj6T0I+1EskvkawKMpI
        nzBKtsDt6gDNtXd5du5n/ihteRQERMbbYw==
X-Google-Smtp-Source: APiQypJKaPUIpNKIeM1S4TQG4CqiQmoXpruLfwsRdw928lUopKp/PkcCkXUlo6cmMm2kQIc0Q/aUEQ==
X-Received: by 2002:a17:90a:208f:: with SMTP id f15mr1724748pjg.60.1586303463664;
        Tue, 07 Apr 2020 16:51:03 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id s27sm14467165pgn.90.2020.04.07.16.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 16:51:03 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     mka@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, swboyd@chromium.org,
        evgreen@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/10] drivers: qcom: rpmh-rsc: tcs_is_free() can just check tcs_in_use
Date:   Tue,  7 Apr 2020 16:50:21 -0700
Message-Id: <20200407164915.v3.7.Icf2213131ea652087f100129359052c83601f8b0@changeid>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200407235024.260460-1-dianders@chromium.org>
References: <20200407235024.260460-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcs_is_free() had two checks in it: does the software think that the
TCS is free and does the hardware think that the TCS is free.  I
couldn't figure out in which case the hardware could think that a TCS
was in-use but software thought it was free.  Apparently there is no
case and the extra check can be removed.  This apparently has already
been done in a downstream patch.

Suggested-by: Maulik Shah <mkshah@codeaurora.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Replace ("...warn if state mismatch") w/ ("...just check tcs_in_use")

Changes in v2:
- Comment tcs_is_free() new for v2; replaces old patch 6.

 drivers/soc/qcom/rpmh-rsc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 84ae3e514eee..9502e7ea96be 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -177,7 +177,6 @@ static void write_tcs_reg_sync(struct rsc_drv *drv, int reg, int tcs_id,
  * @tcs_id: The global ID of this TCS.
  *
  * Returns true if nobody has claimed this TCS (by setting tcs_in_use).
- * If the TCS looks free, checks that the hardware agrees.
  *
  * Must be called with the drv->lock held or the tcs_lock for the TCS being
  * tested. If only the tcs_lock is held then it is possible that this
@@ -188,8 +187,7 @@ static void write_tcs_reg_sync(struct rsc_drv *drv, int reg, int tcs_id,
  */
 static bool tcs_is_free(struct rsc_drv *drv, int tcs_id)
 {
-	return !test_bit(tcs_id, drv->tcs_in_use) &&
-	       read_tcs_reg(drv, RSC_DRV_STATUS, tcs_id);
+	return !test_bit(tcs_id, drv->tcs_in_use);
 }
 
 /**
-- 
2.26.0.292.g33ef6b2f38-goog

