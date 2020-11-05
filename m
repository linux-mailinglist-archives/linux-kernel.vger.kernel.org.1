Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9B12A7785
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 07:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgKEGo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 01:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKEGo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 01:44:57 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB8FC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 22:44:57 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id s89so396777ybi.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 22:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P1AEyCMpZsd/QIquE6tYX9KtCaCr8gnLL3mOQrMAiXg=;
        b=NQPhG2YFNXbtOt0H5y1zSKmvzUO2Nf2p41ze4faNGIgVL0oS70YBcf128NGKTCa9qJ
         0FBRV1Jyzf8i6YFuSq+gLzKwYzIt3SJNk5dzzoQlYXBWCHFFrhuW8tLX0QlKHnm/JcF/
         qKiPgIDREYz0sk3tipAYcjKbKgrx3+axqAEHSTwIjr0M4xiZr5P6X7tF0ZPRsaMcO/H/
         anw6eW2XZPnjfMbY2KOxXMT6lawOFXUcwoExzn98nDTSzbkgxw/kVtm9DUQF0ZrwCmKY
         n6IzGm6C6Ecn91hRcCOL3Hohrya+1ygGQ2uTt4e08Xq7x848Td5kgFsvKlC6y9wa6XyT
         0DRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P1AEyCMpZsd/QIquE6tYX9KtCaCr8gnLL3mOQrMAiXg=;
        b=jHqoStj2UbXpqMBisv0ZPu8XNTckS7Hy9y4FhyaPdjNjxV9Arj4hdmfmNuk7qkM4kJ
         tPz9Q8qEpXdUlwhkWgMIJAwQRGIgPJjy9i7C243i1zLjxDxROyawqJuQijKDhXXC9YCA
         RWpLufrq7l7uDbTlEx7caxCxr3R7JoOF/klvCeNWg7Y7cDRLwIsLChKrx6l2pNP4GOMT
         NidTS/mKaePh8CAXDji2DQUw+fCwoofJ3UPnePDSrulhjI01RiUWQz5eNcK5OzgUuMdK
         0xfvcgTeNONfZlJrCsKvK2CjH8bbQGwQpbWUQr5kXI+JjTyVDTSNHOAmCE0eCsbFvbcb
         EALg==
X-Gm-Message-State: AOAM532NUtfLUXgc2sgnNWXyE0lGXB01Nva4GDFeh1WtXMbME2nydGwR
        lajq3N85ExhP6CJ9Pyd0P3eaXJ4J6FgWCQCfzwqbyieoZAQh6w==
X-Google-Smtp-Source: ABdhPJwC48JFZ7PdQc4UqOcFK2P0vwTw9TIJ1SjsyTLdOIRPRw1DxkrAo7ZdhN7OnIPNB5IrK4enSYw9EeCV3OZOYsI=
X-Received: by 2002:a25:ae97:: with SMTP id b23mr1715434ybj.26.1604558696355;
 Wed, 04 Nov 2020 22:44:56 -0800 (PST)
MIME-Version: 1.0
References: <363325b4a85f094ba9cf06301dd022912ec79d03.camel@perches.com>
 <CANiq72=r6oieZ-Nj-e6e+HriW8kADB75z2pj6W-gg7Cff3nqGw@mail.gmail.com>
 <CAKwvOdmnz-DJ-hG5FKJZYF7W-ujPrgfMkrb2hMLhmzhk8Hx6dA@mail.gmail.com>
 <ba3126e1424c578f5040c7a6f04cdd6a334b2db4.camel@perches.com> <CAKwvOdmoR9xph_TK5zaKdh1qHX4Sh9MW9xYcxLJf6wZfxSkv2Q@mail.gmail.com>
In-Reply-To: <CAKwvOdmoR9xph_TK5zaKdh1qHX4Sh9MW9xYcxLJf6wZfxSkv2Q@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 5 Nov 2020 07:44:45 +0100
Message-ID: <CANiq72m0Rwu78AVjt71Ym55E_xvk6SSC5ZpMoS+WEt=ri2MgNQ@mail.gmail.com>
Subject: Re: [RFC PATCH] .clang-format: Remove conditional comments
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Joe Perches <joe@perches.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 1:35 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> I'll help you paint your bikeshed. Oh, but what color?  I see a red
> door, and I want it painted black.
>
> Sounds to me like Miguel could win over a critic by addressing some of
> your (quite valid) concerns. ;)

I am happy to take the patch, but we need to at least enable other
features that were added meanwhile -- that is the advantage of
increasing the minimum!

If someone wants to take a look (wink, wink -- Joe, you are very
experienced with all the different styles used around the kernel and
would be great to have you on board with clang-format), they can use
the following list for starters.

There are a few important new features:
  - AlignConsecutiveMacros is probably one of the biggest one for the
kernel that we were missing so far.
  - IndentPPDirectives and AlignEscapedNewlines would be very good to
use too -- but the kernel style is not consistent AFAIK, so we would
need to decide.

Then there are a few others that pertain to us too:
  - SpaceBeforeSquareBrackets
  - SpacesInConditionalStatement
  - SpaceAfterLogicalNot
  - SpaceInEmptyBlock
  - IndentGotoLabels

Others are also worth checking to see if we can take advantage of them:
  - IncludeBlocks (and configuring IncludeCategories etc.)
  - StatementMacros

Then there are others that are not related to us, but to be consistent
we would explicitly set them in the file. Finally, for extra points,
we could already document the new ones in LLVM 11 if any, for the
future, but that is optional.

If no one is up for the task, I will eventually do it... :-)

Cheers,
Miguel
