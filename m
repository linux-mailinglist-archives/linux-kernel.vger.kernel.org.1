Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFC92B6C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbgKQRtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730253AbgKQRtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:49:11 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82112C0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:49:11 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id g7so17782081pfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EAf9d4gGWEUWE1b+AMgq6WQ0FcZNv1uCLoEh96U6HDQ=;
        b=GrQmJSaliPTve3DL04A9GAepxzDBPQmaJDXflI0uIc24Ceqru5Te8SBteMXYibBiWV
         YXtyBkZcp4alV78euGq8ZrdXrY/s1xTOqwOzjdB/goMB33KUlG5kJWFx/V0Hqrk3JZEp
         zw7ndp6YX9rmihiKPQuebdAS2Wg2Jl1+n+zNJJHekxbJkjfpKusp/zA2T2t21GcxUBBV
         sZr+xgHWq6+/6X33ZHMmafEYZVgWboH6fcuIKZcdfC7uKZ/Gc2XP02Uwep7dMXIQHRUe
         AZFf9CI2yybVt/jWzI+IT2jw9m6POx/FLGVpicrbqCfBClD5HoQVjXuKaz0ESjdzURvc
         ZuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EAf9d4gGWEUWE1b+AMgq6WQ0FcZNv1uCLoEh96U6HDQ=;
        b=gNvdj4znFf/hA7WD4TPj6AIJxF3/AzTsiuAziU2kqgohLY2EWsznd6pEJ26tfi7BL6
         pXsZMRpkZMjbsurLvkUB+jjyPc45ZxbUaY9HcVQzcNFfnQmnhsi9HtoviPcSXvSi7D5e
         q5T7uENdJEo2ipzZLGSNIl4pbQpti0QqF5dJF5q+KRUNqnS3DK6UjU4Sm4kvMNIvRDuI
         oVA8gGQe/vsLi5C65PjfM2H32UTSZNMGZxWgFEd6zjvlEVMKFekRr9etPugWR42zWW+a
         7UYpwu2T1r4thzmx8l/r6taeaN7G4C066c9zDAlo9hAJcHxjnmdKEwMytwXR3n1U2oQU
         JsTQ==
X-Gm-Message-State: AOAM530LpzSw/o2ekdb3WNJNTG2ot5dGuV6dR+Bg3igkuZ+1Hbec+K8f
        j+v5S4o19we/labLao4woBr5
X-Google-Smtp-Source: ABdhPJwxqq2K6RhfPEieDLWKql41cofe+24CsQYp9jpMXliRovzgKa7QgkEGeFPlq1NqV99mGfsR1w==
X-Received: by 2002:a65:55ce:: with SMTP id k14mr4432790pgs.65.1605635350991;
        Tue, 17 Nov 2020 09:49:10 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id 192sm22222810pfz.200.2020.11.17.09.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 09:49:10 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 4/4] mtd: parsers: afs: Fix freeing the part name memory in failure
Date:   Tue, 17 Nov 2020 23:18:45 +0530
Message-Id: <20201117174845.28684-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117174845.28684-1-manivannan.sadhasivam@linaro.org>
References: <20201117174845.28684-1-manivannan.sadhasivam@linaro.org>
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

