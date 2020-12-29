Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D642E6F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 11:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgL2KXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 05:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgL2KXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 05:23:22 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7A1C061796
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 02:22:41 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 3so1934144wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 02:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2tAzY7WCaNY6Vvb3iCn3hNcrKN7+M/W71UmthXEquj0=;
        b=LA/fmstXWYD3Q7WIdCqiVNaiZ5QcREMBZp7CS9kFsq2H/yhCJ0qQAYszegyz2qd1Pu
         GfHGAk9oVBnmAPSpRk++mM2EXIuHhHvweXTgEb1Lw+YwJl1tWUObeeN3tIsDzGex8yt7
         xfN2iSHwP16MTtVT/45G1ETj4GIvuyFymbRycC0iWcFliSa/WoEaaYIKeM25K94J7yPk
         0Gj/405Ldji1/4JdqQoVZgUg5NyHUuNNQUWGbvI3iWyQtZSjfGqeFqR+VfnUws2NLyct
         1r/rzkZM9F2jFHx4O6i0h/YngykMgmxLByE7FfH5ldi/64gKCKZyESq7CF7qPUUOTzMb
         I1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2tAzY7WCaNY6Vvb3iCn3hNcrKN7+M/W71UmthXEquj0=;
        b=PEX+dJELbqE/+tD37fDr1MK4toSGle8crmPSh4RrnG3p3kge3y/Q2z917PiTynDgg4
         lOmxryqF6juWrgJdGJDxDm9waNU5Dg513ydXxdDgtaJkhaGJEYwr+7BatbTDNgpZE3lD
         qc3/vLEqHw19KmG76yse+UvJSb24IkYjLrhwJVG/nBSK3vBLCqPRub4MY6OaOrgMcrP2
         o4AkLichJsTu6alGI22WGxY933Nd9dw5yKkiEFbao38/MQLHJnzsrRbBPplqKd4Sg3yh
         Wz/2YBK98oYVVqfh6cQwi1qdGdAwCQvHJOPVCKVu/1q9xHcSavvd5SA6h3cdq+bzyAWj
         r9Mg==
X-Gm-Message-State: AOAM532erN/Nksydr9uTxxhT76CY5BhT9sNhTJeOiGGzc1qzjYyXPAN/
        iKl83P8O9sxGFzZsSm2Alel+0w==
X-Google-Smtp-Source: ABdhPJxM/Gvj1fd5HwCK4wRBnLrUzowHAlFb9IXDs18nRzS5+WDcIEjvVQjdU1S4LlznGxbYSVSD7w==
X-Received: by 2002:a1c:e306:: with SMTP id a6mr2916748wmh.66.1609237360513;
        Tue, 29 Dec 2020 02:22:40 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id h5sm61174512wrp.56.2020.12.29.02.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 02:22:39 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v3 1/4] configfs: increase the item name length
Date:   Tue, 29 Dec 2020 11:22:32 +0100
Message-Id: <20201229102235.29550-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201229102235.29550-1-brgl@bgdev.pl>
References: <20201229102235.29550-1-brgl@bgdev.pl>
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

