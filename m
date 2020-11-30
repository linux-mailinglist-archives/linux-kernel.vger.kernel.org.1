Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F9F2C89E1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgK3QsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbgK3Qr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:47:58 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D73C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:47:12 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r3so17096077wrt.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2tAzY7WCaNY6Vvb3iCn3hNcrKN7+M/W71UmthXEquj0=;
        b=RwmYii802fgbGuDQhU6u3TAOZwemeblULUj5lGxrKO1EF2eWtKK8zwa28DfilWRgch
         3Nrt6zsrgjEBejGIyhEbIhE27J11poL3dh4HIDmhDUX0CMBsh5u5QEYu5mxLV08m0IOU
         tLMNb2E0pz6DEqJXlgZqhnL5rA61lAsysquYng+/XEXyR45ovnkzT1FS8U6DSI/3N6fx
         OW0K+tv+7PbQ34YTr3OEF8G8HwucMYqJYbtkqIVgTOPj2w5xEnEl2H9rJqGVKce9svDy
         +D13QtJQQgosUUehnqq2Cg7/VXevlmhE5A/omAWoM6o54qnJiFUAFs05TEKbkYEGZimg
         ccJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2tAzY7WCaNY6Vvb3iCn3hNcrKN7+M/W71UmthXEquj0=;
        b=CYAppbkAP4DFFO2F3uXme68lB5/qqxlvVlaVwxkpSprw5vMwP8b7quv+NDgb7tmO1O
         aoW1BaSSas6jRvzvogyS1tyEOqU7KJTv6WUtO74bcpWapZkekgsNs5Iya1dADzHVMYxI
         XU3zl+Tl/bZ09oFF4TmraVIaCLDbkjKzggGFKjN8I3ysK/ZRR/uoGT/WOsXXqNcMncAJ
         v0yvvRAH1SwftsF3drcGi16NuFEY6sI3PJOkhoby0rFQZqA8m22sUnTK2cuPRUPAesnb
         IO30e+HhogXvEjsRAcFZJ8RjDdRTWCPIfgFY12Qmyzo+5Md4i+B4ZXAlEhzn0drCqegH
         bL/Q==
X-Gm-Message-State: AOAM531BQQmSNau/GCRNJFNJTtuLQhtfoNyeLER554DrcNTrpUmIen7P
        qBeQToJRo4smYzC8nS/5aSWl/g==
X-Google-Smtp-Source: ABdhPJw4VhKZ+mcCiK1CW9lYdB12fKznXq0mtz/atQNdSHA++tAiAoG86oi0jLIwvVfaX1SkIKaL0w==
X-Received: by 2002:adf:fc8c:: with SMTP id g12mr29470041wrr.355.1606754831051;
        Mon, 30 Nov 2020 08:47:11 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id b4sm8400805wrr.30.2020.11.30.08.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 08:47:10 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 1/4] configfs: increase the item name length
Date:   Mon, 30 Nov 2020 17:47:01 +0100
Message-Id: <20201130164704.22991-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201130164704.22991-1-brgl@bgdev.pl>
References: <20201130164704.22991-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

20 characters limit for item name is relatively small. Let's increase it
to 32 to fit '04-committable-children' - a name we'll use in the sample
code for committable items.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/configfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 2e8c69b43c64..4f76dcc08134 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -27,7 +27,7 @@
 #include <linux/kref.h>   /* struct kref */
 #include <linux/mutex.h>  /* struct mutex */
 
-#define CONFIGFS_ITEM_NAME_LEN	20
+#define CONFIGFS_ITEM_NAME_LEN	32
 
 struct module;
 
-- 
2.29.1

