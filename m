Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D128F246EFE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 19:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbgHQRkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 13:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731336AbgHQRjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 13:39:32 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C79FC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 10:39:32 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d190so13931008wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 10:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UGi7nUmnSU2AxJ3eHG2eTFsMqNAfZu9moA2MOVQZI4w=;
        b=1KYk0y+8JsMaFBq6jYJRs0ApLLfRkYIJlOrYd4R26WriO5pVrCEeVrNH8WV2wmallB
         NxLm00PrOYQzbSgTZNLhTJq5AMmcb8J1qcd254ez5/Drafrad0Cqh8HBLXbP8i7BuYtu
         ndJHlIJ/3auHSGqX6LwyUNZz12S2jkRJ5w+gSv/a0htU3zpOx+O/apFbokMrjORoSXEV
         E9Pthgcf7Dh6TxDpUQO+CyjUdwyMbolritSwpfDV6VUBOkDzDggHwiGT6VYdDdZDpA3H
         rRaQMDQBSQgbioY1bRFfxDPFHIaaV2EmXQdOxAAswmDsjYhiMACKUioQx/AbE9esX9C0
         hIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UGi7nUmnSU2AxJ3eHG2eTFsMqNAfZu9moA2MOVQZI4w=;
        b=BY7x5t/k+wPH+IKHcM+W0B60tC+4PlRc9bPTqHzgvtiCmLXVTfqjM6UXjqdW/LzbmB
         7bXaFtHxqxjRDeO3l3+0k/MVsmwgJRNeh73SyNHzDKw+93og0TeSvlbeC/x4kVfHTD83
         pAbX5p2W0na7fMQX2faX5LE1eIrISv8SXr7xNkunn3zKqRT8b6W8WN6B/Hvti4oZXlhC
         6wMJDFzDXCD6xvbgCzUqcqy5TbOfhR9QfDhnrujfSnsIcnTTVEoHwxwGI6meftMQAJf7
         t3e5w/6yRNK10WbqIFEq3ZChn9qi8airhPrF8tu0pyuFJcxQyNiKhq8CSrJZPvo8Y9Kv
         HAAA==
X-Gm-Message-State: AOAM532wXd3sA7pMjhkrVp9KHq9yvtpRIcKdcEjHWMLxZOQVg48aKJve
        UJnqaCon53Xj6i/vvgeahYe5zoZjqBH1Sw==
X-Google-Smtp-Source: ABdhPJytG3rX7acI30gpSc7TqlK9Uh77srnc9MMySIvka/xac3M3wjSRX0b+Appyv1zZLD8RNNUNgg==
X-Received: by 2002:a05:600c:245:: with SMTP id 5mr15339803wmj.22.1597685970965;
        Mon, 17 Aug 2020 10:39:30 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id v20sm9659205wrd.6.2020.08.17.10.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 10:39:30 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH] mm: util: update the kerneldoc for kstrdup_const()
Date:   Mon, 17 Aug 2020 19:39:27 +0200
Message-Id: <20200817173927.23389-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Memory allocated with kstrdup_const() must not be passed to regular
krealloc() as it is not aware of the possibility of the chunk residing
in .rodata. Since there are no potential users of krealloc_const()
at the moment, let's just update the doc to make it explicit.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 mm/util.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index 5ef378a2a038..bb902f5a6582 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -69,7 +69,8 @@ EXPORT_SYMBOL(kstrdup);
  * @s: the string to duplicate
  * @gfp: the GFP mask used in the kmalloc() call when allocating memory
  *
- * Note: Strings allocated by kstrdup_const should be freed by kfree_const.
+ * Note: Strings allocated by kstrdup_const should be freed by kfree_const and
+ * must not be passed to krealloc().
  *
  * Return: source string if it is in .rodata section otherwise
  * fallback to kstrdup.
-- 
2.26.1

