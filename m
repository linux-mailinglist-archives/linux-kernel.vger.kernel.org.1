Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCB229820D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 15:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416576AbgJYOZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 10:25:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34638 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416477AbgJYOZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 10:25:42 -0400
Date:   Sun, 25 Oct 2020 14:25:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603635941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BNakxmUGe+TYDOFRTCAWwHt7WAczZvtIVJLM7+rIxjM=;
        b=kO4qU5pmeX6+Q9V2SvVBo6qJEAMGcRU/eER5w6Uz/QADToRpcb5x1wJo6QqzR6gC6gzIUa
        Y1b7T4G0lMm10T7f9B3X9C7Gz1hqHSSqr+WbijBV2fnJCQgtuAB1hiS8aS1P8v4PDNu8YK
        kCDZn7voKwbzyFIxOf7AhkZ9tmcf15CXSDxz6dIbLYD1NPAviqcW9usSncGlJUqJGAE2ge
        i0k+vCqpq6zVqCgTu565gL0JCFq6rF+G4fnCxgpJ7YxKNAg0+PbDBOYuWovokD9O1KIHds
        8u9R0OwzTp2kx/4xiZ+7woWa6lJ2e36Wc5e6p48+Piy0wxwacCKskh0K8qO+YQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603635941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BNakxmUGe+TYDOFRTCAWwHt7WAczZvtIVJLM7+rIxjM=;
        b=Frg0mkHDMf89sFVMpVxN4UCwSWq82e72uMV8K9igD4HUa3voD8y6JuQTeC9QaxfLmJLRv8
        N/+xDoQHXNu3e5Aw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/urgent for 5.10-rc1
Message-ID: <160363590465.1234.11586095980767794789.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-10-25

up to:  ed3e453798d4: locking/seqlocks: Fix kernel-doc warnings

Just a trivial fix for kernel-doc warnings.

Thanks,

	tglx

------------------>
Mauro Carvalho Chehab (1):
      locking/seqlocks: Fix kernel-doc warnings


 include/linux/seqlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index ac5b07f558b0..cbfc78b92b65 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -154,7 +154,7 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
 #define __SEQ_LOCK(expr)
 #endif
 
-/**
+/*
  * typedef seqcount_LOCKNAME_t - sequence counter with LOCKNAME associated
  * @seqcount:	The real sequence counter
  * @lock:	Pointer to the associated lock

