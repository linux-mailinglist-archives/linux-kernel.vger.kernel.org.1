Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2546328C8B0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 08:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389556AbgJMGhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 02:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389470AbgJMGhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 02:37:17 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AE4C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 23:37:17 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id x16so16911020pgj.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 23:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+1wfzrIL65NAPWaqgLsoNY6XBV7rqfcyLpmvCVcLBAw=;
        b=FUk6dXM72vLJwJmOWdSehSqvb0Fcf+JJRGsZae9utP2ZvNfGyUZ+Bj0ktfLJBerRza
         4mF/fWar4fOOVJsPsQVGs4sIPzKS2ZuU+AhwsM04CLela7kTeYnKIgLUM60vvSxjWtWL
         lBeUSeSXN2qYFnek6CSujYyGm3YD0n4MOOrz9ie0bOaoLrunbaFVW2c0M55ajkM/+xp1
         vQ24lt9GEv1gsJkkUG5gBy3pRBEGbLyZLtuNcKiZUckRlJ+6ipXJBy5kOXYUIx47nRHt
         1w6OfsOCmiEYudaFp2b4VG0vcgpJLGtyWJ1SjFfuZcW0KMz4bCOpkxoZHUMzYRx7U7g3
         H8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+1wfzrIL65NAPWaqgLsoNY6XBV7rqfcyLpmvCVcLBAw=;
        b=MP7U7crt6hHQSXhun3VxxW2RGhJasIf9HRi0+zt9eC/nUej1+99ngUfiD9BYzvVdqf
         N2p9dXVDvBXc9+jPW+ZBGyN5JIzD/d6uaFGSaUQrDJsuyYe7z6YZrn5ICgN9VxrUurhP
         5FlUNpgo2oM44pV69ccm4jsLPqV/UaEyPiWz4vNia0DNcsr0d+VkujpoExZllPAF9gSq
         yPwZl0s5WVTTQqh3URoBVtZUPWva1baVhnMpR/GoXHafa8M3hMwDagYv4NuK7NGTONWi
         h/O5kmPAyInRzGpp4JbWY+s9RSD69J2BCM016jlQPmeJxwW5weUbRtFvlv1BlndeKHnl
         +hqA==
X-Gm-Message-State: AOAM530CxTSruZAEarsJn5mJ3j9qWhPR0vhaoG+VJ9CRBv1bIBRZ8BOT
        0P6SL52nVKIZp6+ysJIhXcM=
X-Google-Smtp-Source: ABdhPJyPOnj1LG8F3dpAH4VBAMobj1M1mvT46HiME+dTv3Q6IZCNaaRkC0ARITWKqsff4ZO4QoKUgw==
X-Received: by 2002:a63:c342:: with SMTP id e2mr15669689pgd.56.1602571037023;
        Mon, 12 Oct 2020 23:37:17 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:6854:a1e4:e3df:76ee:38b8])
        by smtp.gmail.com with ESMTPSA id w6sm17530235pfj.137.2020.10.12.23.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 23:37:16 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH v2] checkpatch: fix missing whitespace in formatted email
Date:   Tue, 13 Oct 2020 12:06:42 +0530
Message-Id: <20201013063642.39810-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0c01921e56f9 ("checkpatch: add new warnings to author signoff
checks.") introduced new checks for author sign off. The format_email
procedure was modified to add comment blocks to the formatted email. But
no space was added between the email address and mail comment.

This causes wrong email formatting in cases where the email is in the form
"author@example.com (Comment block)". The space between the address and
comment block is removed, which causes incorrect parsing of the
formatted email.

An evaluation on checkpatch brought up this case. For example,
on commit 1129d31b55d5 ("ima: Fix ima digest hash table key calculation"),
the following warning was reported:

WARNING:BAD_SIGN_OFF: email address 'David.Laight@aculab.com (big endian
system concerns)' might be better as 'David.Laight@aculab.com(big endian
system concerns)'

Add a single space in between the address and comment when the
extracted comment is not empty.

Fixes: 0c01921e56f9 ("checkpatch: add new warnings to author signoff checks.")
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b493cef..f1a4e61917eb 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1221,7 +1221,9 @@ sub format_email {
 	} else {
 		$formatted_email = "$name$name_comment <$address>";
 	}
-	$formatted_email .= "$comment";
+	if ("$comment" ne "") {
+		$formatted_email .= " $comment";
+	}
 	return $formatted_email;
 }
 
-- 
2.27.0

