Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2389F3017F8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 20:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbhAWTGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 14:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbhAWTGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 14:06:41 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECA7C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 11:06:01 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id g15so6145150pgu.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 11:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mzZg7viznpPW9SNKKzGUUY3fkPMxKyXqQG2BhjhBWW4=;
        b=K6fh6gdLRuB22vj3PYFX/FhCAWroNIJs2DV7WgnNY52nneKQf3SSssNRfNWTkgAeBh
         fDY1iPfJOg6ITqLcTeXqgjl3B5B6RORl4rZfFA21sBm0llst6mrjbqkKnL9NUMMy8/ee
         etrynJ6ieCdaO52TgHO1OnkimMAJ6NZWDqV/HUxp1tqWFdQ0P7jpJ0cEDaMiFLu58NEi
         PsXarqKn+KwqrN7ary1sf8XlfuxeeSfFMyJK1cEC8dIqeFinkUeksHmpZa2edZ4uTAsF
         SxgDKr524wrw6KA93L8G3RFXjJ2zFg9/COAA7cPB5qoumB5gP2JA/zGmKuhLiasVhrUl
         fGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mzZg7viznpPW9SNKKzGUUY3fkPMxKyXqQG2BhjhBWW4=;
        b=bY9pxUQ0gSrhAWhAR6Sl+6Sfu1YHXB9PFfLjCBYiayikSYIIGU2Y1/VlggGQEGVssT
         i9BMhz/wrhTZ4PMh8CphIZgSaOmfZCn6LQPPMry04WedPJDQUaVJbm5dEVQxDw84dh79
         a0I1iAqNAnwaODDv0LxbjnXJzJFnJVH8QykaZqOhADIZ5Iyzn5tyyyxoDOite1bSyo+O
         1udkEL6HdR7itLUr1eJb5XP/34LHTOnEBCPYANvgTmpcSyyprCRDN3uQFfz+IqHP8Efy
         x1nLHZfHtyStui68xfxNLWK5+AA1nDlADQgC9B0CWPyh/41KJgxQ5ehn0mLu0D+9U3Xn
         BJfw==
X-Gm-Message-State: AOAM531ox6Oc0+hExCj+0//5N11Gm3fDMEPKrkbGoo1j0VfCqtwBNP2/
        b1mz3ZwsHmVjyDPkjOT6wNU=
X-Google-Smtp-Source: ABdhPJz7C1AJJPuFSxibuxFN3GfHArq09cTmE6ZISuKx25crKnNZ14ljLvQW30Dgl7HeAKeWPXlfSQ==
X-Received: by 2002:a63:2009:: with SMTP id g9mr1055989pgg.219.1611428761067;
        Sat, 23 Jan 2021 11:06:01 -0800 (PST)
Received: from localhost.localdomain ([2405:201:600d:a089:8c2b:8940:3286:eb08])
        by smtp.googlemail.com with ESMTPSA id t8sm12524465pjm.45.2021.01.23.11.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 11:06:00 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        dwaipayanray1@gmail.com, broonie@kernel.org,
        ndesaulniers@google.com, jpoimboe@redhat.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3] checkpatch: add warning for avoiding .L prefix symbols in assembly files
Date:   Sun, 24 Jan 2021 00:34:59 +0530
Message-Id: <20210123190459.9701-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <f23f4003-0017-d52a-39b9-2737e60182bb@gmail.com>
References: <f23f4003-0017-d52a-39b9-2737e60182bb@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

objtool requires that all code must be contained in an ELF symbol.
Symbol names that have a '.L' prefix do not emit symbol table entries, as
they have special meaning for the assembler.

'.L' prefixed symbols can be used within a code region, but should be
avoided for denoting a range of code via 'SYM_*_START/END' annotations.

Add a new check to emit a warning on finding the usage of '.L' symbols
for '.S' files, if it denotes range of code via SYM_*_START/END
annotation pair.

Suggested-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/lkml/20210112210154.GI4646@sirena.org.uk
Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
* Applies perfectly on next-20210122

Changes in v3:
- Modify regex for SYM_*_START/END pair
- remove check for arch/x86/entry/* and arch/x86/lib/*
- change 'Link:' in commit message to lkml
- Modify commit description accordingly

Changes in v2:
- Reduce the check to only SYM_*_START/END lines
- Reduce the check for only .S files in arch/x86/entry/* and arch/x86/lib/* as suggested by Josh and Nick
- Modify commit message

 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7030c4d6d126..4a03326c87b6 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3590,6 +3590,13 @@ sub process {
 			}
 		}
 
+# check for .L prefix local symbols in .S files
+		if ($realfile =~ /\.S$/ &&
+		    $line =~ /^\+\s*(?:[A-Z]+_)?SYM_[A-Z]+_(?:START|END)(?:_[A-Z_]+)?\s*\(\s*\.L/) {
+			WARN("AVOID_L_PREFIX",
+			     "Avoid using '.L' prefixed local symbol names for denoting a range of code via 'SYM_*_START/END' annotations; see Documentation/asm-annotations.rst\n" . $herecurr);
+		}
+
 # check we are in a valid source file C or perl if not then ignore this hunk
 		next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
 
-- 
2.17.1

