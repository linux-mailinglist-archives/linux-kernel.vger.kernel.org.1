Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2984D2FF7BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 23:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbhAUWII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 17:08:08 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:63130 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbhAUWIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 17:08:01 -0500
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 10LM74Ga018049
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 07:07:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 10LM74Ga018049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1611266825;
        bh=MjWZFSssMPbyWrPt1Q7VeUt87lBCgSnFjOoettOI7mc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hA4NS2VPgMbXelAT7IVcZktkuQltTMYqMXSG0ayROijmyCFBnYwm5gw0ZI/zTQe91
         K6egCmV8OYyFak3fzOecWreEDmvei5DS+zyCHDcme5JSlYY9f0WL+piHUDOj5yzyK6
         JpYbWiFk9Og/dt4r8CHG1B1ivT3iPEXhI0Y6yJSGtuGJE5YmJEBVX0AhB/l1aJI7Xy
         ZlforJtUHtNA+YVFd4vOsUGh3lLJJgpDuUc+Z6goRf51IZo6hFsJxa7O1++H8ckBv3
         V/xyXS/bE+UGgnS5UoeVJoz4esfwvoMeGFHWNbaKWUAOmiqHSBTFDcI6wVQ/PM/w14
         A0cqdyjOy2Sow==
X-Nifty-SrcIP: [209.85.210.172]
Received: by mail-pf1-f172.google.com with SMTP id i63so2365630pfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 14:07:04 -0800 (PST)
X-Gm-Message-State: AOAM532qDZ/TyNMdTVOVELa/70KUdJhGcPmxV3PIxqTMlz07DvEhw5Cz
        cauazFTiLs6fh/lAfnobY6EolfaKuimahek6/1g=
X-Google-Smtp-Source: ABdhPJzOTrs51F64/7+tiY00uNsvZJqdeT6syyZfBtQQk6TdnoI0U5xwGCZ2RXYLsUVS9Ai3+SGtJiOPdE+Cb/GJLtA=
X-Received: by 2002:a63:ff09:: with SMTP id k9mr1418784pgi.175.1611266824104;
 Thu, 21 Jan 2021 14:07:04 -0800 (PST)
MIME-Version: 1.0
References: <20210121170736.2266-1-scott.branden@broadcom.com>
 <CAK7LNAQEvej1_UrS6s1+vwdei8cK1UW8b5erYc-6Ggu25oC0cg@mail.gmail.com>
 <CAHp75Vf=Ba+e8PDsvi8eDiuNDvC6Pfx3RsRAkaOZvD26Z2pnQA@mail.gmail.com> <CAHp75VcLi8hjYaDXrfAjbj+Kw_FRef=xnKiXr_Kv+YUToEjHTQ@mail.gmail.com>
In-Reply-To: <CAHp75VcLi8hjYaDXrfAjbj+Kw_FRef=xnKiXr_Kv+YUToEjHTQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 22 Jan 2021 07:06:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNARL570EgjijCMY_CF91frwtTeatyhYcnD8-s08aiduFnQ@mail.gmail.com>
Message-ID: <CAK7LNARL570EgjijCMY_CF91frwtTeatyhYcnD8-s08aiduFnQ@mail.gmail.com>
Subject: Re: [PATCH] diffconfig: use python3 instead of python in Shebang line
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Fri, Jan 22, 2021 at 5:35 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Jan 21, 2021 at 10:31 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Thu, Jan 21, 2021 at 10:28 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > On Fri, Jan 22, 2021 at 2:17 AM Scott Branden
> > > <scott.branden@broadcom.com> wrote:
> > > >
> > > > Use python3 instead of python in diffconfig Shebang line.
> > > > python2 was sunset January 1, 2000 and environments do not need
> > > > to support python any more.
> >
> > > Just from curiosity, what problem is this solving?
> > >
> > > Is there a distribution where 'python' does not exist,
> > > but 'python3' does ?
> >
> > Yes. Called surprise surprise Debian
> > An it's a rare case when I agree with them.
>
> For the record, you seems haven't noticed:
> https://lkml.org/lkml/2020/12/9/446


Ohh, I missed it.
I know many patches are falling into a crack.

To respect the first submitter, and it solves
another file, I just picked up Andy's one.


I use Ubuntu, where /usr/bin/python is a symlink
to /usr/bin/python3.

I just booted Debian in a VM, and confirmed
/usr/bin/python no longer exists.

Thanks for the explanation.




-- 
Best Regards
Masahiro Yamada
