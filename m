Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A7F2020AE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 05:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbgFTDcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 23:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733053AbgFTDbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 23:31:12 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315D5C061A86
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 20:30:28 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e18so5396771pgn.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 20:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dfh/vw+ddjlYh9CDRFRkQhWgDe6VpIaXph6iMJk9GA8=;
        b=MihGMYKdZDiLuZtFYTQG9hHMsTVzmuQ3DJp1RxmrKSOaCHLlYqx3RB7EzdxAAEd4dy
         xUDLp5ekbRUHQEBzv61Wp4NXwSE99zyWUIbQoIUuKzEORyW2v8VjeUMh5o4KgUgFAoK+
         QK/RDmLsOZKbaJ59vz56xsAOtVZ6x+uY8ER9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dfh/vw+ddjlYh9CDRFRkQhWgDe6VpIaXph6iMJk9GA8=;
        b=Dg+h8CPza9+F2yW9xHyW1DyFPA5lVhnhoRFskJqfTCPys7z2iU8DnUr7hzZbtV2+jT
         oAkMcydr/Nzjsi8zehqAKU56/buzdqyqS7a3oadW3N1XV4jiBmTt3mwg8sRv1EFU8Hk3
         6wUkq1Eze7wEPioVw1VmZMZgZ8ZrRmFfS2YNDkqc8L2/aCrNghK1JPZLkAw9jJopVkXQ
         4PPaJEhxSkCz/pF36OXalPdyNXk1/yfwhvIeYrw11ZZQZdhJ/2hjZfmuwlx1fDXpfzsV
         CHOxu7Pc5deubw4l6JMUt8lxAEjJ5D+sFCfhBBJqHkACacQZQGqb8bM+v8OhjmO+5TDj
         ap7g==
X-Gm-Message-State: AOAM531OBAYA2nOZMFAQInkszkoc1p+7mGIG6y7ZFk15Wfp9CqR11tDX
        PApEKlHz5do1KGnsWxw8P4P93Q==
X-Google-Smtp-Source: ABdhPJx0aCYAbShJE+YVxO7qvT0bOjdhl9ynwJyizMCTWOBsedHyy3Q5JrRb42SiCaY2nko2swgfTw==
X-Received: by 2002:aa7:9569:: with SMTP id x9mr10876864pfq.308.1592623827680;
        Fri, 19 Jun 2020 20:30:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i63sm6601330pje.34.2020.06.19.20.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 20:30:26 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, x86@kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH v2 14/16] checkpatch: Remove awareness of uninitialized_var() macro
Date:   Fri, 19 Jun 2020 20:30:04 -0700
Message-Id: <20200620033007.1444705-14-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200620033007.1444705-1-keescook@chromium.org>
References: <20200620033007.1444705-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using uninitialized_var() is dangerous as it papers over real bugs[1]
(or can in the future), and suppresses unrelated compiler warnings
(e.g. "unused variable"). If the compiler thinks it is uninitialized,
either simply initialize the variable or make compiler changes.

In preparation for removing[2] the[3] macro[4], partially revert
commit 16b7f3c89907 ("checkpatch: avoid warning about uninitialized_var()")
and remove all remaining mentions of uninitialized_var().

[1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
[2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
[4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/checkpatch.pl | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4c820607540b..60b737e222fe 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -840,7 +840,6 @@ our $FuncArg = qr{$Typecast{0,1}($LvalOrFunc|$Constant|$String)};
 our $declaration_macros = qr{(?x:
 	(?:$Storage\s+)?(?:[A-Z_][A-Z0-9]*_){0,2}(?:DEFINE|DECLARE)(?:_[A-Z0-9]+){1,6}\s*\(|
 	(?:$Storage\s+)?[HLP]?LIST_HEAD\s*\(|
-	(?:$Storage\s+)?${Type}\s+uninitialized_var\s*\(|
 	(?:SKCIPHER_REQUEST|SHASH_DESC|AHASH_REQUEST)_ON_STACK\s*\(
 )};
 
@@ -6330,8 +6329,7 @@ sub process {
 			if (defined $cond) {
 				substr($s, 0, length($cond), '');
 			}
-			if ($s =~ /^\s*;/ &&
-			    $function_name ne 'uninitialized_var')
+			if ($s =~ /^\s*;/)
 			{
 				WARN("AVOID_EXTERNS",
 				     "externs should be avoided in .c files\n" .  $herecurr);
@@ -6350,17 +6348,13 @@ sub process {
 		}
 
 # check for function declarations that have arguments without identifier names
-# while avoiding uninitialized_var(x)
 		if (defined $stat &&
-		    $stat =~ /^.\s*(?:extern\s+)?$Type\s*(?:($Ident)|\(\s*\*\s*$Ident\s*\))\s*\(\s*([^{]+)\s*\)\s*;/s &&
-		    (!defined($1) ||
-		     (defined($1) && $1 ne "uninitialized_var")) &&
-		     $2 ne "void") {
-			my $args = trim($2);
+		    $stat =~ /^.\s*(?:extern\s+)?$Type\s*(?:$Ident|\(\s*\*\s*$Ident\s*\))\s*\(\s*([^{]+)\s*\)\s*;/s &&
+		    $1 ne "void") {
+			my $args = trim($1);
 			while ($args =~ m/\s*($Type\s*(?:$Ident|\(\s*\*\s*$Ident?\s*\)\s*$balanced_parens)?)/g) {
 				my $arg = trim($1);
-				if ($arg =~ /^$Type$/ &&
-					$arg !~ /enum\s+$Ident$/) {
+				if ($arg =~ /^$Type$/ && $arg !~ /enum\s+$Ident$/) {
 					WARN("FUNCTION_ARGUMENTS",
 					     "function definition argument '$arg' should also have an identifier name\n" . $herecurr);
 				}
-- 
2.25.1

