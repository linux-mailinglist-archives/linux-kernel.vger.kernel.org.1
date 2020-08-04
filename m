Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD93923B2C1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 04:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgHDCec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 22:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgHDCec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 22:34:32 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F7AC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 19:34:31 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ha11so1199978pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 19:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gk1n9r93n5xzn2rKO1ZKzoYAJi9jZTqeFwpABIqhBHQ=;
        b=RKcu90jsK3dX6vNsb59fWWIKejmewqQMDcSpVmACXTzhaOWbJrRkAQzyrxFSAjGZRD
         65HYehXNNjB8ie/+MBhH8gOdt8xJjQAl1KO2QVPNw6EvtyLpZO63mrvmg5dIJY+d8aRm
         gr+LYxFVJvq9ugnhbFE+e6HnX7fSBLJWzkftlMgp2LVQEHTgWXYgfpjFqilIAymEbEgN
         QQs7Aw309e4ZqLYmCvVk2AopAVxCGjxPraMquUs7qi92BrBQFn2f348p7tVwSFoJvVb4
         7H4XP+P2OtTyempPDSHk8ihMvrDQgv/nNZxdArbBeOjhzZtDeQqrE6eSqmVrBqolkArf
         QV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gk1n9r93n5xzn2rKO1ZKzoYAJi9jZTqeFwpABIqhBHQ=;
        b=pDAnKmif0AC4QJ/gZGQChXNzqzQpNBx3GN2Klk3DLBKTAEBy+5u+wJmtzxI/Z7MS56
         NTtRAVUB40yrZI23EZTZTe4hGWXc9PT3TTOnWPQvstd1Z+HCMxQIOMKt9aPnWBPx3V1M
         LwsImuqYqhanJutx1ScQxXteExpU0VdPVSLxqjpVgqZLW7qENvjMERSe4MCTt96tRy/2
         4xLLMF+eB84JNwIJTaaPr/dj07HMEg06xoDZhpdabYv8n7z28T6nlxoGtOh703HVSa/Y
         DcxDlcYyuSlmFuj2bGvQif+oVM46LxDTr5u1K4NIPw+Qap7rKhseXW8LL/VJWsM2oCIw
         bBLA==
X-Gm-Message-State: AOAM530QBtUhQKNBEsUihwYeap6dDl00GJMlQrTNf5eG0jloGUaGzPIS
        taxSfeQecTKsDb7+PidrotI=
X-Google-Smtp-Source: ABdhPJyjSM6GGnwIOwT4czYh0dSYoXR+QvwkKyqQxdz2oiHqEE85lJNjtRm2tz+pnXC014ud9ADZ/g==
X-Received: by 2002:a17:90a:fd03:: with SMTP id cv3mr2100743pjb.111.1596508471324;
        Mon, 03 Aug 2020 19:34:31 -0700 (PDT)
Received: from localhost.localdomain ([106.51.110.64])
        by smtp.gmail.com with ESMTPSA id u65sm754508pjb.22.2020.08.03.19.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 19:34:30 -0700 (PDT)
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Sumera Priyadarsini <sylphrenadin@gmail.com>
Subject: [PATCH] scripts: coccicheck: Add chain mode to list of modes
Date:   Tue,  4 Aug 2020 08:01:41 +0530
Message-Id: <20200804023141.9510-1-sylphrenadin@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds chain mode to the list of available modes in coccinelle.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e04d328210ac..6e37cf36caae 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -99,7 +99,7 @@ fi
 if [ "$MODE" = "" ] ; then
     if [ "$ONLINE" = "0" ] ; then
 	echo 'You have not explicitly specified the mode to use. Using default "report" mode.'
-	echo 'Available modes are the following: patch, report, context, org'
+	echo 'Available modes are the following: patch, report, context, org, chain'
 	echo 'You can specify the mode with "make coccicheck MODE=<mode>"'
 	echo 'Note however that some modes are not implemented by some semantic patches.'
     fi
-- 
2.17.1

