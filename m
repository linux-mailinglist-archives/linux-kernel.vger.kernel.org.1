Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48834287545
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 15:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbgJHNfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 09:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgJHNfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 09:35:50 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7C6C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 06:35:49 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id l4so5471085ota.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 06:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2gxPFYsnlZ12+GaKZv8ppvoZXQ2lPcKEK4w6wsUjhc0=;
        b=kSRbKf40XqV0l411+b4zQLVQOonAxtlSNecMg/T80Ukzk/KBIGsRMiYozaRMGoE+I9
         YZmlnArjYcsAzdbyx0eta8P4gSWpJbKAhs27GS76bvi65Rcy4AY+0UdOZC7/n7OXPDeT
         5hzrbN9EFrDCH25BySerKQbgk1zAmjMvBw9xJfEeBwH3PtB1toIzKqjMeaKdBmeSKqia
         rBU9PocD6IY/c5DQlp8rLF28OQWJP1wpS0dJ/LWb7qJGrh0iXG4ocuKveN5Cf6U0u6Ne
         RySDT935UhaAeEOjgYjc69aSLmrUQsvz8eiSO02I21uVOOmt+NG8vHiSSEgD12NLAEYA
         xFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2gxPFYsnlZ12+GaKZv8ppvoZXQ2lPcKEK4w6wsUjhc0=;
        b=jFwOQuEmUphYXc3xpVdABxai9GqNRMessWj3hlrsjRE0EOaP0jaz18BJwW6/OjH4LB
         a6sHgbP6anHcShov/vKY3plkcdaLg3vacXhZSdEXWNyPw8aHQQCS+dsusU0B7XrnPL6D
         Mqd0lQ9P6bS5mvnsEZ9T8szA9BOSJ1w3zGuwOmGlKMuBWXawLnZjYEhzigoB9cOFg4Qd
         rRVYQUN3xVdMPC6xxDL2ejhJoMb/7oZ7ejdW0ct4Z1qDw2IU+PECTRU4EzbrlwlrMdXS
         7mWCv/rEZuQg0gV85sr2o8UJ/jOAaCTYgiu+WhiJ/128QviSFVCgpo19uJz/wB4vtElh
         bu7A==
X-Gm-Message-State: AOAM5338BeTldIiDlACd8oMbqAFPWdzJN5gA7TDMsiiFvZXlNJfcoTEg
        lrGbEn4e/04Q4TLKQZ2srPER8TRui66CJgGQbbY=
X-Google-Smtp-Source: ABdhPJyYy+WNZqpUVoS3/U9Ws1pjVAS/8vxjphuMpLvUmDDtWyupvbqAY21CaP4FFp4pAZs0DrEfziADasHV/mPsWiY=
X-Received: by 2002:a9d:6c4b:: with SMTP id g11mr3476386otq.265.1602164149001;
 Thu, 08 Oct 2020 06:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2010081247510.19461@felia> <b6cd81b936671a8868fe98536d7c80771bdfd61c.camel@perches.com>
In-Reply-To: <b6cd81b936671a8868fe98536d7c80771bdfd61c.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 8 Oct 2020 19:05:24 +0530
Message-ID: <CABJPP5DLhdOfuOX=Ls0-726-ECL3+o4pkVtcRY0gqk2EvLsByg@mail.gmail.com>
Subject: Re: checkpatch.pl: REPEATED_WORD: massive false positive in MAINTAINERS
To:     Joe Perches <joe@perches.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 8, 2020 at 6:18 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2020-10-08 at 13:50 +0200, Lukas Bulwahn wrote:
> > Dear Joe, dear Dwaipayan,
> >
> > while maintaining MAINTAINERS, I noticed that the REPEATED_WORD check,
> > which in general is a great addition to checkpatch.pl, generates a massive
> > number of warnings due to one specific pattern in the MAINTAINERS file:
>
> I didn't actually check if there were many
> new false positives, but
> clearly that's one.
>
> Maybe exclude the MAINTAINERS file?
>
> -               if ($rawline =~ /^\+/ || $in_commit_log) {
> +               if (($rawline =~ /^\+/ || $in_commit_log) && $realfile ne "MAINTAINERS") {
>
> Maybe add git to the check for "long long"?
>
> -                               next if ($first eq 'long');
> +                               next if ($first =~ /^(?:long|git)$/);
>
>
>

Hi,
It does resolve all the warnings concerned.
But could we also exclude documentation type blocks like:
/**
* @size size of access
*/
There were quite a few of these in include/linux/instrumented.

And also it isn't case sensitive. So the line
"the the word is repeated" generates a warning, but
"The the word is repeated" doesn't generate anything.

Thanks,
Dwaipayan.
