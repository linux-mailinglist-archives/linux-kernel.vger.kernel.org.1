Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729E828BBAE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389856AbgJLPUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389142AbgJLPUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:20:21 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C360C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 08:20:20 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id u24so14613540pgi.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 08:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YDmkkeeqQ3b4HtPKjP66HsePetdbbMIHR1qv6Sgv0no=;
        b=FdyOPnVLgzq3ZS9epBu1sjXXvTR8eEKZ5VpYLpcm3BPKfJNM1y4HEgEn7mIJwTRFix
         tTqqY6a2Zn8c02xDq4naVIPJL1aAIj5aKZWKo/r8it7Z/KpEZbSWJkjQv1UyV8VBVWbB
         GdETIFMLuCmCwuq3PKmNMr/tOwxTzb/AaTGC8GSh8ZGJMy6Q76JD6WmXtDUNZD6Vr26r
         0r5WCxbXawommwNRbiPBRZS+T7A2wtgvT4uyp5M+J4rBifo2xVw3XKVJGBtkRM6Lk3tc
         ENj3egXAZWuN5vTOYIZq+F950I7rG5sXj/Xn2CgMFj6XJOol7QmJr6EliQxmabQRZLJs
         a4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YDmkkeeqQ3b4HtPKjP66HsePetdbbMIHR1qv6Sgv0no=;
        b=EAb8PDFaSgaHFI1Sd5KQvd+DYQXICkOkqy2QJ6vwliRvYYSfaeUingMpDxqtZKDU8n
         1L0ahJDj/jYFpFZrNQXwmozEyuWJptih5CT1X1B4qXFjRWANquEtnKtGjifUfYQ2Jn0Y
         RESiQUfLKN2zrCfOiHTCtYuVsxeDIO0mkokwNbJjkriHG5Ci4BlU7EYZzaetUXWLngvO
         +xb/GmHsNyifRcJKeVW5DhJZmfkMEMWF5zAS7j/yVtUYmbNYfpLYCHHtxGDnPWIUn5qV
         ofjM08m7D9oGmq8B2wYoWPIYQVpe1gzUlcgzNm3eo5LtjzEz70O+2YwnSxpgJSQxnYNO
         YD5w==
X-Gm-Message-State: AOAM533jxn1rO2h4LhjoiH8T49fHJr3Gc1HWbcOum28vVgYCFEH8mB0g
        7JwFNDdtH4Yd231likQ/eTk=
X-Google-Smtp-Source: ABdhPJy1Fti/loRGToxRXjORfSstPLRFKjgO4hcuBr2WEwN07TpGRA8ISHOtIspE0tS0MABmB867TQ==
X-Received: by 2002:a17:90a:d983:: with SMTP id d3mr20612669pjv.144.1602516019438;
        Mon, 12 Oct 2020 08:20:19 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:a404:280a:90bd:7a49:dcda:1fb1])
        by smtp.gmail.com with ESMTPSA id t5sm19814480pgs.74.2020.10.12.08.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 08:20:18 -0700 (PDT)
From:   Ujjwal Kumar <ujjwalkumar0501@gmail.com>
To:     Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Ujjwal Kumar <ujjwalkumar0501@gmail.com>
Subject: [PATCH] checkpatch: improve EXECUTE_PERMISSIONS tests
Date:   Mon, 12 Oct 2020 20:46:30 +0530
Message-Id: <20201012151628.1234094-1-ujjwalkumar0501@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Use group capture regexp for file mode test to improve code
   readability.

2. The 'scripts/' directory test on filenames can be excluded
   as it has become obsolete because there are many source
   files that are not scripts in this directory and its
   subdirectories.

3. Replace unnecessary group capture regexp with non-capturing
   group.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Ujjwal Kumar <ujjwalkumar0501@gmail.com>
---
 scripts/checkpatch.pl | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b493cef..aa84999917b5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2678,10 +2678,11 @@ sub process {
 		}

 # Check for incorrect file permissions
-		if ($line =~ /^new (file )?mode.*[7531]\d{0,2}$/) {
+		if ($line =~ /^new (?:file )?mode (\d+)$/) {
+			my $mode = substr($1, -3);
 			my $permhere = $here . "FILE: $realfile\n";
-			if ($realfile !~ m@scripts/@ &&
-			    $realfile !~ /\.(py|pl|awk|sh)$/) {
+			if ($mode =~ /[1357]/ &&
+			    $realfile !~ /\.(?:py|pl|awk|sh)$/) {
 				ERROR("EXECUTE_PERMISSIONS",
 				      "do not set execute permissions for source files\n" . $permhere);
 			}

base-commit: d67bc7812221606e1886620a357b13f906814af7
--
2.26.2

