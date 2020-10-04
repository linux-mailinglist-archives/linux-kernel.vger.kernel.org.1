Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57A7282D4A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 21:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgJDTcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 15:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgJDTcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 15:32:13 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA59EC0613CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 12:32:12 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 77so8364641lfj.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 12:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i/fufn2S+UYs1En0UMjsqmWtEsBWJSmLjtdgI01juaY=;
        b=LI2msM40zkPaDk3frBHh3eduuKwhVqAIJHfHYYqWpeVsltZ2gPpV1KbpcwXZ76nNnX
         fF2lAoPzKnC4gPzW+kBfYaRbTDYKniv9k0LK/Qf4VSLsgCwftdgZyYrKvb9XnUe6v9bg
         B7FDps6fHjBVtdek6tzXN7cPlJpmwyekN5CMJjqp4yKdY/g1dVZhvYRW4bAOzVzI02yc
         PlrfN6B1RtHfJeDmusyq4NlZgvv9KKLTfdsWiHDCVRqAoSLZc4cZ5RFjLuJFVuk3i6Ps
         qSB+imymyBphE9ygjkd/7QvEFEAlPWwbJmlqMfWYBlDREvZqzbBCphTaCeWmFKwu5wp5
         eGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i/fufn2S+UYs1En0UMjsqmWtEsBWJSmLjtdgI01juaY=;
        b=czw0Qooi/3kjd03RAldHSsbm7TTNFaAq1oWoRNhc/xNvTcf0QPN1+foHNgXS9AbqUI
         10namGRTdJY89KHOwft6e6E+RdB+hf/SuX75xTCVP2IP1nsNP5rmezPCEHPS6NfSxr9j
         fgiMZx2x+RvAkzyFhRq7KjVLDcLkNnQRX44Dln1sn01sFzU3J5+bhXFiCZd1ey39i20/
         eGNh571Ex2u+VlpPdwtuGfadOBlrH5Ngcy+Ubbjx5ymgD5YwLKR7NSBRU1ccjAl7rMbi
         GYUz+YK58KhROo5DpnGkPbOFHL/vHmbADhdukTwFGKAHs+Cu4NVdz3kEEFUZEcEhtQb7
         KOgA==
X-Gm-Message-State: AOAM533Z3wKd2drSKquYhr/0UBFQU3BNLP8H3uXEqRJ9onZTuscgmsER
        zTSy/SLFHQ/7M9vskY8wxqM=
X-Google-Smtp-Source: ABdhPJxY6EhOPZzqIag0EHTkC+YwdQEKHeb+OWYAg8PUV+HnhThvtqgdO7Qcd4N5gbfHn1Iv1/8ERw==
X-Received: by 2002:a19:254:: with SMTP id 81mr3936931lfc.405.1601839931261;
        Sun, 04 Oct 2020 12:32:11 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-221-232.NA.cust.bahnhof.se. [155.4.221.232])
        by smtp.gmail.com with ESMTPSA id h22sm2298220ljl.101.2020.10.04.12.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 12:32:10 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Akira Shimahara <akira215corp@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 1/3] w1: Constify struct w1_family_ops
Date:   Sun,  4 Oct 2020 21:32:00 +0200
Message-Id: <20201004193202.4044-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201004193202.4044-1-rikard.falkeborn@gmail.com>
References: <20201004193202.4044-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fops field in the w1_family struct is never modified. Make it const
to indicate that. Constifying the pointer makes it possible for drivers
to declare static w1_family_ops structs const, which in turn will allow
the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/w1/w1.c    | 2 +-
 include/linux/w1.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index e58c7592008d..6bd64bcb6316 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -613,7 +613,7 @@ static int w1_uevent(struct device *dev, struct kobj_uevent_env *env)
 
 static int w1_family_notify(unsigned long action, struct w1_slave *sl)
 {
-	struct w1_family_ops *fops;
+	const struct w1_family_ops *fops;
 	int err;
 
 	fops = sl->family->fops;
diff --git a/include/linux/w1.h b/include/linux/w1.h
index cebf3464bc03..949d3b10e531 100644
--- a/include/linux/w1.h
+++ b/include/linux/w1.h
@@ -269,7 +269,7 @@ struct w1_family {
 	struct list_head	family_entry;
 	u8			fid;
 
-	struct w1_family_ops	*fops;
+	const struct w1_family_ops *fops;
 
 	const struct of_device_id *of_match_table;
 
-- 
2.28.0

