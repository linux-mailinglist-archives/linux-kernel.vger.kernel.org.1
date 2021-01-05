Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BAE2EA83D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 11:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbhAEKJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 05:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbhAEKJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 05:09:51 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9F6C061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 02:09:10 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b26so71322884lff.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 02:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aaxAf+R1vtGlgAiK9+LLSa0g3dVA/3iKj+wRF3vAQCQ=;
        b=BgA3W1s3FTkBVnpV+qaENW1Rr+lfKjzIySh5gVCJ67cRjxvmHVJPrR8dehEkpFWFe5
         zp6rPU89Kx4bE2fSQ9a9ESmiHQegyOoNWzinZPykt7RtlxUWCfHKX7g1UTZ6/LFvtyqg
         jZiKxU8aeXhA78arG+4Ow0rEJ60rgzEzp0ukrTiWutG9rn+wgXSeuRfDzGAYqw3Blgeg
         4ZoEQKYpF5V5UOGkzWbqiZLLztDPrQ2C6junsTsXZdv6IHXdmRwoRPIPxuleuqlr71rY
         GXb7rn6PI+2Nleny3MVQAeC6LedO0VIhWQB7AeIj4DvsTWK8B1mLIJEuPc9WS7DuWnas
         1FAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aaxAf+R1vtGlgAiK9+LLSa0g3dVA/3iKj+wRF3vAQCQ=;
        b=PhVihmywJvUvg0wg8iKKa3lNwII4OKMtGsT36Yl5fEK52QYs0wu+xZF5YLl3w7Ms7x
         f9AQElCDqRWEBxrp3lHklUGzQxBzuxAAjAr6t7kinhOog64cAmw6PjNkXnq8sdQNUszA
         GFne4rviS59isv/VP/c+GXr1Bgmv6zwu4xLGP8TFIM6Tuh9X3YYS9qR/dQhXxfOYntNA
         SeWp9n4bG2RXCCep0MBsYIKMfayqalDecdxFpq3xXkUxTA3NqBPz6rWOnTK4OIkGe2Bq
         I29Xzb+dYL9UUvNhki9mq74qkGTtaqk/bGc28bAbfehH8K7qmVp3WUjZkHSHonZI82dC
         XDGg==
X-Gm-Message-State: AOAM533VAaZYFt8Rm1mlG8RSsRxb/WAajM2PEDFZrC4podAgMf/dliGF
        /kCEXCcUfrg8aHPFt3gLfqbsVPcAmf5HiRrOqWE=
X-Google-Smtp-Source: ABdhPJyiKDQwDxcro89bj/wGdEj5xLiuPx18cYRMOrDsfgvoDbWcWHdwimaPLHp7/g8nGbnOYaVeibFpDdHiG87bPko=
X-Received: by 2002:ac2:44c3:: with SMTP id d3mr32997875lfm.238.1609841348812;
 Tue, 05 Jan 2021 02:09:08 -0800 (PST)
MIME-Version: 1.0
References: <20210105093507.29297-1-dwaipayanray1@gmail.com> <cf102ac77eb1f9e6424f30aef835f6c61dd03407.camel@perches.com>
In-Reply-To: <cf102ac77eb1f9e6424f30aef835f6c61dd03407.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Tue, 5 Jan 2021 15:38:56 +0530
Message-ID: <CABJPP5AEtFDdsF0h2uS1QZ6XVnvNY7h7ZQEN_OzbQqUCTvuF5A@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: fix unescaped left braces
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 3:31 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2021-01-05 at 15:05 +0530, Dwaipayan Ray wrote:
> > Perl 5.22 onwards require that "A literal "{" should now be
> > escaped in a pattern".
>
> Not quite correct.
>
> > checkpatch contains several literal "{". Fix such instances
> > by preceding them with a backslash.
>
> Not all literal left braces need to be escaped.
> https://www.perlmonks.org/?node_id=1191981
>

Thanks, I got this from perl diag:

"
The contexts where no warnings or errors are raised are:
as the first character in a pattern, or following "^" indicating to
anchor the match to the beginning of a line.
as the first character following a "|" indicating alternation.
as the first character in a parenthesized grouping like
/foo({bar)/
/foo(?:{bar)/
as the first character following a quantifier
/\s*{/
"

I will update the patch with the above in mind.

> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -2036,7 +2036,7 @@ sub annotate_values {
> >                       print "ASSIGN($1)\n" if ($dbg_values > 1);
> >                       $type = 'N';
> >
> >
> > -             } elsif ($cur =~/^(;|{|})/) {
> > +             } elsif ($cur =~ /^(;|\{|\})/) {
>
> Like this one.  And why escape the right brace too?
>
The right brace escape was just for the expression to look a bit even.
It's unneeded, will remove these too.
> >                       print "END($1)\n" if ($dbg_values > 1);
> >                       $type = 'E';
> >                       $av_pend_colon = 'O';
> > @@ -3913,7 +3913,7 @@ sub process {
> >                       # it there is no point in retrying a statement scan
> >                       # until we hit end of it.
> >                       my $frag = $stat; $frag =~ s/;+\s*$//;
> > -                     if ($frag !~ /(?:{|;)/) {
> > +                     if ($frag !~ /(?:\{|;)/) {
>
> And here.
>
> etc...
>

Thank you,
Dwaipayan.
