Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B4C27DE5D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 04:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgI3COa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 22:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729322AbgI3COa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 22:14:30 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E34AC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 19:14:30 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id d2so55917vkd.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 19:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JUU/C8onyKlPySCRSWT+QTeeD0ZR4lGerEsMoIi67e4=;
        b=K2WoCboVWCFeycF6Cel1OxgEYyPECxfD4z6C6iz6yw4uA4s2K9sv3S1wAWR85Vk+gG
         qg06ACp4f9siDISwnA27+75sDaZLCpNq0gCfsduvOb59OJHIsgnlhbc66FSI1OFcVOl+
         yvZLTVs2IsolT45igftD4Z0i4rhGNXjMVeFh9ARzdfLA6lblkSfQVR5letffC8THPpp6
         7psdUWlY4zZwHIZLhkdfMQku0UCt9TedPW4WgyLm/QyT6t5QFrX6nYjJ9TkO+wa3C7+d
         7kScSZb0f78h+ELxUrXK1e+D9sxGNzqbdDgSXUs0JUXoIkqYEZz0g79Tj7b2crnzr5Wi
         Lv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JUU/C8onyKlPySCRSWT+QTeeD0ZR4lGerEsMoIi67e4=;
        b=ISrQu9R7t+4ZO37YU4q9LiTasNZWvDq+vPQByQRY2MD9txhPKOc84y3M+mqbkG3Xtn
         f7kMBsuXqOhIM/THToHXLjWQKoTA6Murk5mXgk8XNdKesjdIExddmNc0q5kAGcRaDatf
         BsxSqQMQEvnkk7Xv3lOwHiVYWHJtdeLWTIuqodwnmkWQVp+w6jzu+keKCxOU4ALEsxJk
         BJ004x5NIw1M/5GaKH4jTYdrhO9BtgJZxWyRR7CZV+AfpkVljHorVlPewEVCgs5dqxUP
         hWXZZ8P0jAQOzAa9cMMEtAZ9sNQWpteucOPI/AB2e5JeCCNTdTZMm7K8NAEioma1/G6r
         7JRw==
X-Gm-Message-State: AOAM531nCZj6vbm9H8DxWOoXOuFyP1nwvUyw/nvH9YtSmzJ8MJSqThez
        3bwj4sj8AqpvES7JEBu7tILpXtb5VCfQydXrSp8=
X-Google-Smtp-Source: ABdhPJx5O7kvI1mEB2B2sDiokcvWeYJVvanpoDMf53buvyuf9FBFg/1rOW24ZgAQCBoagEqAxE7FaHmtZ0S/kyBf7z0=
X-Received: by 2002:a1f:9bc2:: with SMTP id d185mr194775vke.23.1601432069317;
 Tue, 29 Sep 2020 19:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <1599375114-32360-1-git-send-email-jrdr.linux@gmail.com>
 <1599375114-32360-2-git-send-email-jrdr.linux@gmail.com> <8a608871-af25-fee6-24ea-24d78010cd6c@oracle.com>
 <CAFqt6zbKdzFDq6TTadQqQhwZPsZKJLW0LE9ER-qTHm7y3raw9w@mail.gmail.com> <a3df6cac-4d29-a5cf-2bb2-35a8834aef64@oracle.com>
In-Reply-To: <a3df6cac-4d29-a5cf-2bb2-35a8834aef64@oracle.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 30 Sep 2020 07:44:17 +0530
Message-ID: <CAFqt6za1JzbnxK1nuYZhGaj_MxRc33cbTXo7MyP+CgXTfYRXfg@mail.gmail.com>
Subject: Re: [PATCH 2/2] xen/gntdev.c: Convert get_user_pages*() to pin_user_pages*()
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 6:00 PM <boris.ostrovsky@oracle.com> wrote:
>
>
> On 9/29/20 8:09 AM, Souptick Joarder wrote:
> > On Fri, Sep 11, 2020 at 8:12 PM <boris.ostrovsky@oracle.com> wrote:
> >>
> >> On 9/6/20 2:51 AM, Souptick Joarder wrote:
> >>> In 2019, we introduced pin_user_pages*() and now we are converting
> >>> get_user_pages*() to the new API as appropriate. [1] & [2] could
> >>> be referred for more information. This is case 5 as per document [1].
> >>>
> >>> [1] Documentation/core-api/pin_user_pages.rst
> >>>
> >>> [2] "Explicit pinning of user-space pages":
> >>>         https://lwn.net/Articles/807108/
> >>>
> >>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >>> Cc: John Hubbard <jhubbard@nvidia.com>
> >>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> >>> Cc: Juergen Gross <jgross@suse.com>
> >>> Cc: David Vrabel <david.vrabel@citrix.com>
> >>
> >> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Are these 2 patches queued for 5.10-rc1 ?
>
>
> Yes, I am preparing the branch. (BTW, your second patch appears to have been either manually edited or not generated on top of the first patch. Please don't do this next time)

I created it on top of the first one and didn't edit manually.
I was able to apply it in my local repository.
What was the error ?
