Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422872792F9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 23:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgIYVIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 17:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgIYVIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 17:08:00 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ED5C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:07:59 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id b79so577042wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K97X2RHTYq4ARTwka6ZMNlPXc27d+vNcQg3ndyKU7S4=;
        b=wWJDp7DJ/HSLsogZGC8Djl65CIcLMR4WYa3ADAj6UKKThfriQIIl0AP5YkYOCeZjQg
         KvWcIpXuUmNNcLIcy0qIPpol6N1nCEXLafFw0RqOTH4dc3O8g1f6JLmWNIBhig9vRNwL
         DH/d7LjlahlLTw4oUcx+CVrvoJOFZowbGEJCfrBLFxTQxvj+HdwfFKnqKyug0MqleX7P
         7uIXwrDM/O+qcsf+ArWoYr85x58YYnxGkdVf8ILr8dVNn5HGGWFx/QBUt0YIZYC8ubGb
         L8zS0WxjNwMO0RbpE7WFpzZIVgW+bBfk06GgnPTlhDZ6qBiWQ2S3l5yLVpSMzXpDOaK7
         vL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K97X2RHTYq4ARTwka6ZMNlPXc27d+vNcQg3ndyKU7S4=;
        b=TvGVc8YqBvK8BpFpADsny0IxNfElr9uULJUHc2nmYhpK8unL91qXS2pF3SnY7UUiNI
         ZaKr1fglZT2BlqAkwUa+hDZa5rXz+lWJxryMLu46+Tx2vo7kH6olpTqbOEM2TpEsgOvG
         TN4dYFjKNPodhYlus2cWY4nNB999kkyCxW3CHWU3BkUD2906nNR3Ncn6iCGplgV4g26r
         itenGGnHIwOrxlGYFVrIBMOsNFu6CavsLi8lFLIwf5c2aN3FdtTWfRvLwQd87/2OKajR
         A4xPTXbsEPrYLfUc9S6PDO85vQ5PE+Anf2uDr6kfgW0IACzpRczNIWruzgcgnGsObAfN
         j1sw==
X-Gm-Message-State: AOAM531gCni+Ary+i74MEAMvDlEsFkKhSL+AuOrVEdrKSVP1ZhKbAF0v
        1hWMEPqFrXrZaU194/DhSmScOREpVpkSsQsqAZ15OQ==
X-Google-Smtp-Source: ABdhPJybyFObTULGeYsdiwfil6bHB/bVxxQM+SWeMyX++xGCC6MaJ/cX0aYsdELwah2M/FxoIVL6b6QjN4YOeSHoolY=
X-Received: by 2002:a1c:740c:: with SMTP id p12mr445421wmc.176.1601068078574;
 Fri, 25 Sep 2020 14:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <202009251223.8E46C831E2@keescook> <2FA23A2E-16B0-4E08-96D5-6D6FE45BBCF6@amacapital.net>
 <202009251332.24CE0C58@keescook>
In-Reply-To: <202009251332.24CE0C58@keescook>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 25 Sep 2020 14:07:46 -0700
Message-ID: <CALCETrU_UpcLhXSG84SA6QkAYe8xXn4AXPKeud-=Adp57u54Mg@mail.gmail.com>
Subject: Re: [PATCH v2 seccomp 3/6] seccomp/cache: Add "emulator" to check if
 filter is arg-dependent
To:     Kees Cook <keescook@chromium.org>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 1:37 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Sep 25, 2020 at 12:51:20PM -0700, Andy Lutomirski wrote:
> >
> >
> > > On Sep 25, 2020, at 12:42 PM, Kees Cook <keescook@chromium.org> wrote=
:
> > >
> > > =EF=BB=BFOn Fri, Sep 25, 2020 at 11:45:05AM -0500, YiFei Zhu wrote:
> > >> On Thu, Sep 24, 2020 at 10:04 PM YiFei Zhu <zhuyifei1999@gmail.com> =
wrote:
> > >>>> Why do the prepare here instead of during attach? (And note that i=
t
> > >>>> should not be written to fail.)
> > >>>
> > >>> Right.
> > >>
> > >> During attach a spinlock (current->sighand->siglock) is held. Do we
> > >> really want to put the emulator in the "atomic section"?
> > >
> > > It's a good point, but I had some other ideas around it that lead to =
me
> > > a different conclusion. Here's what I've got in my head:
> > >
> > > I don't view filter attach (nor the siglock) as fastpath: the lock is
> > > rarely contested and the "long time" will only be during filter attac=
h.
> > >
> > > When performing filter emulation, all the syscalls that are already
> > > marked as "must run filter" on the previous filter can be skipped for
> > > the new filter, since it cannot change the outcome, which makes the
> > > emulation step faster.
> > >
> > > The previous filter's bitmap isn't "stable" until siglock is held.
> > >
> > > If we do the emulation step before siglock, we have to always do full
> > > evaluation of all syscalls, and then merge the bitmap during attach.
> > > That means all filters ever attached will take maximal time to perfor=
m
> > > emulation.
> > >
> > > I prefer the idea of the emulation step taking advantage of the bitma=
p
> > > optimization, since the kernel spends less time doing work over the l=
ife
> > > of the process tree. It's certainly marginal, but it also lets all th=
e
> > > bitmap manipulation stay in one place (as opposed to being split betw=
een
> > > "prepare" and "attach").
> > >
> > > What do you think?
> > >
> > >
> >
> > I=E2=80=99m wondering if we should be much much lazier. We could potent=
ially wait until someone actually tries to do a given syscall before we try=
 to evaluate whether the result is fixed.
>
> That seems like we'd need to track yet another bitmap of "did we emulate
> this yet?" And it means the filter isn't really "done" until you run
> another syscall? eeh, I'm not a fan: it scratches at my desire for
> determinism. ;) Or maybe my implementation imagination is missing
> something?
>

We'd need at least three states per syscall: unknown, always-allow,
and need-to-run-filter.

The downsides are less determinism and a bit of an uglier
implementation.  The upside is that we don't need to loop over all
syscalls at load -- instead the time that each operation takes is
independent of the total number of syscalls on the system.  And we can
entirely avoid, say, evaluating the x32 case until the task tries an
x32 syscall.

I think it's at least worth considering.

--Andy
