Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBA72C7FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 09:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgK3IVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 03:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgK3IVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 03:21:40 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0433AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 00:21:00 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id f190so20414544wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 00:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LsButuHFAqy+OskYL0jzAl5KW1Dckt4dG1CLIfV9Upk=;
        b=OkxnoyEMLuvHqGcegIUZFOiKoveic7OUkMbqUILxx4SYxmIVB75XWby8PJbSAyGxPU
         CSOr54HH4xLHUaUPKo/IunfF5r+m9tDwUq1g/nWN+F2MS0CIpe6TjmiODReCBhRvG5gQ
         0svQ+Ry7W/iina6anhc+lHkCDmF6+RXzcNAPnG2cTlDGMOPhmI+TlOlfLzFEsNxjkybc
         x5LNsl4YJI+Zm5xvMByijiUVKG7ObURRm6Z+4ehQEHNIkfuf/b3cUxZ5mPeHvbQ27mpz
         SRD1w6IJB1bQXN15u7PMPVk+P8YsyGqa5sZziZX74s6EI3PmejAdJ1Tf2CzB5HbELeNL
         1E5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LsButuHFAqy+OskYL0jzAl5KW1Dckt4dG1CLIfV9Upk=;
        b=rHFHXd5B2837yZ1kZiJAhNrqGdtgUwj9aXdgFOmZdLo6H7gFtRP9exJDDxVFJsRBOS
         yHoX36a+RSyA1gePqHNOO7xUJMIysFj0bJ0n5pAJu/G8Y6uVTe4R9y1plj7Yg+zWiI23
         a6ELlGuK5EdTJn7t+IGcwXF6rM7DOGxiU51LzVSXK3pucmIuzOVbgXkbZqmNPGSqzErQ
         wpwCQGqYSFnSOWojDiouGCd9AdjBkvGY/DQz6ROnFS+7uRDfntMG5pXz5BI/PjueQmqO
         /B2Ob9G1nv7TGKn2WgFVUQ4kNo6DFgV/LtDNnI/s/2KHempRpbsNVsumbCoQAOZ4mr5f
         fwnA==
X-Gm-Message-State: AOAM531/QAB/wh9DehwN+nefczGt6PA6GuWIel7QdLGbs96N8TUz8jy+
        EeuogdJLjniSLcrzAy6ixhM=
X-Google-Smtp-Source: ABdhPJw/7z1HciIsdbptb3bMN7e1HWonB9acEvSEe03DvjIjw6KldmtK6STDUqWSKBxdsbW9M3nOVw==
X-Received: by 2002:a1c:2d84:: with SMTP id t126mr21608418wmt.132.1606724458643;
        Mon, 30 Nov 2020 00:20:58 -0800 (PST)
Received: from penyung-VirtualBox (60-250-204-170.HINET-IP.hinet.net. [60.250.204.170])
        by smtp.gmail.com with ESMTPSA id b14sm25852005wrq.47.2020.11.30.00.20.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 00:20:57 -0800 (PST)
Date:   Mon, 30 Nov 2020 16:20:32 +0800
From:   Antony Yu <swpenim@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        swpenim@gmail.com
Subject: [PATCH v2] ARM: fix __div64_32() error when compiling with clang
Message-ID: <20201130082032.GA25739@penyung-VirtualBox>
References: <20201123073634.6854-1-swpenim@gmail.com>
 <20201123181602.GA2637357@ubuntu-m3-large-x86>
 <20201124074211.GA26157@penyung-VirtualBox>
 <CAC5oF3W+RkcO-dSiKXGxVvhBGb0n7fQ-KvdjbPNJJVadv6qNBw@mail.gmail.com>
 <CAKwvOdkE5-OBWjmGwc8qUkj5wuqZTmtYxaMD3sz+4+aNiC2vLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="v2-0001-ARM-fix-__div64_32-error-when-compiling-with-clan.patch"
In-Reply-To: <CAKwvOdkE5-OBWjmGwc8qUkj5wuqZTmtYxaMD3sz+4+aNiC2vLg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 3a4c19e09079324a625941ea3c16fe4b0df2ed86 Mon Sep 17 00:00:00 2001
From: Antony Yu <swpenim@gmail.com>
Date: Mon, 9 Nov 2020 17:31:52 +0800
Subject: [PATCH v2] ARM: fix __div64_32() error when compiling with clang

__do_div64 clobbers the input register r0 in little endian system.
According to the inline assembly document, if an input operand is
modified, it should be tied to a output operand. This patch can
prevent compilers from reusing r0 register after asm statements.

Signed-off-by: Antony Yu <swpenim@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
---
changed in v2
- add kernel-test-robot tag
- fix build failure on big endian

 arch/arm/include/asm/div64.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
index 898e9c78a7e7..961a129eb41f 100644
--- a/arch/arm/include/asm/div64.h
+++ b/arch/arm/include/asm/div64.h
@@ -39,9 +39,10 @@ static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
 	asm(	__asmeq("%0", __xh)
 		__asmeq("%1", "r2")
 		__asmeq("%2", "r0")
-		__asmeq("%3", "r4")
+		__asmeq("%3", "r0")
+		__asmeq("%4", "r4")
 		"bl	__do_div64"
-		: "=r" (__rem), "=r" (__res)
+		: "=r" (__rem), "=r" (__res), "=r" (__xl)
 		: "r" (__n), "r" (__base)
 		: "ip", "lr", "cc");
 	*n = __res;
-- 
2.29.0

