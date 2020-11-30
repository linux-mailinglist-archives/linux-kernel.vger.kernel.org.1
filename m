Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05452C8A67
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgK3REW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729292AbgK3REW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:04:22 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48F1C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 09:03:35 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id q8so10006942ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 09:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=50weI0bYloddYiv+R6W9ImnCSftRMUprlRnSViTP+Fs=;
        b=GOW82eGekEAExilGvS1tivJ+ROVME0C8tukpZ5zxI6/JJYCM7rzPM8zlhqszWzdJiU
         Ir5BpAyChcBZjIlei63NiuPOg14sjP+zzqyOJldQyHm4CtMkGQLeayYkyN/hakmyH0zs
         HdD8xeYeZZ+jRZhw/+lS2QVbkUgUeEg3e4gOEFXoMj24M7F7SUNYfEA4yi5d5tzhORR2
         GW2cfU4XoAGHWLpMElbR1KowZmrSp4Wxb7NHUK/3r8FyFf0fQlrzuU9Coqm4lV2wzmDb
         ot/Vrbr60ohAN0KSVYjiiF9v6iMgQ24NUIyfJez7yjviCmUxnJ2P7XPTHw+qrRdWefkj
         cXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=50weI0bYloddYiv+R6W9ImnCSftRMUprlRnSViTP+Fs=;
        b=T2Jth3Ru7ZC/u21KSTp+kD6F9HaK16Mk4HJU+sM0w/3c/iwy6ibt9/3MuUOKLvlqeQ
         Rk8cIXL/qkXNbM/hq/CJhK6nhNLdRQOYz6XI8XgmhcBhRms4+EU5IVjtK7AoLTdGmzrO
         C6rry0fBFWKjLP868TdsYf0Copk4+bKymoAFHCif8W/2+9B//K/+Uc0IWpkzr6h4mmbl
         A3Z5oqdqpDJNHmiBQOF1MEyo2/m3HOdWplscnJ4rUW2oc0qHQNutfiH6PKVxaR7otX15
         Oz+PEKFtBXDMrP5CCe1QwnQcMlruVvn2jXXNyWHiaiPbGCtVQ4Hv5MhYole0STur+IRV
         tfNA==
X-Gm-Message-State: AOAM532CWwlLxwX6M1q9zM+ZykXx64uEbVlfMguf6rqlRxlvWCuZLzb1
        3Y9vjcCpKceMWxbM+ktb7tJC/Dz9sgAHKuIwqyw=
X-Google-Smtp-Source: ABdhPJyFHR69kHKYran2WCfbGm0UB93xIcfyege3Y/0ePkkwMxnRYkRkTeajxnmBq+B7k8csZr7aiWPCIvbbzMdpqXU=
X-Received: by 2002:a2e:3210:: with SMTP id y16mr10171277ljy.395.1606755814157;
 Mon, 30 Nov 2020 09:03:34 -0800 (PST)
MIME-Version: 1.0
References: <20201130144515.8320-1-dwaipayanray1@gmail.com> <c8eeab847fc09368ce270ea3e06ea0bbbd7d1b7f.camel@perches.com>
In-Reply-To: <c8eeab847fc09368ce270ea3e06ea0bbbd7d1b7f.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Mon, 30 Nov 2020 22:33:06 +0530
Message-ID: <CABJPP5BLjbx3FbvB3nAOiHfkRLUo7s0n-vboE+AXJqrZXseUNQ@mail.gmail.com>
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

On Mon, Nov 30, 2020 at 10:13 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2020-11-30 at 20:15 +0530, Dwaipayan Ray wrote:
> > checkpatch reports a false TYPO_SPELLING warning for some words
> > containing an apostrophe.
> >
> > A false positive is "doesn't". Occurrence of the word causes
> > checkpatch to emit the following warning:
> >
> > "WARNING: 'doesn'' may be misspelled - perhaps 'doesn't'?"
> >
> > Check the word boundary for such cases so that words like
> > "doesn't", "zig-zag", etc. aren't misinterpreted due to wrong
> > splitting of the word by the \b regex metacharacter.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -3106,7 +3106,7 @@ sub process {
> >  # Check for various typo / spelling mistakes
> >               if (defined($misspellings) &&
> >                   ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
> > -                     while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b|$|[^a-z@])/gi) {
> > +                     while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b(?![^\w]?[a-z@]+)|$|[^a-z@])/gi) {
>
> Wouldn't it be simpler to change the existing [^a-z@] blocks to [^a-z@'-] ?
>
Hi,
I tried it and it doesn't seem to work. Probably because the first
group already causes the
word to be captured. In this case `doesn'` was already captured
because of the \b group.

Is the first group modification perhaps okay? Or would you suggest
something else?

Thank you,
Dwaipayan.
