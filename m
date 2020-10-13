Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E4E28CDEC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgJMMPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbgJMMO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:14:56 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11A8122260;
        Tue, 13 Oct 2020 12:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602591295;
        bh=lZ0DMSd0gNqY4mdYZgTISK0mJnAdK/yJ7//Q3B7wU7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uZV8W6GPmaRQLLN/4V4tHsFQMPQojrAeXz0MzmyBMVGROitkMwF4st480wlL6iFdu
         xkEHaEn46wR5NM4E7WvkgtxHOxFCu/J5cLXttt8w3haDPaBiWZHVy+hdONFSVQDziw
         4fJ4wefZpOLYwTLOCx84dwQbTUscbV2E2FCwaduw=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSJCf-006CoQ-3u; Tue, 13 Oct 2020 14:14:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/24] seqlock: fix two kernel-doc warnings
Date:   Tue, 13 Oct 2020 14:14:43 +0200
Message-Id: <a59144cdaadf7fdf1fe5d55d0e1575abbf1c0cb3.1602590106.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602590106.git.mchehab+huawei@kernel.org>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, seqloc.h produces two kernel-doc warnings:

	./include/linux/seqlock.h:181: error: Cannot parse typedef!
	WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno ./include/linux/seqlock.h' failed with return code 1

Those are due to two things:

1. the kernel-doc markup syntax doesn't recognize "typedef"
   expression at the markup. Both functions and typedefs
   use the same notation:

	/**
	 * foo - some bar description
	 */
  or
	/**
	 * foo() - some bar description
	 */

2. kernel-doc markups require a function or typedef prototype,
   in order to get the type of each argument. This is also
   common for other code documentation markkup languages, like
   doxygen.

On other words, a valid notation for describing those macros
would be:

	 /**
	  * seqcount_LOCKNAME_t() - sequence counter with LOCKNAME associated
	  * @seqcount:  The real sequence counter
	  * @lock:      Pointer to the associated lock
	  *
	  * <some description>
	  */
	#if 0 /* kernel-doc needs a function or typedef prototype */
	void seqcount_LOCKNAME_t(seqcount_##lockname##_t *seqcount, locktype *lock) {}
	#endif

Alternatively, the description of those arguments should be added
as a DOC: block.

Yet, from changeset a28e884b966e ("seqlock: Fix multiple kernel-doc warnings"),
it sounds that, on this file, it is preferred to just convert the
kernel-doc markups into simple comments.

Fixes: a8772dccb2ec ("seqlock: Fold seqcount_LOCKNAME_t definition")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
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
-- 
2.26.2

