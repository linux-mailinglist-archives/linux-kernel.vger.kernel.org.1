Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E48D295034
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 17:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444187AbgJUPx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 11:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2444179AbgJUPx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 11:53:28 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C769FC0613CE;
        Wed, 21 Oct 2020 08:53:27 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id h196so2193744ybg.4;
        Wed, 21 Oct 2020 08:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gBAHnp2G0WCm+kthplQjXkMa2YX4/qHuFgOj64TAh7s=;
        b=fJ6Pk3yJqb7jLkjmtP91AnXIWzGZfLuhd55prGbX5Enl7PFKEztbO/LKblBlBdduVQ
         u3Alqlyttf3e1Dj+mDdUTR4bSi0THIqoIPMC7bKFjzIF2XnLrfIC3pAoinDN66kAL1Zn
         kOLp3zAPvwoPAmC0pG2K43pOFJFClfMXPjD2IEHAxjkz6jSRDp4eqRqp0LcGRCLWgYqj
         Nh0gd6cMPiuv+EW9S+hxgRQ+bTWtQ2H6oJmrtxlmDmWuKnxxO9zE30rup/ybrmSCBOQt
         01MGTKKD2bnE08D6+kFA5SRLtbThDLcj7bj0GeF2lT28Sc6IwnEhEZHH05Txk5DvvnAk
         ZedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gBAHnp2G0WCm+kthplQjXkMa2YX4/qHuFgOj64TAh7s=;
        b=HVBupkFIiwK5xwpfIAXUNbGmVke97ztz4f3GN/gTAsSdogrMXP8gTiLr2DNZdzwdZI
         /OYLKLaGx1fqcEqIEh8DQJH9EcL+41Ruqp5fREOeZ7kuTWrDKMW52Gr5zHcWbCftZjGE
         ZiR38cTG2JaqBi0Mwn3eAXVPPtyVXQ9JawlMfeJFhUBEdsGpRA54rVJ4R3bDocFy29rq
         W3djFpspwrdRPDSECyyDnMhztJmKwJDNfa7XdFU6SV9SoXR6b0HQ8iFKVYyQLr8TQZJ8
         ARgt3SDGRUmQc+u3HXIiHrejDSefSukAArT3GDDAyhbqGUyXYp/jm5pyuWdKQHbJzlem
         m2xA==
X-Gm-Message-State: AOAM530rY7q46xvM3HrnjrlcWgq5W5aB3RFEnephSHfWnYncijrzArso
        I/5NXTazmZccAusuNmGGd77PDzkiHEqmQx0hciV++3c6
X-Google-Smtp-Source: ABdhPJw8jhcGciDEZkIoGXYCThFVDJl+6j/xV8fifw9wqFu+TuCPPZpUn3RAhEEpMOb8oISWPNYmquMvCBZnlKgcndg=
X-Received: by 2002:a25:25c2:: with SMTP id l185mr5639803ybl.230.1603295607121;
 Wed, 21 Oct 2020 08:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAFDeuWM7D-Upi84-JovKa3g8Y_4fjv65jND3--e9u-tER3WmVA@mail.gmail.com>
 <82b757bb-1f49-ab02-2f4b-89577d56fec9@kernel.org> <20201020122015.GH2294271@kernel.org>
 <f7246cb6-901e-0bc3-eb18-194d1754da53@kernel.org> <20201021112900.GN2342001@kernel.org>
In-Reply-To: <20201021112900.GN2342001@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 21 Oct 2020 08:53:16 -0700
Message-ID: <CAEf4BzbpRaDsRGv+V5xvhHERJA7zoXwOnL_WJCimHHLk=tM3nw@mail.gmail.com>
Subject: Re: Segfault in pahole 1.18 when building kernel 5.9.1 for arm64
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?B?w4lyaWNvIFJvbGlt?= <erico.erc@gmail.com>,
        dwarves@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Hao Luo <haoluo@google.com>, Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 6:48 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Oct 21, 2020 at 08:22:40AM +0200, Jiri Slaby escreveu:
> > On 20. 10. 20, 14:20, Arnaldo Carvalho de Melo wrote:
> > > > Yeah, I observe the very same. I reported it at:
> > > > https://bugzilla.suse.com/show_bug.cgi?id=1177921
>
> > > Would it be possible to try with
> > > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=tmp.libbtf_encoder
> > > ?
>
> > Yes, that branch fixes the crashes and the kernel build finishes. The
> > zero-sized symbol error remains.
>
> > So what should distributions do now -- should we switch to a pahole snapshot
> > for a while?
>
> That would do the trick, I just completed my testing and pushed to the
> master branch on kernel.org and github, tests detailed at:
>
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=040fd7f585c9b9fcf4475d294b3f5ddf78405297
>
> There are some minor bug reports I want to address but my ETA right now
> is the end of this week to release v1.19.

I've just sent a patch that skips zero-sized ELF symbols without a
warning or error.

>
> - Arnaldo
