Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C742E0CCD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 16:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgLVPdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 10:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbgLVPdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 10:33:40 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EE3C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 07:32:59 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id o195so3106708vka.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 07:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sCCWkD/7cQKPFXtewXveIGY2SqGtgyK9cV2bzmLn1iY=;
        b=eJ9AZPbWNoxrprRr7Td1v3jTzH5E7goKQ08BrweW7k7WC7UYuAREWRWJ1hwoMkL6/v
         a6S2ulSlqsq9T75ssxl6m4wYB3+0M/Kc8JKlhDYAGGwP8vRu1n5BraDIybrvZ9tzlkGJ
         WXKksnT1J14sMbzI1C/DATLEyYSkr2cXxIVKSMbDz7r04WK7jVxTdd9uQktNv5F90eaA
         KSgukhsE1y0aLn4WffVlKr2hzxy7YoVPkGWu/KLi2+gPADfzIcUWcUXsSgvkmOpxQq3c
         TGxBC4H0o8DmGFUalrBswoSYf4peX5jvvTf9Mtve94lP0Aa16NVm6WAPUswUbtJ93AMP
         Y2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sCCWkD/7cQKPFXtewXveIGY2SqGtgyK9cV2bzmLn1iY=;
        b=hW5eiDicmXFYIkWdFZRFeBvr0A86MmQuNFQdlmZzG5qny7NUKXl34SVA7JgJ/ImkAs
         QKbW/N/ke63CUcAaEaOo3IGcu7dyPjRGZJMa2mX/J/wfmqOqOwBMP86zdSOD1AOvPxWb
         qeAUXp8eQ9kHyMmt3nZnf8xKlh5UDJKIe9aU9zGh189n8pkMTUvEbS6ZTc25UdHoWktK
         srbsTn8QVYiMqx+CIYAVz1ipVs5bLeCwHK0sg0FXc3veWA6MHAethEzyOKH2+yY3U1tP
         XEYIlE0MWePpXB2zq96CmQFnF5V5a7HMiEgI1nQ4H3uxIfio/+58wPEb7VziLGTrcBmJ
         Cv5g==
X-Gm-Message-State: AOAM532p83LwXJSrfPcFZ7wmczMl1glF8+Ds793zxkrCDJ2oI5mHEQAh
        bg+afj+T1u0QhfwaUTG0LyQSoKj5owK7nm+b+kM=
X-Google-Smtp-Source: ABdhPJw9mRX/xeSGCJ1cnXOEv2fpcO1VPs/9HviH6a5y1VLGkIkoB8tS6sbhoTzLipJDioUaypwXyAH3A63WH1enEsg=
X-Received: by 2002:a1f:a796:: with SMTP id q144mr8906878vke.19.1608651178945;
 Tue, 22 Dec 2020 07:32:58 -0800 (PST)
MIME-Version: 1.0
References: <20201222121904.50845-1-qianjun.kernel@gmail.com> <CAFqt6zbVSnHoU54ZaOEcHAEvO96h0X6wQaNrjxqgGkgmD4Vqdw@mail.gmail.com>
In-Reply-To: <CAFqt6zbVSnHoU54ZaOEcHAEvO96h0X6wQaNrjxqgGkgmD4Vqdw@mail.gmail.com>
From:   jun qian <qianjun.kernel@gmail.com>
Date:   Tue, 22 Dec 2020 23:32:48 +0800
Message-ID: <CAKc596KAQodOKCraMy=rcFBsh_CbaV2YG61QRqX8HqutGnE52g@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm:improve the performance during fork
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Souptick Joarder <jrdr.linux@gmail.com> =E4=BA=8E2020=E5=B9=B412=E6=9C=8822=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8811:08=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Tue, Dec 22, 2020 at 5:49 PM <qianjun.kernel@gmail.com> wrote:
> >
> > From: jun qian <qianjun.kernel@gmail.com>
> >
> > In our project, Many business delays come from fork, so
> > we started looking for the reason why fork is time-consuming.
> > I used the ftrace with function_graph to trace the fork, found
> > that the vm_normal_page will be called tens of thousands and
> > the execution time of this vm_normal_page function is only a
> > few nanoseconds. And the vm_normal_page is not a inline function.
> > So I think if the function is inline style, it maybe reduce the
> > call time overhead.
> >
> > I did the following experiment:
> >
> > I have wrote the c test code, pls ignore the memory leak :)
> > Before fork, I will malloc 4G bytes, then acculate the fork
> > time.
> >
> > int main()
> > {
> >         char *p;
> >         unsigned long long i=3D0;
> >         float time_use=3D0;
> >         struct timeval start;
> >         struct timeval end;
> >
> >         for(i=3D0; i<LEN; i++) {
> >                 p =3D (char *)malloc(4096);
> >                 if (p =3D=3D NULL) {
> >                         printf("malloc failed!\n");
> >                         return 0;
> >                 }
> >                 p[0] =3D 0x55;
> >         }
> >         gettimeofday(&start,NULL);
> >         fork();
> >         gettimeofday(&end,NULL);
> >
> >         time_use=3D(end.tv_sec * 1000000 + end.tv_usec) -
> >                 (start.tv_sec * 1000000 + start.tv_usec);
> >         printf("time_use is %.10f us\n",time_use);
> >
> >         return 0;
> > }
> >
> > We need to compare the changes in the size of vmlinux, the time of
> > fork in inline and non-inline cases, and the vm_normal_page will be
> > called in many function. So we also need to compare this function's
> > size. For examples, the do_wp_page will call vm_normal_page, so I
> > also calculated it's size.
> >
> >                   inline           non-inline       diff
> > vmlinux size      9709248 bytes    9709824 bytes    -576 bytes
> > fork time         23475ns          24638ns          -4.7%
>
> Do you have time diff for both parent and child process ?

yes, the child time diff and the parent time diff are almost same,
just like this, a.out is the test program.

./a.out
time_use is 23342.0000000000 us
time_use is 23404.0000000000 us

>
> > do_wp_page size   972              743              +229
> >
> > According to the above test data, I think inline vm_normal_page can
> > reduce fork execution time.
> >
> > Signed-off-by: jun qian <qianjun.kernel@gmail.com>
> > ---
> >  mm/memory.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 7d608765932b..a689bb5d3842 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -591,7 +591,7 @@ static void print_bad_pte(struct vm_area_struct *vm=
a, unsigned long addr,
> >   * PFNMAP mappings in order to support COWable mappings.
> >   *
> >   */
> > -struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long =
addr,
> > +inline struct page *vm_normal_page(struct vm_area_struct *vma, unsigne=
d long addr,
> >                             pte_t pte)
> >  {
> >         unsigned long pfn =3D pte_pfn(pte);
> > --
> > 2.18.2
> >
> >
