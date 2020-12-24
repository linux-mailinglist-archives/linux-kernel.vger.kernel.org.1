Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679B92E23F8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 04:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgLXDNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 22:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbgLXDNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 22:13:04 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D195C06179C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 19:12:24 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id c12so531965pfo.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 19:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EbypRiS+9PLfGMqxSxXC547WEWfIQ4iF1EiMz2Usxn0=;
        b=1+669ZjdqM7iT1NhCq2oNw//9yauIL84PQhZQMQqRRlPcoM32NuiQmvi4Q/K1xpVrH
         swN8EnBuUMcBmrUjQ42Ci5mX9KvModAtHnhBX6tOXTiNds0Wh8vhZaRN/s3yf8RPXLeB
         cyfHedBxluRyZD2OlYcsypi+2UUNUsW8eHFNBLhgpNnBSAzV+RvFBZ2udeKP6zJyHNqL
         1r7c4lmWwPq+QFQPrNTQy9otiYfBm/QyTTyK8qhWtbJD811CFgFjJ1SsPilhd/w5ghef
         SUVAD+Xi0vm4/A49Ou2o6GHswa/sc40RUXwIqtVD9Pu8X6wDxO6ODMAg0ifDXU8yTRq3
         cR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EbypRiS+9PLfGMqxSxXC547WEWfIQ4iF1EiMz2Usxn0=;
        b=ICwVfZs3j26Gx8eS6irDEG5Jsi/5RwxTvFqaZFMawfNctoAfl6xJJQkjkNxAKOzSao
         cgyX+pppxmt0/ybtGxeLDm63o2b4qmhWP8w1Wn2M3TtxvW5az6XLVeE22Gf+C/MgLt5+
         ByHYquobHlYDWVdPyynv4aeKNJd68prK7+Z+ANedLRpDfxbJDhTdHT3Bxuuc1NHUBvU9
         VvUkkA7nbQi2vt2qQeTNTrzey5MZzMgGvjA8DT0NFkx4lmpkXVY8hMiUqKu4AkqBQAhr
         J+pgz8ihBKzg+MfwW8sa+jNVaOUz6M5bAbq8Y1JrqBHAPKu1oJrvI3bJ+LrUXqG5Vrqk
         ZZDA==
X-Gm-Message-State: AOAM5329srHF37Ic+PqmpGt3M4D3zVcCfPNe5a2vRfRlqIJ20+2zojsj
        wjQQVKsfy9G0k/Vi0i3eE3n9+GTIEGebqrR6b6fORg==
X-Google-Smtp-Source: ABdhPJx9C3d/DmC7+EMAdHwkpdH81cpBPXMiiZ/K4MGw43gwXske/acVfm3oRuv2s/okVoIxwisyKYUQGcOvtgboyA0=
X-Received: by 2002:aa7:8701:0:b029:19e:561:d476 with SMTP id
 b1-20020aa787010000b029019e0561d476mr6837324pfo.2.1608779543625; Wed, 23 Dec
 2020 19:12:23 -0800 (PST)
