Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D092D944D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 09:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407112AbgLNIqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 03:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgLNIp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 03:45:59 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF9BC0613CF;
        Mon, 14 Dec 2020 00:45:19 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id ce23so21399203ejb.8;
        Mon, 14 Dec 2020 00:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nOHcwlqEDRT0lM53kesWlw3BCTLLVoBAEddAgoVvR/M=;
        b=el5drreD7BLx+lL/RUsZhAypfycxf1Imjzdg28G7OpYi8Hb4coH3UdiQSe/P9pPt+I
         tbLMoeXCnXe95t3yjItjBQWmvSQdfYPLFEvlhLoayuXQ2PW8BkM6lzmhOLgxMIp6uXDy
         fU+WSNoW6jIHRdfv/fvmVkOJ/txjtz/Bbq0/8Go7lzhNgU8ZvG/GTpznOurRlD2iQj00
         aD6FWDhe+N8px1pvZ+syzQ8ic3srrZ/oF7TMmd16gO0Xo7uJZn8GjoKwSqRZJef88Ocg
         nq9K6wGiSvf6Q1HqxQEq0gHIUHThM4Md71PpsCvdoN8U0YNdzPdQkgQwmIGSNbr3DxnM
         1New==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nOHcwlqEDRT0lM53kesWlw3BCTLLVoBAEddAgoVvR/M=;
        b=WL1O9SKKFJ5dY4MYuUY9NxNgCv6pIFXfeIodG2OlE4TfUWg8CywfaWj52RnJQSGp9I
         MrFVqPEPb5RwcOwQjae630m9Q0uTyikHUhEOR8DaomppdlhPJRpskJlLfYL8u/QZW3cq
         XcNAzdI/Au+abJ9W9HEuQWishPiXTafnwrhp3BMxdqwtZwC0mjUUxZ7nst6WbEQ+y/R3
         nu8mqQ5+Cs6YzhXE0orTFaDfodcvnIppZ0sCABy+fVJT67VZgTHFFAaTl5fxXj84xTrQ
         VZbcyWUP4YGTBkbN7vckWT4EwuGCP6vEXSjCJUmyHebh3zsldDN5hjZe3MWs+1kfCHhi
         Wgfw==
X-Gm-Message-State: AOAM533p580dN3xdbba34qvp4ktDJkfoVEsUwO1deap/mQ19mkaCT6v+
        CEWOotWaNvgjOQBUOjP7O2o=
X-Google-Smtp-Source: ABdhPJx6G9yF8J9LtSYqVMXulBGSRXXEaG4AuicJ6Bqc6Brbw194jwgxuuhHfoFOAD+oL/tzkSLeYg==
X-Received: by 2002:a17:906:524a:: with SMTP id y10mr21913056ejm.97.1607935518226;
        Mon, 14 Dec 2020 00:45:18 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2dd4:5300:f852:2e6a:155e:5ca])
        by smtp.gmail.com with ESMTPSA id f13sm12939048ejf.42.2020.12.14.00.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 00:45:17 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Qiujun Huang <hqjagain@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] trace: drop unneeded assignment in ring_buffer_resize()
Date:   Mon, 14 Dec 2020 09:45:03 +0100
Message-Id: <20201214084503.3079-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0a1754b2a97e ("ring-buffer: Return 0 on success from
ring_buffer_resize()"), computing the size is not needed anymore.

Drop unneeded assignment in ring_buffer_resize().

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 kernel/trace/ring_buffer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 91db9d032a0c..95ecfb107e3e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1974,8 +1974,6 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 	if (nr_pages < 2)
 		nr_pages = 2;
 
-	size = nr_pages * BUF_PAGE_SIZE;
-
 	/* prevent another thread from changing buffer sizes */
 	mutex_lock(&buffer->mutex);
 
-- 
2.17.1

