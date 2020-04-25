Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263A81B858F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 12:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgDYKQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 06:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726046AbgDYKQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 06:16:16 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4D8C09B04A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 03:16:16 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so14498858wrr.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 03:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pNKiJVpVR0UOowLpR3joQeorJ+uy6wvlk/1yvc3fPNg=;
        b=mRWFuE1XJta9nT1zk9b33ywbTo4iWQ1l/hnq+XKs6bENGDpjPQ1ErYTUvzlZPLEwDm
         rUmxlMrBQ2OxpGZzBocZkYqtka9EhN9kT1aCK0v3ddOlhZfG6988yVGC7P2pf+E0clhz
         u2FaWDt1789DYGEiaDgI3T5wNwgut2ZQ43jD7/cLgUQs5uRWmmHGvEY2IYUWxFAyeNMt
         LYSoj+HRyJxSQ/Fg0iCY9wb5wudXbdy98lkznPdHpbvUBa4/+8e9o5pQVYUqbfV7K/F6
         YQ1Dj6dDOPAy091dRaRNXNChVa1k830dMRSSRmSPzdy+0DRj1vAVCY51XZ8sXMg9/qsm
         XLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=pNKiJVpVR0UOowLpR3joQeorJ+uy6wvlk/1yvc3fPNg=;
        b=d6MC6OHD32BwpPLvkOKZFkgC0LONAmz0ksNqdW3H/6b4Jft/Dp1ILUA8463xNvWR8H
         R/OeFIgnMCiAUSFBFCYcqY8q+ex5cYmz9Ii3QNMcqkU0LPd2xZRFUN5X7q4RIbhosSlM
         E5D0kToC74oG8df5vUkCrJyxySvl1/2JTs0JKEXAhGMKGSpB1C7EOma5UhFslZUiyWlQ
         UXxnqGetB2/1iP/EzPKdTQfQJ5U3pR4oRqnuLbWxm7bXUG1mYjgOwgGtghvIuBBLry2o
         FGq9zvnY2l90wAeHzZZdHowIdQCk2aKv5pV9TJ5hmpeCALZTDTRHZlNz/qUXhrZOm41F
         LVQg==
X-Gm-Message-State: AGi0PubYIBiC+1fRj31Aih4sIxFm8tAMJKF+1QUNlv6O+DYfckhyQzS4
        v46uzKZOeEbb/yP6zuC0RVs=
X-Google-Smtp-Source: APiQypKQWqSUDbZ08ks1AzLHahWeljZTibAROrE/FLHZactidtHPci7Exx7QxzHbCefMAZr64n45Rw==
X-Received: by 2002:adf:a15d:: with SMTP id r29mr15440725wrr.134.1587809774233;
        Sat, 25 Apr 2020 03:16:14 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id h16sm13759095wrw.36.2020.04.25.03.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 03:16:13 -0700 (PDT)
Date:   Sat, 25 Apr 2020 12:16:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] timer fix
Message-ID: <20200425101611.GA70989@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest timers/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-04-25

   # HEAD: ac84bac4062e7fc24f5e2c61c6a414b2a00a29ad vdso/datapage: Use correct clock mode name in comment

A single fix for a comment that may show up in DocBook output.

 Thanks,

	Ingo

------------------>
Christian Brauner (1):
      vdso/datapage: Use correct clock mode name in comment


 include/vdso/datapage.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 5cbc9fcbfd45..7955c56d6b3c 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -73,8 +73,8 @@ struct vdso_timestamp {
  *
  * @offset is used by the special time namespace VVAR pages which are
  * installed instead of the real VVAR page. These namespace pages must set
- * @seq to 1 and @clock_mode to VLOCK_TIMENS to force the code into the
- * time namespace slow path. The namespace aware functions retrieve the
+ * @seq to 1 and @clock_mode to VDSO_CLOCKMODE_TIMENS to force the code into
+ * the time namespace slow path. The namespace aware functions retrieve the
  * real system wide VVAR page, read host time and add the per clock offset.
  * For clocks which are not affected by time namespace adjustment the
  * offset must be zero.
