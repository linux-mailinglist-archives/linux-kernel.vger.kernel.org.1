Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660E82CA6E2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391343AbgLAPWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387678AbgLAPWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:22:15 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8DAC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 07:21:29 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id v1so1140011wri.16
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 07:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=gl38stHx97yG3pBLu7/ITLy+50rUPm1B17DaXfHgCU0=;
        b=eghANDW2FL1PybZmM54BmaIrwglStAqovEy8ZjXMwkS9/+RJCaIIMRFF7ih4FiMjHT
         Np1Bq4CB6QThrvsvhKEsUvsGxwUb1M/8e+DFKySVn7JBE2PYdK4NxMg6fx+5PzQmEsgX
         Gb34vhEUMUcEbuthvPXy5S3mylYZj1t/px97yM9ssbw+n5vOPnzx0S4i0K/5AZ2iEW4N
         tEVgn1auaxBXNXdwRdA8+RGRigPR03sM85r3hSYR+izrfCjo++DcHY6puqNmdkHmH6so
         giK4qFka9xCjqX3Fq3cH6dFW8DmrHs7pWo4ACAksvcTDx+w7Z29Ij6hmkorA2fgwuWob
         haHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=gl38stHx97yG3pBLu7/ITLy+50rUPm1B17DaXfHgCU0=;
        b=nhCbNofZ1YmPuRowt06UWvD93PMTVV9hQY0XS4c7irNErbrpOJcxqEXaCMapQ6r15C
         6cjtCgiAJsdEzQjL8kjagE/S69iEdBn2BNJj+zzhkwqYTHUo+xFzeck5FAX6ospMtw4l
         K19pyhrytforgS1TnQftkEVH5fTbL/RFDNExDa6aIXMkpzUZjr11S7tHAW40fM5YdJUE
         LNZpK580BWWr95R09SgBp9Y3CPHqG9Pxrjm4Uwrdupw1IaCxf/pY6TD0kDR5p1fVCaYD
         wGijkPp8XCnD3/tjW+0ZzQOQFG64hiQta7TGk/LP1qkoJOEnAkzUR8rZ3PSStNWTnpLo
         i5+Q==
X-Gm-Message-State: AOAM530bECR3FpvhDq3qSqhPJZN08RSSyUAHmAcg699my/Dmys74T6HK
        ItZblhP6A/VIz8Sa6WJOn/osUaNxyQ==
X-Google-Smtp-Source: ABdhPJxOw+T74UpAJRTmrsR154jupGOFkS71t+dSppD/Nd/XUtyMB07b/gB8m+8YDA8p4WmScMcnQhKvvQ==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a1c:7217:: with SMTP id n23mr3064828wmc.167.1606836087168;
 Tue, 01 Dec 2020 07:21:27 -0800 (PST)
Date:   Tue,  1 Dec 2020 16:20:18 +0100
Message-Id: <20201201152017.3576951-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH] genksyms: Ignore module scoped _Static_assert()
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        masahiroy@kernel.org, ndesaulniers@google.com, joe@perches.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The C11 _Static_assert() keyword may be used at module scope, and we
need to teach genksyms about it to not abort with an error. We currently
have a growing number of static_assert() (but also direct usage of
_Static_assert()) users at module scope:

	git grep -E '^_Static_assert\(|^static_assert\(' | grep -v '^tools' | wc -l
	135

More recently, when enabling CONFIG_MODVERSIONS with CONFIG_KCSAN, we
observe a number of warnings:

	WARNING: modpost: EXPORT symbol "<..all kcsan symbols..>" [vmlinux] [...]

When running a preprocessed source through 'genksyms -w' a number of
syntax errors point at usage of static_assert()s. In the case of
kernel/kcsan/encoding.h, new static_assert()s had been introduced which
used expressions that appear to cause genksyms to not even be able to
recover from the syntax error gracefully (as it appears was the case
previously).

Therefore, make genksyms ignore all _Static_assert() and the contained
expression. With the fix, usage of _Static_assert() no longer cause
"syntax error" all over the kernel, and the above modpost warnings for
KCSAN are gone, too.

