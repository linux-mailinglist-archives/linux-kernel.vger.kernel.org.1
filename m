Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758BF2A2A09
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgKBLyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbgKBLya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:54:30 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF6FC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:54:29 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id w1so14273325wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=93EjZ3Q1Gw8Ho51hZkZvcyMJpfj7h+RPmd54ZDyuP+E=;
        b=opBwhrxLDDOijB/+6w0qKgtlnTAnSYM4uhprrPkJ9C3OtHPXIDM2Rf5IU/mmjdS3AV
         PhSjyKbvUb1D1DhP3/69ICZJTZNjyxqoO5bagSZy3o6ovSKW57KJryFUjgQY15PSLMG+
         a5HnXkkhUOuhw5aMJwRRXrKFqqDX3oYAcL6z2tSkcVapWDlr9iRxSeMI0NARDRsWWMxa
         YX71OJpG0fGny9J4O/WWj2F/kiO7SC9kRW+nF1PGUECszF08zIAJrtAfIUsUZ7ZgGpMG
         eQDt909GDycd9buJqg8nBRhIOsrykhLgf268VB7fCmuqoiYiuXDFGX00vcPVtTTwHK2U
         q58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=93EjZ3Q1Gw8Ho51hZkZvcyMJpfj7h+RPmd54ZDyuP+E=;
        b=JAVlxjOHotcTRgCMsb0KNb44Z00wBusmEd63dZfDrweok+6/m2XWicbiK2rlzYDORD
         kAWqPACJ8DM6tGtWmToev1Ua2WkC0/kp/XONCfp602plehyWzobFvZsRnLKmPlIDslqU
         dW4BqN9PRKbAsR+UVwa84XUITDbA+n/50qNDU0jLvI4ABHuTKAZmw7vpn/iqISzyV2gn
         rwZe7h5KYGdfj2mxM/tN6b8+4jZ/k2mwOsfx++se4ZXbrLy02CWt+BtiUfwxzIvaQXCS
         jdZ/nBQKOlDj/9/9jX2XYxIyQNIxHefZfLtP4yf/7ciH3fvARcN67H/VSSue1bNJ4hRs
         HOvw==
X-Gm-Message-State: AOAM531xuWzYsnIfRD73PDazEaOFz4lhxhjXeFSo1xG5QGc0qtH/gBNs
        SC3iS943AwwXO8zP51zJhIIJAA==
X-Google-Smtp-Source: ABdhPJwxzsFyIA+Yg1CglN1R6rmmAXo9pfMhFKXJu0Gimkd0jsZ691A7wWzZjoNud7hrDZ5CNQ9FHg==
X-Received: by 2002:a5d:4083:: with SMTP id o3mr18475908wrp.44.1604318068665;
        Mon, 02 Nov 2020 03:54:28 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t23sm14284010wmn.13.2020.11.02.03.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:54:28 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 12/23] mtd: ubi: wl: Fix a couple of kernel-doc issues
Date:   Mon,  2 Nov 2020 11:53:55 +0000
Message-Id: <20201102115406.1074327-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115406.1074327-1-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/ubi/wl.c:584: warning: Function parameter or member 'nested' not described in 'schedule_erase'
 drivers/mtd/ubi/wl.c:1075: warning: Excess function parameter 'shutdown' description in '__erase_worker'

Cc: Richard Weinberger <richard@nod.at>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/ubi/wl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index 7847de75a74ca..8455f1d47f3c9 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -575,6 +575,7 @@ static int erase_worker(struct ubi_device *ubi, struct ubi_work *wl_wrk,
  * @vol_id: the volume ID that last used this PEB
  * @lnum: the last used logical eraseblock number for the PEB
  * @torture: if the physical eraseblock has to be tortured
+ * @nested: denotes whether the work_sem is already held in read mode
  *
  * This function returns zero in case of success and a %-ENOMEM in case of
  * failure.
@@ -1063,8 +1064,6 @@ static int ensure_wear_leveling(struct ubi_device *ubi, int nested)
  * __erase_worker - physical eraseblock erase worker function.
  * @ubi: UBI device description object
  * @wl_wrk: the work object
- * @shutdown: non-zero if the worker has to free memory and exit
- * because the WL sub-system is shutting down
  *
  * This function erases a physical eraseblock and perform torture testing if
  * needed. It also takes care about marking the physical eraseblock bad if
-- 
2.25.1

