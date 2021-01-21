Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B782FF600
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbhAUUgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 15:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbhAUUfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 15:35:40 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBE0C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 12:35:00 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id i17so4066485ljn.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 12:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NvOVYQfFSt8nYGcotV1osT1wbrhiYGmlu7GSc6HoD2k=;
        b=M6o7wXBC7freOWbOB2muQ2VEmRRaC+dKV4HYqbvpP+Pn0U7mReJDS02EaplNdXr4w7
         PlTAmoJ+sasT+YBqWLIPbhFEA55AeBewi26SA/OPgckJjG/qkljEQiAoLTUU7vaRlI4C
         E/2dCNlH8TtYT4uwDj5xRkuvoitBn/y/xhqK1ax/1wmW/fX99gmRfjyQwICc3GQvhDld
         VZJ6Hw6T/+toTBA2blCnaJtgDmHr9oH1+mzuQ0KBougfTmY/Thv197DdtS83sq3XVwd+
         UPQwFiZLGIXIChhaeOZ8V9P5xoQtgQ013QAzZMQ6GGcEXKuZqhK07IuAStmQsYP5Z625
         ihog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NvOVYQfFSt8nYGcotV1osT1wbrhiYGmlu7GSc6HoD2k=;
        b=hbQ8VN+Jl2FJtziewM0PyErdXdeAu83poGf6GNe0C3i/bjSPipLxqKQIAdahH582AW
         gs8wRtxYAh5wZ/TXpc2KdUm/YyP5HEdcQrOKHgk22jy3gb5eBy7YoQF92FTKT2iCuaux
         HhDpkGqBTbBVAsDQFxggmdjEBAzr1NQWuh8Gj02rc5+SJthupH9/MVHe0mCPzS20NA9j
         M1dvTP5mU5Yt8i8sfk5OASzxgmvrEiqeQYeQ4tUJhyd7BcJ2+LI8L8rFUZbXtBv1oet3
         GFvVKnEJswbgIi4IFSCQfLFKbh3WiJ4/+JtWaCGyQir4LI8A1op17397YGyiCNHD9yP8
         +tiQ==
X-Gm-Message-State: AOAM531b2zlJWi+8en81lNZ/lb6uDeiUHZ8R6p44RFCeiGJ8wPZmld5j
        NW/udwNEO7UGIMNPsz8C51rlPgfpi5LdmO6jn3LaojIkgrGm5HDd
X-Google-Smtp-Source: ABdhPJwWmnVhz+BXYIOIFlJOXnHQLe+kcjjK0sDHB0ZuYgNkqtSScGh+9nTsexwVVdfsQp9sP29CYu7kyDsQz1Yk9D0=
X-Received: by 2002:a2e:6f18:: with SMTP id k24mr517828ljc.225.1611261298631;
 Thu, 21 Jan 2021 12:34:58 -0800 (PST)
MIME-Version: 1.0
References: <20210121170736.2266-1-scott.branden@broadcom.com>
 <CAK7LNAQEvej1_UrS6s1+vwdei8cK1UW8b5erYc-6Ggu25oC0cg@mail.gmail.com> <CAHp75Vf=Ba+e8PDsvi8eDiuNDvC6Pfx3RsRAkaOZvD26Z2pnQA@mail.gmail.com>
In-Reply-To: <CAHp75Vf=Ba+e8PDsvi8eDiuNDvC6Pfx3RsRAkaOZvD26Z2pnQA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 Jan 2021 22:35:47 +0200
Message-ID: <CAHp75VcLi8hjYaDXrfAjbj+Kw_FRef=xnKiXr_Kv+YUToEjHTQ@mail.gmail.com>
Subject: Re: [PATCH] diffconfig: use python3 instead of python in Shebang line
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Finn Behrens <me@kloenk.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 10:31 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Jan 21, 2021 at 10:28 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Fri, Jan 22, 2021 at 2:17 AM Scott Branden
> > <scott.branden@broadcom.com> wrote:
> > >
> > > Use python3 instead of python in diffconfig Shebang line.
> > > python2 was sunset January 1, 2000 and environments do not need
> > > to support python any more.
>
> > Just from curiosity, what problem is this solving?
> >
> > Is there a distribution where 'python' does not exist,
> > but 'python3' does ?
>
> Yes. Called surprise surprise Debian
> An it's a rare case when I agree with them.

For the record, you seems haven't noticed:
https://lkml.org/lkml/2020/12/9/446

-- 
With Best Regards,
Andy Shevchenko