Signed-off-by: Marco Elver <elver@google.com>
---
 scripts/genksyms/keywords.c |  3 +++
 scripts/genksyms/lex.l      | 27 ++++++++++++++++++++++++++-
 scripts/genksyms/parse.y    |  7 +++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/scripts/genksyms/keywords.c b/scripts/genksyms/keywords.c
index 057c6cabad1d..b85e0979a00c 100644
--- a/scripts/genksyms/keywords.c
+++ b/scripts/genksyms/keywords.c
@@ -32,6 +32,9 @@ static struct resword {
 	{ "restrict", RESTRICT_KEYW },
 	{ "asm", ASM_KEYW },
 
+	// c11 keywords that can be used at module scope
+	{ "_Static_assert", STATIC_ASSERT_KEYW },
+
 	// attribute commented out in modutils 2.4.2.  People are using 'attribute' as a
 	// field name which breaks the genksyms parser.  It is not a gcc keyword anyway.
 	// KAO. },
diff --git a/scripts/genksyms/lex.l b/scripts/genksyms/lex.l
index e265c5d96861..ae76472efc43 100644
--- a/scripts/genksyms/lex.l
+++ b/scripts/genksyms/lex.l
@@ -118,7 +118,7 @@ yylex(void)
 {
   static enum {
     ST_NOTSTARTED, ST_NORMAL, ST_ATTRIBUTE, ST_ASM, ST_TYPEOF, ST_TYPEOF_1,
-    ST_BRACKET, ST_BRACE, ST_EXPRESSION,
+    ST_BRACKET, ST_BRACE, ST_EXPRESSION, ST_STATIC_ASSERT,
     ST_TABLE_1, ST_TABLE_2, ST_TABLE_3, ST_TABLE_4,
     ST_TABLE_5, ST_TABLE_6
   } lexstate = ST_NOTSTARTED;
@@ -201,6 +201,11 @@ repeat:
 
 		  case EXPORT_SYMBOL_KEYW:
 		      goto fini;
+
+		  case STATIC_ASSERT_KEYW:
+		    lexstate = ST_STATIC_ASSERT;
+		    count = 0;
+		    goto repeat;
 		  }
 	      }
 	    if (!suppress_type_lookup)
@@ -401,6 +406,26 @@ repeat:
 	}
       break;
 
+    case ST_STATIC_ASSERT:
+      APP;
+      switch (token)
+	{
+	case '(':
+	  ++count;
+	  goto repeat;
+	case ')':
+	  if (--count == 0)
+	    {
+	      lexstate = ST_NORMAL;
+	      token = STATIC_ASSERT_PHRASE;
+	      break;
+	    }
+	  goto repeat;
+	default:
+	  goto repeat;
+	}
+      break;
+
     case ST_TABLE_1:
       goto repeat;
 
diff --git a/scripts/genksyms/parse.y b/scripts/genksyms/parse.y
index e22b42245bcc..8e9b5e69e8f0 100644
--- a/scripts/genksyms/parse.y
+++ b/scripts/genksyms/parse.y
@@ -80,6 +80,7 @@ static void record_compound(struct string_list **keyw,
 %token SHORT_KEYW
 %token SIGNED_KEYW
 %token STATIC_KEYW
+%token STATIC_ASSERT_KEYW
 %token STRUCT_KEYW
 %token TYPEDEF_KEYW
 %token UNION_KEYW
@@ -97,6 +98,7 @@ static void record_compound(struct string_list **keyw,
 %token BRACE_PHRASE
 %token BRACKET_PHRASE
 %token EXPRESSION_PHRASE
+%token STATIC_ASSERT_PHRASE
 
 %token CHAR
 %token DOTS
@@ -130,6 +132,7 @@ declaration1:
 	| function_definition
 	| asm_definition
 	| export_definition
+	| static_assert
 	| error ';'				{ $$ = $2; }
 	| error '}'				{ $$ = $2; }
 	;
@@ -493,6 +496,10 @@ export_definition:
 		{ export_symbol((*$3)->string); $$ = $5; }
 	;
 
+/* Ignore any module scoped _Static_assert(...) */
+static_assert:
+	STATIC_ASSERT_PHRASE ';'			{ $$ = $2; }
+	;
 
 %%
 
-- 
2.29.2.454.gaff20da3a2-goog

