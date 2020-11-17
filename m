Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A962B6FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbgKQUNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgKQUNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:13:39 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45609C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 12:13:39 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id j5so10866629plk.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 12:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OiYQHkYqtsWMrbxAgg5uqvn4s6SS9WvyA+bC9y6faaY=;
        b=R17JdDlRo48mLGhSs6XeKtxCd/fu4bpFLuaEFmc8ZMHMDr3aDitOWgqqGLijKWHl/P
         IiLYb8cCijUklpvexTBp/Q8gy0rjjLX8lt+qQAQxNc7SwzUEbh4QUn641oHOS+M9w2M5
         NAeUi0htAsPgjLfoUehQLP8XISiFg4YL1cqh/yyL9Pw4NizuvrT4j3ApWFrtQuuB7o3p
         cKE2ODKmIr6COpu+7uWRDhctCGbNBgDtSl8K39ugDAVR8zvRv0+z0CnVvnPO0C0VxLoo
         hS+sq6UeP8JgVC0EEorjAzkhbtoybXnlffTNk8sJufS9nrHQpp3lvUEueQg0g3ip0oLA
         x+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OiYQHkYqtsWMrbxAgg5uqvn4s6SS9WvyA+bC9y6faaY=;
        b=hmLVkSisJAIsL5tCcHCQ0LaYZHMY3VbZUEzFRkF3U95shl2cuTbAAR5MKMxKXDWJcj
         l8PNzqsF6NoytGTBAAiC9Fbz8FJnycMqH0QSBeYUokaw4maIfaQ8J9UHsMWOJy0huYLy
         Qk7gejfRMAsBpUPaEkuX6QokhqA2OH5QM/DqPdCbKfCgXVP/pKrTDG2007l4s01TP2se
         g3x6kQXA6nTZSVy9JscRiP0vDrsXnc5yg3BYn7WHnPLgu8ugLVapseUxioFGGdK+eydx
         TgBEmxycnreGNN7ZXV62+26zVyKk84UjyixQIyWRAoKqf/dGBtN/Fw3+hkdClgPOb6Y6
         sUWQ==
X-Gm-Message-State: AOAM530OdjsuEbk1VFEX7Wr+oZrN3ISnmCRnleTm4FUgPPZP77zx8/zv
        7x2YJlKZI6ewwH63qJcHbYQ=
X-Google-Smtp-Source: ABdhPJzUZDYasxQm32VBKPbjzgNfrCYEWVkfOI79WsuSIypR+8vmoT0smq2/7t4nBSsKjBgTvy7Ltw==
X-Received: by 2002:a17:902:d698:b029:d6:b974:13c5 with SMTP id v24-20020a170902d698b02900d6b97413c5mr826115ply.13.1605644018679;
        Tue, 17 Nov 2020 12:13:38 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:60ba:80c7:87c0:8479:8968])
        by smtp.gmail.com with ESMTPSA id d22sm4179462pjw.11.2020.11.17.12.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 12:13:37 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH] checkpatch: fix spacing check for return with parentheses
Date:   Wed, 18 Nov 2020 01:43:05 +0530
Message-Id: <20201117201305.108427-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spacing check is unreachable for return statements
followed by an opening parentheses.
For example:

int foo(int bar, int baz)
{
	return(bar+baz);
}

There should be an error emitted for a space between
return and the opening parentheses but checkpatch doesn't
emit one.

Fix the spacing check. Also add --fix option to
the check.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 8da6cde20c68..07feeb3321e2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5176,10 +5176,13 @@ sub process {
 				if ($value =~ m/^\s*$FuncArg\s*(?:\?|$)/) {
 					ERROR("RETURN_PARENTHESES",
 					      "return is not a function, parentheses are not required\n" . $herecurr);
+				} elsif ($spacing !~ /\s+/) {
+					if (ERROR("SPACING",
+						  "space required before the open parenthesis '('\n" . $herecurr) &&
+					    $fix) {
+						$fixed[$fixlinenr] =~ s/\breturn\s*\(/return \(/;
+					}
 				}
-			} elsif ($spacing !~ /\s+/) {
-				ERROR("SPACING",
-				      "space required before the open parenthesis '('\n" . $herecurr);
 			}
 		}
 
-- 
2.27.0

