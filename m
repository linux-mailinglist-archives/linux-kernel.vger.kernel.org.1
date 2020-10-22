Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DF7295DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 13:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897547AbgJVLp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 07:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437249AbgJVLp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 07:45:57 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002FCC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 04:45:56 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id v190so786143qki.21
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 04:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=WwVpVCl4mVaLx/Y9kggr1s7Fduh1lvdItvOpC6doLlc=;
        b=llBRAaxsFK0Jv3FwPUH131xi0+2HXuuQAur4/LHy8+LZTojR2hfqcUCTqi2qxQCmqD
         SPkPwBcPzG52V7NXfAlFDUuQM+sHYqj1HqMqAq2kwztEvNHe8lMOZ3v54Dqaq85kDtST
         3wbJH/CG1GEYGoNrQ/Lz9les8TWhy39LzMhqrb0+ccyiHTqF96tGdKi+Hui1gegyU5SJ
         MEA2FWkxVRhDngcMG7ybJaXrwBFmVEwBFvudoSOjiQvApGTCEqo9CNt3or84x/i8qroL
         kma1H5dJYtZnt9J/JQ7spjDCEPvAvoHRYlSWcsbv+21jOhtOKiopa8tOgtNGFoW1hLzd
         9u0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=WwVpVCl4mVaLx/Y9kggr1s7Fduh1lvdItvOpC6doLlc=;
        b=jm+8Lpnykew4n8Hbc877pVT8ik3LJSlJVzdAT4bkL0M2jOzxQhNlOIEWFsqoGEzaw2
         aJ7QYSmkq13y1rOrmWLReWCevBUo/arjEXTkpf6B1VQhBelsL+a+lPmNYU8MYJEBGFu5
         f5CbDBLxPSlD5r1nInYZrqzIZnV5qE5FiG8XISPFhEu1aCgUS+4d5ZvyWr+b8wjFdoM/
         /E+UHs8MR2OrCLX5TvLS1wtqJPT1N5qUTxBZedY4y+EPUcKDVA2GA6/2b1GSRSKZqTtE
         2wgqY2uHnemAicedH1QrZryGQRtIe1ylQpSjp/K3mu2ODKvsMGESxtdOfmKvIstQHgAa
         I/2g==
X-Gm-Message-State: AOAM533FsNLe5hmJUwBOi4Gb6hlsLMG4gR8fo1JYwhIMZsHuSTcE9hqa
        0ZT/2wuu/ZbyKYFniwy0Q8UJ2Q9q5g==
X-Google-Smtp-Source: ABdhPJzBf/O9zRXYetQ/53zGLvVJAs1fnhUcZGYm6sz65bHf5tJjwynyYkbp5PSjE/YHlyX89jFZ2rU/TQ==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:ad4:456c:: with SMTP id o12mr1978035qvu.48.1603367156174;
 Thu, 22 Oct 2020 04:45:56 -0700 (PDT)
Date:   Thu, 22 Oct 2020 13:45:52 +0200
Message-Id: <20201022114553.2440135-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v2 1/2] kcsan: selftest: Ensure that address is at least PAGE_SIZE
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     mark.rutland@arm.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of supporting only addresses not within the NULL page,
change the selftest to never use addresses that are less than PAGE_SIZE.

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Introduce patch to series.
---
 kernel/kcsan/selftest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kcsan/selftest.c b/kernel/kcsan/selftest.c
index d98bc208d06d..9014a3a82cf9 100644
--- a/kernel/kcsan/selftest.c
+++ b/kernel/kcsan/selftest.c
@@ -33,6 +33,9 @@ static bool test_encode_decode(void)
 		unsigned long addr;
 
 		prandom_bytes(&addr, sizeof(addr));
+		if (addr < PAGE_SIZE)
+			addr = PAGE_SIZE;
+
 		if (WARN_ON(!check_encodable(addr, size)))
 			return false;
 
-- 
2.29.0.rc1.297.gfa9743e501-goog

