Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725B82CC883
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 22:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388636AbgLBU6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728577AbgLBU6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:58:47 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699C7C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 12:58:07 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id o9so2009010pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 12:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kZoiJysIE6nklYevoiw7YQHmFZ3mb7vgfEQBLxTf4ro=;
        b=LJXmnV5XM5jpdHywKUDKsGnhPXfxmIfvNsdjJvmQmhH8fjI24kw0L9S76iBLvPlJ8q
         OIUdkKyokkp0ZkuurpO1Q9iRM3TBjAjxbxQ/CZaNBFlInQjxoBfwN3LZn2JJIXqLG4/9
         miFhaby0srQHvhoFarNyVMkZSB8DlXMlRF+pc5i4KXMuTOCAqMzJuXT9TiO28JJYHnoa
         r1FaOaNZnfBK3F5kH7UrJoR1H3I9MdJCS1XvtCvTjlrqJjhw/BcX7BCaM4GJj7webxOp
         qIcfDyT/abVa/zuMkq/V+AiHIdfB/597L+VXblE+2ryiPg97iUrj6iGgn089EQyU1l46
         Samw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kZoiJysIE6nklYevoiw7YQHmFZ3mb7vgfEQBLxTf4ro=;
        b=sR5Mrfj2wsub7y+9FI6Ednd8dUoalfXC+gWdzJaWNVqSRVNXsiABDbrkiolOzD6a6E
         YDKDv19j/zoj5Sjcm2m1FPbwhjQurlATp0LCKx1RE8K7mba7TI/gVNPo9A7iYjM7F7mi
         QbDWN1c422O1PYE4YOb/0a0siZZ7riApPTaP1iPKygU1MjTOt0mpR8YwbF57IJGqvEVK
         J58r6zplTbVer48ggiWa+laWURK5zW0SqyMdJ8VSOU/O9+qG/aZKfMn6UW4ImGVpVGbU
         K7OCyI87UTCfAqmjM48QftHBE7Mup8VH4n3ZJfwVaxmbpag6hPcL206JWl8vD2i7+0i4
         gmMQ==
X-Gm-Message-State: AOAM531X3b2CHKIa9M7qPMDm8UN2IQNfx97BGoD/oHtjjAXkovnkDL39
        dv79WUsWNyteh6pXh6zAaFnorR37yiPE26Rl
X-Google-Smtp-Source: ABdhPJw0CHfYgivBLWvIxs8tSyC5V2/y4Gh3eDFW+qKjHQWEPfbgBUxn3Mqtm+JaTbSpM2WTj3O7Kg==
X-Received: by 2002:a62:d11b:0:b029:18b:b3e:95aa with SMTP id z27-20020a62d11b0000b029018b0b3e95aamr3217pfg.3.1606942686814;
        Wed, 02 Dec 2020 12:58:06 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6a1b:d60e:9bc5:1ecd:a6f8])
        by smtp.gmail.com with ESMTPSA id b13sm17614pfo.15.2020.12.02.12.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 12:58:05 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH v3] checkpatch: add warning for lines starting with a '#' in commit log
Date:   Thu,  3 Dec 2020 02:27:40 +0530
Message-Id: <20201202205740.127986-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit log lines starting with '#' are dropped by git as comments.
Add a check to emit a warning for these lines.

Also add a --fix option to insert a space before the leading '#' in
such lines.

Suggested-by: Joe Perches <joe@perches.com>
Suggested-by: Peilin Ye <yepeilin.cs@gmail.com>
Tested-by: Peilin Ye <yepeilin.cs@gmail.com>
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
Changes in v3:
- Modify commit message for more clarity
- Modify warning message
- Modify --fix option to substitute single space instead of tab

Changes in v2:
- Modify warning message and type
- Style fixes

 scripts/checkpatch.pl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e8c1ed0b1fad..7940889877ba 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2966,6 +2966,15 @@ sub process {
 			$commit_log_possible_stack_dump = 0;
 		}
 
+# Check for lines starting with a #
+		if ($in_commit_log && $line =~ /^#/) {
+			if (WARN("COMMIT_COMMENT_SYMBOL",
+				 "Commit log lines starting with '#' are dropped by git as comments\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s/^/ /;
+			}
+		}
+
 # Check for git id commit length and improperly formed commit descriptions
 		if ($in_commit_log && !$commit_log_possible_stack_dump &&
 		    $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink|base-commit):/i &&
-- 
2.27.0

