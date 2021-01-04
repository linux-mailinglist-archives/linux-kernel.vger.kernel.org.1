Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EB02E8FC1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 05:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbhADENV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 23:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbhADENL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 23:13:11 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F35C0617A4
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 20:12:04 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id l23so9987606pjg.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 20:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wneBaSsM0xu86yHRW+fmULQ20sTukJwsm41Qy3J+Umg=;
        b=kUog3bVTIvYUWWUzjYQiRQyzxAlie5iBaP/m/YoCMjhOoCsT5F3U3JzXz4OfLihcw1
         1Jfz8lCNkbUcL5zpmLYT36af6+u9c30idejRXIJnXxpoWV1itGu7GtGC+EeNuWsl9txK
         vsWQKMoxfakSo0jp85msmiCUaKTYvpvbXOcCcnjofk2XnHJxOk6ncEMs+sVEt3LhN4Ck
         SnN2gH1CzJhgK7MG4/RjaLccO4G+1/BNgtpUW7IeHVEYx1EIGFM8BeL+Hs2HSngLT2Ng
         si/ivAd11a85yLlElbr6ZR4yQSLZ8SrYFtGdOjBTClmTc4GfgJt7S2xED02PsfxuT/SR
         tkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wneBaSsM0xu86yHRW+fmULQ20sTukJwsm41Qy3J+Umg=;
        b=MHuCCxskuAkfScq6XZLf9QmtKIBnsTSFigDrxXD+s/QRNYGoqfU6GZgfqXJCGZ0tvE
         Bw8qogO4izhgm12IyUWyTvTbzqLtmIGvLDix1d6m/CmwrSqoKpOAp+j76bsR2KNoKODa
         KnMhMrrgGfVaryH2WjRmG3UEWfeGgRCTtP2/yDqKPQ85UnVSBIt2qd88fEbj31vJ1zXs
         bv+q9ia+pBbYMsm8I5hdYkNd8ZQK17HJ0WqTIqgHeBtQWqAIJ2OzQZnLWFyCstC3yytt
         1g1n2bFfZRAtgRAH/EmrKlkT0d7tjJt9HH3rviGGbCVThV43BLFHbMTt/sYJQIemxs6L
         ukkA==
X-Gm-Message-State: AOAM531MXrQuk4jS1YvbxPCfvxUNl9Vu+XNNu8n7HW1CZ8gNk3bcV9hZ
        ZnkDNr6mQLmTPwCg5u17ulb6
X-Google-Smtp-Source: ABdhPJwp6G0zMQLd1gP3mxWQZWOQI5+R61JLxuOhu+0q+EumPWeHC8XjNAYRaBZ+3gNLo4XqYkOh7w==
X-Received: by 2002:a17:902:8d97:b029:dc:313:ee70 with SMTP id v23-20020a1709028d97b02900dc0313ee70mr70807129plo.82.1609733523386;
        Sun, 03 Jan 2021 20:12:03 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.160])
        by smtp.gmail.com with ESMTPSA id x22sm54899930pfc.19.2021.01.03.20.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 20:12:02 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v4 4/4] mtd: parsers: afs: Fix freeing the part name memory in failure
Date:   Mon,  4 Jan 2021 09:41:37 +0530
Message-Id: <20210104041137.113075-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210104041137.113075-1-manivannan.sadhasivam@linaro.org>
References: <20210104041137.113075-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of failure while parsing the partitions, the iterator should
be pre decremented by one before starting to free the memory allocated
by kstrdup(). Because in the failure case, kstrdup() will not succeed
and thus no memory will be allocated for the current iteration.

Fixes: 1fca1f6abb38 ("mtd: afs: simplify partition parsing")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
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
2.25.1

