Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E60A2C4F70
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 08:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388445AbgKZH3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 02:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbgKZH3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 02:29:09 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B98FC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 23:29:09 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id l17so1002839pgk.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 23:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1pi9O3cyuNu1mNgsP919qLPV/NgB9Q3iHB4i+uum6yk=;
        b=DzLNjMcJmlfr82HmrsJXykti2GEhPMrG0SEg7zKdoGbGUVRum4GMN5MIJsTypxi/ao
         YNlUaUkr+ygnUlpsmUAxWN8I0yhtJb0msg7nVNQUaRz1XSSwrCIzhcRibOSkk08BFuZ3
         IThSmYUZSNx3Lgg43FTfYi4zx4mHQp7W4dvgOlWE5oqjSMLE05uiXU88mcVBOig2/0Fd
         FFuZkDjSIiwHVtRA3J4tusKHawtaDG4D1tdvrQMKJayh6FZAYMeLbMKld6QqPPnAkFbY
         +ASb8Fd6Fp3HE1+NZX9/uJLUsQAGfpZW0k+PzjBtQpUadh624p48I1b58uv3PbGDexuC
         Ylpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1pi9O3cyuNu1mNgsP919qLPV/NgB9Q3iHB4i+uum6yk=;
        b=rJFklGT/eef+b/Twpb0YTqFW8xz762WOV03dSCK/f3nAtjyEc4BqoB4kFd7u9Wv5wY
         XqarTOS3XlKoJ7M01366KQiMlrNyZY2a4YF/76bEq616+mcDGwRMgKbuBZqA3ioMomf3
         IA0GVAQTMnmMnND6D1BfJ498CH2RiFg/RlPLfitBjDryIE7jw/VHCF8GO4VufVbaqiq7
         JSuoJ8eXPFpz1dMR4VrhL7CxxtL9Vif5M2R44qnc+f17j9Y09R8ayV5c114coT6Ut9Aj
         XSk2FT4YW2dI0KqMX2Pr3mikVts6sbY2xwCNXeUTOJnh2kqWBuaWXrYLzqfvpOoKMblx
         qUqg==
X-Gm-Message-State: AOAM532OfFRwOoBnsZVvL+fdYLd4Sr0LZyZPxPRTwosEk15mFLcQCKLx
        Bpm48UjkqWViAtB5y93CQik9luRHq2O2tL0+
X-Google-Smtp-Source: ABdhPJz4KICB0kuuy0BPKk/Hr7oanZ67ULP4kWWRn8saCecz2h3+3CZOjPt7Dh/PgMFCOokoAWNJOQ==
X-Received: by 2002:a05:6a00:228a:b029:18b:212a:1af7 with SMTP id f10-20020a056a00228ab029018b212a1af7mr1697062pfe.55.1606375748924;
        Wed, 25 Nov 2020 23:29:08 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6052:6026:75db:5ad2:e7b3])
        by smtp.gmail.com with ESMTPSA id j74sm3805528pfd.43.2020.11.25.23.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 23:29:07 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH RFC] checkpatch: add warning for unnecessary use of %h[xudi] and %hh[xudi]
Date:   Thu, 26 Nov 2020 12:58:40 +0530
Message-Id: <20201126072840.32681-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modifiers %h and %hh should never be used.

Commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use
of unnecessary %h[xudi] and %hh[xudi]") specifies that:

"Standard integer promotion is already done and %hx and %hhx is useless
so do not encourage the use of %hh[xudi] or %h[xudi]."

"The "h" and "hh" things should never be used. The only reason for them
being used if you have an "int", but you want to print it out as a
"char" (and honestly, that is a really bad reason, you'd be better off
just using a proper cast to make the code more obvious)."

Add a new check to emit a warning on finding an unneeded use of %h or
%hh modifier.

Link: https://lore.kernel.org/lkml/4910042649a4f3ab22fac93191b8c1fa0a2e17c3.camel@perches.com/

Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7dc094445d83..47c1017a9973 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6570,6 +6570,19 @@ sub process {
 			}
 		}
 
+# check for unnecessary use of %h[xudi] and %hh[xudi]
+		if ($perl_version_ok &&
+		    defined $stat &&
+		    $line =~ /(?:[sd]?print[kfd]|(?:pr_|drm_)(?:info|debug|warn|error))/i) {
+			my $lc = $stat =~ tr@\n@@;
+			$lc = $lc + $linenr;
+			my $stat_real = get_stat_real($linenr, $lc);
+			if ($stat_real =~ /\"[^\"]*%[\d\.\*\-]*h+[idux].*\"/i) {
+				WARN("UNNECESSARY_MODIFIER",
+				     "Unnecessary use of length modifiers %h[xudi] or %hh[xudi]\n" . "$here\n$stat_real\n");
+			}
+		}
+
 # check for naked sscanf
 		if ($perl_version_ok &&
 		    defined $stat &&
-- 
2.27.0

