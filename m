Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20331ECDA7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 12:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgFCKfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 06:35:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:38086 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgFCKfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 06:35:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DC09CAC40;
        Wed,  3 Jun 2020 10:35:20 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        Nikolay Borisov <nborisov@suse.com>
Subject: [RESEND PATCH] bloat-o-meter: Support comparing library archives
Date:   Wed,  3 Jun 2020 13:35:13 +0300
Message-Id: <20200603103513.3712-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Library archives (.a) usually contain multiple object files so their
output of nm --size-sort contains lines like:

<ommitted for brevity>
00000000000003a8 t run_test

extent-map-tests.o:
<ommitted for brevity>

bloat-o-meter currently doesn't handle them which results in errors
when calling .split() on them. Fix this by simply ignoring them. This
enables diffing subsystems which generate built-in.a files.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

Resending and CCing Andrew this time.

 scripts/bloat-o-meter | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/bloat-o-meter b/scripts/bloat-o-meter
index 8c965f6a9881..d7ca46c612b3 100755
--- a/scripts/bloat-o-meter
+++ b/scripts/bloat-o-meter
@@ -26,6 +26,8 @@ re_NUMBER = re.compile(r'\.[0-9]+')
     sym = {}
     with os.popen("nm --size-sort " + file) as f:
         for line in f:
+            if line.startswith("\n") or ":" in line:
+                continue
             size, type, name = line.split()
             if type in format:
                 # strip generated symbols
--
2.17.1

