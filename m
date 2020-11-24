Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343842C1A83
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 02:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgKXBDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 20:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgKXBDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 20:03:46 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD26AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 17:03:45 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id v14so4318479lfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 17:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0vzXw+/uxksrYSQi7P32GugamvpCbRVeit1O2RKCjC8=;
        b=EF1azQY4IzEj9jf33+wizwLb9UX45vSEYoFf2iwNgKTZGwbS+KxINRZEnRRocnfdlU
         IhSXD+t6wzk0HhlurTGK5mQiOlzilaiFOF8Fm5y4WtY1+k+JY0eWAIbLr0QA6y40h3zm
         1j5RdKHOzxe7to5SM0JgLz5hyvAHuC4cymOEPx9FyZ/da74tUA7dGWxl2UnSitL3/QDz
         QOnZLFk9m5byAiGhndXd02N+gSUNyI+6poo1I3NMfKhGRsK/BjCfnQxQKOCtsDjxkvDn
         kDDYwDExctxD2JhAH19FRFqc7jFh2VsJOG3m15c1h/I3CNrPX6omgb9PTy+UKVL1MOBB
         EgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0vzXw+/uxksrYSQi7P32GugamvpCbRVeit1O2RKCjC8=;
        b=hziw0Mgy0z+PBzi4AEWjKOwkvMB6jKmD018vxd9OKw9dho99owQluqiIMVm5h7PnYb
         EKraK3O+lJgRJjRcdND4k+lBE1xvmW0ZoKOAjyGjtAskwV8CEXBjDnDpwiQ99M5Ug0iM
         XW29IBzg56mYCZEiGLPzUlTFHBLT9asCjK8IHgMbZJQnc8IxMddIwOcC8DSQuL+k653O
         edh3p9miebiIQYAcIxsTA76dDjzi8PHCvD8HgBwzaMqQbCBlKLSdszg7dbSljUByBBDW
         kG2sxNMHunJcOTYLx7vV75hVdGDzV6zAl8XMVL4/MV0q/v2HSlU0er6J+X6InZl1hwK2
         FRFA==
X-Gm-Message-State: AOAM533ExkdOqG/xI0BOjXWTNY/VIslbyxDqWBXgYNc69R6vLhSKXd/x
        lLKiGD9NRkWmcj05PKK/zDgDBGCS8URvNCYHDtI=
X-Google-Smtp-Source: ABdhPJwxi5ptN3FzIcuUewgPmFTiqPCpFHSxU/1rs3GHbeP2Zexr0ylqQwybqVY8YHntbJmqEze4c7lK7nOcT9grK0I=
X-Received: by 2002:ac2:51b4:: with SMTP id f20mr740123lfk.338.1606179824105;
 Mon, 23 Nov 2020 17:03:44 -0800 (PST)
MIME-Version: 1.0
References: <20201123031751.36811-1-daeho43@gmail.com> <20201123031751.36811-2-daeho43@gmail.com>
 <20201123184821.GB3694916@gmail.com> <CACOAw_xEe=3H60njSfwJSToFnVbOHabUd2Nt=uZJLvCfxFgM4Q@mail.gmail.com>
 <X7xF8+jko5d71CKq@sol.localdomain>
In-Reply-To: <X7xF8+jko5d71CKq@sol.localdomain>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 24 Nov 2020 10:03:33 +0900
Message-ID: <CACOAw_xZCC3u08=ZB_Ugk-LJs1wJL3ByJhuxwNK9zOYqU46Jzg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 11=EC=9B=94 24=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 8:29, =
Eric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Nov 24, 2020 at 08:02:21AM +0900, Daeho Jeong wrote:
> > Jaegeuk,
> >
> > My mistake~
> >
> > Eric,
> >
> > What I want is like do_page_cache_ra(), but I used
> > page_cache_ra_unbounded() directly, because we already checked that
> > read is within i_size.
> >
> > Or we could use do_page_cache_ra(), but it might do the same check in i=
t again.
> > What do you think?
>
> page_cache_ra_unbounded() is basically a quirk for how fs-verity is imple=
mented
> in ext4 and f2fs.  I don't think people would be happy if it's used in ot=
her
> cases, where it's not needed.  Checking against i_size multiple times is =
fine.
>

Got your point. Thanks.

> >
> > I could add some description about these in
> > Documentation/filesystems/f2fs.rst and I implemented tests internally.
>
> Documentation in f2fs.rst sounds good.  All the f2fs ioctls should be
> documented there.
>
> The tests should be runnable by any kernel developer; "internal" tests ar=
en't
> very useful.  Could you add tests to xfstests?
>

Yes, I'll add all the internal test cases to xfstests soon~

> - Eric
