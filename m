Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F32628317D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgJEIGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgJEIGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:06:51 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13736C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 01:06:51 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a15so6553897ljk.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 01:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l5qjARLGDEhYYr5IfJCOtYDMVIpFPp0ZNzy5B3uTwDA=;
        b=UeypbU3ZjtFqaTYeRjJJ+uG3iMJ8iTMdMXI/l06MwcDoGNE7QZkwvFtu9b6QWkGG8D
         VJAZtukaEDWkRRmC098fA3lwHH+Tj7Gz2mAIN8oOjBqgZqoV84bOAQX7ZKECzAOQs8Y2
         bjs+Thcwg2Q68Ri3SO8WEODyjwe9E/RjubUj+72WvBBLC7A15l8iJRjhhbxRE82kShKC
         vEErxHoHAxYA/J0U/vrhj6Duo09vNZb5Nd2SGrY+QhTo1/scPFBIh4IdC4RM2LpEjxxD
         XCMfl2HqZMIrkUtWdWho6WmZSolU1fqX8a9eX63vGdDA45NRq6sIwh0iAhqinJ6lO68/
         9jTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l5qjARLGDEhYYr5IfJCOtYDMVIpFPp0ZNzy5B3uTwDA=;
        b=FFlIJmd+o4J08jt5ciP3ScUTiV8vUwWf+u3ljTnVcaD97tU3jk8/OWsyCBUjF33rol
         rqQgNP+qmPq+eTBga69J2Ft3zNkp63bMSezZHtO+t3BAPVBERPOtTyOjiR4a3g6xj56F
         HM3lLif7UWKsFi5pzWw5Lw3/hpVT2e1iEEr1arV6EsLE1kFnEZaNn3FA3pTQT6i350S1
         wGphOWnELVLV3mZ2/CIaKT6+yghilOhkWL5H6ajYbs3GNpR25RDT3HhfeBfmkkmsXsX1
         F0NcWZAJDQttHm0k3OlwYOQR4U9A/dckjXPO33FqIhCtBCIA8F8JaES8r65CjpYSR+2U
         x0Zw==
X-Gm-Message-State: AOAM531bF43sKrh2p3U8rgPZzIQKchcIExYSRrbVigc/qxn6grZQ2AQL
        ls1nCOd6jmIVVqqFHR/H4MOGUHAeZirTWlxvynk=
X-Google-Smtp-Source: ABdhPJwkp8dmspXaM3/LXDRqn2LMObaDI/JFEsKHTZxdKDrd9ovxgzLigvc5yrQGq2AIrlXzMwC6qiztzaynMcUWUuY=
X-Received: by 2002:a2e:8011:: with SMTP id j17mr4516143ljg.444.1601885209406;
 Mon, 05 Oct 2020 01:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594032517.git.tammo.block@gmail.com> <20201002123002.GA3346488@kroah.com>
In-Reply-To: <20201002123002.GA3346488@kroah.com>
From:   Tammo Block <tammo.block@gmail.com>
Date:   Mon, 5 Oct 2020 10:06:38 +0200
Message-ID: <CAEHKo2nK+S42FmjN3NDh8g8+yNvcpeBAbY8sq+wUxbRmZcbCGA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] vt: Add SRG mouse reporting features
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jslaby@suse.com>, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Am Fr., 2. Okt. 2020 um 14:30 Uhr schrieb Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> On Mon, Jul 06, 2020 at 12:57:22PM +0200, Tammo Block wrote:
> > Hi everybody,
> >
> > this patchset adds xterm like mouse reporting features to the console.
> >
> > The linux virtual console has support for mouse reporting since 1994 or so,
> > but the kernel only supports the original X10/X11 style standard protocols.
> > To support more protocols these patches expand the kernel structures in a
> > up- and downwards compatible way, see the last patch for detailed
> > documentation and pointers to even more detailed docs.
> >
> > The main goal is to become compatible with xterm, as most TUI software today
> > is tested in xterm or another compatible terminal.
> >
> > Support by the mouse daemons (consolation, gpm) will be needed too.
>
> What happened to this feature.  Was there a new set of patches or was
> this the last one?

This was the last set, there were no further comments in any direction.

> mouse support for the console feels odd these dyas, who would use this?
>
Well .... at least i am using it .. ;-)

This is in fact not a really new feature, but an improvement of an old feature.
The patch just tries to be compatible with xterm and other modern terminals
to be able to run stuff like midnight commander or similar programs.

I am personally using console tty's for long running or controlling stuff
and being able to use the mouse (especially for cut n' paste) seems useful.
At least for me. But my personal habits might be odd ...

Feel free to ignore the patches if you don't consider this feature useful.
If you do consider it useful I can rebase against whatever you like.

kr
Tammo
