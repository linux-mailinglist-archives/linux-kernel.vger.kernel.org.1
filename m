Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B992A9F34
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgKFVh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbgKFVhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:37:17 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18E2C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:37:16 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a65so2633705wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=93EjZ3Q1Gw8Ho51hZkZvcyMJpfj7h+RPmd54ZDyuP+E=;
        b=cvGUz9vFmdq9m3LcG6h2WXDm9NcajWq52twh6MVrvfJxfk83JKWtunTtBbGxznuGRw
         RYi+l/Oe7C4iUOShplsZz0ND8kpwu67qnNZz1Lbbl6HE0EOFU9tMkIh93D1/HYP56Av0
         673edbjckqfRywYQuHoPBvsOHVPWlKjR1REJeTOMHyE6WN+0vqKe6tvUTmIHHICRU08K
         8hXS+5La2R08G1bEnlZ0++Ml9gfjVjNgKUBMC16TWaRpkgFmVhzKLW9iIATEpLBtfg77
         Ht+AOn6dGvcQFtbUBd6jqgyafA2nSSFWhtuW2GSLPOp1BjDFFOC7mYruDcKB3cz2bzlI
         p9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=93EjZ3Q1Gw8Ho51hZkZvcyMJpfj7h+RPmd54ZDyuP+E=;
        b=q2FaVBOecJ6639+TLb543gGSegm6khWzZbGwizbTBYo60anGYztJRM7RT77w9GLjEZ
         0NE2HkUchI5USYcpMSD1E4JUp71EpaXaGoFxd1Kw2wM5cfSiWVTEwkUeF5kqlOuiAk9z
         HH2/L6exxCEskS+q3mP+Eco7QtDP9+tPtUMVOLD74C6LLk82AQnSSHXBohJlSNAXzmUX
         KbaoRZwEYipDFcQH8S8NVJpzVtrHpyuYANM6NQXRxd8boVcbNdNMZnhwKj04ktkfXn3I
         3SiN2G3z3CX7WFNYaqNhrVlRNrsD4KnDEKO1ttOKeuswC07jsK47yBTlUjJAOSGHsejz
         5XSw==
X-Gm-Message-State: AOAM532wdCjirL6gVCanx4fnmZI4UbWqMRKgY4kw9ghKhFcIz1BmLb3A
        QBujv7UGnjoN7LNAzbKPBCDNvw==
X-Google-Smtp-Source: ABdhPJzPk8Sy5RnOJ5+GcYE/M213NgScyYk8H3UlXOO5RgpME2G4BnxgdBGAg2AfyOr6Z4ZV7gH3DQ==
X-Received: by 2002:a1c:ed15:: with SMTP id l21mr1703834wmh.26.1604698635749;
        Fri, 06 Nov 2020 13:37:15 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id d16sm3984942wrw.17.2020.11.06.13.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:37:15 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v2 12/23] mtd: ubi: wl: Fix a couple of kernel-doc issues
Date:   Fri,  6 Nov 2020 21:36:44 +0000
Message-Id: <20201106213655.1838861-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106213655.1838861-1-lee.jones@linaro.org>
References: <20201106213655.1838861-1-lee.jones@linaro.org>
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

