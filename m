Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952852FF756
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbhAUVdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:33:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45526 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726563AbhAUVbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611264594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A3tZhw5lFO9vqK5NVdOq0e0gwHHYr93gbViyAOdUZh8=;
        b=ZO4htwAMjpWd1waylpJHmxc8aZ9MBJ9yMMTsxwinKqKnYwnvwEmIrjwT5ZEzZpJkdFqHId
        BeOtkhhficWljqEA3fdmBSWw2D1Yh3BnzjUqUr5S5i+oN7PywTSaefF6uxLGtnvMJe/fPE
        eG8EO2FkyTKX7W4JauX/nJ2OJvhuoog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-nnvBoIYePH23VFajn1q8dw-1; Thu, 21 Jan 2021 16:29:50 -0500
X-MC-Unique: nnvBoIYePH23VFajn1q8dw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4959802B40;
        Thu, 21 Jan 2021 21:29:48 +0000 (UTC)
Received: from treble.redhat.com (ovpn-116-102.rdu2.redhat.com [10.10.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB8433AE1;
        Thu, 21 Jan 2021 21:29:46 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 03/20] objtool: Fix ".cold" section suffix check for newer versions of GCC
Date:   Thu, 21 Jan 2021 15:29:19 -0600
Message-Id: <ca0b5a57f08a2fbb48538dd915cc253b5edabb40.1611263461.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1611263461.git.jpoimboe@redhat.com>
References: <cover.1611263461.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With my version of GCC 9.3.1 the ".cold" subfunctions no longer have a
numbered suffix, so the trailing period is no longer there.

Presumably this doesn't yet trigger a user-visible bug since most of the
subfunction detection logic is duplicated.   I only found it when
testing vmlinux.o validation.

Fixes: 54262aa28301 ("objtool: Fix sibling call detection")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 081572170f6b..c964cd56b557 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -846,8 +846,8 @@ static int add_jump_destinations(struct objtool_file *file)
 			 * case where the parent function's only reference to a
 			 * subfunction is through a jump table.
 			 */
-			if (!strstr(insn->func->name, ".cold.") &&
-			    strstr(insn->jump_dest->func->name, ".cold.")) {
+			if (!strstr(insn->func->name, ".cold") &&
+			    strstr(insn->jump_dest->func->name, ".cold")) {
 				insn->func->cfunc = insn->jump_dest->func;
 				insn->jump_dest->func->pfunc = insn->func;
 
-- 
2.29.2

