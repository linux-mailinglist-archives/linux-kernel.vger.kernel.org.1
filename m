Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464A72D079C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 23:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgLFWJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 17:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbgLFWJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 17:09:38 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01DEC0613D1
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 14:08:58 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id o25so13332982oie.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 14:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JCel08KYiln8YgmkxbPOj1WtQ5EQrMdu3OBxwf9clAs=;
        b=MOSPkYY7RXc+BAeMcL2aCrKADmNx83Ql7gOgBElBF/2aDvhrhz9CCFufS1EbGNlikx
         dzly5xco1sNTjqLr42kAZHPE/TSrjMEaaAnG07IbxhGmzQU/dQXSKdOYHEL10inJCcfI
         PLLdMweU/W25zuT0IdGjA7RB6jyYeaeJxveLCMaN33YjDhF1R64JE7otIEUh7wB+IJXN
         G7LiDRZeR0c+aoBzaL87mXlL11DDh0xNvktlmbNgCsBLx7l+OYh85/vWTHg2+v+y2WFA
         jdasEnBVq5zNje1/6hLGvppUsJ36LvsMy9oeCUre4BXdgFaoqmIEI2hycWMtzQnZX6yQ
         QNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JCel08KYiln8YgmkxbPOj1WtQ5EQrMdu3OBxwf9clAs=;
        b=YgRUK8LTxs/qcS0nMXSoWjBifiSz6a5/+4r1FGQI4zOn343qsB/zsBc/jhbYcw1/45
         eUN8apw5IooPMbtSFFASP+0PfgiiVKfUDBJvHL60rp7TU0vqVXqEe3JVimW4tD/6TJKj
         DZzrI17okO5PlOWagx4vV/eTH/qBaVxN1DSfMxK+HhMvBnLMkUH6LDRZ05xGCoOgJyWV
         glIaMrGHTic0RhRMCdJEi4LE5pdIbmMw2MCDPwy0KIsCO9qewbiwaNI8v6R8h5C56wtZ
         rJV+l0h3JIXDGyUwskcXbTRI72/DpmRStNNH6HiLziHXtAKeECbMxpOLxoHSFVRxyCcr
         7w1w==
X-Gm-Message-State: AOAM531L7AUGeCXrA51uK/PwREhHefLLvYTVtgmWhNOlPzz0QaiND+GI
        cXJYTbO3Z8IoPNynaCH2yWF+6a67K/zpxTnIKV/PVA==
X-Google-Smtp-Source: ABdhPJybJRXrC+5WZsdCuGBMO8dLeix5tmfJ7XfDav/VhIdMKb7kcyrkA0xVqSrC0pQ1nPYKPLPCFebkBpqZbtB5WvU=
X-Received: by 2002:a05:6808:313:: with SMTP id i19mr10498856oie.70.1607292537946;
 Sun, 06 Dec 2020 14:08:57 -0800 (PST)
MIME-Version: 1.0
References: <20201205172207.GA4097@rlk> <20201207082300.38f5207f@canb.auug.org.au>
In-Reply-To: <20201207082300.38f5207f@canb.auug.org.au>
From:   Marco Elver <elver@google.com>
Date:   Sun, 6 Dec 2020 23:08:46 +0100
Message-ID: <CANpmjNPifOwd9w34dSJhsvmP2sUkKa0ESPiJ7gj+gUDffhPO3A@mail.gmail.com>
Subject: Re: [PATCH][next] arm64: fix the mm build error in mm/kfence/core.c
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Hui Su <sh_def@163.com>, Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Dec 2020 at 22:23, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> [Cc'd Andrew Morton]
>
> On Sun, 6 Dec 2020 01:22:07 +0800 Hui Su <sh_def@163.com> wrote:
> >
> > When I build kernel with ARCH=3Darm64, the building errors came out lik=
e
> > this:
> >   CC      mm/kfence/core.o
> > In file included from ../mm/kfence/core.c:21:
> > ../arch/arm64/include/asm/kfence.h: In function =E2=80=98kfence_protect=
_page=E2=80=99:
> > ../arch/arm64/include/asm/kfence.h:12:2: error: implicit declaration of
> > function =E2=80=98set_memory_valid=E2=80=99 [-Werror=3Dimplicit-functio=
n-declaration]
> >    12 |  set_memory_valid(addr, 1, !protect);
> >       |  ^~~~~~~~~~~~~~~~
> > cc1: some warnings being treated as errors
> >
> > which introduced by commit d54febeba2ff ("kfence: use pt_regs to
> > generate stack trace on faults").
> >
> > Signed-off-by: Hui Su <sh_def@163.com>
> > ---
> >  arch/arm64/include/asm/kfence.h | 1 +
> >  1 file changed, 1 insertion(+)

Thanks, but a patch for this is already in the -mm tree:
https://lore.kernel.org/mm-commits/20201205011409.o9PNsRntR%25akpm@linux-fo=
undation.org/

Perhaps try the latest -next?

> > diff --git a/arch/arm64/include/asm/kfence.h b/arch/arm64/include/asm/k=
fence.h
> > index 6c0afeeab635..4d73e34da59d 100644
> > --- a/arch/arm64/include/asm/kfence.h
> > +++ b/arch/arm64/include/asm/kfence.h
> > @@ -4,6 +4,7 @@
> >  #define __ASM_KFENCE_H
> >
> >  #include <asm/cacheflush.h>
> > +#include <linux/set_memory.h>
> >
> >  static inline bool arch_kfence_init_pool(void) { return true; }
> >
> > --
> > 2.25.1
>
> Added to linux-next today.  I think it actually fixes patch "arm64,
> kfence: enable KFENCE for ARM64" since that actually introduces the
> set_memory_valid() call?

The patch that moved the declaration was after the kfence patch, so
it'd be the other way around:
https://lkml.kernel.org/r/X8otwahnmGQGLpge@elver.google.com

Thanks,
-- Marco
