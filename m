Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786AF2E6C86
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgL1X30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 18:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbgL1X3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 18:29:24 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BD9C061796
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 15:28:43 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id l11so27329156lfg.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 15:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XYFP2ulc60ot4/NC1efgeH0hQlOhvsC8IPEDkooBvEs=;
        b=PnzaIY0WevdN1LX4x77XkAqdCbHnILaK8s5lgAa0OpFX4yGYQetICtSErEbnRqJyF2
         df1IdnigAMWBVb78TsJfEZX+2u+q70jwsNoCzYhAOeHQSolJsz4xefb3lBQb/IMqWPfX
         LLsh+emoPQ9elejcOAXkRap3sj2sF/7th9mgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XYFP2ulc60ot4/NC1efgeH0hQlOhvsC8IPEDkooBvEs=;
        b=CTUJlicA9aEtteiDy5vX07rWfBq/UB4ZlMzONJnvGQVQP5+V637vbeoPxKxs+z3cKX
         iLtrY28CbkC+Meq5JTY3sABoCRW4SMrFBQJvHVyYaEnCsN7vGDaOobr1XX1cfEHXJ9IL
         luUx78mgixq4enW+UdE+J4tw6ewkxDivkEiZ29lOWzBQWqFy3IljbPDf9siKsFrbjc+o
         QUQZ/v/hX5EPNgND8nKr0fnW5KsGk98UNqwXrkp+9XlB/xweXFyEUUXbD14yJpOVMH9m
         a0hlhbtQtsNZGb6/AJAqoN6vjaqT+F+GyztsncWkHn17g6Zszaj1c1yLcVQJPOASXHA+
         RQSA==
X-Gm-Message-State: AOAM531kBqdvl93CMHMsHQGhzl17I4XdNl9OM7x3pEMkJ+evhOOJIInR
        EtH34O1wNyhCT2IPlbwr79Mvk4YFVwGEOQ==
X-Google-Smtp-Source: ABdhPJzLozDg2YWxfLPoq2hIwwnTJfIY59S3f1wl3bMd/c//WISrvoT5F4qF0rGRmblPYfoVDy+xHQ==
X-Received: by 2002:a2e:98ca:: with SMTP id s10mr21664506ljj.417.1609198122248;
        Mon, 28 Dec 2020 15:28:42 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id g13sm5461457lfb.43.2020.12.28.15.28.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Dec 2020 15:28:40 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id 23so27198154lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 15:28:40 -0800 (PST)
X-Received: by 2002:a2e:6f17:: with SMTP id k23mr23942779ljc.411.1609198119916;
 Mon, 28 Dec 2020 15:28:39 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjesveWEQZ4tqRssSSQvuxx46LqYfME+uxKfghxAe6U_w@mail.gmail.com>
 <20201226224016.dxjmordcfj75xgte@box> <alpine.LSU.2.11.2012261623140.1022@eggly.anvils>
 <alpine.LSU.2.11.2012261816520.1071@eggly.anvils> <CAHk-=wjHvipz5DqWUFP5zuPK-kWM4QD-eokf75V8NGNATnn+BQ@mail.gmail.com>
 <20201227234853.5mjyxcybucts3kbq@box> <CAHk-=wiVrd4R2EVGCGtmybt6+u9LoGgMdnf12zc=sYL=QbvRWQ@mail.gmail.com>
 <alpine.LSU.2.11.2012272233170.24487@eggly.anvils> <20201228125352.phnj2x2ci3kwfld5@box>
 <CAHk-=wg4bzJ9ugrOp7DBoMjNpHechm4QWb0-HC3A_pN564RU5A@mail.gmail.com> <20201228220548.57hl32mmrvvefj6q@box>
In-Reply-To: <20201228220548.57hl32mmrvvefj6q@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Dec 2020 15:28:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjquk=AxcbqA0UapYsHipa+myB4ayhttm6-Rb1Q5prKMw@mail.gmail.com>
Message-ID: <CAHk-=wjquk=AxcbqA0UapYsHipa+myB4ayhttm6-Rb1Q5prKMw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries when prefaulting
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 2:05 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
>
> But I *think* we should be fine here: do_fault_around() limits start_pgoff
> and end_pgoff to stay within the page table.

Yeah, but I was thinking it would then update ->pte to just past the edge.

But looking at that logic, you're right - it will update ->pte and
->address only just before installing the pte, so it will never go
_to_ the edge, it will always stay inside.

So scratch my suspicion. It looked promising mainly because that ->pte
pointer update was one of the things that changed when you instead
compared against the address.

         Linus
