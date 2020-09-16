Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B5D26CA8B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgIPUHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbgIPUGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 16:06:24 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AECC061756
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 13:06:23 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id u8so8348037lff.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 13:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=83r2wrjQMjUpX6ec5uvyqkMhiCmfyJ7v7vGfYiNy+/M=;
        b=bLEy5kgLWyy3Cw20pb4aEiiWr7+GT1cqur9BhkHWjWdXPw+nCjzBamNJGhlwczulxN
         E9vUC3IhP190vrZ+CvbT0sygSie4Mu5mvwN5wwB1I5aGXf4YdqNNoQSRwoItRphNTt1/
         Jymsc024JmkinWUOi+zRpaeBMFAnJ0CPQClyl8PmAewGZ6c7RCfyZ8evg5ZOzQ4zg1Xc
         hJk0bZKnFWZ6qrzQPuhHdgPbd9k0hgV0L3xry24ezxeimhAF8QPcfqKXFvFNmR7kXm1/
         KjGQIHvilzdgi9KFtEHo+R0g8iShzPV4vEIjVV4P9Y5zepY7E+CR2WDncDepNRaLw63T
         nLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=83r2wrjQMjUpX6ec5uvyqkMhiCmfyJ7v7vGfYiNy+/M=;
        b=pzA52Df86cms+9TaNHRoBIQIgfl5wCv50kO/d7fi1frrn0FWiEemMSiG8SAvT9lhFb
         G2uN6z2/dFgJmtnBr7GdePD0eWH4+qfiabFVjAFXJZA/Wq+oylJlKvGz2/ZKZbsTdzPb
         +Xx1D9zNhEyCqGGxiFSYwDJ4/XpLjPsKorC/BgNP7SKe2bPld/yCEhRro76wnVTWpA0N
         2gsXz4h9+KN3zLin4uIQmPEwJDp7k3UIJ7bVUjjYrfdbPT+qvfnULzCDFYhVuj6Vsr1D
         ccBlIb5LmRLXIdCpBz07BNC6jCn1vDvJtHuRM7xp5GkCSnZS2cziNAAQCWYKFPGD/vbY
         5cJQ==
X-Gm-Message-State: AOAM531TMqe70f8zcmdHdf0gE7XF+BeEPGMPMvW9/S3DQs5pCQj4tYd6
        ML4cjKlgNC3UpypOjpZ5sgE=
X-Google-Smtp-Source: ABdhPJxm2gH2T/GibDyTFJML/hUlGDceRYhbfAYXwtXAvrUDtwj9ZBbKk0PSzGojnhNryVm0BCp/+w==
X-Received: by 2002:a19:38c:: with SMTP id 134mr7770047lfd.564.1600286781767;
        Wed, 16 Sep 2020 13:06:21 -0700 (PDT)
Received: from localhost.localdomain (188.147.112.12.nat.umts.dynamic.t-mobile.pl. [188.147.112.12])
        by smtp.gmail.com with ESMTPSA id q4sm3376728lfm.46.2020.09.16.13.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 13:06:20 -0700 (PDT)
From:   mateusznosek0@gmail.com
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Subject: [PATCH] mm/slab.c: micro-optimization spare one branch in main flow
Date:   Wed, 16 Sep 2020 22:05:39 +0200
Message-Id: <20200916200539.23268-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

By small refactoring two 'unlikely' branches are changed so that if
not one of them is true then only one branch occurs in 'likely' path
of the function in question. Change verified in assembly generated
by gcc 8.3.0.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 mm/slab.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 2cb494d98fe9..e04ea756bcbc 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -4186,9 +4186,10 @@ size_t __ksize(const void *objp)
 	struct kmem_cache *c;
 	size_t size;
 
-	BUG_ON(!objp);
-	if (unlikely(objp == ZERO_SIZE_PTR))
+	if (unlikely(ZERO_OR_NULL_PTR(objp))) {
+		BUG_ON(!objp);
 		return 0;
+	}
 
 	c = virt_to_cache(objp);
 	size = c ? c->object_size : 0;
-- 
2.20.1

