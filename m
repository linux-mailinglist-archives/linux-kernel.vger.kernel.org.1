Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1E426C895
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgIPSxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbgIPSIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:08:49 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4559FC0086CF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 06:40:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z9so3103834wmk.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uEjVdCuhEoV9lb5ls6kMmq0ECr43Rh1pbVRxVP/xc0E=;
        b=PUU8fv2nYs0tjxbo5vnP2us18PfVb1Xunkump0q2oq1WUGUGx/Lcgus2dW8plEctBu
         Qs795uckGKFqlBwaeJHxNgTa+zHUOIdMlaH3B20/ByLXLBl1QewIY26uQl3s6wxgl40X
         y7Sl4VoAKpf9y+O370S6csA9+tABN6AXQ9HcHeTZqbP97j+ZCcAFKfcYEXVp30f3T7oT
         AKvU83SX8xyIW8vmTdkzt38dQ3ZZvj9WB+i6K2xhG2tMsoEdmckLp5IrXXlCBCOLWG47
         PpIwBYRZreCvfOOlJ031bSRstEvlHX/qqXpdEFTM3AnwGbd4Y0lA6o8uLVziWP/yTVL3
         MYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uEjVdCuhEoV9lb5ls6kMmq0ECr43Rh1pbVRxVP/xc0E=;
        b=dpjAJVMe+qkNgc6Q+MqZKKUmxrfVbt2ewbEwBdLvwhlsVWUsZ4CrF1t2SwfPBD1QhQ
         LSXcARBVrcSzmZPhewIJ8KlkBRqSrMafzgmk88ByfshQ1NKfQvnxgiA2U3/0/FKg8/q+
         RflRM4MWdgWNylkFYHaAmzn9RCv7gfEosGW0EFq5EI8pCIlFZXK0sVICzNCObwh0njR6
         YGDAJmm9z4hTEk31RvK0YWJTs3zLDOabMi8vvrxAjKdc1gHWi24jXBrHA/TM57HGfuPS
         4EYKZMvLm/4s7H1jdHSP1JgEzjQL87GZQzuHHSX8F3whe/4WV7uULQfz2VqICoi891kp
         AZrg==
X-Gm-Message-State: AOAM532HMbcVq5tTls1ltS+ocrPTKKcnVlfkh+Xn+R3nYpPDVLYJQa7Z
        gkDPrNyljc3Ip61VqNUEzVgObQ==
X-Google-Smtp-Source: ABdhPJwkYqBdHOlcj/6E3C/Hg3AY0p7Pq+MV0hPCUD7Q9dFfXQXlMg4ViJJ/8esSCNDeaapoa/urtw==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr5048312wmi.55.1600263636710;
        Wed, 16 Sep 2020 06:40:36 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id o16sm31108612wrp.52.2020.09.16.06.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 06:40:35 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:40:29 +0200
From:   Marco Elver <elver@google.com>
To:     George Popescu <georgepope@google.com>
Cc:     Kees Cook <keescook@chromium.org>, maz@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu, LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Brazdil <dbrazdil@google.com>, broonie@kernel.org,
        Fangrui Song <maskray@google.com>,
        Andrew Scull <ascull@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, kasan-dev@googlegroups.com,
        andreyknvl@google.com, glider@google.com
Subject: Re: [PATCH 06/14] Fix CFLAGS for UBSAN_BOUNDS on Clang
Message-ID: <20200916134029.GA1146904@elver.google.com>
References: <20200914172750.852684-1-georgepope@google.com>
 <20200914172750.852684-7-georgepope@google.com>
 <202009141509.CDDC8C8@keescook>
 <20200915102458.GA1650630@google.com>
 <CANpmjNOTcS_vvZ1swh1iHYaRbTvGKnPAe4Q2DpR1MGhk_oZDeA@mail.gmail.com>
 <20200915120105.GA2294884@google.com>
 <CANpmjNPpq7LfTHYesz2wTVw6Pqv0FQ2gc-vmSB6Mdov+XWPZiw@mail.gmail.com>
 <20200916074027.GA2946587@google.com>
 <CANpmjNMT9-a8qKZSvGWBPAb9x9y1DkrZMSvHGq++_TcEv=7AuA@mail.gmail.com>
 <20200916121401.GA3362356@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916121401.GA3362356@google.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 12:14PM +0000, George Popescu wrote:
> On Wed, Sep 16, 2020 at 10:32:40AM +0200, Marco Elver wrote:
> > On Wed, 16 Sep 2020 at 09:40, George Popescu <georgepope@google.com> wrote:
> > > On Tue, Sep 15, 2020 at 07:32:28PM +0200, Marco Elver wrote:
> > > > On Tue, 15 Sep 2020 at 14:01, George Popescu <georgepope@google.com> wrote:
> > > > > On Tue, Sep 15, 2020 at 01:18:11PM +0200, Marco Elver wrote:
> > > > > > On Tue, 15 Sep 2020 at 12:25, George Popescu <georgepope@google.com> wrote:
> > > > > > > On Mon, Sep 14, 2020 at 03:13:14PM -0700, Kees Cook wrote:
> > > > > > > > On Mon, Sep 14, 2020 at 05:27:42PM +0000, George-Aurelian Popescu wrote:
> > > > > > > > > From: George Popescu <georgepope@google.com>
> > > > > > > > >
> > > > > > > > > When the kernel is compiled with Clang, UBSAN_BOUNDS inserts a brk after
> > > > > > > > > the handler call, preventing it from printing any information processed
> > > > > > > > > inside the buffer.
> > > > > > > > > For Clang -fsanitize=bounds expands to -fsanitize=array-bounds and
> > > > > > > > > -fsanitize=local-bounds, and the latter adds a brk after the handler
> > > > > > > > > call
> > > > > > > >
> > > > > > > This would mean losing the local-bounds coverage. I tried to  test it without
> > > > > > > local-bounds and with a locally defined array on the stack and it works fine
> > > > > > > (the handler is called and the error reported). For me it feels like
> > > > > > > --array-bounds and --local-bounds are triggered for the same type of
> > > > > > > undefined_behaviours but they are handling them different.
> > > > > >
> > > > > > Does -fno-sanitize-trap=bounds help?
[...]
> > Your full config would be good, because it includes compiler version etc.
> My full config is:

Thanks. Yes, I can reproduce, and the longer I keep digging I start
wondering why we have local-bounds at all.

It appears that local-bounds finds a tiny subset of the issues that
KASAN finds:

	http://lists.llvm.org/pipermail/cfe-commits/Week-of-Mon-20131021/091536.html
	http://llvm.org/viewvc/llvm-project?view=revision&revision=193205

fsanitize=undefined also does not include local-bounds:

	https://clang.llvm.org/docs/UndefinedBehaviorSanitizer.html#available-checks

And the reason is that we do want to enable KASAN and UBSAN together;
but local-bounds is useless overhead if we already have KASAN.

I'm inclined to say that what you propose is reasonable (but the commit
message needs to be more detailed explaining the relationship with
KASAN) -- but I have no idea if this is going to break somebody's
usecase (e.g. find some OOB bugs, but without KASAN -- but then why not
use KASAN?!)

I'll ask some more people on LLVM side.

Thanks,
-- Marco
