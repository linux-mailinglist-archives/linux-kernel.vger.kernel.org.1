Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49E12556E9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 10:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgH1IxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 04:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgH1IxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:53:11 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407DAC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 01:53:11 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l63so448324edl.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 01:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ktsAQ91xboTAYZP0C7thOIjus0CQMSrEXw6IWffHbYU=;
        b=CpqFWRrE9P2sQd66kBhi5X/V7ZWfIk9vn2OIEM3Gwxvoy/hPZuHvTu6u3hSRjC7Tq+
         3GM7QNB96k/bus1riR3l7Wui1wPtpJI4Q5vek/U2KUQZloM+ELPqTxvFOHHZYnWvqYud
         IYcMpLsg3Xe3+J9Ir6d27sEguokvdpigcNYJ09JutwEZTQznGyX1+eRz6aCiBMJOhc69
         W/XlTr8cRiAd7dwcza4scsSDJzCjyDQxaUC46IMmSCeuvOQhaOPvVNWjlCLxRmWRDpv3
         Vp/VrXBTLvULjbgKXrN7mgk8/q/qQ0uWAZqsCNTH+z3Bz/whFPVHNXxvDqW9T76gTMl2
         uDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ktsAQ91xboTAYZP0C7thOIjus0CQMSrEXw6IWffHbYU=;
        b=FUKoZyi/rpD6CxUgXoV4lP+3cxLt4/wL+cbO/7uVQCq3+wkBpKYvvC7LNnv/cFRDh9
         ZSfJ/FYSCEGcQJS4pQck5rmt35yxosIHmtV8sqf54HiLkrJiQCQvHV69os/iVO50SyCN
         O6BWVC2NX0wj+sIQYJJAPSLanJ23qecKm73Ea53VdBYQFdCtwbBc2jpYw9oud0RHkFf2
         Lk7vffk5oGOMNq2yOdOhq1KzMEG6Ip0ZvQdmTjMtoZSXzcdFigHi/ZuwVDk/lDVUM1BR
         4o6JbOxPaevrE3gzGqfyTaYG5cP2uDkj/6IdZpBKUa2yvjsN4mdwrRCcon69QcdXSC6P
         WGDw==
X-Gm-Message-State: AOAM532XzuXVNwJOVwjRUBTAhvCg7/Z3yrQKZKxOJeC1/qoTN3EiYUGz
        +oZdEbKWVpr5taj30eR3dsE=
X-Google-Smtp-Source: ABdhPJxIhB7rwdSMnKeJcvMCcb4tIqajrJxJ4uLnErsB4iMcolvls/ktBw5vnGsq0zdoh7JcHQRFBg==
X-Received: by 2002:aa7:d70a:: with SMTP id t10mr789143edq.161.1598604789869;
        Fri, 28 Aug 2020 01:53:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:4d0:302a:c6fb:6068])
        by smtp.gmail.com with ESMTPSA id r18sm330254eju.25.2020.08.28.01.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 01:53:08 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] sparse: use static inline for __chk_{user,io}_ptr()
Date:   Fri, 28 Aug 2020 10:53:01 +0200
Message-Id: <20200828085301.78423-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__chk_user_ptr() & __chk_io_ptr() are dummy extern functions which
only exist to enforce the typechecking of __user or __iomem pointers
in macros when using sparse.

This typechecking is done by inserting a call to these functions.
But the presence of these calls can inhibit some simplifications
and so influence the result of sparse's analysis of context/locking.

Fix this by changing these calls into static inline calls with
an empty body.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 include/linux/compiler_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


Hi Miguel,

Could you also take this patch in your queue?
It has already be sent twice but ignored by the other channels.

Many thanks,
-- Luc

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index aaa6f051e78e..01bc5e5ae06c 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -11,8 +11,8 @@
 # define __iomem	__attribute__((noderef, address_space(__iomem)))
 # define __percpu	__attribute__((noderef, address_space(__percpu)))
 # define __rcu		__attribute__((noderef, address_space(__rcu)))
-extern void __chk_user_ptr(const volatile void __user *);
-extern void __chk_io_ptr(const volatile void __iomem *);
+static inline void __chk_user_ptr(const volatile void __user *ptr) { }
+static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 /* context/locking */
 # define __must_hold(x)	__attribute__((context(x,1,1)))
 # define __acquires(x)	__attribute__((context(x,0,1)))

base-commit: 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
-- 
2.28.0

