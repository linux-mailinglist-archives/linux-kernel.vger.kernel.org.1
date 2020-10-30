Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB1329FDC3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 07:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgJ3GRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 02:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgJ3GRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 02:17:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E91C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 23:17:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q8so5245352ybk.18
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 23:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=YO54Tn56HJNBVhbrimlUnxLhvXTbKZkDHGpoiKtBB8k=;
        b=MnLy5KfWi58tKQmOi2bgN2hpIYNcmF6fRMhxl/0fIFvHOAZM/y613TiU51QwVPcGvl
         GHPUCVFq9YqY5jdTE5zLuUhcNY9hTZ5bi8gIx63LDC6PIGPoaCiYjET2qE+Rhn+xCXaj
         u4UIeb79ld6YqpGT6RCBpY3/A2PRZ9694fSgcGaB0Evz/xICV/r10IR5yLBK+I5MAMfD
         dIbaj4jKQioH0kK9g88DONPnN1yk3pRnbZtWt43prTokvwuv3UGjFJU9OW/lim1PO/5/
         6PIoSVjKrVybXSu5BiO4w9kRbP4rTy/T1n61BJgMx6gZ0O6bsFFB4RPhoqip2whwkWmR
         77yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=YO54Tn56HJNBVhbrimlUnxLhvXTbKZkDHGpoiKtBB8k=;
        b=oRUYNxmJBYDz3b4f58/mXC4y7QrgqeLhhwdRn4grYgiwMxV0bj9afBZIq33ALHQSV4
         ZyxDU8O81G/BX5GU/p9V7rnDDT4CFEe2wmYKf9y43wWYg/KHtV4pLzPEyIly6stiGIaN
         mEtS9eLrk88YObCCpU4iU6j0lzuSHq2DH3Pdxf0jHXIuSf98/cWaCtTNeK9IsRV8xZ2a
         F7CQ9oybwUm3NyOPxuFkkjypgGz64vm7XSJIEtuS+1IOzPdxY4DNbgu1a4vDPiYkYHTi
         z5VVF0C6G/AdwoXZfyoEL77pb8DRJSswaCKHEt6AT8Wkcj9RiYb6s6l/GAQ4pp89s4k9
         IxnQ==
X-Gm-Message-State: AOAM530Y3NwlfzgveIuCsvfedGiQ12bJ55gSiHzvtsNcb0TGCmZnbOOk
        l7JfYMeiXRdNp72kH1sgDF37jfptW9NJTw==
X-Google-Smtp-Source: ABdhPJz4h/cncIdfXNYFCHiItiL5FrOJHZuYoxPSW9rrDLIqk7gZlypHCWiSfBSDItF67J+L/vzk/4+1oryyvQ==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a25:b53:: with SMTP id
 80mr1548340ybl.45.1604038635364; Thu, 29 Oct 2020 23:17:15 -0700 (PDT)
Date:   Thu, 29 Oct 2020 23:16:55 -0700
Message-Id: <20201030061655.162839-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH] kunit: tool: fix --raw_output to actually show output
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently --raw_output means nothing gets shown.
Why?
Because `raw_output()` has a `yield` and therefore is a generator, which
means it only executes when you ask it for a value.

Given no one actually is using it as a generator (checked via the added
type annotation), drop the yield so we actually print the output.

Also strip off the trailing \n (and any other whitespace) to avoid
  [<601d6d3a>] ? printk+0x0/0x9b

  [<601e5058>] ? kernel_init+0x23/0x14b

  [<600170d2>] ? new_thread_handler+0x82/0xc0
making the output unreadable.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_parser.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 8019e3dd4c32..c44bb7c27ce6 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -63,10 +63,9 @@ def isolate_kunit_output(kernel_output):
 		elif started:
 			yield line[prefix_len:] if prefix_len > 0 else line
 
-def raw_output(kernel_output):
+def raw_output(kernel_output) -> None:
 	for line in kernel_output:
-		print(line)
-		yield line
+		print(line.rstrip())
 
 DIVIDER = '=' * 60
 

base-commit: 07e0887302450a62f51dba72df6afb5fabb23d1c
-- 
2.29.1.341.ge80a0c044ae-goog

