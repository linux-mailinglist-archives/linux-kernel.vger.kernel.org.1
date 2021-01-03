Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9792E8A15
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 04:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbhACDJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jan 2021 22:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbhACDJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 22:09:18 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52274C061573
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jan 2021 19:08:38 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b5so8339678pjk.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jan 2021 19:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MPFL5H9ZSVilaIsjC1NaXD0wkAu+/ivoFybzBOXrt1Q=;
        b=bdXaJyq9jjG91N0oU5j26ZdioUt/s/Td0bzl6bUbj52ou5yDywZ9hFCTn1HoM+KC/4
         9EzJ6m5B4Cd+NK90VtD8WFo6LfERg+x7Ikcj+6TnCYK+VP1eUtIHZAUfC+8dCKMvJx2l
         eoEe0b1CzhoHHyYSeXZPpFK5FJV13NDFveZYSz0Rhn5znMnLIpiiZrzwm2IOgXy40Bhs
         CWACUihfWL0RUKhHm4NDcmpmZprInO9E1kS3Bfel/mEWonfHGyFHWILYXEVVd51xkQpF
         j5t0MqcwBvuvkUUilRWgeJwUoA61LCBGfrwqQks3JkEcVq1xq8wwRxheBP3V05+xS749
         XjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MPFL5H9ZSVilaIsjC1NaXD0wkAu+/ivoFybzBOXrt1Q=;
        b=APYFyHXtHKBeES/hzV+K+Cd3bS09jgnWKa+FGsIz89WcfE1GD92fDgcEACwSW0RI5M
         6FVqP62TCEQUKe606iiWBjbgU1RVMo+d6/97/SKAIrbgkYUdYmwqIc44z+mXPGrTF9AL
         3iFC9G30fyyNAPoXVPsiblpLqpcw5y8F+UCJnhV50DW0UN5jvqXG0/EZwQ8/0ldcMNyK
         xEahaPxZsvRKC8zS7BKo+HtCjG5Vecp+2n1TWen/imdmCWei5SFk+th/AvRR3XdQs/gJ
         zVW79JNm/3mgna7SFLVSmBH3/NDKc6gk3dNDlnEMuyq3WE7OuPxGIJWtGr9pVxOE4bks
         acIg==
X-Gm-Message-State: AOAM530F+kAjys4p210gFSKRVgVC8VgzLqAyDVx/oPc37cHqERN/6/Ra
        BjaydgK5lpeN0vBy61Dnt3o=
X-Google-Smtp-Source: ABdhPJxmFPzG8YfwLBpnABwecIW4Gs2carG706Epep2PQmxx7jOMkViaQ5y0oQhzUJONWVpQnBvpGQ==
X-Received: by 2002:a17:902:d893:b029:da:72d4:8343 with SMTP id b19-20020a170902d893b02900da72d48343mr39594669plz.84.1609643317872;
        Sat, 02 Jan 2021 19:08:37 -0800 (PST)
Received: from haolee.github.io ([2600:3c01::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id c3sm49191144pfi.135.2021.01.02.19.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jan 2021 19:08:37 -0800 (PST)
Date:   Sun, 3 Jan 2021 03:08:34 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, alexandre.chartre@oracle.com,
        linux-kernel@vger.kernel.org, haolee.swjtu@gmail.com
Subject: [PATCH] x86/entry: Remove deprecated do_IRQ declaration
Message-ID: <20210103030834.GA15432@haolee.github.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_IRQ has been replaced by common_interrupt in
commit fa5e5c409213 ("x86/entry: Use idtentry for interrupts")

Remove its declaration.

Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
---
 arch/x86/include/asm/irq.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index 528c8a71fe7f..76d389691b5b 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -40,8 +40,6 @@ extern void native_init_IRQ(void);
 
 extern void __handle_irq(struct irq_desc *desc, struct pt_regs *regs);
 
-extern __visible void do_IRQ(struct pt_regs *regs, unsigned long vector);
-
 extern void init_ISA_irqs(void);
 
 extern void __init init_IRQ(void);
-- 
2.24.1

