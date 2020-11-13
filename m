Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D18B2B1D04
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgKMOSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMOSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:18:08 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C33C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 06:18:08 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id w142so14009875lff.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 06:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6tBAwBzS7iwqCUewGR0y+Gc4bMGvCRT0xXoTY4P2mKg=;
        b=G95AmXiniU6+6+gndCRtrbAiQmgHotx7w7EJwmMNy6RoSo4LDZuMSsMpg1v8ZCZ708
         ab0PqXEZcVJNselEJQCZtL6cTw7nqudpLwkYXkAbw3PV3dXRo48YYfaJt3e2P6oTb/IP
         nPNgnvxnh3JPSAUjxkFDIe671yg3DK9EqCZgH7fTDEnPJpl8lTLARcbSGYwOre4B/yaM
         efreXHIVhlyPsC4M2KEhfoQEXghewnen2Yce9av+KHKwnbvGbo2p7sIIzDMEu6eCL/43
         a3HHmww6E8kfO2ydfSxUd3vX7LXZNjI4cfxI00x4odai1FuOXqquR2FDaSNrg7/Aqd1U
         e4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6tBAwBzS7iwqCUewGR0y+Gc4bMGvCRT0xXoTY4P2mKg=;
        b=N7lJlk16BaDbLA4RCuJTpC7kJGvdvt++39PvVKS5C3/XbHCs1UrD8S9xSHgmZiJZIe
         kMIs1bITCP9g9lQ+bQXE1X8SLGqxOqDIBJUBABY/lmNnE0/LEy/UKpRKJmGraVzcgyRM
         eE62PruC7zi1gsI1rdYzFmXCf6mTkAddjRP6SvbWL3Cpoz/bsB5lP+wpyDKvK90u1+nH
         8OX5AVAQRT3+mehhJYv2h4Nl6vOiWs0nngsSj82dAWWO0xQKLYVWvGMG4oWsufOdQ3zH
         EfH4lzGRJ/Huu2Pli08c4VSDSW9tenbdsyVt+syobZK/ttDFyDkthndiKN4ZOrwxtqkc
         UGzg==
X-Gm-Message-State: AOAM533zmUwUL4MjOXe3KKIfJBcSc6KW+aka3TwnRzx7YTi3lsQIL+ji
        j8pFyUT6ygplrhs+YQrBUV5Xa8xlyz3S6q4eLIY=
X-Google-Smtp-Source: ABdhPJxkqnyjaPfiFauMuqRVvmoGQcpOfuPydcNvcl+fjGJuXb1+0M14H99LplxxvXpAHyDqpyilntUtCOuOdgO95RU=
X-Received: by 2002:a19:5c8:: with SMTP id 191mr1024039lff.111.1605277086543;
 Fri, 13 Nov 2020 06:18:06 -0800 (PST)
MIME-Version: 1.0
References: <20201113123101.29057-1-dwaipayanray1@gmail.com>
 <CAKXUXMxS-hF=j8wbwzc4d3x_guaUPs+WH=pK_QAJPEHmxg=5vA@mail.gmail.com> <CAKXUXMzmFjZv231eBgeESosyUzahg9Uv9sUqxZ-68cGjCkwLnQ@mail.gmail.com>
In-Reply-To: <CAKXUXMzmFjZv231eBgeESosyUzahg9Uv9sUqxZ-68cGjCkwLnQ@mail.gmail.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Fri, 13 Nov 2020 19:47:35 +0530
Message-ID: <CABJPP5B4EDKccFt=9x2QGV_8VCOmtu38xu=m2mZ17-KwiTBuXg@mail.gmail.com>
Subject: Re: [PATCH RFC] checkpatch: add new cases to commit handling
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 7:31 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> On Fri, Nov 13, 2020 at 2:37 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> > On Fri, Nov 13, 2020 at 1:31 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
> > >
> > > Commit extraction in checkpatch fails in some cases.
> > > One of the most common false positives is a split line
> > > between "commit" and the git SHA of the commit.
> > >
> > > Improve commit handling to reduce false positives.
> > >
> > > Improvements:
> > > - handle split line between commit and git SHA of commit.
> > > - fix handling of split commit description.
> > >
> > > A quick evaluation of 50k commits from v5.4 showed that
> > > the GIT_COMMIT_ID errors dropped from 1032 to 897. Most
> > > of these were split lines between commit and its hash.
> > >
> >
> > Can you send me the file of the evaluation, e.g., all contexts (two
> > lines above and two lines below) around the warned line in the commits
> > where the GIT_COMMIT_ID dropped?
> >
> > Then, I can do a quick sanity check as well.
> >
>
> Thanks, Dwaipayan; I checked your file sent off-list and it looks good
> to not report on those cases.
>
> Maybe we can now check the remaining 900 cases once again; are they
> all true positives or is there still a big false positive class?
>
> Lukas

Hi,
I had roughly gone through the list and most of them are true positives.
But there are two particular cases which may be false:

1) References: tag. (I don't know if it is a proper convention).
There were about 50 of these:

References: 22b7a426bbe1 ("drm/i915/execlists: Preempt-to-busy")

But it is non uniform. Some commits use this tag to refer to links also.

2) Quotes inside commit title. (apart from the main enclosing quotes)
I think by design checkpatch doesn't handle this case.

Thanks,
Dwaipayan.
