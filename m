Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5312DF8DA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 06:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgLUFi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 00:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgLUFiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 00:38:25 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972BCC0613D3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 21:37:44 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id lt17so11756585ejb.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 21:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M+U0IAqwLz7ytlX+iBmXFuWL176+VMtz6rn8QLAwPlw=;
        b=Kaxnil6FIh77xY6+KndaNjpSZKY6BhBkwTMURgaGjNx+/l3W124clImHUD/WHBCm9N
         0xj5Tv8Em/uotTEplknMwxp1eva4UNHgMjyxui/wMOfjmFU7mFVopQ7H929c/oyQ32pO
         ynnn1CnHFLJcxFSgmjmwEDaYDmR+3ncbROlS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M+U0IAqwLz7ytlX+iBmXFuWL176+VMtz6rn8QLAwPlw=;
        b=qanJkzaIgPJUey6LVI0yHSm46mKvF6uN7E4BtMHdnnFyOeYXxj8PNjoIeAblThV88D
         rXixcaIdtVtdYer7UivL4QvpPaGNmt5UcwDRu2IoDtYwNZPxahp7Mpq7Q6k5Sw/94Iv6
         m0dx/RG+7qrgTMq9ReNAPNTkxISjF1QIDuR24Qamn+ydZ3inVvbV7BGmcPe3gNcoa/WP
         4FRcMkw4EWF/Ng1Avbm+hbGWMuti7Mwf9mYbk0dRThQ/idOeMI70/7sm36nuideFZv8v
         bbzWyJbgCaSDpCqsI90NrgqQj2dEMCD0oaX5Ztx/+iLf6p3s/MfrbmTwynjQvXSuSQQH
         x26g==
X-Gm-Message-State: AOAM530KbemebkvO6Xhup3L423+lu4QCfU8/Dx1U/7R1XCW1NGjAAADa
        L05utBTU2rCciWS6qsiZx6QWAwmNQ4pOtQ==
X-Google-Smtp-Source: ABdhPJx+u5igVaPH69ifjZhRHHw1uIQ7EjQkiDQUO1jpIDg30meEIlyFziceRrKkV3hfUNPh4QrWfw==
X-Received: by 2002:a2e:b4a7:: with SMTP id q7mr39863ljm.391.1608490700343;
        Sun, 20 Dec 2020 10:58:20 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id m16sm1738776lfb.248.2020.12.20.10.58.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Dec 2020 10:58:20 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id o13so18547812lfr.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 10:58:19 -0800 (PST)
X-Received: by 2002:a05:6512:789:: with SMTP id x9mr4935640lfr.487.1608490329100;
 Sun, 20 Dec 2020 10:52:09 -0800 (PST)
MIME-Version: 1.0
References: <20201220095830.17843-1-hca@linux.ibm.com> <CAK8P3a1NPMbKnuZ7-b0qbVVtLHT2YG6eEtzKUOf4AZkcu5VO4g@mail.gmail.com>
 <CA+FuTSeKfSouk7SV0cfuZ122J3fAc_ddy_a9unyCRq4F7f6+pw@mail.gmail.com>
In-Reply-To: <CA+FuTSeKfSouk7SV0cfuZ122J3fAc_ddy_a9unyCRq4F7f6+pw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Dec 2020 10:51:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjXFfeCHdhAwH8ciXhMJwAc3dOnCAug4G8=eb=+zFnkTQ@mail.gmail.com>
Message-ID: <CAHk-=wjXFfeCHdhAwH8ciXhMJwAc3dOnCAug4G8=eb=+zFnkTQ@mail.gmail.com>
Subject: Re: [PATCH] epoll: fix compat syscall wire up of epoll_pwait2
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Anvin <hpa@zytor.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 20, 2020 at 10:22 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Slightly tangential, it's not immediately clear to me why in
> arch/x86/entry/syscalls/syscall_32.tbl epoll_pwait does not need a
> compat entry, unlike on other architectures and unlike signalfd.

Hmm. Good question. That looks like a bug to me. Probably nobody
noticed because it's so rarely used.

Or maybe I'm missing something too.

Adding x86 entry code people to the participants.

             Linus
