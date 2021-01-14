Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52242F6B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbhANTmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:42:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43970 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726198AbhANTmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:42:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610653234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UQfXCHh4i4SXIEZjgVa0H71mp1wdk2045lCYD+UgrNk=;
        b=D7wmSy+5RbxIJl7E9XSAianPmTsLgMHekExmpJQLCaNgJk7/QN76/+1S4+zgyNHkppY0T0
        f2GIpOU9drAw0WIx2NxkEDPXD/oIGfhmzSravxqWQ/hRGPkTw+xJ4tdYAvSj2viAiPuooW
        H9pfR0fnATTfctpDJWyyjxT7VYlFYYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-jgI2Nlx8NV6D1s5T8o8JAg-1; Thu, 14 Jan 2021 14:40:30 -0500
X-MC-Unique: jgI2Nlx8NV6D1s5T8o8JAg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2848800050;
        Thu, 14 Jan 2021 19:40:28 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8835A1001E73;
        Thu, 14 Jan 2021 19:40:24 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 02/21] objtool: Fix error handling for STD/CLD warnings
Date:   Thu, 14 Jan 2021 13:39:58 -0600
Message-Id: <90a81eb41741429562d2fdd5bf1e23c416b1fc6a.1610652862.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1610652862.git.jpoimboe@redhat.com>
References: <cover.1610652862.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually return an error (and display a backtrace, if requested) for
directional bit warnings.

Fixes: 2f0f9e9ad7b3 ("objtool: Add Direction Flag validation")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ed26c22c8244..93c3937d1d6a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2592,15 +2592,19 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 
 		case INSN_STD:
-			if (state.df)
+			if (state.df) {
 				WARN_FUNC("recursive STD", sec, insn->offset);
+				return 1;
+			}
 
 			state.df = true;
 			break;
 
 		case INSN_CLD:
-			if (!state.df && func)
+			if (!state.df && func) {
 				WARN_FUNC("redundant CLD", sec, insn->offset);
+				return 1;
+			}
 
 			state.df = false;
 			break;
-- 
2.29.2

