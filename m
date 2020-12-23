Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855332E183E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 06:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgLWFHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 00:07:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37404 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725923AbgLWFHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 00:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608699934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UpdFfa5ubXWs5+ZAsqLa1UlbVD0Yd2WcynxMVwNQ5W8=;
        b=COyiVQDaoN5uOcjuYY+UNI8qAQPvbXpaRiD65R1excrHbF0Pl/Xg+NsA12H+Q+/nJklaad
        vOxACSYhyvDAzQc3Dmy7JajusD1A2QEk+fnax+uYPHWWrrHE76xozM0OYlR7Ju+31G2xJP
        75r1Z9x8UdYepRIIV3x904OzwULObE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-2aaTyyqaMQqykASEZCryfQ-1; Wed, 23 Dec 2020 00:05:32 -0500
X-MC-Unique: 2aaTyyqaMQqykASEZCryfQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CFA5800D55;
        Wed, 23 Dec 2020 05:05:31 +0000 (UTC)
Received: from treble.redhat.com (ovpn-117-91.rdu2.redhat.com [10.10.117.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1168310013C1;
        Wed, 23 Dec 2020 05:05:30 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] mm/uaccess: Use 'unsigned long' to placate UBSAN warnings, again
Date:   Tue, 22 Dec 2020 23:04:54 -0600
Message-Id: <590998aa9cc50f431343f76cae72b2abf8ac1fdd.1608699683.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 7 has a known bug where UBSAN ignores '-fwrapv' and generates false
signed-overflow-UB warnings.  The type mismatch between 'i' and
'nr_segs' in copy_compat_iovec_from_user() is causing such a warning,
which also happens to violate uaccess rules:

  lib/iov_iter.o: warning: objtool: iovec_from_user()+0x22d: call to __ubsan_handle_add_overflow() with UACCESS enabled

Fix it by making the variable types match.

This is similar to a previous commit:

  29da93fea3ea ("mm/uaccess: Use 'unsigned long' to placate UBSAN warnings on older GCC versions")

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 lib/iov_iter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 1635111c5bd2..2e6a42f5d1df 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1656,7 +1656,8 @@ static int copy_compat_iovec_from_user(struct iovec *iov,
 {
 	const struct compat_iovec __user *uiov =
 		(const struct compat_iovec __user *)uvec;
-	int ret = -EFAULT, i;
+	int ret = -EFAULT;
+	unsigned long i;
 
 	if (!user_access_begin(uvec, nr_segs * sizeof(*uvec)))
 		return -EFAULT;
-- 
2.29.2

