Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1202841D7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 22:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgJEU5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 16:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgJEU5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 16:57:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5226DC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 13:57:45 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d81so848046wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 13:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0eiYnVUSZWaB7wjTbIdc+IOLA3BxLnNTNEEMhygD1Ts=;
        b=kQw3aCS/Afak1JMHu44Vl9eOt2UZHhjFsmf0/eoMBBrhfzNwwe4z9cFieF2+muK/Xn
         jW/6fEctYM5tOZ52kdkdFjj6CwFswNljkxUUglGD4d1sxepxX+nXDF7l7hs7gDP8v38J
         eY3DZaVWJDg0toAapAVa9U4P/94e2YaMIz6S6KsSLBl1rY2TZcra1qZl9jQ8zemCpqb2
         RbnB44Mmr76drR+GvahpSGXZzus56PsdwQN+2rT0lE6Leaoe2txdjGk9O9hwF8QHnLUv
         E03HZk/oA9qbcYZMtfiZeSsh1BpgTnesYp6K/MTEIXW7i3G4mYw25B7eABjnfjVqcsWC
         TB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0eiYnVUSZWaB7wjTbIdc+IOLA3BxLnNTNEEMhygD1Ts=;
        b=GZWoyOY4ZGyYari8y5yh829Jkut96hCLTzqYbs5Po+LUofI23ljuQ/AaimaZDD6+39
         Q4QptrvfxED8bK16P9JJoGMdyAtSvZNZ6XjiBgJM4O9YM1nT478VEZjCh8+K+xkakXtW
         cluVbgVk0Uvvt7lea9m6I9kasFaJCwlLuW6kJNICq9ZAueZ5WPBLIlWGag9l5erjxQkU
         UZR8htdXlpozxGHbGN8e6t72n/nU1X/LASyCu0k4NblDuhUhNi4wVwAa+prN7eDKJyXs
         5S+PmbKURchDu4PCziOq52+5rVdjW/pOMll9v0Sl+ZZMzIG0wskyqQomBbgo4YwPAX/z
         btFw==
X-Gm-Message-State: AOAM533THM4TgpDRpRcwX5Pw8/bP8FixOxP3k0eDyMcG5JqL9N/vjBI5
        YEcfNZ9RH6Bv9qdQ2BT56kE=
X-Google-Smtp-Source: ABdhPJyYsi9VQcnonSkp6FT2w5YczNf/fjur2N+ipdQc3Q+Ko2Ny3v6++Z2bPFWyL7yGgMvbwKlu0A==
X-Received: by 2002:a05:600c:4108:: with SMTP id j8mr1235393wmi.116.1601931464022;
        Mon, 05 Oct 2020 13:57:44 -0700 (PDT)
Received: from localhost.localdomain (host-92-5-241-147.as43234.net. [92.5.241.147])
        by smtp.gmail.com with ESMTPSA id c16sm1515319wrx.31.2020.10.05.13.57.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2020 13:57:43 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] kernel/relay.c: drop unneeded initialization
Date:   Mon,  5 Oct 2020 21:57:27 +0100
Message-Id: <20201005205727.1147-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'consumed' is initialized with the consumed count but
immediately after that the consumed count is updated and assigned to
'consumed' again thus overwriting the previous value.
So, drop the unneeded initialization.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---

The resultant binary stayed same after this change. Verified with
md5sum which remained same with and without this change.

$ md5sum kernel/relay.o 
20854215a46e241520576a5d3c523073  kernel/relay.o

 kernel/relay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index fb4e0c530c08..b08d936d5fa7 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -1002,7 +1002,7 @@ static int relay_file_read_avail(struct rchan_buf *buf)
 	size_t subbuf_size = buf->chan->subbuf_size;
 	size_t n_subbufs = buf->chan->n_subbufs;
 	size_t produced = buf->subbufs_produced;
-	size_t consumed = buf->subbufs_consumed;
+	size_t consumed;
 
 	relay_file_read_consume(buf, 0, 0);
 
-- 
2.11.0

