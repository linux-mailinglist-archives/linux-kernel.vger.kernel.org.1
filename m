Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DE128E2EA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbgJNPQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgJNPQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:16:09 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B442C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 08:16:09 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id a9so4117615lfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 08:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A7qeE0xxnpiHLWpKKf8QKG7pIbitiCpMmVRMPiNJEvg=;
        b=jaKzuw9U24cGoWFshi7QjL1pX/No9vxWKw/p9l7BKt6IZBi2TE61Zaz87kULACr63K
         ciWrH8LB4V3BpJCDruLP32cBLohI9dhPPE32KnX42FL/pm9CYKaULkCZq1sWXGtmJqQd
         z4aXKrFnSiuvRA+10GQEmAt9mlckLfmuyrmiJ8r3CEygXw7gMKElEg7FXjzSYHIvLZEC
         AfrmStpojx2A+mx1Ctyoqnh0PougGKNgdPIC9sBNuQaXtQadEaXz55Mda/buMkkPfjWP
         6V6IBj22WEsi68mO2Q8705BE6AS4heBLjJoMg5ho3jdaemN9a7FQ2d8S51xqxZ4JnlRH
         vmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A7qeE0xxnpiHLWpKKf8QKG7pIbitiCpMmVRMPiNJEvg=;
        b=HH6khRlSwpa1uDZJbup+QIerMsnHcPXKVmSvugzQeoapEB9GufN+nhlNryz6ftc8JQ
         ezrqo6t2cSSzvsJbuH2MQZ/6YCKo+/NIMpmQWpyzGW+kTddIlYQlxtIrUg0pcv/GjwNY
         I4ORHHK1q0/qr/ov6e2a9wdNpgS0mScQ6Rq7eJvCuuKthGZlgJkLRDX0wGSGOgeCkhQ3
         Sp/ffahDA4jkpHa6atyobkbZrUHRma13ev8PzBYiQuxJcWODEXEc4oUibc48amO+LnJP
         zLRzbKEe3ctrMfNurx000lgNGefxnQR+10Vc3tZefBcbSaXV/yVIvAVBY7LNdF8ETsDk
         AIzQ==
X-Gm-Message-State: AOAM5336S+9NvdSRKKoquPOYs2BISdw7Cx38UPzjNHlwXpogbMlPLaKr
        mER2INEgB4wYcWbGwtq+PLgfaqQ0rVlD6S8eW4Mn+RzWSGw=
X-Google-Smtp-Source: ABdhPJzaLdN+oqtNX+c0wup488Kb9hx6M7ZG7oLWR1eqEkXOQKARrb113qRN7kjHUBGaGyUDe7MFyW7a2RIbCfBL1Ms=
X-Received: by 2002:ac2:4149:: with SMTP id c9mr1483019lfi.412.1602688567488;
 Wed, 14 Oct 2020 08:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <njB1czX0ZgWPR9h61euHIBb5bEyePw9D4D2m3i5lc9Cl96P8Q1308dTcmsEZW7Vtz3Ifz4do-rOtSfuFTyGoEDYokkK2aUqBePVptzZEWfU=@protonmail.com>
 <6bOOjFIyEwIPNLoY3wMdLuKENpcumphiNztVz7xDofD2Pkyv61mvDghklDSA3xNNCm7pC6XvqNeTCJ7vt1MsjrJZN5i0mbPK7YkE8Jgi1uw=@protonmail.com>
In-Reply-To: <6bOOjFIyEwIPNLoY3wMdLuKENpcumphiNztVz7xDofD2Pkyv61mvDghklDSA3xNNCm7pC6XvqNeTCJ7vt1MsjrJZN5i0mbPK7YkE8Jgi1uw=@protonmail.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Thu, 15 Oct 2020 00:15:55 +0900
Message-ID: <CAC5umyhd5pikGHEtZmjR3+10w1z3J9G6skXC7xSgC4zE=h36XA@mail.gmail.com>
Subject: Re: [PATCH] fault-injection: handle EI_ETYPE_TRUE
To:     =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Please consider taking this patch in the -mm tree.

This patch looks good to me.

Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>

2020=E5=B9=B410=E6=9C=8813=E6=97=A5(=E7=81=AB) 18:31 Barnab=C3=A1s P=C5=91c=
ze <pobrn@protonmail.com>:
>
> Hi,
>
> I had some difficulty finding who should receive this patch, and I am not
> sure I got it right. Could someone please confirm that any of you
> can take this patch, or should I resend it? (In that case, to whom?)
>
>
> Thank you,
> Barnab=C3=A1s P=C5=91cze
>
>
> > Commit af3b854492f351d1ff3b4744a83bf5ff7eed4920
> > ("mm/page_alloc.c: allow error injection")
> > introduced EI_ETYPE_TRUE, but did not extend
> >
> > -   lib/error-inject.c:error_type_string(), and
> > -   kernel/fail_function.c:adjust_error_retval()
> >     to accommodate for this change.
> >
> >     Handle EI_ETYPE_TRUE in both functions appropriately by
> >
> > -   returning "TRUE" in error_type_string(),
> > -   adjusting the return value to true (1) in adjust_error_retval().
> >
> >     Furthermore, simplify the logic of handling EI_ETYPE_NULL
> >     in adjust_error_retval().
> >
> >     Signed-off-by: Barnab=C3=A1s P=C5=91cze pobrn@protonmail.com
> >
> >
> > kernel/fail_function.c | 6 +++---
> > lib/error-inject.c | 2 ++
> > 2 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/fail_function.c b/kernel/fail_function.c
> > index 63b349168da7..4fdea01c0561 100644
> > --- a/kernel/fail_function.c
> > +++ b/kernel/fail_function.c
> > @@ -37,9 +37,7 @@ static unsigned long adjust_error_retval(unsigned lon=
g addr, unsigned long retv)
> > {
> > switch (get_injectable_error_type(addr)) {
> > case EI_ETYPE_NULL:
> >
> > -         if (retv !=3D 0)
> >
> >
> > -             return 0;
> >
> >
> > -         break;
> >
> >
> >
> > -         return 0;
> >
> >
> >     case EI_ETYPE_ERRNO:
> >     if (retv < (unsigned long)-MAX_ERRNO)
> >     return (unsigned long)-EINVAL;
> >     @@ -48,6 +46,8 @@ static unsigned long adjust_error_retval(unsigned=
 long addr, unsigned long retv)
> >     if (retv !=3D 0 && retv < (unsigned long)-MAX_ERRNO)
> >     return (unsigned long)-EINVAL;
> >     break;
> >
> > -   case EI_ETYPE_TRUE:
> > -         return 1;
> >
> >
> >     }
> >
> >     return retv;
> >     diff --git a/lib/error-inject.c b/lib/error-inject.c
> >     index aa63751c916f..c73651b15b76 100644
> >     --- a/lib/error-inject.c
> >     +++ b/lib/error-inject.c
> >     @@ -180,6 +180,8 @@ static const char *error_type_string(int etype)
> >     return "ERRNO";
> >     case EI_ETYPE_ERRNO_NULL:
> >     return "ERRNO_NULL";
> >
> > -   case EI_ETYPE_TRUE:
> > -         return "TRUE";
> >
> >
> >     default:
> >     return "(unknown)";
> >     }
> >     --
> >     2.28.0
> >
