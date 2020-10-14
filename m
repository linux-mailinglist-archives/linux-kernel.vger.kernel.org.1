Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B3128E498
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 18:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbgJNQiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 12:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgJNQiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:38:07 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5BDC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:38:07 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w21so2074771plq.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VY0MvFGC3zETzD7GSybyFTiANMXXAizdMlP9FpHdDks=;
        b=JlhJgRLOiKuRBVyOzDvLQb1fUdCqWuEwAmzXPogFUfHdYzaGJKNpYmhrhIySnhY0jb
         /flNj2fUG+fMsUhdoQzTNgROvI2/2Uyj4iXCQCSw/37/+PWSl3M0fSZIzcSTCq6Cyprr
         uFsxGp1b/I1HONVODLHPgdKlgfIvMgrRhOBd+Gignq9ya7Rq6XgowwsZ4y6JThX/mm5x
         5Qnuwh+OddizWCRNDnE44cSOof+RNJoU0Ina+OEaG0JNrRWdyVLDtR6AL1Bi81zpq2bx
         DSpgPslKXtYi0eWn2dWse15DXTpDr7reIvdZB5LdExL/6TLpSvGRNyZDUKhZWzA+D20w
         uclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VY0MvFGC3zETzD7GSybyFTiANMXXAizdMlP9FpHdDks=;
        b=k8CFcVV+g25HJPSDQ6S3yCAKS0frYVSZXlaWJjDgimN67vMysGZ8oFPWEGypxO2iC6
         XzWRceUiUkG4eWAcVUx+vrBFVQoOcI9+uHaJyzf1aYsIQEkkjIZxV/YF7PO1WIYaDW30
         mBcMObuIdtIRW3wy2ydAk6Mxp9uiyra4LF3eZoQcPCimwjxZK2pUBFZvx/yTtzFhDxop
         TRQd150kZ2IC4xGSpz5JWID2FA1PSNsLet+mxhk/yD7Gg4tMD27PlQr7NPIrZTg/yqPS
         ISbRM9Wn4dCG/Z5F9FbAvPAHUJuj8toBZDNestYvzT2wG6d17RbOA2kKhndrCw46Ucpw
         7dTQ==
X-Gm-Message-State: AOAM531N95BreI23a5y5aUupuC5lIppwfzCm23ZRyNmBdu+bB4OqWc+K
        cBGnnvqfdPK3BIIRzUqaLuw=
X-Google-Smtp-Source: ABdhPJwcYKvkBeJurfX7deEz1OcTacSj1Kgx3dK1DosE2Zg4V36UjONzj+d/gU/HmswMrazPm1PlFA==
X-Received: by 2002:a17:902:9695:b029:d3:8b4f:558c with SMTP id n21-20020a1709029695b02900d38b4f558cmr5110232plp.27.1602693486444;
        Wed, 14 Oct 2020 09:38:06 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:686c:a3bc:1846:e23f:17d])
        by smtp.gmail.com with ESMTPSA id m11sm102187pfa.69.2020.10.14.09.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 09:38:05 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH v2] checkpatch: add new exception to repeated word check
Date:   Wed, 14 Oct 2020 22:07:38 +0530
Message-Id: <20201014163738.117332-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, commit 4f6ad8aa1eac ("checkpatch: move repeated word test")
moved the repeated word test to check for more file types. But after
this, if checkpatch.pl is run on MAINTAINERS, it generates several
new warnings of the type:

WARNING: Possible repeated word: 'git'

For example:
WARNING: Possible repeated word: 'git'
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git

So, the pattern "git git://..." is a false positive in this case.

Add 'git' to the exception list for repeated word check. This effectively
fixes all the newly generated false positives.

Fixes: 4f6ad8aa1eac ("checkpatch: move repeated word test")
Link: https://lore.kernel.org/linux-kernel-mentees/b6cd81b936671a8868fe98536d7c80771bdfd61c.camel@perches.com/

Suggested-by: Joe Perches <joe@perches.com>
Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f1a4e61917eb..b55d83360366 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3063,7 +3063,7 @@ sub process {
 				}
 
 				next if ($first ne $second);
-				next if ($first eq 'long');
+				next if ($first =~ /^(?:long|git)$/);
 
 				if (WARN("REPEATED_WORD",
 					 "Possible repeated word: '$first'\n" . $herecurr) &&
-- 
2.27.0