MIME-Version: 1.0
References: <20201224001635.5H0RjpkF_%akpm@linux-foundation.org> <a7b46040-2980-c2f4-45ea-1fa38f36d351@infradead.org>
In-Reply-To: <a7b46040-2980-c2f4-45ea-1fa38f36d351@infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 24 Dec 2020 11:11:47 +0800
Message-ID: <CAMZfGtVvoQA00zENRzURHTomVgNvNYxXiX2rUkimYfOFt26P8Q@mail.gmail.com>
Subject: Re: [External] Re: mmotm 2020-12-23-16-15 uploaded (mm/vmstat.c)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        mhocko@suse.cz, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 24, 2020 at 10:57 AM Randy Dunlap <rdunlap@infradead.org> wrote=
:
>
> On 12/23/20 4:16 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2020-12-23-16-15 has been uploaded to
> >
> >    https://www.ozlabs.org/~akpm/mmotm/
> >
> > mmotm-readme.txt says
> >
> > README for mm-of-the-moment:
> >
> > https://www.ozlabs.org/~akpm/mmotm/
> >
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> >
> > You will need quilt to apply these patches to the latest Linus release =
(5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated=
 in
> > https://ozlabs.org/~akpm/mmotm/series
> >
> > The file broken-out.tar.gz contains two datestamp files: .DATE and
> > .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss=
,
> > followed by the base kernel version against which this patch series is =
to
> > be applied.
>
> on i386 or UML on i386 or x86_64:
> (and probably on x86_64, but my builds haven't got there yet)
>
> when CONFIG_TRANSPARENT_HUGEPAGE is not set/enabled:

Very thanks for your information. I will fix this in the next version. Than=
ks.

>
> ../mm/vmstat.c: In function =E2=80=98zoneinfo_show_print=E2=80=99:
> ./../include/linux/compiler_types.h:320:38: error: call to =E2=80=98__com=
piletime_assert_269=E2=80=99 declared with attribute error: BUILD_BUG faile=
d
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>                                       ^
> ./../include/linux/compiler_types.h:301:4: note: in definition of macro =
=E2=80=98__compiletime_assert=E2=80=99
>     prefix ## suffix();    \
>     ^~~~~~
> ./../include/linux/compiler_types.h:320:2: note: in expansion of macro =
=E2=80=98_compiletime_assert=E2=80=99
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>   ^~~~~~~~~~~~~~~~~~~
> ../include/linux/build_bug.h:39:37: note: in expansion of macro =E2=80=98=
compiletime_assert=E2=80=99
>  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                      ^~~~~~~~~~~~~~~~~~
> ../include/linux/build_bug.h:59:21: note: in expansion of macro =E2=80=98=
BUILD_BUG_ON_MSG=E2=80=99
>  #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>                      ^~~~~~~~~~~~~~~~
> ../include/linux/huge_mm.h:325:28: note: in expansion of macro =E2=80=98B=
UILD_BUG=E2=80=99
>  #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
>                             ^~~~~~~~~
> ../include/linux/huge_mm.h:106:26: note: in expansion of macro =E2=80=98H=
PAGE_PMD_SHIFT=E2=80=99
>  #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
>                           ^~~~~~~~~~~~~~~
> ../include/linux/huge_mm.h:107:26: note: in expansion of macro =E2=80=98H=
PAGE_PMD_ORDER=E2=80=99
>  #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
>                           ^~~~~~~~~~~~~~~
> ../mm/vmstat.c:1630:14: note: in expansion of macro =E2=80=98HPAGE_PMD_NR=
=E2=80=99
>      pages /=3D HPAGE_PMD_NR;
>               ^~~~~~~~~~~~
> ../mm/vmstat.c: In function =E2=80=98vmstat_start=E2=80=99:
> ./../include/linux/compiler_types.h:320:38: error: call to =E2=80=98__com=
piletime_assert_271=E2=80=99 declared with attribute error: BUILD_BUG faile=
d
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>                                       ^
> ./../include/linux/compiler_types.h:301:4: note: in definition of macro =
=E2=80=98__compiletime_assert=E2=80=99
>     prefix ## suffix();    \
>     ^~~~~~
> ./../include/linux/compiler_types.h:320:2: note: in expansion of macro =
=E2=80=98_compiletime_assert=E2=80=99
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>   ^~~~~~~~~~~~~~~~~~~
> ../include/linux/build_bug.h:39:37: note: in expansion of macro =E2=80=98=
compiletime_assert=E2=80=99
>  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                      ^~~~~~~~~~~~~~~~~~
> ../include/linux/build_bug.h:59:21: note: in expansion of macro =E2=80=98=
BUILD_BUG_ON_MSG=E2=80=99
>  #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>                      ^~~~~~~~~~~~~~~~
> ../include/linux/huge_mm.h:325:28: note: in expansion of macro =E2=80=98B=
UILD_BUG=E2=80=99
>  #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
>                             ^~~~~~~~~
> ../include/linux/huge_mm.h:106:26: note: in expansion of macro =E2=80=98H=
PAGE_PMD_SHIFT=E2=80=99
>  #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
>                           ^~~~~~~~~~~~~~~
> ../include/linux/huge_mm.h:107:26: note: in expansion of macro =E2=80=98H=
PAGE_PMD_ORDER=E2=80=99
>  #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
>                           ^~~~~~~~~~~~~~~
> ../mm/vmstat.c:1755:12: note: in expansion of macro =E2=80=98HPAGE_PMD_NR=
=E2=80=99
>     v[i] /=3D HPAGE_PMD_NR;
>             ^~~~~~~~~~~~
>
> due to <linux/huge_mm.h>:
>
> #else /* CONFIG_TRANSPARENT_HUGEPAGE */
> #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
> #define HPAGE_PMD_MASK ({ BUILD_BUG(); 0; })
> #define HPAGE_PMD_SIZE ({ BUILD_BUG(); 0; })
>
> #define HPAGE_PUD_SHIFT ({ BUILD_BUG(); 0; })
> #define HPAGE_PUD_MASK ({ BUILD_BUG(); 0; })
> #define HPAGE_PUD_SIZE ({ BUILD_BUG(); 0; })
>
>
>
> >> mm-memcontrol-convert-nr_anon_thps-account-to-pages.patch
>
> --
> ~Randy
>


--=20
Yours,
Muchun
