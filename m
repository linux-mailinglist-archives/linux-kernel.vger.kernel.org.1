Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0D72B742F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 03:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgKRCbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 21:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgKRCbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 21:31:23 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75634C061A48
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 18:31:21 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id 7so618048qtp.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 18:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8b4iSaMQbkOsXKVrPVTdb4e933LrWafVxDAh1z5pNFw=;
        b=FbG1ylC+hN7kHCfOUP71IibqqFobG8cnKh6gcCQi+gZnc2axArBwStq+TYnDKgUaFv
         HH5ty9xl+fwcvrXbhO3IL70pm5tKYoC2HQZa+SRSCUWRpJdhWTNQWdat/o9udhW0JQ9t
         wyjxDn4tz/oEO6pdNnSKhdTRtvF9nagzcS01Ke5AgFH8Tb32uJgk4TfFTgnwReo8sld9
         I0x+pp//CBXEfDLe4nCU80wbnL1/LbdZtG8BFEJcouDeAJv0g2beu/fMG21P1+kMmQnm
         jt7qRsQWTy1wYy+JdoS0UtQYiF7GFNq40dHtbXtPBA98X8InkwxsQ/qJbE08VFC0MdbZ
         dEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8b4iSaMQbkOsXKVrPVTdb4e933LrWafVxDAh1z5pNFw=;
        b=Ik0h5wf4SIc180v1o8TEbuyJXkJZaOJen/wzj+w9kLf2EqURxxpLCaAIA+nTA4hd7k
         s+mFho+9ZNk1e9QR0BFQhP+UPHEE7jL3ZdYxI6ZrNCkwpCsqIbjaHiKZcCfEkjoaaTb0
         ZL4UaBqb5TaNrlicIoQWMvS3RrwQhD1PMi018DLmZih232YcaOnAIRRzMDE08C9CA1dx
         k+sOgooRUulkM1zDFVYBeLS5yLkBP4Z4EXgW8IJQlqHHMpsphEzAWnVebwwwr7AVozA2
         Y0WVD3uo5+VxXuDFqdqpdzgoGnQYkhXGm0GgYUnt64Xs22PJSwXsV0778hiB7SQArltj
         SgGA==
X-Gm-Message-State: AOAM5315eqbxk7nncDXTbXDEJp6yrAa4KeLMGm4mG9jC7fknec5V1Jgr
        axBUAZTJtbAC/Frr3j9FZZs=
X-Google-Smtp-Source: ABdhPJz0GC2VeKIZZKlS0XvXzIr02zxjfa2OVf9b9VM7Tig8vru0p8ZGoFf4UJZs6+Ex5m8U97iRWg==
X-Received: by 2002:ac8:4252:: with SMTP id r18mr2825092qtm.26.1605666680578;
        Tue, 17 Nov 2020 18:31:20 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id g123sm9152476qkd.135.2020.11.17.18.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 18:31:19 -0800 (PST)
Date:   Tue, 17 Nov 2020 19:31:18 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     John Hubbard <jhubbard@nvidia.com>, jarkko.sakkinen@iki.fi,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Marco Elver <elver@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 1/7] compiler-clang: add build check for clang 10.0.1
Message-ID: <20201118023118.GA1069826@ubuntu-m3-large-x86>
References: <20201104013447.GA21728@kapsi.fi>
 <20201117030427.61981-1-jhubbard@nvidia.com>
 <CAKwvOdkEFPYmH+JFC5a0+whb_1H84gS1WU5FVpV071Bc4mhiCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkEFPYmH+JFC5a0+whb_1H84gS1WU5FVpV071Bc4mhiCQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 10:46:29AM -0800, Nick Desaulniers wrote:
> On Mon, Nov 16, 2020 at 7:04 PM John Hubbard <jhubbard@nvidia.com> wrote:
> >
> > Hi,
> >
> > I just ran into this and it's a real pain to figure out, because even
> > with the very latest Fedora 33 on my test machine, which provides clang
> > version 11.0.0:
> 
> Hi John,
> Thanks for the report.  The patch was picked up by AKPM and is in the -mm tree:
> https://ozlabs.org/~akpm/mmots/broken-out/compiler-clang-remove-version-check-for-bpf-tracing.patch

This should probably go to Linus as a regression fix in the next wave,
if that is possible.

Cheers,
Nathan
