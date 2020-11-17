Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88D02B6C07
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgKQRjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbgKQRjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:39:47 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AEAC0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:39:46 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id w20so895643pjh.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EAf9d4gGWEUWE1b+AMgq6WQ0FcZNv1uCLoEh96U6HDQ=;
        b=roejm7Op9Zg7DIDxR2z85W2idQGhDnJWcLxRVK9/FJgE4xP73woVLLM3cWiZlNukme
         7+xYxPb12cPLd+Nwpof5LdVtyYyAhs6qQ7FHzo4sK3gHh0Xx2Wtv8G9zgI36HcQnBFQm
         wKGkcZAMWGvS2Hqr7Gu0t5WgVOHwqNbmEGgziVOhQGPyvC011MB/JsNYjgpt3LFLUGPo
         Acd4A10Ljb3knE8r1khe/l2wZxdZajD+HcPx7IjGqAReaUTDHa3ri/fAE6xuo7CA/MpO
         zYoRNRYMQ9DHMlSXNT+ckd/V5j9z/Nizr4H4DFkCaRPLwCRDeUxnQxd13waGTyExsCLg
         ECdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EAf9d4gGWEUWE1b+AMgq6WQ0FcZNv1uCLoEh96U6HDQ=;
        b=SMHJIUpJHp1Rq6e4E5PKrW/4VT+5cpi1zdewPRyCwjbuzx0of0LoMqaMfP6i8fN/UF
         Ux03eDvDaPMapkIoAeIfaqUQ7gZN6LNcqUV9j7TbB3EF9yaz0I6btErUw1Ha/nJdj8kM
         0jzuyujpFNFXTqTV75KhM0TFW7NqyS9/wJhY91ZgnpnygvfNZaWKw63gdFPeOKhwNUD3
         0Rung40gpzU7BYvgd9mAYfsKizorHn6jAWuSaL4dEnOToXlQMorU32oSA6XOTopT4rlS
         t436HkJr4jz2sVDGXM5QNjpMr6VcoBVF4qqMpMAxpdxfucMDxPGrhg4hoNrK8LONmCt7
         sPVA==
X-Gm-Message-State: AOAM532Km+/bXmSAkKLlPXRbRhmRMXtZ2y2sBiSZvESojO0YMDxWzFwS
        2zDlHoloXnl77fLb4t6+6FWo
X-Google-Smtp-Source: ABdhPJwB2H0ru1rDI9vN4pDM/1VqZieHatMHr5QNK9SyRs7wdkDFRvOEa/dKnxkDSTZFI1x7nSplCA==
X-Received: by 2002:a17:90b:a54:: with SMTP id gw20mr198504pjb.178.1605634785524;
        Tue, 17 Nov 2020 09:39:45 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id a21sm1751330pjq.37.2020.11.17.09.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 09:39:44 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/4] mtd: parsers: afs: Fix freeing the part name memory in failure
Date:   Tue, 17 Nov 2020 23:09:09 +0530
Message-Id: <20201117173909.23585-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117173909.23585-1-manivannan.sadhasivam@linaro.org>
References: <20201117173909.23585-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of failure while parsing the partitions, the iterator should
be pre decremented by one before starting to free the memory allocated
by kstrdup(). Because in the failure case, kstrdup() will not succeed
and thus no memory will be allocated for the current iteration.

Cc: Linus Walleij <linus.walleij@linaro.org>
Fixes: 1fca1f6abb38 ("mtd: afs: simplify partition parsing")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/mtd/parsers/afs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mtd/parsers/afs.c b/drivers/mtd/parsers/afs.c
index 980e332bdac4..26116694c821 100644
--- a/drivers/mtd/parsers/afs.c
+++ b/drivers/mtd/parsers/afs.c
@@ -370,10 +370,8 @@ static int parse_afs_partitions(struct mtd_info *mtd,
 	return i;
 
 out_free_parts:
-	while (i >= 0) {
+	while (--i >= 0)
 		kfree(parts[i].name);
-		i--;
-	}
 	kfree(parts);
 	*pparts = NULL;
 	return ret;
-- 
2.17.1

