Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74575300A76
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 19:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbhAVRyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729497AbhAVRsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:48:36 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6C2C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 09:47:55 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id f11so7452535ljm.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 09:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9BI9UmKtX79h66/CQZ3IJ6vmAlgkat1H+gnMZ1+LnI0=;
        b=ZX7i47LbJuaQXq6bQiKIG0XprrvIqBEewRCdU/KclPepZbN8Q8Bt2Bg0k9pRjLbccy
         Ukwn7141QK6bW8RSFCY+xd4lZaj9IkTpBDXtTxxrjgOve3se8ozgoyr+DgUhaF6PZt8a
         i0NLZhqARpo5bDPqeNGNM13idS+dZ1yzYdZe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9BI9UmKtX79h66/CQZ3IJ6vmAlgkat1H+gnMZ1+LnI0=;
        b=Yr0GtdOZXNUz69hqF4y4QsB8A0f/t+m06tUq0k8Km1F65O74JiYkAcFqNuYNfw6o3V
         Ztz4DE27jH14kI3Zk6+BGD63NvU/3KfvEWKz8A356ZkB6EnTYex6Uo2zdJBUhgbyiRz3
         cdFT6nVNZk1rAjGdPOk7h/5ubFbHqnueI03HX/KG9NfOwmwnqiUA8U2/s9CmCFSRBIg3
         ECqrRsAQjhOIx8v5PpM+nsTeJ8HrqFvzYw7mwnZV/InfEJArTte8Eov5m+H1ptG/CXZg
         7zD1DWp0QyH+/3bqtWKMj/zgdYBfSx6YU3T6ZhlK2K154hniNi5yfh9e2CJxC6TKKKSB
         JtvA==
X-Gm-Message-State: AOAM5304L0odBYzJOVaW/XShJptUQ/2Xjj8VxGizPVNWCy22BjFHq5o5
        f2UmFlcAa1ZmJA0tZrDiVZEYx4Pa0IBaSg==
X-Google-Smtp-Source: ABdhPJyh6dkRgkC/umDIu+gsuTnENLEP/s0RWSjwb0bdsGX8KC8NhphltpWfxAIFlDtqF9lBi//RBQ==
X-Received: by 2002:a2e:6c0a:: with SMTP id h10mr861306ljc.149.1611337673431;
        Fri, 22 Jan 2021 09:47:53 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id f21sm1055823ljh.18.2021.01.22.09.47.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 09:47:52 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id f11so7452381ljm.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 09:47:51 -0800 (PST)
X-Received: by 2002:a2e:9ad7:: with SMTP id p23mr908941ljj.465.1611337671368;
 Fri, 22 Jan 2021 09:47:51 -0800 (PST)
MIME-Version: 1.0
References: <20210120173612.20913-1-will@kernel.org> <20210120173612.20913-9-will@kernel.org>
 <CAKwvOd=B+tMi7-82Q8hEYnQ+BzkLDygOhMh6cQ2L+3SaL+F4tQ@mail.gmail.com>
 <CAHk-=wiOecmzTXoc6hbTmYdBCyhkmOpAHeMVXmJ_DEGgjPfZ5Q@mail.gmail.com> <20210121131101.GD22123@willie-the-truck>
In-Reply-To: <20210121131101.GD22123@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Jan 2021 09:47:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgMR1-Syn8sPpZUXQVz_dnaeWB9SpmtUVKyLdfAqMryLQ@mail.gmail.com>
Message-ID: <CAHk-=wgMR1-Syn8sPpZUXQVz_dnaeWB9SpmtUVKyLdfAqMryLQ@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] mm: Mark anonymous struct field of 'struct
 vm_fault' as 'const'
To:     Will Deacon <will@kernel.org>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 5:11 AM Will Deacon <will@kernel.org> wrote:
>
> > (It turns out that sparse gets this wrong too, so it's not just clang).
>
> Adding Luc, as hopefully that's fixable.

I had talked to Luc about this earlier, and he just sent out a fix for
sparse. It's not in the git repo yet, but it's coming.

Having looked at what sparse does, I suspect the clang behavior stems
from a similar approach to looking up unnamed struct/union members.

And the sparse fix was fairly straightforward: changing the _lookup_
is painful, because that's late and trying to fix types after-the-fact
is just not great. But just (recursively) modifying the type modifiers
at type parsing time for anonymous struct/union members is quite
straightforward, probably in clang too.

So honestly - I think the clang push-back was by somebody who thought
it would be nasty to fix, and who was thus actively trying to mis-read
the standards language.

I'm not willing to argue with compiler people who do standards
language weasel-wording (I've seen it before, my life is too short to
deal with those kinds of people), but maybe Nick is more used to deal
with clang people.

Nick - I suspect that the sparse type system model is different enough
from the clang one that the sparse patch is not really helpful as a
"look, this is how it was done in sparse, maybe clang can do something
similar", but I'll bounce it to you separately anyway just in case.
Maybe your clang knowledge means that you go "yeah, in clang that
function is called 'xyz', and we can do something very similar".

            Linus
