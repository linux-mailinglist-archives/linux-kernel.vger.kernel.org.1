Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CE826AC1A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgIOSgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbgIOSg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 14:36:28 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A319C061788
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:36:27 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id q8so4182656lfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2zoHbkMZFFhAGDLD6+oRaQAq0ZiYfkwGQ2rEJMY8yX0=;
        b=f1T9mNnu6S7dphLok7aD+ocpHnqQmx7NNA4OT7K8lwQBOq9Xw1nXpHsEd1Dk3wFWJB
         54MeFRG6bYhxz2+mBnevnCkrNt7WaN0r85esfwMhDLdkpbP7TSVT6+1YqLtIKRtHLhNH
         nPbQEGok1fA0j7AygUwMDGUHt3GRZIZ7lIxTWdVu+wxvvcsVoUmV7P9hBIcGQTY7mdvv
         eEs9z432gLG8QWQ2TRp0Lm3x/IcE7/Rz8XJzh0et9cLYjEm7etRjLEkSFfXwwG0weRBJ
         7gcEdYRVj5pyDc/uvU5rErejQqgiwa5I7FsjPnUx+HC9+M7LTAYZJZjqYSLdwDRN4M7T
         5ETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zoHbkMZFFhAGDLD6+oRaQAq0ZiYfkwGQ2rEJMY8yX0=;
        b=gw6Jq0OK9cURfdivYqqtVMjHFq4I9M84j9EjwZDtIpgqY04OVfVfnPFDveQA3vqgH4
         jyt3yFukPUjekwPwxdM9WcxMT39EuES/lmKrHlC3+rn7hhbh6ArOqtwgG0dS2UTSdQ4V
         1sWe0Patm86DjHtlXY229L++40AJLgc9EZXq0Ltlm9L2wkN95AAP+LkZmfUG0PmLJMTb
         vq5fbf1lfuhnf+oZbbx1xbWaFzsmgXmE/DnQNon0m3w87UuL/yj4l4UPYDQ5eH6Bv/cB
         pgaw5XhDAvl5UXIuAAyopU9aR7bmTwA9NoqcZ/rU1RtHDPvSg7VkwwZIYZvqI4VuYqoL
         d9Dg==
X-Gm-Message-State: AOAM5325+rpzNt2bMEErthNiKjRDBTZAuq7LcwMJsv184mrrIP7cNX9N
        jJUz4gxR8a/P4Zsq/RAyuUws/oCzl39exnf6B7JboA==
X-Google-Smtp-Source: ABdhPJxPRpIb3Z3FDCHy2rc8ihRoSisSIyjn1j13LORsg2VWCauuLLlokK2U412Qi098EJrS+PhYXwW9R7T3BkqZ724=
X-Received: by 2002:ac2:511c:: with SMTP id q28mr6128023lfb.411.1600194985320;
 Tue, 15 Sep 2020 11:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200915172658.1432732-1-rkir@google.com> <20200915174643.GT14436@zn.tnic>
 <CAOGAQepp_1QXrNAAXbLpW8qrujfdszfU2rMoh804wKK-Ja66Yw@mail.gmail.com> <20200915182730.GW14436@zn.tnic>
In-Reply-To: <20200915182730.GW14436@zn.tnic>
From:   Roman Kiryanov <rkir@google.com>
Date:   Tue, 15 Sep 2020 11:36:13 -0700
Message-ID: <CAOGAQeqhKS48Kd8W4y13ATT3m+nJSksF_U1SJ=SBrOZFrDq9Nw@mail.gmail.com>
Subject: Re: [PATCH] arch: x86: power: cpu: init %gs before
 __restore_processor_state (clang)
To:     Borislav Petkov <bp@alien8.de>
Cc:     rjw@rjwysocki.net, pavel@ucw.cz,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alistair Delva <adelva@google.com>,
        Haitao Shan <hshan@google.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:27 AM Borislav Petkov <bp@alien8.de> wrote:
> > I believe the kernel makes a questionable assumption on how clang
> > uses registers (gs will not be used if stack protection is disabled).
> > Both kernel and clang behaves unfortunate here.
>
> If the kernel is at fault here and this same thing happens with GCC,
> sure, but this is a clang-specific fix.

This is fair. Unfortunately I am not an x86 asm expert. I expect the proper
fix should land into arch/x86/kernel/acpi/wakeup_64.S to init %gs
(maybe some more registers) before "jmp restore_processor_state".

Regards,
Roman.
