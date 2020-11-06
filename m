Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30562A8F69
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgKFGWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgKFGWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:22:21 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBEFC0613CF;
        Thu,  5 Nov 2020 22:22:21 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id v5so268376wmh.1;
        Thu, 05 Nov 2020 22:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=s5ZmG5HziDA6IddsEwKpYTRZvML0z6aMnCT2nnV/iGw=;
        b=eXFlA98XsP9bNmMIrUbtLEH8DNqvq47SPuGmJHCzfmWSp1fR1x2j++BW+WQOKtNHpy
         +n08HtlcerjUblGu7gVJIEAE8snqfmrKwkHUBhVmckyOAifi9wl/MLGB+j8fZnAhKgft
         AGf/TnfJECJbQhkZd5NaLUOE+dB2HmNcP1cXmptgfCEcvh2ESOWwr8viqYLL3qrflwQ4
         ej9EnxUhE9BBa/UQrjg+TYA/zGHhHUF5z3raVSr5MypFVjkjv0/u1pitZf2oUcQxMax5
         RehF139mRg36hUXiXbPwOZYby58Feh1Zu8IX5dkdNtsMdC9/SYNEfYpNKEiRcDbBCiqK
         Sc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s5ZmG5HziDA6IddsEwKpYTRZvML0z6aMnCT2nnV/iGw=;
        b=Do7G5p0HT/LiprlUywutKIToOdokDz71Gs1SVzkJSeaFbfeTB9SbhDRyiRC96EB9+9
         Hh7Ch3fD7si1hrfI/Ksjtef1JHxF93igmRk1nevNE7wb48njwRwZilhBrGntIINjkthu
         RPwuryWlB7u1POEZ/559RMXG3dz7BFNmU2gouQ2SsCxYtSfv537M12sNKh2Zuxf2A/x9
         8aCNsX4fp1YlqtjvR3shrOcxFharShsY/+8ucrm1G/6lmxneE8Iiyu7GCMn34eI6ror7
         uuzfRB2vKXjznjJYQK8aLCVlFbS976QUsbAFm9rt/y73qeJRkLVSErwyKVhDrqjIknrI
         PgyQ==
X-Gm-Message-State: AOAM532t0lkV+b2IwUsx7P+pN2zKJfFrFGTY+1E7VBK/T5k9IwwUZHDQ
        W3+hzYgUKkK6A83xpMYpLQQ=
X-Google-Smtp-Source: ABdhPJw1kNpLxAin7EGLXZO9jr3KRSf4YMHdtk5JEmho3ZDLTxUMoNc/quG7fq3c5nak5We4cIg9ig==
X-Received: by 2002:a1c:a503:: with SMTP id o3mr613462wme.21.1604643739995;
        Thu, 05 Nov 2020 22:22:19 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d20:9d00:b87b:b644:61a3:6870])
        by smtp.gmail.com with ESMTPSA id h81sm612401wmf.44.2020.11.05.22.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 22:22:19 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] taskstats: remove unneeded dead assignment
Date:   Fri,  6 Nov 2020 07:22:10 +0100
Message-Id: <20201106062210.27920-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make clang-analyzer on x86_64 defconfig caught my attention with:

  kernel/taskstats.c:120:2: warning: Value stored to 'rc' is never read \
  [clang-analyzer-deadcode.DeadStores]
          rc = 0;
          ^

Commit d94a041519f3 ("taskstats: free skb, avoid returns in
send_cpu_listeners") made send_cpu_listeners() not return a value and
hence, the rc variable remained only to be used within the loop where
it is always assigned before read and it does not need any other
initialisation.

So, simply remove this unneeded dead initializing assignment.

As compilers will detect this unneeded assignment and optimize this anyway,
the resulting object code is identical before and after this change.

No functional change. No change to object code.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20201105

Balbir, please pick this minor non-urgent clean-up patch.

 kernel/taskstats.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index a2802b6ff4bb..bd18a7bf5276 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -117,7 +117,6 @@ static void send_cpu_listeners(struct sk_buff *skb,
 
 	genlmsg_end(skb, reply);
 
-	rc = 0;
 	down_read(&listeners->sem);
 	list_for_each_entry(s, &listeners->list, list) {
 		skb_next = NULL;
-- 
2.17.1

