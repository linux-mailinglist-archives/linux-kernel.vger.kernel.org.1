Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F4227338C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 22:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgIUUTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 16:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgIUUTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 16:19:46 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54809C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 13:19:46 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4BwG4v6Fc6zQkmC;
        Mon, 21 Sep 2020 22:19:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id 8-0nJxhkurv1; Mon, 21 Sep 2020 22:19:40 +0200 (CEST)
From:   Hagen Paul Pfeifer <hagen@jauu.net>
To:     linux-kernel@vger.kernel.org
Cc:     Hagen Paul Pfeifer <hagen@jauu.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/2] perf script: add min, max to futex-contention
Date:   Mon, 21 Sep 2020 22:19:28 +0200
Message-Id: <20200921201928.799498-2-hagen@jauu.net>
In-Reply-To: <20200921201928.799498-1-hagen@jauu.net>
References: <20200921201928.799498-1-hagen@jauu.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -2.65 / 15.00 / 15.00
X-Rspamd-Queue-Id: 0804F1704
X-Rspamd-UID: 230c58
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Average is quite informative, but the outliners - especially max - are
also of interest.

Before:

mutex-locker[793299] lock 5637ec61e080 contended 3400 times, 446 avg ns
mutex-locker[793301] lock 5637ec61e080 contended 3563 times, 385 avg ns
mutex-locker[793300] lock 5637ec61e080 contended 3110 times, 1855 avg ns

After:

mutex-locker[795251] lock 55b14e6dd080 contended 3853 times, 1279 avg ns [max: 12270 us, min 340 us]
mutex-locker[795253] lock 55b14e6dd080 contended 2911 times, 518 avg ns [max: 51660261 us, min 347 us]
mutex-locker[795252] lock 55b14e6dd080 contended 3843 times, 385 avg ns [max: 24323998 us, min 338 us]

Signed-off-by: Hagen Paul Pfeifer <hagen@jauu.net>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/futex-contention.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/scripts/python/futex-contention.py b/tools/perf/scripts/python/futex-contention.py
index c440f02627dd..e8a02aecabd9 100644
--- a/tools/perf/scripts/python/futex-contention.py
+++ b/tools/perf/scripts/python/futex-contention.py
@@ -53,5 +53,5 @@ def trace_begin():
 def trace_end():
     for (tid, lock) in lock_waits:
         min, max, avg, count = lock_waits[tid, lock]
-        print("%s[%d] lock %x contended %d times, %d avg ns" %
-              (process_names[tid], tid, lock, count, avg))
+        print("%s[%d] lock %x contended %d times, %d avg ns [max: %d us, min %d us]" %
+              (process_names[tid], tid, lock, count, avg, max, min))
-- 
2.28.0

