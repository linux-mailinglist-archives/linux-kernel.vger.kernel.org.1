Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7883E2C8CC7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgK3S2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbgK3S2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:28:15 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CDDC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:27:29 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id a9so23516136lfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cC0JGbl2FGZrNCis0SJgSoGv2mflRVQSSrcIdCJ2JcQ=;
        b=nev2YXyvTVDb0ljD384vUGMR6QzpyxuCfM2yn+rG+oSk+Xinj+BGUZybSKPmenCrg5
         j6HUuw8EeIWk0MYJ0WbW1HzMCOgoVO7+URgdzDAzqOp10lVADlYmGnEaHAr7XHY0gecm
         NTD8LkfoMCkmb7htRA7Erh2NIllZLIO4fnhQQYO7mlmp1X5wIN4xWvpb9zLXc0y7b0ZU
         upCH2yFtc5dP5PKqI3vGo4prrBFmWzg2I2K1Dmnefcku3HZHzWA0ui3tHJx+/Ju7Kx5N
         iO26HyNZlEPimIkgGnnZPFR8+cobNHtAhLzGvkL9j9t87PokJgch0KKVi23j6ohS8U0g
         TQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cC0JGbl2FGZrNCis0SJgSoGv2mflRVQSSrcIdCJ2JcQ=;
        b=tyZJgVsYKl24dL40mc1O99UKmcwkrc/eGdU8f2xGwjvn9RnV7n+FO8zkgQMLN8p1Dg
         X5Y/2QG34Lt0XMSHjLvU3m7QizI0gol8cZD89ulnfBjBUoEnh7YxGbje3XnY8TaclLnV
         1Chuv9I2z4ZsFspVF0KHXoTLPsMiRxYGHERiCv7QeK53VjjfFYlMMPqagljMWA86DUcO
         N8mCSNwb0WTKjrjcbAGVqjYUY5mGlmT4YvgYoimnpn+HjQsbSXdpLvtv6iOJPVnG/jYS
         iQzWjY1oNKO2feIHMR8RKrSDdyYRSmTt1Kj8BRXdSNC+NA6IYM3LKgSAerNTjqdTfE9G
         YEOA==
X-Gm-Message-State: AOAM531uadUfB6HmtGSGf/MRio8o4dshraES+/NuPxGdjjO99jU6Fmqp
        nr4gFF9u98hJT+Los5ND6uIliQq3kSDdCYGXPrA=
X-Google-Smtp-Source: ABdhPJywAt5REPStdIScNwTHzYyKNVPnyRgjV9ew+rDqRf/xeI8LRCcI9Gp/v3eNFQFhesnAEaOC1QgTD6lNUM2LEBA=
X-Received: by 2002:ac2:4199:: with SMTP id z25mr10153236lfh.148.1606760847697;
 Mon, 30 Nov 2020 10:27:27 -0800 (PST)
MIME-Version: 1.0
References: <20201130144515.8320-1-dwaipayanray1@gmail.com>
 <c8eeab847fc09368ce270ea3e06ea0bbbd7d1b7f.camel@perches.com>
 <CABJPP5BLjbx3FbvB3nAOiHfkRLUo7s0n-vboE+AXJqrZXseUNQ@mail.gmail.com>
 <070109a56817288562a91dfeec74359eb948234e.camel@perches.com>
 <CABJPP5BxO20-YzbTZij4gZGm4R63iG_n2kH58pSz5mgyXXwVBw@mail.gmail.com> <40b6e1fa9fc638a7e755f7e91f401b6019fee2fa.camel@perches.com>
In-Reply-To: <40b6e1fa9fc638a7e755f7e91f401b6019fee2fa.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Mon, 30 Nov 2020 23:56:59 +0530
Message-ID: <CABJPP5C0eN5kC8-jB0Bes438GxWbwnNyYeN5a+6uym5MgyuBPw@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: fix TYPO_SPELLING check for words with apostrophe
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:31 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2020-11-30 at 23:02 +0530, Dwaipayan Ray wrote:
> > Sorry I think i explained wrong. For words like "doesn't", it still
> > has the same problem.
>
> I think you explained it wrong when you didn't mention this is
> _only_ a problem when using --codespell.
>
Sorry for that.
> Likely it'd be better to use "(?:^|\s)($misspellings)(?=\s|$)"
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7dc094445d83..b1783f02f745 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3106,7 +3106,7 @@ sub process {
>  # Check for various typo / spelling mistakes
>                 if (defined($misspellings) &&
>                     ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
> -                       while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b|$|[^a-z@])/gi) {
> +                       while ($rawline =~ /(?:^|\s)($misspellings)(?=\s|$)/gi) {
>                                 my $typo = $1;
>                                 my $typo_fix = $spelling_fix{lc($typo)};
>                                 $typo_fix = ucfirst($typo_fix) if ($typo =~ /^[A-Z]/);
>
> $ cat t_spell.c
> // SPDX-License-Identifier: GPL-2.0-only
> void foo(void)
> {
>         //misspelled doesn' doesn't arne't word
> }
>
> $ ./scripts/checkpatch.pl -f --strict t_spell.c --codespell --codespellfile /usr/lib/python3/dist-packages/codespell_lib/data/dictionary.txt
> CHECK: 'doesn'' may be misspelled - perhaps 'doesn't'?
> #4: FILE: t_spell.c:4:
> +       //misspelled doesn' doesn't arne't word
>

Thanks, this does resolve the original problem, but again the following
line throws 0 warnings:

"zeebra" ther, yourr.

Any punctuation separators are ignored :(

 (?:^|\s)($misspellings)(?=[\s\.\,\:\;\"\?\!]|$)

Would this be acceptable rather? But again this doesn't
handle [therr] or (therr).

Thank you,
Dwaipayan.
