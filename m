Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4EC1AF637
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 03:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgDSB6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 21:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbgDSB6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 21:58:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FEB7221F4;
        Sun, 19 Apr 2020 01:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587261489;
        bh=jKP7uD9q3zWYsTKN99FjfTgw+Et5XfVoMV5WtjjFR04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=otgADSGhhNLMIcu9cPdiJRTJBnm/YwEWq6DvuEIUonTNPGfD3lyW/ZbSzKoQ3cBbZ
         VTa57OocvDkqtKfBBO92t0sdRUB4swriNCSx2dDotXpkbKNkvvLu7uNTeP/qeKeRlB
         4LFi0eTuUPZqKwpzPaOG8W7yQz9kripUshJHFXvo=
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, songliubraving@fb.com,
        acme@redhat.com, allison@lohutok.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 09/12] tools/lib/lockdep: Enable building with CONFIG_TRACE_IRQFLAGS
Date:   Sat, 18 Apr 2020 21:57:51 -0400
Message-Id: <20200419015754.24456-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419015754.24456-1-sashal@kernel.org>
References: <20200419015754.24456-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At this point it's always enabled with CONFIG_PROVE_LOCKING, so it's
easier to enable it in liblockdep as well rather than try and fix up the
lockdep code.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/lockdep/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/lockdep/Makefile b/tools/lib/lockdep/Makefile
index 9dafb8cb752fe..efb6b7980a009 100644
--- a/tools/lib/lockdep/Makefile
+++ b/tools/lib/lockdep/Makefile
@@ -78,7 +78,7 @@ export Q VERBOSE
 INCLUDES = -I. -I./uinclude -I./include -I../../include $(CONFIG_INCLUDES)
 
 # Set compile option CFLAGS if not set elsewhere
-CFLAGS ?= -g -DCONFIG_LOCKDEP -DCONFIG_STACKTRACE -DCONFIG_PROVE_LOCKING -DBITS_PER_LONG=__WORDSIZE -DLIBLOCKDEP_VERSION='"$(LIBLOCKDEP_VERSION)"' -rdynamic -O0 -g
+CFLAGS ?= -g -DCONFIG_LOCKDEP -DCONFIG_STACKTRACE -DCONFIG_PROVE_LOCKING -DCONFIG_TRACE_IRQFLAGS -DBITS_PER_LONG=__WORDSIZE -DLIBLOCKDEP_VERSION='"$(LIBLOCKDEP_VERSION)"' -rdynamic -O0 -g
 CFLAGS += -fPIC
 CFLAGS += -Wall
 
-- 
2.20.1

