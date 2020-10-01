Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29466280B78
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbgJAX4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgJAX4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:56:18 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A19C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:56:18 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a3so312715ejy.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=huRrm9uRTF6EQtP3Gb3rzv3n9rl5QC5dhEPKA1yWUwo=;
        b=XaP00L7EdhotRxKDmoF2aYq7K8neRHGRpPiSpCbWUMRbbHRzomvmHNio8rp7Bqld9k
         6sTEPllvCqsoowPLp5OqORiyIKcW9T3Nnve22rGNj4up9gkv9fvV2sJFnhhzQLH9spc7
         gPewysecSzSqjCaI+kmUiKHcR15RTvcZsOcPERvYwkc3XKv+DA31+BNxlkYr0Yine0qq
         Wn5Q8Hjelz1j02imtNEGqQTx471nFgRWf41hl+blA8s+LvRVTgtDr6cdpTmNQIDKZ0dL
         DK6OwtyNLs0JS6FjQKc/0mTfkd/D6xAZVyFdtmlAKKd2kHweSimVSSihZbvTfZk8q9CE
         Q36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=huRrm9uRTF6EQtP3Gb3rzv3n9rl5QC5dhEPKA1yWUwo=;
        b=cPURqjAN7gCoEdXWZsd1GJ00CupifpSHp24IvSc2plRgqXININ2wftzw9JfI64vJEe
         jef+zsu9BdPCXA07b2VWxTY/2VVYuQ/LBKn30crXm1Q1Dlg2K05hsmddL0c95ZMvxM4L
         Un2cy7T5C+RNohParOPX0JeHQGz3w2Oze2+FP2ompmwnqR+to38dsPp5fmzaXysy3KoK
         uqP8p8njgfvq/w9utAF+dmbtbCuvUvhMmMel5UtKoTph+bqTPOTVbMRz8zcfPxpDfRoh
         78lP5iTK/UZmlxJLUoevhnU47Fcv0622WZOmRGeM0Wg7esGHmZboGfzs0ZwIbVOsE+9g
         2+Xw==
X-Gm-Message-State: AOAM530oMBu1QFYgPAO5dcZVUpQCPPLfgUQUHL4e70nLltEz9j5Y9PSb
        l0SS+eohBhtvWUuC0yYdXiPHyJmu8NSUTGP43fHQEw==
X-Google-Smtp-Source: ABdhPJzY0cXU4m7Tu4YFGGwKpafVHVFUjH9rQpY1NNEXp84S0DHdO+CZPKylkQGHz77THxSw1DQrSf3fLkRHOcjxDTw=
X-Received: by 2002:a17:906:980f:: with SMTP id lm15mr11072385ejb.184.1601596577053;
 Thu, 01 Oct 2020 16:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200930011944.19869-1-jannh@google.com> <CAG48ez03YJG9JU_6tGiMcaVjuTyRE_o4LEQ7901b5ZoCnNAjcg@mail.gmail.com>
 <20200930123000.GC9916@ziepe.ca> <CAG48ez2z1R8MLS0_pjhBSGnJC8RwaHMpiGdv8GhJUCrwtsLOPg@mail.gmail.com>
 <CAG48ez0fhY0twgriBDv9RU1YG8mBxg_KoK_YsLPWYo4feAQ=Sg@mail.gmail.com>
 <20200930232655.GE9916@ziepe.ca> <CAG48ez0i2++2Jg1Z-RyCKn-uZ-gcszVknAaCyXbJyptuMxbCsg@mail.gmail.com>
 <20201001191512.GF9916@ziepe.ca> <CAG48ez3GW9sRfZWwx+YpKdouAVT+o9zQR73-itJMbLCXTiUxBw@mail.gmail.com>
 <20201001234127.GG9916@ziepe.ca>
In-Reply-To: <20201001234127.GG9916@ziepe.ca>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 2 Oct 2020 01:55:51 +0200
Message-ID: <CAG48ez3pvgEYiGziw=_3wVQ5mDrWWyLD_DidoB+L4Zu=bb=KqQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] mmap locking API: Don't check locking if the mm isn't
 live yet
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 2, 2020 at 1:41 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Thu, Oct 01, 2020 at 10:16:35PM +0200, Jann Horn wrote:
> > > A subclass isn't right, it has to be a _nested annotation.
> > >
> > > nested locking is a pretty good reason to not be able to do this, this
> > > is something lockdep does struggle to model.
> >
> > Did I get the terminology wrong? I thought they were the same. The
> > down_*_nested() APIs take an argument "subclass", with the default
> > subclass for the functions without "_nested" being 0.
>
> AFAIK a subclass at init time sticks with the lock forever, the
> _nested ones are temporary overrides.
>
> I think what you kind of want is to start out with
> lockdep_set_novalidate_class() then switch to a real class once things
> are finished. Not sure exactly how :)

Huh, is there an API that sets a *subclass* (not a class) at init
time? I don't think there is.

Anyway, I'm pretty sure I just need to use the normal _nested()
locking API. I'm still cleaning up and testing a little bit, but I'll
send it out in a short while, unless I run into unexpected trouble.
Let's continue this if necessary once there's a concrete patch to talk
about. :)
