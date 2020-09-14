Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3E626831E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 05:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgINDaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 23:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgINDaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 23:30:04 -0400
Received: from X1 (unknown [209.33.215.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC401208E4;
        Mon, 14 Sep 2020 03:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600054203;
        bh=DGwweu43/njL3LpV4klh5m/GnEyyp3xKZ/SaT3e4Ar8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ul7X1DJkQ2mHtCjDAyKaHbsrLvx9QsZ5unplMQAgQAYdj182YvU1s5lKCGvf27E5h
         4FSvcsTScs1Vh0phky7sY44ySIyiIKGvlMMM1+G9eASOKDf43wwiJcrf8WLkam0DLc
         2X+CNpmT1xOejERYJ3ks/o1ZSgFLtMJRkqBThxZo=
Date:   Sun, 13 Sep 2020 20:30:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/string.c: Clarify kerndoc for stpcpy()
Message-Id: <20200913203002.332df6c673d4ca365a5d8f76@linux-foundation.org>
In-Reply-To: <202009061325.8B4A75057@keescook>
References: <202009060302.4574D8D0E0@keescook>
        <20200906160809.GA1620946@rani.riverdale.lan>
        <202009061325.8B4A75057@keescook>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Sep 2020 13:26:32 -0700 Kees Cook <keescook@chromium.org> wrote:

> On Sun, Sep 06, 2020 at 12:08:09PM -0400, Arvind Sankar wrote:
> > On Sun, Sep 06, 2020 at 03:06:29AM -0700, Kees Cook wrote:
> > > Fix the language around return values to indicate destination instead of
> > > source.
> > > 
> > > Reported-by: Masahiro Yamada <masahiroy@kernel.org>
> > > Link: https://lore.kernel.org/lkml/CAK7LNAQvQBhjYgSkvm-dVyNz2Jd2C2qAtfyRk-rngEDfjkc38g
> > > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > > This is a fix for lib-stringc-implement-stpcpy.patch in -mm.
> > > 
> > > Andrew, please note that it would be nice to get this into -rc6
> > > to unbreak the clang builds.
> > > 
> > > Thanks!
> > > ---
> > >  lib/string.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/lib/string.c b/lib/string.c
> > > index 6bd0cf0fb009..32a56436c7eb 100644
> > > --- a/lib/string.c
> > > +++ b/lib/string.c
> > > @@ -280,12 +280,12 @@ EXPORT_SYMBOL(strscpy_pad);
> > >   * @src: pointer to the beginning of string being copied from. Must not overlap
> > >   *       dest.
> > >   *
> > > - * stpcpy differs from strcpy in a key way: the return value is the new
> > > - * %NUL-terminated character. (for strcpy, the return value is a pointer to
> > > - * src. This interface is considered unsafe as it doesn't perform bounds
> > > - * checking of the inputs. As such it's not recommended for usage. Instead,
> > > - * its definition is provided in case the compiler lowers other libcalls to
> > > - * stpcpy.
> > > + * stpcpy differs from strcpy in a key way: the return value is a pointer
> > > + * to the new %NUL-terminated character in @dest. (For strcpy, the return
> > > + * value is a pointer to the start of @dest. This interface is considered
> > 					      ^ need closing parenthesis
> > 
> > Thanks.
> 
> *face in hands* Yup. Andrew, do you want to poke that yourself or should
> I send a fix-fix? :)

I haven't got onto the stpcpy() base patch yet, so a full resend of
a v4 would be nice please.
