Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0FA301630
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 16:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbhAWPO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 10:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbhAWPO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 10:14:57 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756CDC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 07:14:17 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id j12so5625032pjy.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 07:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KTy8n+bNEd4gKJ9+t7A4mZcH7giU4TFs0RUo2PYg5Ec=;
        b=UxxNr3YpD9YBVQbYAyjJjJWFfl+beyLmtL53wnThX2tbCnVaexxDvLKMv6nX97vmJL
         dPrh7fERj0dUfCbxnppUwbQfCO6Kdh9kDvwP+OXKmSuJ55WDFAylPN/SHjrDemghyf0P
         kLgnLv5MfpVi+Mi6wQPkEzB4qjcWl0gxTR1ogA3cty2EWv/AwrijGuKHwQLs5YlAkr2m
         hcmKF1PNzz416Ws9iouT9MsRuMHeHoe4PqeywmqbhTpfTuk7/ilJcRPl3j2XHxNMZAI3
         CT6RmsAKG1oZ6xmPlnhZGPCbRoAiS2gtP3c1hncP5z3bhJzq3vIpQN2/SJZNB5lcECvV
         04QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KTy8n+bNEd4gKJ9+t7A4mZcH7giU4TFs0RUo2PYg5Ec=;
        b=VELL1nSYFnIyCkoDqh4pLMms/HhjY98PrTtAHDUOnuoZODV0G86HATilOQm0v6hjYH
         U1i3hveQKNcvgK3p+sP4UvUPQ4CgozUv039u+l0QYCXrvrH1WqoiyWJxnzZipmNT5zFq
         I6b0jSNgM2OebmZGHgOQMIT+Vgj41IeUNuyXYHQ/xAeuWOBn4E12YfsT/TeDEjosdd84
         kNKDXyk7ubIfpr+ire/zotG/qTjOPjeH7ZifnjgdIUg+PboQiKPq4EKQS6+cYo8Olx4S
         ymbk3oCLa5nWO8ntFqcFyXuirft54/OAXqFeykvJeHXqaoEkKo7AE7Tcfl1Tvhm5sqY3
         EJlg==
X-Gm-Message-State: AOAM531/iTeb2qYVYL5J1Alx+tEmLm2AgZ8BczfeHl2KPTJhNlIE3nOq
        IBsdULlIbvS+aW/Tx63hUILqkyjZMYDk9w==
X-Google-Smtp-Source: ABdhPJyawreUvgM30jreQ3mbYFF9icNJijFyxamoBHb0+gQwNeZEpJp5E9zZHs0h9YmWiQeItodIrg==
X-Received: by 2002:a17:902:7043:b029:df:cabc:cc97 with SMTP id h3-20020a1709027043b02900dfcabccc97mr1429590plt.4.1611414856478;
        Sat, 23 Jan 2021 07:14:16 -0800 (PST)
Received: from localhost.localdomain ([2405:201:600d:a089:8c2b:8940:3286:eb08])
        by smtp.googlemail.com with ESMTPSA id 3sm12107301pfw.204.2021.01.23.07.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 07:14:15 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        dwaipayanray1@gmail.com, broonie@kernel.org, joe@perches.com,
        ndesaulniers@google.com, jpoimboe@redhat.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH v2] checkpatch: add warning for avoiding .L prefix symbols in assembly files
Date:   Sat, 23 Jan 2021 20:44:05 +0530
Message-Id: <20210123151405.26267-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <bd560a8e-7949-933a-e4a9-508cb42c2570@gmail.com>
References: <bd560a8e-7949-933a-e4a9-508cb42c2570@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

objtool requires that all code must be contained in an ELF symbol.
Symbol names that have a '.L' prefix do not emit symbol table entries, as
they have special meaning for the assembler.

'.L' prefixed symbols can be used within a code region, but should be
avoided for denoting a range of code via 'SYM_*_START/END' annotations.

Add a new check to emit a warning on finding the usage of '.L' symbols
for '.S' files in arch/x86/entry/* and arch/x86/lib/*, if it denotes
range of code via SYM_*_START/END annotation pair.

Suggested-by: Mark Brown <broonie@kernel.org>
Link: https://groups.google.com/g/clang-built-linux/c/-drkmLgu-cU/m/4staOlf-CgAJ
Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
* Applies perfectly on next-20210122

Changes in v2:
- Reduce the check to only SYM_*_START/END lines
- Reduce the check for only .S files in arch/x86/entry/* and arch/x86/lib/* as suggested by Josh and Nick
- Modify commit message

 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7030c4d6d126..e36cdf96dfe3 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3590,6 +3590,13 @@ sub process {
 			}
 		}
 
+# check for .L prefix local symbols in .S files
+		if ($realfile =~ m@^arch/x86/(?:entry|lib)/.*\.S$@ &&
+		    $line =~ /^\+\s*SYM_[A-Z]+_(?:START|END)(?:_[A-Z_]+)?\s*\(\s*\.L/) {
+			WARN("AVOID_L_PREFIX",
+			     "Avoid using '.L' prefixed local symbol names for denoting a range of code via 'SYM_*_START/END' annotations; see Documentation/asm-annotations.rst\n" . $herecurr);
+		}
+
 # check we are in a valid source file C or perl if not then ignore this hunk
 		next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
 
-- 
2.17.1

