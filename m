Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30A02FF789
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbhAUVqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:46:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21402 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727150AbhAUVbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:31:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611264612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=frcc2xgX24Go8tsf7u9fFO21jkTHhq9MVktThtUSJFk=;
        b=O2g1nCgKgBf0YQ98yxl3yP24a6ILKxdSZ8+/G/6qM/opDSSmQJL3dQ89bO1yPX26WMBK9d
        J1OkWXEcyEU6aH1BrJeGiiepiFRbcUxKDC/uhylE79f974oQYGu0VBj2T2sbDENcs866Im
        ASA7pYUuOV+5OkOS0RJlLT6Yn1JTcRo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-WlZGomJ-Mwi_hXkLq1DqPg-1; Thu, 21 Jan 2021 16:30:09 -0500
X-MC-Unique: WlZGomJ-Mwi_hXkLq1DqPg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31BCA1842140;
        Thu, 21 Jan 2021 21:30:08 +0000 (UTC)
Received: from treble.redhat.com (ovpn-116-102.rdu2.redhat.com [10.10.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C25D19C59;
        Thu, 21 Jan 2021 21:30:05 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 09/20] objtool: Add xen_start_kernel() to noreturn list
Date:   Thu, 21 Jan 2021 15:29:25 -0600
Message-Id: <930deafa89256c60b180442df59a1bbae48f30ab.1611263462.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1611263461.git.jpoimboe@redhat.com>
References: <cover.1611263461.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
index f88f20327bf2..5f056ddab4fa 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -160,6 +160,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"machine_real_restart",
 		"rewind_stack_do_exit",
 		"kunit_try_catch_throw",
+		"xen_start_kernel",
 	};
 
 	if (!func)
-- 
2.29.2

