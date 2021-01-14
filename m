Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9CB2F6E85
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 23:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbhANWri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 17:47:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53265 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730719AbhANWrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 17:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610664371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SG7+b/qMDi7iBZy0j7zTI9l6RiTTvs0NJW8DoHGJuaw=;
        b=Fs4fSsuuAeReG1XKtmQL8G2VUOKg9BLFDz0mWb929DIJpCya5M1s9l+HAvJxPx5afcAdGA
        VO0DdnlpxcW1r61gVnFRRlE3nTULDuq/J8i0mgi8Eq5TJxbSwzGBrsnTinCr8PuQR98u9p
        s9hBvhr/StAD30jJskM3qeCJxsvwTUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-sGnqntQgPNCrdD-14yIHDw-1; Thu, 14 Jan 2021 17:46:07 -0500
X-MC-Unique: sGnqntQgPNCrdD-14yIHDw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C0F4107ACF7;
        Thu, 14 Jan 2021 22:46:06 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 982955F9C2;
        Thu, 14 Jan 2021 22:45:58 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, Borislav Petkov <bp@suse.de>,
        Julien Thierry <jthierry@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] objtool: Don't fail the kernel build on fatal errors
Date:   Thu, 14 Jan 2021 16:45:21 -0600
Message-Id: <9ec7a9531e99f461e02adc18a4124c921c0ab777.1610664286.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is basically a revert of commit 644592d32837 ("objtool: Fail the
kernel build on fatal errors").

That change turned out to be more trouble than it's worth.  Failing the
build is an extreme measure which sometimes gets too much attention and
blocks CI build testing.

These fatal-type warnings aren't yet as rare as we'd hope, due to the
ever-increasing matrix of supported toolchains/plugins and their
fast-changing nature as of late.

Also, there are more people (and bots) looking for objtool warnings than
ever before, so such warnings not likely to be ignored for long.

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5f8d3eed78a1..4bd30315eb62 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2928,14 +2928,10 @@ int check(struct objtool_file *file)
 	warnings += ret;
 
 out:
-	if (ret < 0) {
-		/*
-		 *  Fatal error.  The binary is corrupt or otherwise broken in
-		 *  some way, or objtool itself is broken.  Fail the kernel
-		 *  build.
-		 */
-		return ret;
-	}
-
+	/*
+	 *  For now, don't fail the kernel build on fatal warnings.  These
+	 *  errors are still fairly common due to the growing matrix of
+	 *  supported toolchains and their recent pace of change.
+	 */
 	return 0;
 }
-- 
2.29.2

