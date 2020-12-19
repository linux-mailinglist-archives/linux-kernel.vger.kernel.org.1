Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F7B2DF099
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 18:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgLSRFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 12:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgLSRFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 12:05:51 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBDAC0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 09:05:11 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k7so8032471ybm.13
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 09:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:cc;
        bh=vRLuXOIA8ra1QfYJtJa6fHDyAv5QMA5uNL7Qfw/l2xY=;
        b=HWimkrBOC8ZIriK9HG74tC08/J66mjh16qNL2u/hX9z4DtBTOI3PLS/VmIBgtHgm9+
         oYOWiJCYs+V4J7ubKHvfBqo71hOpbfn4DiycoDKwTvIMnHjIiFmojmbOqYoVM348ILAa
         r0rE4NQvpACZFo/ZvJbqEazXPskml7zeyzemvEMNIsFtA3bzK0Ybs+BMzf/DksqTnGnF
         jwIf8UEnZ1A0sOhQTBhAg48XKATfgXZGk54r9+/IqMTjQjJcvSKPFHgZuYUKteGas+7x
         gxdKbWiHvF+h76pCj18NzcKdblvSJq0+cgFGNZSvusbXw5aQbjQyp3madF2aEfaFT8rX
         v1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :cc;
        bh=vRLuXOIA8ra1QfYJtJa6fHDyAv5QMA5uNL7Qfw/l2xY=;
        b=fM/YaDBtYwzmuCIAbT4wW1nz50C+2ErcQ/DiG2H0+7x+O8+gh6cLYb+PoulHtjNZ/w
         CIhSk3nW1br8gRZap/vXqI90gfgIaQ/lRqn/UxzkQ76XuamcMmQ0emBQZFjcnUCwUGJk
         nBv+IbWCKk5Kpziomp0VQKgDmj19Zvoa83KyLT6WQ8W2n5Cy/IUKOmWeC/9DUGrZ9X7X
         u6nSKnH3q2bPUk9Qfs3EmgKVNqbFZVjiNvIqaz07OEFVBLUL217iK2uVSbC4aq+x6sYH
         h0BsJdP9GjRGKxd3T/FklWdF2S455F/HED5+RWnO2AN6mGsC7kbIsKfSQU2+zVsok2rh
         D/AA==
X-Gm-Message-State: AOAM533K7O+jKLq2gMXybU1EXwc9HcsBu7rj60Q5YqO+yr2W1X0uN88I
        vwMZzgNwZHlOMaf4CzRxs5XdRJIsRfaLojDOQw==
X-Google-Smtp-Source: ABdhPJynjoV9VkSkhhIshxUKIFINAPf+sn8pGQ14p/7YjLEdfYWCJUzeZOOgVOwmhgKi8bRkAoffv0ZRs5VUt/0JYg==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a5b:812:: with SMTP id
 x18mr13542220ybp.334.1608397510135; Sat, 19 Dec 2020 09:05:10 -0800 (PST)
Date:   Sat, 19 Dec 2020 17:04:33 +0000
Message-Id: <20201219170433.2418867-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH] mm: mremap - Fix extent calculation
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, minchan@kernel.org, joelaf@google.com,
        lokeshgidra@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux@roeck-us.net,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When `next < old_addr`, `next - old_addr` arithmetic underflows
causing `extent` to be incorrect.

Make `extent` the smaller of `next - old_addr` or `old_end - old_addr`.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 mm/mremap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index c5590afe7165..f554320281cc 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -358,7 +358,9 @@ static unsigned long get_extent(enum pgt_entry entry, unsigned long old_addr,
 
 	next = (old_addr + size) & mask;
 	/* even if next overflowed, extent below will be ok */
-	extent = (next > old_end) ? old_end - old_addr : next - old_addr;
+	extent = next - old_addr;
+	if (extent > old_end - old_addr)
+		extent = old_end - old_addr;
 	next = (new_addr + size) & mask;
 	if (extent > next - new_addr)
 		extent = next - new_addr;
-- 
2.29.2.729.g45daf8777d-goog

