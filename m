Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0C02AC3B6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbgKISXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730125AbgKISWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:22:38 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83304C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:22:38 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r17so5894808wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=93EjZ3Q1Gw8Ho51hZkZvcyMJpfj7h+RPmd54ZDyuP+E=;
        b=FGiuz2Cst7W8YGzjuH7oR/80riR1y3ryV13ErPsnJPIku+MH0/ysQZFcPAyi6Rak30
         A7uyeT+Pv0IY9nd1ybvTN4TTOIXRxo6WyAarJc69qAIgAVWwItf9dE2Xipuv1iDs6PrZ
         8VTA94w7a0qq8YfA8iPwN69GCrDDKsiXEpnuvGsK2Q8x1fo6N5raOMUGb46Kdp8/akPj
         M7cPQ0B3xEAWcsbudiOqaKsqamxeMJEKo93pm8ktcyX3KUUcKcdtzEqbVbAJ6pVplMfw
         SGiLPCC+vSwii8OmWho/PSnPB70IwNmqiRCgM2kfdWrmSgxw2nTZHbNsJgNpO2ILGkXn
         Wqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=93EjZ3Q1Gw8Ho51hZkZvcyMJpfj7h+RPmd54ZDyuP+E=;
        b=cQbi6eIcffgNm5Ef6lQEoTtVe2VzAv8grsG5ZC/fAbAt/5egCw+rSGeJCIcxo85gZV
         Xe6TmmvGvMOydDzBWV3PV38CS4rco1OoKzSASDvDsHdU+uirAgKTkCIQVyZ4oICgfl6I
         LXFfdhQJ5fXQOOqwKke1+o37n+eFam1U22kanOzzi3RZjoI0rMxcwrxwKrRpmztyFcph
         Y8vhIpxx3RvVvq2vBmlJpRlvYS45mjlaI+C9uIZx7XK9jdlrwox6txUndvjrbQOUPiR6
         Ct/4u6SltuVGkhtFNvKalO+RXQW5xO6bht//P609j49Sk1JtQrbdKP3Uy26waSTXy6tf
         gufg==
X-Gm-Message-State: AOAM530jsAg8b66fk1AfJxgyplvxoxUQjMLvy2CnR9vxZkhZBLlVqVew
        IsR/KHDoxeOTJcDDU8XqIvgxsKTkdgwppLCA
X-Google-Smtp-Source: ABdhPJzjA29ReDKoS8meuG3AwVUifiDdGOjuNnliZQ8OcrzScX2JdL+j0w6/+uklVrrqt8pkwQWMfw==
X-Received: by 2002:a5d:670f:: with SMTP id o15mr2175982wru.204.1604946157299;
        Mon, 09 Nov 2020 10:22:37 -0800 (PST)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g186sm735365wma.1.2020.11.09.10.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:22:36 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v3 12/23] mtd: ubi: wl: Fix a couple of kernel-doc issues
Date:   Mon,  9 Nov 2020 18:21:55 +0000
Message-Id: <20201109182206.3037326-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109182206.3037326-1-lee.jones@linaro.org>
References: <20201109182206.3037326-1-lee.jones@linaro.org>
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

