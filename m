Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38C02EB3C2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 20:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbhAETyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 14:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbhAETyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 14:54:49 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7570BC061795
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 11:54:08 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id l11so1359484lfg.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 11:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/uf2XQkjmS6W7PKKesbRc3QvpPXneXjuwgCuBFE/hMo=;
        b=aJRkYButiDTQqAzxp0oHMiKq3+wTDqLaHNusBBared9b+2eNkAaLlL5/R/KL3BO2RU
         YulslaZbXvbBumlCNJqnIWN3MB/9CPWNiqyvF0VokMujseO9NWic1W+fBW7Bw6xdCwLN
         rL8LCIRdmuFwxFUyVRFng9yBvPbqayX8+3zAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/uf2XQkjmS6W7PKKesbRc3QvpPXneXjuwgCuBFE/hMo=;
        b=pdJHIAzz4W4tRsI4W8rfUHRA0g8BOcbiM7s8aeoUemmcVzX7lc6MeAv4+V2V+dRPxP
         sYx1B+Zc/lW50O7clYdf5nW9k1sfYVczYnPlEPvGDltkNpbTJ+RF/ZdtLP7iJt2VynZN
         f6m1MucAyUE2juEFmFcXFIrpThfbBZNsquGJKwe3TYn6y0ua3oQsDEChXcubWvyy9noY
         QJR9q67zDivh1MHu55Ylkrt4dmDqMRHalYBBJ/3q2zS34Sgan0m3jplVoZd2PHAAV+jz
         A4dKGXBrGUnBCWBoxV/LqPbDrhi2SyLzHZr6SA3fXGYkqaP7O8AyZ3g/L8Yr7UIQSyHI
         SfBQ==
X-Gm-Message-State: AOAM530a5jVUYURVqq9/kklpQx4zJEoTUiF9TUNZtP1za0s5LQaumEf3
        PHifdUSUS0wGwEsrnqa5cJMnueQTgO/Y5Q==
X-Google-Smtp-Source: ABdhPJzeBacoFIlqUbbuSwZnwaKHOkeipA1Afxpp5M+F6lIe1btYMiGcr0xtscfO7f5svxG/GuXIGQ==
X-Received: by 2002:a19:fc1b:: with SMTP id a27mr347325lfi.349.1609876446596;
        Tue, 05 Jan 2021 11:54:06 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id h13sm16821lfj.110.2021.01.05.11.54.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 11:54:05 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id 23so1204290lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 11:54:04 -0800 (PST)
X-Received: by 2002:ac2:4987:: with SMTP id f7mr362618lfl.41.1609876444687;
 Tue, 05 Jan 2021 11:54:04 -0800 (PST)
MIME-Version: 1.0
References: <000000000000886dbd05b7ffa8db@google.com> <20210104124153.0992b1f7fd1a145e193a333f@linux-foundation.org>
 <CAHk-=wi6hd8ATJ1W90goTxjgyvuoFsf0xZdAJmZ2c0dx5wcJSg@mail.gmail.com>
 <alpine.LSU.2.11.2101041839440.3466@eggly.anvils> <CAHk-=wi36CBggdRfdggACvf2hG+djM9kKnorrwsByN6uDvPExA@mail.gmail.com>
In-Reply-To: <CAHk-=wi36CBggdRfdggACvf2hG+djM9kKnorrwsByN6uDvPExA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Jan 2021 11:53:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh=5kDGukMs2sVZ8uHZJX4VL13oD5+xMAR4HvuY6QckLg@mail.gmail.com>
Message-ID: <CAHk-=wh=5kDGukMs2sVZ8uHZJX4VL13oD5+xMAR4HvuY6QckLg@mail.gmail.com>
Subject: Re: kernel BUG at mm/page-writeback.c:LINE!
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+2fc0712f8f8b8b8fa0ef@syzkaller.appspotmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 11:31 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Jan 4, 2021 at 7:29 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > > So the one-liner of changing the "if" to "while" in
> > > wait_on_page_writeback() should get us back to what we used to do.
> >
> > I think that is the realistic way to go.
>
> Yeah, that's what I'll do.

I took your "way to go" statement as an ack, and made it all be commit
c2407cf7d22d ("mm: make wait_on_page_writeback() wait for multiple
pending writebacks").

              Linus
