Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B16627D7DF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgI2URt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbgI2URr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:17:47 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AFAC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:17:46 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y17so7043215lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+EosCr5gn7ZyZ+N6mEKKFHdvoy+RoVVYIyzqWT5rRa0=;
        b=SIKcNag+g326Er1qOD+M4r8gtWgXQPVz/kic6Pqhzd4ohq0ETwiQic06PA+s1UQEdt
         99zWEbowBbjJ7ul1HAHrvx+By9s/EXBD3Jmk7ADbYdxs0I/dpZ6CGBQO6i9TVL1ugdDv
         MuWS7XkKqVOtc8q/7yiROVeTOs2R2AD8MD7AzKLGE9/S1+tuXeIyAmlEoZ4pL2EHfRyt
         Ex9q8hU3lX7hbXod2tc09Xw/ooaVbREt+wUfzCXNgC43b9D3Z8UXLaMXs1Yyf3eSFDjB
         G6BtF/YFVGHNWiQb+ZVWfZt9Bftdr3+DfoZMDBf/uwOpJPkA7T/3N1y62/m4G3n9aX/2
         CqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+EosCr5gn7ZyZ+N6mEKKFHdvoy+RoVVYIyzqWT5rRa0=;
        b=M7oZlow4OepeJLyudFwiqT7PtfYcuhLDkVyVbnY3a0eS3pd0y3pOc1s/i0UO93z57b
         DBIUmsAEpX3XnPZlR9ms/q1+HmXrBStJdaXhM39Iiq82ORJcm6XvvF3lWK0/OeUCID/Q
         fe5W+MMV70xuRr2PyuDkJIroE4EeE+BrghOEzNIETxOpwg1DxWdRLE5Aw2iAk0kS3DJE
         RouKBxFFcI5EioCsy87zB7TvUT0m/DtV58SlARWKxvkw26ztczpnqRVmaItzJBR11rOW
         zKXeT04gmVD+AyFOHhRN/nkzdtoRDWpXWLW8vBKb7J34dlHtzVpo24/J985Ig9GM1vME
         5cew==
X-Gm-Message-State: AOAM533dBg1oYRNOEmOTTMrIOfsOlXcuMYTTI4udHwxCZcu+Od8kLz/Y
        NxRBmiuA5/yzI5I1lARJaC4=
X-Google-Smtp-Source: ABdhPJyefhwk3thR3Nx5YFjMDve83dUfvSBVcpTuJ8Em8uq/iPX2wl3isbkUd/wXNmxePbm5yKNmsQ==
X-Received: by 2002:a05:6512:70f:: with SMTP id b15mr1791605lfs.39.1601410664672;
        Tue, 29 Sep 2020 13:17:44 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-221-87.NA.cust.bahnhof.se. [155.4.221.87])
        by smtp.gmail.com with ESMTPSA id c22sm3329356lff.202.2020.09.29.13.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:17:43 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Barry Song <baohua@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] ARM: prima2: Constify static sirfsoc_rstc_ops
Date:   Tue, 29 Sep 2020 22:17:38 +0200
Message-Id: <20200929201738.349465-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of sirfsoc_rstc_ops is to assign its address to the ops
field in the reset_controller_dev struct, which is a const pointer. Make
it const to allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 arch/arm/mach-prima2/rstc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-prima2/rstc.c
index 9d56606ac87f..1ee405e2dde9 100644
--- a/arch/arm/mach-prima2/rstc.c
+++ b/arch/arm/mach-prima2/rstc.c
@@ -53,7 +53,7 @@ static int sirfsoc_reset_module(struct reset_controller_dev *rcdev,
 	return 0;
 }
 
-static struct reset_control_ops sirfsoc_rstc_ops = {
+static const struct reset_control_ops sirfsoc_rstc_ops = {
 	.reset = sirfsoc_reset_module,
 };
 
-- 
2.28.0

