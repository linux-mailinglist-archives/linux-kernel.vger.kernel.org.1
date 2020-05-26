Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481EF1AF636
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 03:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgDSB6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 21:58:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgDSB6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 21:58:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D09621924;
        Sun, 19 Apr 2020 01:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587261488;
        bh=xe0nsEvKHFqa4kQqrM3BFS8ArtxhgoosRSM61VUGdEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0lgNZdFu1X1RULMFIYlK9jV9VzRFZrwHPflfdT1miY4NAFsgEIsqLxS03cOEhJauJ
         xV8UTE8ENCw7v7JIGgH4TriVprcDS6c+48WDexdvrr7sYcbzIYXxp6XTRS9PmepFmP
         e3/1xVg8Jbed+mWzfOS08YwjeDlQ+SX5emn0vh9M=
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, songliubraving@fb.com,
        acme@redhat.com, allison@lohutok.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 08/12] tools/lib/lockdep: Hook up vsprintf, find_bit, hweight libraries
Date:   Sat, 18 Apr 2020 21:57:50 -0400
Message-Id: <20200419015754.24456-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419015754.24456-1-sashal@kernel.org>
References: <20200419015754.24456-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They already exist in tools/lib/, and are now required by liblockdep, so
just add them to the build manifest.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/lockdep/Build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/lockdep/Build b/tools/lib/lockdep/Build
index 219a9e2d9e0ba..1e7c25690b8ea 100644
--- a/tools/lib/lockdep/Build
+++ b/tools/lib/lockdep/Build
@@ -1 +1 @@
-liblockdep-y += common.o lockdep.o preload.o rbtree.o ../../lib/bitmap.o
+liblockdep-y += common.o lockdep.o preload.o rbtree.o ../../lib/bitmap.o ../../lib/vsprintf.o ../../lib/find_bit.o ../../lib/hweight.o
-- 
2.20.1

