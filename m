Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C902A00B8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgJ3JHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgJ3JHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:07:34 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DB3C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:07:34 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 15so4640972pgd.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+B7DrabjALESSLgvrRU2SUJPeb/davPcXgiTuHjAvYs=;
        b=FCFsB3/tIibDL4zx1fW1oF29wuAfAoJ1hS97J0MKs7E1RJUrUZ94sjGhHikaqpnYmG
         tCr+48OEbfz6TqXrGwlOURI68Ik1O2UMqQveFp3XHKB2rF8Vo05gSrZOAdpt1USJrB/G
         IFZ4GOiqKb0MGjsIoErdioH8lV1BXqMhbMJqPI2xpDxN3y1Q5No8seR5k6RxTPQFF9G5
         C69+8qUCIyqkggXfZf0B4Ngn/X1Zkg/nnv3HSvReNWIZv+qogBm87gVAOmsTiiyP3ys7
         gFu6PMZf3DMGTng4VwRUQLm0h5D6xcLXW4nr/SkDyCIUdwvWbKB2iR7kfKUw/5zE4f6d
         TidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+B7DrabjALESSLgvrRU2SUJPeb/davPcXgiTuHjAvYs=;
        b=aaKgKBJFzGyGoRk9fOYnoUvg+txP0gLpSslejlYM3P/yT43ESmhhSH+t/f1fTC94HT
         sbaef23zo1l3bUYFnEI6dGIrC94jg2ma3m1S6puJF702O9ekfvm4wJds6iP1/4Kd2T0a
         nRV0SkP7hAdSX2UDF/2LTVf6KN1Znaw6VCcEwP2zpLwEXJRtEl6oKX4ZLKF0kZdepC66
         RLrZXnfXf6oZYM7ivik0W5B6WkpVE0RX18z4aiNZ008gwqvkhbuMb+tG5YxQVaIYAPB9
         wEhBbUS0yPY3t9mh/pAl4GaNSx2HfNXqVd5LkX5c+ydgrY8bYd0ULmEdDkvyyRQH03Tp
         AqJA==
X-Gm-Message-State: AOAM5323AgUT6AUXDQFbciVOCjxsJzKeQ/qUjnAXJqsm76tYjOUiW1HA
        vU7AITmeQwgSn8EYQl3png7DuNMnEW2fwxPY
X-Google-Smtp-Source: ABdhPJwQoy5lGoxWGCu+w56vGEHkheybredgq458reF1b9S+aRPHgVNaR+OoMNWdPanqXrkH9up5ng==
X-Received: by 2002:a63:6503:: with SMTP id z3mr1313531pgb.2.1604048853824;
        Fri, 30 Oct 2020 02:07:33 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:6819:f451:9e0a:873f:ed68])
        by smtp.gmail.com with ESMTPSA id w187sm5245878pfb.93.2020.10.30.02.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 02:07:32 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, yashsri421@gmail.com
Subject: [PATCH] checkpatch: improve handling of email comments
Date:   Fri, 30 Oct 2020 14:37:04 +0530
Message-Id: <20201030090704.40533-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch has limited support for parsing email comments. It only
support single name comments or single after address comments.
Whereas, RFC 5322 specifies that comments can be inserted in
between any tokens of the email fields.

Improve comment parsing mechanism in checkpatch.

What is handled now:

- Multiple name/address comments
- Comments anywhere in between name/address
- Nested comments like (John (Doe))


A brief analysis of checkpatch output on v5.0..v5.7 showed that
after these modifications, the number of BAD_SIGN_OFF warnings
came down from 2944 to 1424, and FROM_SIGN_OFF_MISMATCH came
down from 2366 to 2330.

So, a total of 1556 false positives were resolved in total.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b493cef..ae8436385fc1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1183,14 +1183,20 @@ sub parse_email {
 		}
 	}
 
-	$comment = trim($comment);
+	# Comments in between name like John(A nice chap) Doe
+	while ($name =~ s/\s*($balanced_parens)\s*/ /) {
+		$name_comment .= trim($1);
+	}
 	$name = trim($name);
 	$name =~ s/^\"|\"$//g;
-	if ($name =~ s/(\s*\([^\)]+\))\s*//) {
-		$name_comment = trim($1);
+
+	# Comments in between address like <john(his account)@doe.com>
+	while ($address =~ s/\s*($balanced_parens)\s*//) {
+		$comment .= trim($1);
 	}
 	$address = trim($address);
 	$address =~ s/^\<|\>$//g;
+	$comment = trim($comment);
 
 	if ($name =~ /[^\w \-]/i) { ##has "must quote" chars
 		$name =~ s/(?<!\\)"/\\"/g; ##escape quotes
@@ -1205,8 +1211,6 @@ sub format_email {
 
 	my $formatted_email;
 
-	$name_comment = trim($name_comment);
-	$comment = trim($comment);
 	$name = trim($name);
 	$name =~ s/^\"|\"$//g;
 	$address = trim($address);
@@ -1216,6 +1220,11 @@ sub format_email {
 		$name = "\"$name\"";
 	}
 
+	$name_comment = trim($name_comment);
+	$name_comment =~ s/(.+)/ $1/;
+	$comment = trim($comment);
+	$comment =~ s/(.+)/ $1/;
+
 	if ("$name" eq "") {
 		$formatted_email = "$address";
 	} else {
-- 
2.27.0

