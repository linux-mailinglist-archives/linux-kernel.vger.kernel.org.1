Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A86E2AF4E5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgKKPgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgKKPgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:36:20 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F96AC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:36:19 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id f27so1678461pgl.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=1G4agNXNKXgm5IHdyS0s+PRy/cLaiKKlvU0VNTE0TQk=;
        b=tGABkHtn0Y5YNpEYVqyIVSu81Q1fdrW6vsQ5qLojPAf6VEZDc6UvWbCXDG7dPFZRlV
         XEZUrvlYEDt0NJCHiqN/02P8U1XEGljbzpPIZMO5eB8Yzu2FBNjEMHaKZWgI/RzeFmhs
         R2jYIodSdS+j8YHXd+pyw9kLNY19ebaDB9+l4p8rDlp+9hxkZoRnKWeyweIpJUeqsEYz
         GZl7Qcs9pd5Vcye1ROgKcT0svWYQObKoB1R/3tqkNivkiatWgCmEjeB4MCPl04u/ScGr
         cC/KmHHiYQqkyt7aPPfso+O6+dTgF4dc3mRvuIykV3AGab7KRjxZq6hVIv308Vxi08YL
         InoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1G4agNXNKXgm5IHdyS0s+PRy/cLaiKKlvU0VNTE0TQk=;
        b=LFd1pb3je4jbH8N7M9m72FW5fYoMosGBhyTFzoEVH8BK+21v0xAIk6mNmQAGwWntgK
         5XmFNm9VvyEynF6ZuHerY1v3/FnMTTta/UwePqxe4n9LP/eDUxFNf/ywM498istnhWWt
         YyOBuyNNoFIbIyybKL09X/k6Qf3tTjVs5rqCL4hqF4HBgJ9p7p2aepqyLVrmkonZuo/X
         1ejNDjHojfAFx5pzn0sJoUpW5407p/vPVj93tsZX8RXqatN8al5m/1GzWtW9tDw8Zu6g
         GlpezRKutdMYjEsNgKpxLyPjL8B3knxD7LYKa9TNF8oxo2WXOK6LfQpMZdPHfg/BXo4e
         LSWw==
X-Gm-Message-State: AOAM530HjDwRh11PuAsA0hagBq/oxEkCQ8ccGh+eor+yr8CWmgmFN/kK
        0O0EwxOmpL0VrbdZPok5O57UPCCsm5z0jdkQ
X-Google-Smtp-Source: ABdhPJyKic6Ynlr7aPhLBixqQVFs3Rf4kXNap47xlNAUeaP4LBGOzP/gCocq155rUzGaZ9VB+xQQ4w==
X-Received: by 2002:a63:d245:: with SMTP id t5mr21387632pgi.283.1605108978352;
        Wed, 11 Nov 2020 07:36:18 -0800 (PST)
Received: from [192.168.11.16] (softbank126112255110.biz.bbtec.net. [126.112.255.110])
        by smtp.gmail.com with ESMTPSA id u24sm3242889pfm.81.2020.11.11.07.36.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 07:36:17 -0800 (PST)
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Rob Landley <rob@landley.net>
Subject: [PATCH] Collate "run init" message to one line with prefixed var
 assignments
Message-ID: <6daf4796-b211-8022-984c-0dcc20dede0f@landley.net>
Date:   Wed, 11 Nov 2020 09:47:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Landley <rob@landley.net>

Run init: HOME=/ TERM=linux /init

Signed-off-by: Rob Landley <rob@landley.net>
---

 init/main.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/init/main.c b/init/main.c
index 130376ec10ba..80b06566852b 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1328,15 +1328,16 @@ static void __init do_pre_smp_initcalls(void)
 static int run_init_process(const char *init_filename)
 {
 	const char *const *p;
+	char buf[512], *s = buf;

 	argv_init[0] = init_filename;
-	pr_info("Run %s as init process\n", init_filename);
-	pr_debug("  with arguments:\n");
-	for (p = argv_init; *p; p++)
-		pr_debug("    %s\n", *p);
-	pr_debug("  with environment:\n");
-	for (p = envp_init; *p; p++)
-		pr_debug("    %s\n", *p);
+
+	for (p = (void *)envp_init; *p; p++)
+		s += sprintf(s, "%.*s ", (int)(sizeof(buf)-(s-buf)), *p);
+	for (p = (void *)argv_init; *p; p++)
+		s += sprintf(s, "%.*s ", (int)(sizeof(buf)-(s-buf)), *p);
+	pr_info("Run init: %s\n", buf);
+
 	return kernel_execve(init_filename, argv_init, envp_init);
 }

