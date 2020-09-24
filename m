Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B91F277156
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgIXMpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbgIXMps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:45:48 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D19C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:47 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k18so3436884wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0DpbXpiFc70fLCFRlfWlMn/UoS1HIYuQqCSzDx6FL6E=;
        b=pxDUCIYwPFfwnqhr+0IqKTtoUECwlphKHYKhEo0GkaTdEsvtHvT0Q0Q0yZts+45gtU
         +x3ZUfkK6g/q6sVqEji6w6w2CCwoYM7e0LRioa+5C8FZah0GeWmWYHEF5aD8Jf2Okgmm
         IM1F8KpDWGyZPeAGxQ7XEnIBKjPYQRC8qYm8t0tZuPUMnQU4I3EB0O1Wl8071dS/nGXr
         CcbNC0hpoor6Pe+17n0MkxTdqkQcgRGIeSyVKHGPw9RjhapntSAXtMwjWb2ZojUAfcqJ
         29WMmiw5aYYve5v7ZJAhfnLWihLA2t2ZMOa2CAF6fPczqjygGLOP4QpDQQpphmIvMeAS
         Q3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0DpbXpiFc70fLCFRlfWlMn/UoS1HIYuQqCSzDx6FL6E=;
        b=omQBUpCoZi3PjS2g4n38gLfqFWhAvL4+eUKzaic8dk5E76ZN17V/MTnFvnyQARf7qz
         yHih9abEXMrHLvF2E5GDVLYZIT6Ox1U18McTKdC3fXRorjn+z5d2YKNkHo2q7YO/HURL
         wOGAvmh6MlCrmRsdE5/aJ8plateNY487uMibKZsHr0dJTF1PLwznGYnLw1LSTnFmShiQ
         pJo3OZ5KmLj+Td3EEXspr3oughiDBLDKasJF49+iIdOCeiBYyrVkqhXmhVzH3ycL+YG/
         u/Z/ixyntb2Rj38KHNec/jA/8M5EE+5bj+QWqS8rDIl59ulZowOBSpwpnx6eiCEBqtpC
         2h4A==
X-Gm-Message-State: AOAM533XKUvHE867SGoYyzUJ7jbpAARY7Kk+Sy0ZLEElWvTrWPaM+L4A
        zrMp5AXpoJg2MNHivXvZwHHZiw==
X-Google-Smtp-Source: ABdhPJyuVEmrGEqH08ZZaSPY62SdFJ/0xH4AA8Eav5uPxrUuUMcE+ljUHigaUJwwgzGOXG3yp/tF6A==
X-Received: by 2002:a1c:1f86:: with SMTP id f128mr4467567wmf.187.1600951546377;
        Thu, 24 Sep 2020 05:45:46 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id 9sm3316834wmf.7.2020.09.24.05.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:45:45 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 10/12] samples: configfs: consolidate local variables of the same type
Date:   Thu, 24 Sep 2020 14:45:24 +0200
Message-Id: <20200924124526.17365-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200924124526.17365-1-brgl@bgdev.pl>
References: <20200924124526.17365-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Move local variables of the same type into a single line for better
readability.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 samples/configfs/configfs_sample.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/samples/configfs/configfs_sample.c b/samples/configfs/configfs_sample.c
index 220aee7075b6..49c87ca58116 100644
--- a/samples/configfs/configfs_sample.c
+++ b/samples/configfs/configfs_sample.c
@@ -330,9 +330,8 @@ static struct configfs_subsystem *example_subsys[] = {
 
 static int __init configfs_example_init(void)
 {
-	int ret;
-	int i;
 	struct configfs_subsystem *subsys;
+	int ret, i;
 
 	for (i = 0; example_subsys[i]; i++) {
 		subsys = example_subsys[i];
-- 
2.17.1

