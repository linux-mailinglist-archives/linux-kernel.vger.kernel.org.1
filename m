Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A4B2D18A3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgLGSgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 13:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgLGSgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:36:42 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9172FC061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 10:36:01 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id g185so168599wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 10:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sZOgv3xcokPLhDzvLVyYWi3ueTGnJMpnjn9OpxMl6jw=;
        b=VwH5wxITOs/+VSsv82jxPZFxmVGt/GU6UgzwDBxuQ57FHPWVknF0zp0wsnDqNrBmjs
         pjWaHzit3H1/xLWj3PSy/nnuJZW5aC1ThTJDOQxWZr4KlGcfu55U6kQZMB57Weg8b0Nn
         NnVBYe4cr2v3xBo9uG+zc13dmk9egbuXkXVGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sZOgv3xcokPLhDzvLVyYWi3ueTGnJMpnjn9OpxMl6jw=;
        b=SfA31by6hc/jRhsSOEdipYXuhiJ/K1TCvPDznZvx8rGv3850WKCdgOGdla9vntcIt4
         U52fYFC91IKi+kgeZ6lZAVIPorczS9ndCqODOEnQ0ws/JMadSqYyUMBM9629cSJFjlkQ
         +yOJh749841O88sZN7wA/jCCWaDR2PIYJcC8+XCOA9iY5hT3SRVlaKU9Ak4bVfhFiy2r
         Z5p72TKbO3Rl3aMCfAvuRgvGpl006akElhdwJGq4b1qDfaJVUGTgfnkOvr8F5BEG/ABC
         RqFr0M3Ycnsy+HmNTmtnppRFdll1D3w8L3ADeB2ijj+PXY3Hml+CcatjrSymkQbIGExP
         ALNw==
X-Gm-Message-State: AOAM5308cXdn+KntYaIvLLF56SoILvkaYeYR7bfo1kkIwVMv+8fn0lyA
        xStrFOII2lhJAqc2N8XH2Vr7Evrz6AYGyISMump0XA==
X-Google-Smtp-Source: ABdhPJyoZZ2d/7ynUl6DmcUOF/oTR6F9qO1UGyXqmo1PnkijUw4Nsp0Je5eso5tLVDQHITsoCI8kk/lppieNU/t/xCU=
X-Received: by 2002:a1c:35c2:: with SMTP id c185mr186976wma.74.1607366160227;
 Mon, 07 Dec 2020 10:36:00 -0800 (PST)
MIME-Version: 1.0
References: <1604661895-5495-1-git-send-email-alex.shi@linux.alibaba.com>
 <CAFqt6zZU76NOF6uD_c1vRPmEHwOzLp9wEWAmSX2ficpQb0zf6g@mail.gmail.com>
 <20201110115037.f6a53faec8d65782ab65d8b4@linux-foundation.org>
 <ddca2a9e-ed89-5dec-b1af-4f2fd2c99b57@linux.alibaba.com> <20201207081556.pwxmhgdxayzbofpi@lion.mk-sys.cz>
In-Reply-To: <20201207081556.pwxmhgdxayzbofpi@lion.mk-sys.cz>
From:   Justin Forbes <jmforbes@linuxtx.org>
Date:   Mon, 7 Dec 2020 12:35:49 -0600
Message-ID: <CAFxkdApgQ4RCt-J43cK4_128pXr=Xn5jw+q0kOaP-TYufk_tPA@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: add static for function __add_to_page_cache_locked
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 2:16 AM Michal Kubecek <mkubecek@suse.cz> wrote:
>
> On Thu, Nov 12, 2020 at 08:18:57AM +0800, Alex Shi wrote:
> >
> >
> > =E5=9C=A8 2020/11/11 =E4=B8=8A=E5=8D=883:50, Andrew Morton =E5=86=99=E9=
=81=93:
> > > On Tue, 10 Nov 2020 08:39:24 +0530 Souptick Joarder <jrdr.linux@gmail=
.com> wrote:
> > >
> > >> On Fri, Nov 6, 2020 at 4:55 PM Alex Shi <alex.shi@linux.alibaba.com>=
 wrote:
> > >>>
> > >>> Otherwise it cause gcc warning:
> > >>>           ^~~~~~~~~~~~~~~
> > >>> ../mm/filemap.c:830:14: warning: no previous prototype for
> > >>> =E2=80=98__add_to_page_cache_locked=E2=80=99 [-Wmissing-prototypes]
> > >>>  noinline int __add_to_page_cache_locked(struct page *page,
> > >>>               ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > >>
> > >> Is CONFIG_DEBUG_INFO_BTF enabled in your .config ?
> > >
> > > hm, yes.
> >
> > When the config enabled, compiling looks good untill pahole tool
> > used to get BTF info, but I still failed on a right version pahole
> > > 1.16. Sorry.
> >
> > >
> > >>>
> > >>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> > >>> Cc: Andrew Morton <akpm@linux-foundation.org>
> > >>> Cc: linux-mm@kvack.org
> > >>> Cc: linux-kernel@vger.kernel.org
> > >>> ---
> > >>>  mm/filemap.c | 2 +-
> > >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/mm/filemap.c b/mm/filemap.c
> > >>> index d90614f501da..249cf489f5df 100644
> > >>> --- a/mm/filemap.c
> > >>> +++ b/mm/filemap.c
> > >>> @@ -827,7 +827,7 @@ int replace_page_cache_page(struct page *old, s=
truct page *new, gfp_t gfp_mask)
> > >>>  }
> > >>>  EXPORT_SYMBOL_GPL(replace_page_cache_page);
> > >>>
> > >>> -noinline int __add_to_page_cache_locked(struct page *page,
> > >>> +static noinline int __add_to_page_cache_locked(struct page *page,
> > >>>                                         struct address_space *mappi=
ng,
> > >>>                                         pgoff_t offset, gfp_t gfp,
> > >>>                                         void **shadowp)
> > >
> > > It's unclear to me whether BTF_ID() requires that the target symbol b=
e
> > > non-static.  It doesn't actually reference the symbol:
> > >
> > > #define BTF_ID(prefix, name) \
> > >         __BTF_ID(__ID(__BTF_ID__##prefix##__##name##__))
> > >
> >
> > The above usage make me thought BTF don't require the symbol, though
> > the symbol still exist in vmlinux with 'static'.
> >
> > So any comments of this, Alexei?
>
> It's probably more complicated: our v5.10-rc7 builds with
> CONFIG_DEBUG_INFO_BTF=3Dy fail on ppc64 and ppc64le with
>
>      BTFIDS  vmlinux
>    FAILED unresolved symbol __add_to_page_cache_locked
>
>
> but succeed on x86_64, i586, aarch64 and s390x. So far I don't see why
> this should depend on architecture.
>
Fedora is failing with rc7 on the same issue on PPC only.

Justin
