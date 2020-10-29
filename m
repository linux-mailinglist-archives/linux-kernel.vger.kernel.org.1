Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E32E29E49F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbgJ2HkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgJ2HYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD098C08E81A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 23:51:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b25so1750626ybj.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 23:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=D0RG6XCsiYk3Hov12UB1Ls79tsmNIPNALmBWI6I8Qe0=;
        b=qh8nc7inquFnCZ1Gl+JJNsIMjS5CH78e+QQXwZNY+cPKUHEiXtycFZ0CFtimd8zYCG
         Amr92TjpnzexbaTLGJft6X2m4Nuwr+fWmwBS0URNtMy6WUz0iS6epHvM/4LP1fLoRRAH
         33kdoDqgQQneOIDrhKCztqDz0revwKmhBAm37QdYLaClLZhrD/9Qxi1YSWS7U85J/kbJ
         V6duXsFjEeTyc36s+8tRF00xM/Y3/M9XkTGr9BPhdw0WFZdWUsGZyI2diFfRel48fLPE
         0U0JHOnqT+XNWleskOVhe299dCMDba1YWTiuuiSRYE4AVqipNk/OFSKpMH6f5BVkzrZw
         QR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=D0RG6XCsiYk3Hov12UB1Ls79tsmNIPNALmBWI6I8Qe0=;
        b=VnTT79QruQ1MQIIsktryutdKrZ8FUnvF/0VXLOtW0Mo+Go7UsifbsQgjhWGnCAh6Qq
         1yv/obsFiGaiDaFJI3wI6wxt/N4m+AN5ifIrY5RPX4Z8q2suUcqJV4bB+Ay29cmFZrfR
         dSRi72RsIzolPfnWe1+868xCcpHcotey95ZPzyXX1JymwbiDGwtBggRL4uc8zE0F2WPi
         C5dSzjQQAAmQzjNzug9b0WVyxhsLr2fY5WbDc/Z9bGXdkIV2b0DEzvxLehEQ3UW7ab0q
         GepqUVQ4564qBIwrRO+FbGZTlLKFCsZXQpC6OUOpDrBydCJ1Yz0g+SvBHWpHFxa3YeW5
         dIjw==
X-Gm-Message-State: AOAM530MtdJeLxQbM12LWDwozqa86mkJXqrE1J2QuPL2i0B8MeD1G/EU
        FVpitP6fIdQ8SZPqVROkOQzeGyizRzhZ
X-Google-Smtp-Source: ABdhPJxzuEjf17OjMyjcerT0OVNp3Fze7scKYjqqY3Xi0KJmZn6k1DUOW2Ko52bR0DHoDFZKL8BVXe92Bmei
Sender: "amistry via sendgmr" <amistry@nandos.syd.corp.google.com>
X-Received: from nandos.syd.corp.google.com ([2401:fa00:9:14:725a:fff:fe46:72ab])
 (user=amistry job=sendgmr) by 2002:a5b:e89:: with SMTP id z9mr3926538ybr.44.1603954313929;
 Wed, 28 Oct 2020 23:51:53 -0700 (PDT)
Date:   Thu, 29 Oct 2020 17:51:32 +1100
Message-Id: <20201029065133.3027749-1-amistry@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 0/1] x86/speculation: Allow IBPB to be conditionally enabled
 on CPUs with always-on STIBP
From:   Anand K Mistry <amistry@google.com>
To:     x86@kernel.org, linux-kernel@kernel.org
Cc:     Thomas.Lendacky@amd.com, joelaf@google.com,
        asteinhauser@google.com, tglx@linutronix.de,
        Anand K Mistry <amistry@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When attempting to do some performance testing of IBPB on and AMD
platform, I noticed the IBPB instruction was never being issued, even
though it was conditionally on and various seccomp protected processes
were force enabling it. Turns out, on those AMD CPUs, STIBP is set to
always-on and this was causing an early-out on the prctl() which turns
off IB speculation. Here is my attempt to fix it.

I'm hoping someone that understands this better than me can explain why
I'm wrong.


Anand K Mistry (1):
  x86/speculation: Allow IBPB to be conditionally enabled on CPUs with
    always-on STIBP

 arch/x86/kernel/cpu/bugs.c | 41 +++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 18 deletions(-)

-- 
2.29.1.341.ge80a0c044ae-goog

