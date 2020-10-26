Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342E02992A5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786277AbgJZQlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1786269AbgJZQlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:41:07 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 060AB221FC;
        Mon, 26 Oct 2020 16:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603730466;
        bh=lMLOhHMc2SftO2T+sm8yROKHJDCz62u6n7MTkGWYmoI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FrUH0ZuEShI+aS8KaffgCV79P9lzT4BjjVXXKGyDibgUPKeraTWuQWpEUxLSmay7z
         lQQI7sB0AQ37LaJyXvhHpirjuSxZGUvC0eODyyeDdo6bYMCQAGmSMrBhNI+TUTBk9v
         x9gY+Bo9Aqqx1DKY2J0a2qSkapdq3uQIlTJfgAGY=
Received: by mail-qt1-f178.google.com with SMTP id j62so7175052qtd.0;
        Mon, 26 Oct 2020 09:41:05 -0700 (PDT)
X-Gm-Message-State: AOAM533YqinT7Yr3bbcK2hTdEqMnoheBal8eiYzZhYm0GmC3SLwDOzyN
        cJXxPHTkYdecE3n1iCYbYEWh4UkaWJJaYftqPAc=
X-Google-Smtp-Source: ABdhPJygCyFHGrFIobwCE4tFT7e5+AHb2r7uiH1xSI+LOFk1DAIVxaeE5eUCvEKA+8ffiIh34l6rKlQml8nqD0sG+2A=
X-Received: by 2002:ac8:64a:: with SMTP id e10mr16302220qth.142.1603730465152;
 Mon, 26 Oct 2020 09:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201026161026.3707545-1-arnd@kernel.org> <20201026163524.GA1491649@rani.riverdale.lan>
In-Reply-To: <20201026163524.GA1491649@rani.riverdale.lan>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 26 Oct 2020 17:40:49 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1+_o5HC8uU+9p_Wv9NXtXzn0Mp3s+hrpofgfR1wT1mOA@mail.gmail.com>
Message-ID: <CAK8P3a1+_o5HC8uU+9p_Wv9NXtXzn0Mp3s+hrpofgfR1wT1mOA@mail.gmail.com>
Subject: Re: [PATCH] firmware: tegra: fix strncpy()/strncat() confusion
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 5:35 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:

> > diff --git a/drivers/firmware/tegra/bpmp-debugfs.c b/drivers/firmware/tegra/bpmp-debugfs.c
> > index c1bbba9ee93a..9ec20ddc9a6b 100644
> > --- a/drivers/firmware/tegra/bpmp-debugfs.c
> > +++ b/drivers/firmware/tegra/bpmp-debugfs.c
> > @@ -412,16 +412,12 @@ static int bpmp_populate_debugfs_inband(struct tegra_bpmp *bpmp,
> >                               goto out;
> >                       }
> >
> > -                     len = strlen(ppath) + strlen(name) + 1;
> > +                     len = snprintf("%s%s/", pathlen, ppath, name);
>
> Didn't you get any warnings with this? It should be
>                         len = snprintf(pathbuf, pathlen, "%s%s/", ppath, name);
> right?
>

Eek, I did get a warning about a different issue in that one-line change and
fixed it up in the wrong way without testing again. Sorry about that.

I'll retest and resend.

      Arnd
