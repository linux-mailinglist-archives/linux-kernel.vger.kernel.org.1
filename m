Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DD327FD7B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 12:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732238AbgJAKdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 06:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731647AbgJAKdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 06:33:44 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59AFC0613E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 03:33:43 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d9so4081719pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 03:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fQTw1sCQWT6GYrgDpI3EitnTCGAU23/niMRjTpsTEn4=;
        b=PQSa3su63uNtIjlg9q35vYgWy61NXgVmNIoZglHykMU0smYylecz7wgQHRBOtXO74H
         V5JzxrlzocXIY7niAMtmZvggSGDQyIKmhihr2b0iDsZew2RnZiY7J5x9y5DfWa/ZVvjI
         2/suiC/V6yYc3CGEo8aSfS9xltkPBQCamsoAYe+DZ/2xQmiFcHAeqb6M7emezENMnlxW
         b2mS+F+SKRCl+5m1w3cdOi9ZpLwnZjTmDL5fX9NH4pyvZQ2qlVv2P4h6Myi1RDjuofhl
         9TkpPCP7PdcoKmL5dTMSPgbBYxiq7CrOEUMyc8u/DF1RtN0gpMj2/jDhrhekXwVk+g5V
         XZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fQTw1sCQWT6GYrgDpI3EitnTCGAU23/niMRjTpsTEn4=;
        b=uZqCqEesEe2gGwLPGFXK2+3noJcyAY4KI/YnMSpC6MIljMNnlbc00YLQ05pS5d7y52
         nf2qVnET6AdwfpvONRXEM9bG28jivrY9bbS4oDvPA/Fxx8v8f2uooScfI2VvdnWtTa55
         cl6kEHpLcdlZXnbthT7Oi3Rsx/GNQ05jb0VsVrje0ZLogKAHRIvez3BQZKYySUR2lRee
         32dpmK4SHXvGQnh1ha+GRV0Yj1xxYnT4rU0h/9qcI99mYHyS/bkHHik9Zv54OGcy8Yrw
         s0n5QQoc2QXm43zq2UkA3Y0zhWatZtg8uxZHh4ekjXW3GbJpmvP+RJClW1on6rdJ02KC
         31PQ==
X-Gm-Message-State: AOAM5304uRZVxWyljotmOkaRUnIMk3MXWUDEKnuuParJTzODpc/TNcdW
        3ANoTdcbYRwwKmaB3qr7igk=
X-Google-Smtp-Source: ABdhPJx/yV/zBeBpAEW1BN1LxMFduT0jhl9l1ixStjCEezC3xVB/TlAd7E5L7HzhUdDr0IIdF1Rzmw==
X-Received: by 2002:a63:d852:: with SMTP id k18mr5599858pgj.49.1601548423007;
        Thu, 01 Oct 2020 03:33:43 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:6895:98fa:b2ef:d209:c1d4])
        by smtp.gmail.com with ESMTPSA id f18sm6198124pfe.153.2020.10.01.03.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 03:33:42 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com
Subject: [PATCH RFC] checkpatch: fix multi-statement macro checks
Date:   Thu,  1 Oct 2020 16:03:14 +0530
Message-Id: <20201001103314.136645-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch.pl doesn't have a check for excluding while (...) {...}
blocks from MULTISTATEMENT_MACRO_USE_DO_WHILE error.

For example, running checkpatch.pl on the file mm/access.c in the
kernel generates the following error:

ERROR: Macros with complex values should be enclosed in parentheses
+#define copy_from_kernel_nofault_loop(dst, src, len, type, err_label)	\
+	while (len >= sizeof(type)) {					\
+		__get_kernel_nofault(dst, src, type, err_label);	\
+		dst += sizeof(type);					\
+		src += sizeof(type);					\
+		len -= sizeof(type);					\
+	}

The error is misleading for this case. Enclosing it in parantheses
doesn't make any sense.

Checkpatch already has an exception list for such common macro types.
Added a new exception for while (...) {...} style blocks to the same.
This effectively fixed the wrong error message.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 72c4072307ea..c2c211374662 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5342,6 +5342,7 @@ sub process {
 			    $dstat !~ /^\.$Ident\s*=/ &&				# .foo =
 			    $dstat !~ /^(?:\#\s*$Ident|\#\s*$Constant)\s*$/ &&		# stringification #foo
 			    $dstat !~ /^do\s*$Constant\s*while\s*$Constant;?$/ &&	# do {...} while (...); // do {...} while (...)
+			    $dstat !~ /^while\s*$Constant\s*$Constant\s*$/ &&		# while (...) {...}
 			    $dstat !~ /^for\s*$Constant$/ &&				# for (...)
 			    $dstat !~ /^for\s*$Constant\s+(?:$Ident|-?$Constant)$/ &&	# for (...) bar()
 			    $dstat !~ /^do\s*{/ &&					# do {...
-- 
2.27.0

