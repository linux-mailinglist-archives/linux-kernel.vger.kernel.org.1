Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3344822543C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 23:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgGSVEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 17:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgGSVEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 17:04:05 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A983C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 14:04:05 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a6so10630065wmm.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 14:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=twrqapN86/1t1LKuO/iCsZfHNcmWrjBXOPdj4L6Z6nM=;
        b=m4NXgJu8K71aQq0pthXa+FIp5wtDMLNHMIdG+V3noIkY9L7Mqcm0euOou1ZP/Ezkh2
         YKhxUDaklUzFRciHjCdFW56yGynlP1pCeJEzdOnxyiwpGt24xDfIIwPKK75cKvyNCuud
         guEkG50IiUO9doS0GqUMN0mplG9flpet79oFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=twrqapN86/1t1LKuO/iCsZfHNcmWrjBXOPdj4L6Z6nM=;
        b=OiHNAB3Lz2lVHOnyijpKyGONfsliCaysL+PR8sp9wfjOxgNJXtuxJTB++wjg6ZQWAp
         823D4+C16YwjtZ8ag64BLU+a70HJkjtxJLf/C2Wy0qgCMMgtrRpV2LNOx+dWvNCxc3Ru
         zm5sZJ4vgzq+g+RwJiUinwi1BeT9Od0nKkwKeuqjwT5Y47o6PT+i6jRGZ1zb/5QgpYv5
         4eu8sF30TsIK8IhjrB//x7YNX+ak8FutESG5TxXm6IK3qokQ9LGO8skbKB2xSOiMrbIC
         gnSpCa480nvFJ8qTq1tjri13Hbzr85o/6zUPD95Yd4PGsY79TF00ZyMsBTdKsI1joXEp
         sPlw==
X-Gm-Message-State: AOAM531lSlbLmyN1OeGMKBvuF1CVQ0zhsTAY9fBlvDvDlgjPzP0XVdxf
        j3/yfzV/sV1/smY0rPTIx4U1XG6oCwBIo/70yBUglAiG
X-Google-Smtp-Source: ABdhPJxdDRKEIynjD2ZcTlo+fcQ6wNXuCZeG91wZeFU/M8xcWSxl6E4BOpxlu/j3qv1PDgcGuoamnS3tBbe1sdR95CA=
X-Received: by 2002:a7b:c246:: with SMTP id b6mr19888882wmj.161.1595192643983;
 Sun, 19 Jul 2020 14:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200715201159.54166-1-ignat@cloudflare.com> <20200715201159.54166-4-ignat@cloudflare.com>
 <159691324719ca79fbb8c206da527fc1f2bbc1ed.camel@sipsolutions.net>
In-Reply-To: <159691324719ca79fbb8c206da527fc1f2bbc1ed.camel@sipsolutions.net>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Sun, 19 Jul 2020 22:03:53 +0100
Message-ID: <CALrw=nEB-ohdc-RCA=Ncv40TFg457m7gm5qWg5ahjNrpE9bDCA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] um: allow static linking for non-glibc implementations
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        masahiroy@kernel.org, linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 10:10 AM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Wed, 2020-07-15 at 21:11 +0100, Ignat Korchagin wrote:
> > It is possible to produce a statically linked UML binary with UML_NET_VECTOR,
> > UML_NET_VDE and UML_NET_PCAP options enabled using alternative libc
> > implementations, which do not rely on NSS, such as musl.
> >
> > Allow static linking in this case.
> >
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > Tested-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  arch/um/Kconfig         | 5 +----
> >  arch/um/drivers/Kconfig | 3 ---
> >  2 files changed, 1 insertion(+), 7 deletions(-)
> >
> > diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> > index 9318dc6d1a0c..beb98b3b9f75 100644
> > --- a/arch/um/Kconfig
> > +++ b/arch/um/Kconfig
> > @@ -62,12 +62,9 @@ config NR_CPUS
> >
> >  source "arch/$(HEADER_ARCH)/um/Kconfig"
> >
> > -config FORBID_STATIC_LINK
> > -     bool
> > -
> >  config STATIC_LINK
> >       bool "Force a static link"
> > -     depends on !FORBID_STATIC_LINK
> > +     depends on CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS || (!UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP)
>
> Come to think of it, in a way "FORBID_STATIC_LINK" was nicer because
> there didn't need to be a single list of "what has dynamic dependencies"
> like here the list of UML_NET_VECTOR, UML_NET_VDE, UML_NET_PCAP.
>
> Maybe it could be
>
> config MAY_HAVE_NON_STATIC_RUNTIME_DEPS
>         bool
>
> config STATIC_LINK
>         ...
>         depends on !MAY_HAVE_NON_STATIC_RUNTIME_DEPS || CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS
>
>
> and then UML_NET_VECTOR et al can
>
>         select MAY_HAVE_NON_STATIC_RUNTIME_DEPS
>
> so that the knowledge is still distributed to the corresponding options?

Yes, makes sense. I've shortened it to MAY_HAVE_RUNTIME_DEPS and
reposted the series.

> johannes
>
