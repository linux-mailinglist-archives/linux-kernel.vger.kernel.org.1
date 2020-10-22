Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065C2295D5E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 13:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897276AbgJVLaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 07:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897270AbgJVLaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 07:30:03 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F4EC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 04:30:03 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id b12so806048qte.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 04:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=g50aig4WnJQhcCcuXsue/eYMQH3ofUeze+geEk++93U=;
        b=EmL8KR1EYemTfE+yaMAAqD9uhsf7c1TN18IfB+hDqP2t/xR4xVtNJIpEgh0vvRSB7H
         yIFZ5RmJFTACKp5ALHzjuLgtciX1z2PM+QuELDtnDBNKIx3oPQuqi+z98+YelxwXVOwN
         3Adv9SPIir+HlZ/hEszX86FdC7CZzeHUkMMsIBR5EFWNVe9dsUR1Ycq9lFhBSy58ObbZ
         nkdFo5Zx+uKCON+EH1uyw/M72H55uOxgKtdxJNvG5P+tiFs74vDVld2Jx2vREImRDj7+
         1ulKgioLCrEXWmbm7tHvcZxX5GipekTwxXUU81sdbWQf3kOXU7tP2XRwnJeHXGN+Vnty
         FrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=g50aig4WnJQhcCcuXsue/eYMQH3ofUeze+geEk++93U=;
        b=YpPV2rGy3rsB3qdWSJ9BACfCfpRsXxy3YDv2QXdsKuiSej9028cSRvyPrV+vFyDw8n
         w+6DllfHrEI5phX0fA7VbClOO+mlqWpq+so+7W3nhLrYtgw2IvtJfUn9JZnFKP4MI6s5
         J3BU9R2wjwKN3n/60Omh/VeYKIM2+BNTQMyFvofzsrb3k1yI3a72FWa8n1hOdqxWkuy7
         0tQxkygeejU2i/190qwS+LhxXy2Bpq8cIQGrUJYXvQdbcaOQf5BnIaZSwUvPdDp6JLw7
         ph1qUVcAqFYEOkQVZ2uVu3djvauocBPWr5wSAr8BKVn6Xa3oMcI0qUTDNkZ4gbqQ4FPQ
         po1g==
X-Gm-Message-State: AOAM533gXLt+p99tq39oU/N/7bebiIBi/d9IhGAHiJO75BV6Rvto8Lq7
        DwSSaJhKLmTMdb+WOBMysGmtF0IfBw==
X-Google-Smtp-Source: ABdhPJzd73qVhZXwIggR9qvJoBBzmyzsli46XkHq7VLUrjNqzdJ5OEjlbs/bNURfA85jFTyNvLZKiCP0Wg==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:ad4:4e0a:: with SMTP id dl10mr1790315qvb.41.1603366202277;
 Thu, 22 Oct 2020 04:30:02 -0700 (PDT)
Date:   Thu, 22 Oct 2020 13:29:56 +0200
Message-Id: <20201022112956.2356757-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH] kcsan: Never set up watchpoints on NULL pointers
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     mark.rutland@arm.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid setting up watchpoints on NULL pointers, as otherwise we would
crash inside the KCSAN runtime (when checking for value changes) instead
of the instrumented code.

Because that may be confusing, skip any address less than PAGE_SIZE.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/encoding.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
index f03562aaf2eb..64b3c0f2a685 100644
--- a/kernel/kcsan/encoding.h
+++ b/kernel/kcsan/encoding.h
@@ -48,7 +48,11 @@
 
 static inline bool check_encodable(unsigned long addr, size_t size)
 {
-	return size <= MAX_ENCODABLE_SIZE;
+	/*
+	 * While we can encode addrs<PAGE_SIZE, avoid crashing with a NULL
+	 * pointer deref inside KCSAN.
+	 */
+	return addr >= PAGE_SIZE && size <= MAX_ENCODABLE_SIZE;
 }
 
 static inline long
-- 
2.29.0.rc1.297.gfa9743e501-goog

