Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA1028E1C1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 15:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbgJNN5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 09:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730583AbgJNN5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 09:57:08 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB3EC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 06:57:07 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id az3so1619242pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 06:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IzJhHTSFV4aE1sSC7KkXjqi2ufY0RfaV89jrFKTw/jI=;
        b=mG3N043341+5bBtnNcnr9MpI8mZhDJ7O7vwn1aWOUOCDmVIzvL/RvyY+Mdse/Aq5l4
         4FTNBIpY1+cr9nJpLS65/3s+myXHhJTOqmQVTf5Co4ksEfZr1bF3rtDAGq0DnSxGtHX9
         YqupM7tAm4Hg76dHvFxoIX8fRQqR/zacae1kp23eovKg9tVGd4sDokQBbkwq0in9pnZM
         s/YT/QYjKaU2ETfSN9QkPp0QzNZjefzGYmyrwjZ51k4JrerQtqYl6gTU60/FI+tYpzAf
         /Ywz9a1PO9vPoqJ+Kd+1Rf8m57lYaLb75qEq8FgqjjTzO8GwhTKqYHgTKMl+DGixMyME
         XQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IzJhHTSFV4aE1sSC7KkXjqi2ufY0RfaV89jrFKTw/jI=;
        b=NRdAVnEZLtVfPpmLhVz+ahKFYd+X2h//GzYyFGTplnRmGAvObXgbRN82RGxvsUKUMt
         A/SxXhb+md4Oh+FpyZCj1/Wn9lKwnnw6hwOmwGpQki1EFM+aiuoQx/0Gp/Rb9WQX0ZhW
         F2qVNChf2GeFHovDmIAlNF1WSeqL0m9leAKIzrQreuRCAu0aIKeZPC/BV8gIpqMBqTIS
         PTbrzoaEIIgU9fp64T8BQCVNE9px0WI/BY12w7Q7DvUS8OJS7IFBpWQNzI2K1IosRekb
         JK8dk7sfbZxt0J3N1wjwhP1V8eLWfFTAZ3Uo8DJ3+qPkw1Yh2vgA2qR11TZ6q2xzvxwV
         2COA==
X-Gm-Message-State: AOAM533OThDr37x2dahnfvBf6yaPvsqvor/0Mc0TKXPz2/Eji6NaAfrX
        Iw9YY+Lg7RR3smBbqSUG1UI=
X-Google-Smtp-Source: ABdhPJyLKgvVi4cNhtcF1kmM5+5IYdJex9SfZsjFsZoLMQOErJnj4IR4XhMvD7AsyykNItj+W6IFcA==
X-Received: by 2002:a17:902:d394:b029:d3:f13b:5ef0 with SMTP id e20-20020a170902d394b02900d3f13b5ef0mr4497407pld.64.1602683827303;
        Wed, 14 Oct 2020 06:57:07 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:686c:a3bc:1846:e23f:17d])
        by smtp.gmail.com with ESMTPSA id fa12sm3275824pjb.25.2020.10.14.06.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 06:57:06 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH] checkpatch: add new exception to repeated word check
Date:   Wed, 14 Oct 2020 19:26:37 +0530
Message-Id: <20201014135637.92319-1-dwaipayanray1@gmail.com>
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
+				next if ($first =~ /(?:long|git)$/);
 
 				if (WARN("REPEATED_WORD",
 					 "Possible repeated word: '$first'\n" . $herecurr) &&
-- 
2.27.0

