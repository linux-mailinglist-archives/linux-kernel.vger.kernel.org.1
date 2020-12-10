Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD0A2D5C0C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 14:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389557AbgLJNiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 08:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389450AbgLJNfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 08:35:38 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4008C061794
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 05:34:57 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id 4so2774945plk.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 05:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jRaoY3l4sn+gFv9tuxtAOcZu8uN2SZx2b/9rieqqeRk=;
        b=kxK5Ei7ZoihlUR+znIRWS5gS68sI/ms87hjk369Wk5IIp4rlMUCARiQEeMci/vu/sb
         jkFQUxRS9QibsFzo02Y4phhKBI+xMI6wJYSzeIv0xs3lIjysPEIUbb19fZYfLr2rGsvi
         /h1kQmkXVcyJpk2sMeUPVqZWrEjP0puRrYniLKjsDN1dQINNCqjrTdrs2Mpa/jsPwbZB
         Ze9Jw0MXMPL5m6zEeJDF+osoypgc7w3LRs/a6nweJ1Eh6BQS0iMIUSrTchuDKysKBEL9
         1s6RHAu6d3iHRlPjmmQADRp73kKjA0qDzeba+1tZMCfTxVQUsSpQ5nVhVjP6iq09jvPg
         E5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jRaoY3l4sn+gFv9tuxtAOcZu8uN2SZx2b/9rieqqeRk=;
        b=WO140AnQAp/E43HdW91sHwwLXWxnvKQJitxDD/OgH5fUCGVMFk69hNcKbwZN7BbTNg
         /iE5nuego9CM6Bhq3ABfyTitYp5rCrF8Bgyx7fcQzkb1DCT2xWQrZ4I71XPcckKhVDd2
         hHIJJGwL5Lxh3ydW5jVH5hx1E2h96ZYKygjvjWPFGyNQu0OClNVfqnC58FQ9uaHOaDfq
         be/AyY8sjGBWjOvXEYykmFuaP/w/7tBgZm14X3yu6Zwg33hblbjQL4YIEGLf8MTiWZmj
         TrvZXL4LRGHVtYBcRBJwJDC1qwB/ie7wDAjZMWZitKoUyNiuEc1Y8FlTrSyPIzwWI295
         y0lQ==
X-Gm-Message-State: AOAM531iNACy2CLIoj9Z+X9E2UcPvCK2EJyXgMT7RFYdxdirtJSOI2jP
        jih2fwu1nY11ToAi7jSnl//kGdIvq2s=
X-Google-Smtp-Source: ABdhPJy2PZEUhVgeSuRpUGxFnar5kYmJVU65LKjHW7e+FFsNf72uag1hkV5WHs4G3jVuUndUB65Ghg==
X-Received: by 2002:a17:902:a70a:b029:da:1911:4285 with SMTP id w10-20020a170902a70ab02900da19114285mr6690357plq.44.1607607297175;
        Thu, 10 Dec 2020 05:34:57 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id v125sm3810048pgv.6.2020.12.10.05.34.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 05:34:56 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 2/3] x86/mm/pti: issue warning when mapping large pmd beyond specifid range
Date:   Thu, 10 Dec 2020 22:35:25 +0800
Message-Id: <20201210143527.2398-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201210143527.2398-1-jiangshanlai@gmail.com>
References: <0766416e-bab5-c8e7-9466-a72e965fdb8a@intel.com>
 <20201210143527.2398-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

When PTI_CLONE_PTE, the caller doesn't want to expose pages beyond specifid
range and it worths a warning.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/mm/pti.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 7ee99ef13a99..cd6da1d42ba9 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -356,6 +356,13 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
 			 * caller, so we just simply align it here.
 			 */
 			addr = round_down(addr, PMD_SIZE);
+			/*
+			 * Mapping large pmd beyond [start, end) may expose
+			 * secrets to user-space when it wants to clone ptes
+			 * only.
+			 */
+			WARN_ON_ONCE(level == PTI_CLONE_PTE &&
+				     (addr < start || end < addr + PMD_SIZE));
 
 			target_pmd = pti_user_pagetable_walk_pmd(addr);
 			if (WARN_ON(!target_pmd))
-- 
2.19.1.6.gb485710b

