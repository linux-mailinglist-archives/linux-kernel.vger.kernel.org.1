Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4692FBD70
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391512AbhASRWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:22:14 -0500
Received: from m12-14.163.com ([220.181.12.14]:54734 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391250AbhASRST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=5M7gCevfOQMHs6BMuU
        +Qtckc27R+cWeP3GBslE+aJIw=; b=e58ETah0/rEoZAB5pG0oPyMvYtrMSs5c3i
        aoMcgEfj1WDHLUlKx9k+1lcWL3eusDtWOKJNW/a/7lVmXinXZOI4xvCEX2zYRcyc
        pTRxOSvtT9Puel25YCemEDIHsF2DQRM4UA9yXywgMF+C8fF97OlsLovdCIDxjPYy
        HqXC4hj3c=
Received: from COOL-20200923LL.ccdomain.com (unknown [218.94.48.178])
        by smtp10 (Coremail) with SMTP id DsCowADX2RXxpAZgLNVGgw--.17267S2;
        Tue, 19 Jan 2021 17:23:01 +0800 (CST)
From:   chiguoqing <chi962464zy@163.com>
To:     keescook@chromium.org
Cc:     pcc@google.com, linux-kernel@vger.kernel.org,
        shaojunjun@yulong.com, zhangwen@yulong.com, chiguoqing@yulong.com,
        chiguoqing <chi962464zy@163.com>
Subject: [PATCH] signal: remove redundant quote
Date:   Tue, 19 Jan 2021 17:23:01 +0800
Message-Id: <20210119092301.25789-1-chi962464zy@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DsCowADX2RXxpAZgLNVGgw--.17267S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKryxtrWrAF4rWr15Zr17trb_yoWfXrX_u3
        WIyr18Xry8JFW0v3yftr9IqF10g3s3JrWkXFsYgr47Z3Z8uw45Gas5KFy7ArWUWan3uryf
        WF1rXr4Fg3yUWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKSoGJUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: pfklmlasuwk6r16rljoofrz/1tbiRBUfRFSIiJnAhAAAsD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If define __HAVE_ARCH_SIG_SETOPS,it will onece include string.h.
But if no define __HAVE_ARCH_SIG_SETOPS or into this code,
it will repeated references string.h
So i think we can remove this include which in __HAVE_ARCH_SIG_SETOPS.

Signed-off-by: Junjun Shao<shaojunjun@yulong.com>
---
 include/linux/signal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index 205526c4003a..c371d3a3ff61 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -124,7 +124,6 @@ static inline int sigequalsets(const sigset_t *set1, const sigset_t *set2)
 #define sigmask(sig)	(1UL << ((sig) - 1))
 
 #ifndef __HAVE_ARCH_SIG_SETOPS
-#include <linux/string.h>
 
 #define _SIG_SET_BINOP(name, op)					\
 static inline void name(sigset_t *r, const sigset_t *a, const sigset_t *b) \
-- 
2.17.1


