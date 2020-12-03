Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923A92CD994
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgLCOvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgLCOvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:51:21 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B343EC061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 06:50:41 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id r9so1217366pjl.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 06:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4uLfTj1o1I0915H2A2WmipcUm7uEYEQmLiO3gq8Wtf4=;
        b=abq5ETbtnE3P2yBAXHyb+4xWvTRBa9ra0f3ghvMvHc7oRF18GU93ZQtKlrvIafY8QQ
         IQsZHhecQ/sAZHxovmPt47NRfbUpGxdInwRHtyYP6+n3JH1IoWJSSmU49r/0f81A/cCE
         gPpbEvRDEds20QW30htGzRktncOGGEju/XQsO29mFlGouKybFsq7KRTDGLRdAmTJsnbn
         AT9iJfOM4e9IzWqyYG9XUM8OwPZrKrrsRJHKl2s6mSl4jMDy2mAUciVSr7etz/zylXpS
         IQ0U8XO/Fxan5w7vbqYeiOy3nON7N88pNm+Ua81e+uBi5SPwXuil3o4hUSj+fJxUlchF
         7a9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4uLfTj1o1I0915H2A2WmipcUm7uEYEQmLiO3gq8Wtf4=;
        b=dGiZL7N4AwYOcP+Hsp74zLYakDafrgLsOw+GSTvF0a2vpLzULkzwhcS0eaL6uuJKdv
         uHxyCbyoMDgi1zHtOMeZPM95WxWtMdR1LYrcY1r2D7ZxH9Zs7M3aHwZ5Wjotmnr9opEA
         IDiRqzUanSmW60vmh5VpzbJG4b77U7Jgj1XFj81r2QxGbTA3BiV0pC2p+HB+HL3/Rtam
         dZ7zDYqq05qGaGgBzn6lhVdguqRANQ6RKSAsupmlpokvNufn0DL0nH+zRrHqRnBi2Gs2
         hlLwX+TsckWtWVjkQpivBrOZ3f2YSzETTl563OkE//9EBd4su+XfOVHn8cw8dvB6qxvs
         Xd5g==
X-Gm-Message-State: AOAM533/dYDSWxLNQ3YF6e6iQT+2oIpGKFD0/KjEooZJb6f2wQ2suebx
        r1yQdsuiG0ev/dSmxE/dG/c=
X-Google-Smtp-Source: ABdhPJybLDSieWUqpCn+tkaaumMO0kpOolTxHvyzem5KlMjLWCsAENqAlU1YZUHvu+V4e3GLUWScTg==
X-Received: by 2002:a17:902:9f97:b029:da:357b:22b0 with SMTP id g23-20020a1709029f97b02900da357b22b0mr3352805plq.73.1607007041341;
        Thu, 03 Dec 2020 06:50:41 -0800 (PST)
Received: from localhost (60-248-225-230.HINET-IP.hinet.net. [60.248.225.230])
        by smtp.gmail.com with ESMTPSA id q7sm2081497pfh.91.2020.12.03.06.50.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Dec 2020 06:50:40 -0800 (PST)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] x86/alternative: Update the description for text_poke_bp
Date:   Thu,  3 Dec 2020 22:50:20 +0800
Message-Id: <20201203145020.2441-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function changed at some point, but the description was not
updated.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 arch/x86/kernel/alternative.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 2400ad62f330..8d778e46725d 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1374,7 +1374,7 @@ void __ref text_poke_queue(void *addr, const void *opcode, size_t len, const voi
  * @addr:	address to patch
  * @opcode:	opcode of new instruction
  * @len:	length to copy
- * @handler:	address to jump to when the temporary breakpoint is hit
+ * @emulate:	instruction to be emulated
  *
  * Update a single instruction with the vector in the stack, avoiding
  * dynamically allocated memory. This function should be used when it is
-- 
2.17.1

