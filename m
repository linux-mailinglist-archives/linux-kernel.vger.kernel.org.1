Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143352F6B63
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbhANTmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:42:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41026 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730092AbhANTml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:42:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610653275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7v+AgLok7W1rAPFBh37lkGQemrjFQX7RYhoYeASbhJY=;
        b=Hi2k1eO8y2O/RW819Jkh1diNinQkTRW6CjiZJ4LExfh1vERGzBg/zZbtPklDmG76O4BbC8
        bdUg2ax9oJpzYHAsEMQs+0W8vVbUtq9VZPFD+BFJAtNbOxyu9OdLbOApjzUuL5UP74KNB7
        YgKsqa9i8BGxwmuQWmHZySjLHoFzwyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-S3QL8Gg9P8O7BckfOg4e5A-1; Thu, 14 Jan 2021 14:41:12 -0500
X-MC-Unique: S3QL8Gg9P8O7BckfOg4e5A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72A8A190B2A2;
        Thu, 14 Jan 2021 19:41:10 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23F5B10023B3;
        Thu, 14 Jan 2021 19:41:06 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 10/21] objtool: Add xen_start_kernel() to noreturn list
Date:   Thu, 14 Jan 2021 13:40:06 -0600
Message-Id: <a2df2ed5b5ea0116f4d9ec33f7d74d221a288543.1610652862.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1610652862.git.jpoimboe@redhat.com>
References: <cover.1610652862.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xen_start_kernel() doesn't return.  Annotate it as such so objtool can
follow the code flow.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6636f4fd694a..a430eaacd7aa 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -161,6 +161,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"machine_real_restart",
 		"rewind_stack_do_exit",
 		"kunit_try_catch_throw",
+		"xen_start_kernel",
 	};
 
 	if (!func)
-- 
2.29.2

