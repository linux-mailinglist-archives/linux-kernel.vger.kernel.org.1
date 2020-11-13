Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4922B1CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgKMOBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgKMOBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:01:51 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13039C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 06:01:44 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id s24so9805963ioj.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 06:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l34uzIAlK5x2Ajn9Lk3gFgnFnL5Mq1YkGqPQ7H+C73I=;
        b=ATVndjXfWfdEXb35YElM9CO70GiAibR44Ak6+ci2E09UqAIUCfdO4e8Fcbi3leembR
         Hx2e/AvX/jFGsGuNOgXyP7bLSbXijILj5ouz0kVRjtb45sH7PLDqBQn86sxOPmd7r8Y3
         qmruFjd9DwFNnLZZ2u2DnU3HmEIAZWXfljAaWgNdiX0HjT0hhQ7S0jsAhrPP4k2Hn10m
         WXrqF08Qfu1Od2LtFuVf6GtZmAVAieSGKl8IdgE9uGWSo4CeIlaEbduehy1jYc1d+bq8
         julmSCLYq4mClzenp0BU84qjNiSvOlkfP7j7SdPfs0i7FkR2u6jeKDFQiZF77JF8R04v
         w0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l34uzIAlK5x2Ajn9Lk3gFgnFnL5Mq1YkGqPQ7H+C73I=;
        b=Ax/kSP8CyszmdbszLvVgIJbxako2NbadR5uk1iU5VYGnTEvxosiyY+Xd25vcY27nn1
         Lykv6hIkf1kv09lbVMKVyX+ZeSeQth1Ooas3l/vspvZPTLtdOdBuSZ/tNkO65fMw98iK
         XCUpv6Q6f6vrqWdjZ9x11YGueX89l/PtsNDACRmd4h0j67SvYD1RZrqVpJmQCKL7MNja
         1kBaHiQKDn7MCyWW/78Dop1Ko98j9zLIiqxzsARru4MTHotgS9PoOZAMgJs9VcztwEr4
         p169TXDMT1GibjKUVswJI5QnM0Xe17bcWji1ayMachgxxcmvxFDAoWCCbk27TNKINynb
         6pUg==
X-Gm-Message-State: AOAM5321pPBMNjNRBITyw+DFCLU1sA9iE2hQyFxGzThcjD/LdEawmeus
        CsrIJb3LIVRvjPhoJRu84rOEkYHyQ8ieBFi/NMqvVy+mNQM=
X-Google-Smtp-Source: ABdhPJySdyP49nggcZw+V8Pfjenm0dkml54lN3fGxZcr8Wv+aV7QghMHO2dSkNvitlKJBVKgWfCRePTb3OBKOFDgEjE=
X-Received: by 2002:a05:6602:3353:: with SMTP id c19mr1870028ioz.114.1605276103498;
 Fri, 13 Nov 2020 06:01:43 -0800 (PST)
MIME-Version: 1.0
References: <20201113123101.29057-1-dwaipayanray1@gmail.com> <CAKXUXMxS-hF=j8wbwzc4d3x_guaUPs+WH=pK_QAJPEHmxg=5vA@mail.gmail.com>
In-Reply-To: <CAKXUXMxS-hF=j8wbwzc4d3x_guaUPs+WH=pK_QAJPEHmxg=5vA@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 13 Nov 2020 15:01:32 +0100
Message-ID: <CAKXUXMzmFjZv231eBgeESosyUzahg9Uv9sUqxZ-68cGjCkwLnQ@mail.gmail.com>
Subject: Re: [PATCH RFC] checkpatch: add new cases to commit handling
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 2:37 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> On Fri, Nov 13, 2020 at 1:31 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
> >
> > Commit extraction in checkpatch fails in some cases.
> > One of the most common false positives is a split line
> > between "commit" and the git SHA of the commit.
> >
> > Improve commit handling to reduce false positives.
> >
> > Improvements:
> > - handle split line between commit and git SHA of commit.
> > - fix handling of split commit description.
> >
> > A quick evaluation of 50k commits from v5.4 showed that
> > the GIT_COMMIT_ID errors dropped from 1032 to 897. Most
> > of these were split lines between commit and its hash.
> >
>
> Can you send me the file of the evaluation, e.g., all contexts (two
> lines above and two lines below) around the warned line in the commits
> where the GIT_COMMIT_ID dropped?
>
> Then, I can do a quick sanity check as well.
>

Thanks, Dwaipayan; I checked your file sent off-list and it looks good
to not report on those cases.

Maybe we can now check the remaining 900 cases once again; are they
all true positives or is there still a big false positive class?

Lukas
