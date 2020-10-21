Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9BC295143
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 19:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503336AbgJURAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 13:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503330AbgJURAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 13:00:06 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839B7C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 10:00:05 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id l4so2786866oii.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 10:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/lNuAqJQBzgkNVOhcgKF+WesFRHWS1Sh3QfHJHMJek=;
        b=JcsPQC8fgNKsZX90bGIhKVKtm3AKXR58mffVe7vRpt+Um9oFI6e4qLd8ObK/wjzzT2
         ZCVZerHtDkVUJ9eaf6Zfdcd9qSJ2f5m3u957oNvP4Q2w+O5DOKxKrqra7CTT8L9PaSCs
         +/npakv0N72GjX454MfW/GSIw/X7Fakym2j1o17rixna0OLoqLbWctNY1LDtWOXKKIeR
         pESy0KLoPAm7QPC1QjHpAxUy1dbgZ0ShTPRJ1ElrXIos5WhVhaACwUFgcCYuSivVCPLM
         wRRvkyAvxEUl464FB1y8GQIHubUIdhe3WLgTJOfv7bFQ52u6vQdR+Wqi8iEBwf2SM1WU
         FZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/lNuAqJQBzgkNVOhcgKF+WesFRHWS1Sh3QfHJHMJek=;
        b=eaoT8gqewswhRPurhTUjMVCCQr6kjgrrZP6r6zL9Wc59Mzh36O0FjnzfurjrTtLnU+
         pEkvppSzcWhl3nl81VEfQCCYRywDlFZKBTho8yzDLtrVTGXr8n4P9HKLAeNF3t7B1pmU
         /p6WS/r3OGGZFuxyF6EWxYQrsCcCLuC1PFw52pZGh35nv2JGl7I4gHlwvPwOrQwAjCG2
         Ea/IgF38jelEX0yMh/17z54Z56ptMvGACE4RnRYhme3Ka/TtU80yNrVDJyu1kJxsNynn
         6Vx7Xya71jSuGd1n6yK2HnGVX7x8aEZoIkm8j5wYdN6d7Xjv4Dk4aOWUolLHR9sIQt5q
         iczw==
X-Gm-Message-State: AOAM5311/8Jnag5SKU1IISfhJKb9um9C80ankWCbgRaSu6xbpR8FfVNZ
        hVQtmtdjZFONeBl9icWttbNN4Y9iCtCjN2fK9uU=
X-Google-Smtp-Source: ABdhPJxny0r2Az5m7MHafOfmDHjyu/fetJxWguF/MrnVqVM2dRg5P7ft5R4uP3p5zrn4+3a3rzzUUyGE7zMnRD+p/Lg=
X-Received: by 2002:aca:420a:: with SMTP id p10mr2765498oia.117.1603299604714;
 Wed, 21 Oct 2020 10:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201021150120.29920-1-yashsri421@gmail.com> <f073750511750336de5f82600600ba6cb3ddbec0.camel@perches.com>
 <26647abf8cf14595a0dd22f10ec1c32e3dc2a8c0.camel@perches.com> <40ca3f0f9a960799ad0e534b77d778c90119e468.camel@perches.com>
In-Reply-To: <40ca3f0f9a960799ad0e534b77d778c90119e468.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Wed, 21 Oct 2020 22:29:35 +0530
Message-ID: <CABJPP5D9noCN9nMD5HdHq+uk=ot+Xcvd35CrC1E1GKy+nHAhGw@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: fix false positive for REPEATED_WORD warning
To:     Joe Perches <joe@perches.com>
Cc:     Aditya Srivastava <yashsri421@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 10:21 PM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-10-21 at 08:28 -0700, Joe Perches wrote:
> > On Wed, 2020-10-21 at 08:18 -0700, Joe Perches wrote:
> > > I might add that check to the line below where
> > > the repeated words are checked against long
> > []
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -3062,6 +3062,7 @@ sub process {
> > >
> > >                             next if ($first ne $second);
> > >                             next if ($first eq 'long');
> > > +                           next if ($first =~ /^$Hex$/;
> >
> > oops.  with a close parenthesis added of course...
>
> That doesn't work as $Hex expects a leading 0x.
>
> But this does...
>
> The negative of this approach is it would also not emit
> a warning on these repeated words: (doesn't seem too bad)
>
> $ grep -P '^[0-9a-f]{2,}$' /usr/share/dict/words
> abed
> accede
> acceded
> ace
> aced
> ad
> add
> added
> baa
> baaed
> babe
> bad
> bade
> be
> bead
> beaded
> bed
> bedded
> bee
> beef
> beefed
> cab
> cabbed
> cad
> cede
> ceded
> dab
> dabbed
> dad
> dead
> deaf
> deb
> decade
> decaf
> deed
> deeded
> deface
> defaced
> ebb
> ebbed
> efface
> effaced
> fa
> facade
> face
> faced
> fad
> fade
> faded
> fed
> fee
> feed
> ---
>  scripts/checkpatch.pl | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index fab38b493cef..79d7a4cba19e 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3062,6 +3062,7 @@ sub process {
>
>                                 next if ($first ne $second);
>                                 next if ($first eq 'long');
> +                               next if ($first =~ /^[0-9a-f]+$/i);
>
>                                 if (WARN("REPEATED_WORD",
>                                          "Possible repeated word: '$first'\n" . $herecurr) &&
>
>

Hi,
Can it be considered that the Hex numbers occur
mostly in pairs or groups of 8, like "FF" or "FFFFFFFF"?

I think it might reduce the negative side further.

Thanks,
Dwaipayan.
