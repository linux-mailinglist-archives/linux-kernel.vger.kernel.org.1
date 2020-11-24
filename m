Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34482C1E88
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 07:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgKXGyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 01:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbgKXGyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:54:24 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D348BC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 22:54:24 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id v3so4114814ilo.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 22:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jyg5lcJdKgnuPCVzERa4Rt0xWB2AfCQtzpyLk67O5hU=;
        b=lkq3LttM7CTkaBXuWnEHF9j9YCCIyQZMet9iO4QghTwL8ln4iFPDQRHEXJX9shLaBS
         UaiSxBBfpa/vYmTOV80ruwaBlfTNDDAdHVXEShbhwIIeMR5By32wVx+mpAbk2eiNm5tu
         ucm40VBmzvujaB55jq36tXz52pyOgKs6pHQP1WM23d92+f5yKTb6zHOg+yUmk/QDs4UB
         snaLHinXdMPVny2mt7+EElL9sMz5JYpGbDT7dYB6oOED9dwhzD/QyxlnqHJa/ZXRgV3o
         m+t+IuodS57GUUCoY/wgXSkZBb/DQtKSs8OYvAFJRRhHO3VhWI2nM5FUNEbN36/fNmEv
         7OTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jyg5lcJdKgnuPCVzERa4Rt0xWB2AfCQtzpyLk67O5hU=;
        b=RscOT5A6sDWGvOf6hKgZHDWv+TimhrIuWO2VXlabB7iB9ImiA7tI4yBux11rFd4Hbm
         1eARMAqSCm7ZEg/TeaWtjnIsneUFNo2oq917SADFzIVITnnhrT0yidm6rPfEOpjd/Rnb
         LiAbVdStlxJFq2xSg8ClVCEGKLyGp+Gv0dItQylhd2jaB2EhtU2MTr052cYLnkl87Ixr
         UvZe4EvK3SHRBCMYWKl1W8+dvwWo1vJmNrLA+pMnyflByG9I13mj3YSeWuet4PMzRvDN
         gDf7qDkK2JSz/1q7oGqedQn9r1qMuDKtv3jUCSv4qPlG+JLPIQpx9mFCfc+u1uNfz+E1
         sLSA==
X-Gm-Message-State: AOAM532nUoBhj5jcUQCKXRYaL5qQIxJWhaGaoSTNGjTbp9lW9pedARbk
        LT2q12nfa3Qlp83u4whiUQ4FDtA3NzcOz+RZUTw=
X-Google-Smtp-Source: ABdhPJyCdOM0L5zrUb51hSfU7JeNsMaQ+XL9nXC5bGZFGTctTczOxXx9rKpmdH7xqcMblstNAgHqrpBzGiZ2idhhVag=
X-Received: by 2002:a92:aacc:: with SMTP id p73mr3053455ill.64.1606200864161;
 Mon, 23 Nov 2020 22:54:24 -0800 (PST)
MIME-Version: 1.0
References: <CAKXUXMx8siSm67jkBP_r+OKyKALfT2EDcX_SfX7JGBy3YisXcQ@mail.gmail.com>
 <20201123172430.12854-1-yashsri421@gmail.com> <148208ef84344069a6c95d3f686a86ca1199be90.camel@perches.com>
In-Reply-To: <148208ef84344069a6c95d3f686a86ca1199be90.camel@perches.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 24 Nov 2020 07:54:13 +0100
Message-ID: <CAKXUXMzcMWeM2M81b2PZ+D54LO6xd+m667vygWVF93Mnsq8QQg@mail.gmail.com>
Subject: Re: [PATCH v4] checkpatch: add fix and improve warning msg for
 Non-standard signature
To:     Joe Perches <joe@perches.com>
Cc:     Aditya Srivastava <yashsri421@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 6:33 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2020-11-23 at 22:54 +0530, Aditya Srivastava wrote:
> > Currently, checkpatch.pl warns for BAD_SIGN_OFF on non-standard signature
> > styles.
>
> I think this proposed change is unnecessary.
>
> > This warning occurs because of incorrect use of signature tags,
> > e.g. an evaluation on v4.13..v5.8 showed the use of following incorrect
> > signature tags, which may seem correct, but are not standard:
>
> Standards are useful, but standards are not constraints.
>

Agree, but we do try to create statistics and try to derive quality
statements from those tags (yes, empirical software engineering black
magic...).
Hence, I am in favor of suggesting to rewrite those tags that really
do not add anything at all. E.g., Suggestions-by: vs. Suggested-by, or
Coauthored-by vs. Co-developed-by.

Anyone can ignore checkpatch; so it is not a constraint unless
enforced by subsystem maintainers.

> > 1) Requested-by (count: 48) => Suggested-by
> > Rationale: In an open-source project, there are no 'requests', just
> > 'suggestions' to convince a maintainer to accept your patch
>
> There's nothing really wrong with some non-standard signatures.
> And I think leaving humor like brown-paper-bag-by: is useful.
>

I think we do not want to take the humor and fun away from patches.

So let us not suggest deleting the humorous and celebrating ones.

> Just telling people that they are using a non-standard signature
> I think is enough.
>

Maybe a patch reduced to the very obvious synonyms helps newcomers or
people with lousy memory to be reminded that it is called
"Co-developed-by:" not "Co-authored-by".

Lukas
