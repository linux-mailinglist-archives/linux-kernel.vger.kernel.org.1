Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C6328E9CD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgJOBTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388188AbgJOBTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:19:38 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D39BC05BD38
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 15:51:21 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f29so1158910ljo.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 15:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r6oBIo6NMPMfLWaK5KgxYK4Ufg4k2ubTwgmyCFt3P0g=;
        b=NGV+3tygGODZy3py0l471EDO3cAhaCKm/0oH+GnoAnl8uVT08bj08gcxgVjtxWV8Tq
         Bed7WTMDPptLmWYRwNNDJfe+ozsotmCMfsUYGxxJdsub/va6psKbBlDpWECbhy12PwLh
         i1CkPu58C5kDeyvD9pLBgOx+0mzgUNJvq+gN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6oBIo6NMPMfLWaK5KgxYK4Ufg4k2ubTwgmyCFt3P0g=;
        b=Ld27BLJNlkE/Bnli6ekYW1W5Ln4LImhY3MRwgARaLTH7U41DIm19dktSBj0t4AZfsS
         s+9SI6Mp6EivDVZq1VdPnw2YmDuFN4tSar+RNo16bThyeB7vcOHmJisWH6mAtzswcPo9
         THvsqM4UbtIshOVZEt5YHo+PtvWK9/KYmO5v+2fUkHs6ilBIHuX8dopgA5huUal3FTGt
         UURAAT2TiC51isJSwT8l4R18bwgWY1rvTh7M59z//TNtrFa6R7lzEzCmHeLeUCQ+d1Ts
         aeeSWhMqHcxYgLuHu7+ISdwxVkxyiz+rJo0OPD3RDr3Hz7YgQMwWIpIsNBKWOpVO8Gb0
         1bHA==
X-Gm-Message-State: AOAM531j9bio1ebgEuppJFiyrCAhzgYrvv35WURvVKanXyV+SMr7WOxG
        WTse4xVN9bcSHQscUX9Ew8CKw0PvxWT+/A==
X-Google-Smtp-Source: ABdhPJzGSsP/9abZXDoEK88uiavtYHzudsd2dBBDIhH0RsivXc78NpUDC4Kip3icLeEaUqMlqeOhxw==
X-Received: by 2002:a2e:b8d0:: with SMTP id s16mr144552ljp.365.1602715879250;
        Wed, 14 Oct 2020 15:51:19 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id s16sm257218lfp.217.2020.10.14.15.51.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 15:51:17 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id h20so1111469lji.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 15:51:17 -0700 (PDT)
X-Received: by 2002:a2e:8815:: with SMTP id x21mr156315ljh.312.1602715877030;
 Wed, 14 Oct 2020 15:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200724012512.GK2786714@ZenIV.linux.org.uk> <20200724012546.302155-1-viro@ZenIV.linux.org.uk>
 <20200724012546.302155-20-viro@ZenIV.linux.org.uk> <20201014222650.GA390346@zx2c4.com>
In-Reply-To: <20201014222650.GA390346@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Oct 2020 15:51:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgTrpV=mT_EZF1BbWxqezrFJRJcaDtuM58qXMXk9=iaZA@mail.gmail.com>
Message-ID: <CAHk-=wgTrpV=mT_EZF1BbWxqezrFJRJcaDtuM58qXMXk9=iaZA@mail.gmail.com>
Subject: Re: [PATCH v2 20/20] ppc: propagate the calling conventions change
 down to csum_partial_copy_generic()
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 3:27 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> This patch is causing crashes in WireGuard's CI over at
> https://www.wireguard.com/build-status/ . Apparently sending a simple
> network packet winds up triggering refcount_t's warn-on-saturate code. I

Ouch.

The C parts look fairly straightforward, and I don't see how they
could cause that odd refcount issue.

So I assume it's the low-level asm code conversion that is buggy. And
it's apparently the 32-bit conversion, since your ppc64 status looks
fine.

I think it's this instruction:

        addi    r1,r1,16

that should be removed from the function exit, because Al removed the

-       stwu    r1,-16(r1)

on function entry.

So I think you end up with a corrupt stack pointer and basically
random behavior.

Mind trying that? (This is obviously all in
arch/powerpc/lib/checksum_32.S, the csum_partial_copy_generic()
function).

               Linus
