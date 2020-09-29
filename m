Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B1E27C959
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbgI2MJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732003AbgI2MJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:09:48 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A80C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 05:09:48 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id d18so3346492uav.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 05:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9JPwRxOZpiuGc8LaSwFRkiWTX4cPQZfECJ4CU5S5FmE=;
        b=l5BVRnMpNnf24f0Xa+xdLil3jpVOI7oRxWJKNiq+dcno64b0SXSPDQjfW3MpeNZze8
         7Ofb/GIZmArCQh3T/MVYbmc6dm3PU18dajRaJoeYtKp8w/eJKawbswcuEAXWaPRXrHxc
         44AvJx2PgrJq7YccVqY+qJO1T+7uJWAPzfXbipLO9vItl/i/a9uong7HzjGMSCFwpvTs
         ea9sJqvN+MReekCeFcorH8PKXPY8DuzPD7bxqQ/CGrEeK9aV0Cwz7F1YNzZWdhGALlxS
         YTCwMGiRKL7KMGBapK8EOOYFsw2P7VRp5Q+Acn5Ypuluu/7MIBCRYaCuo0u2DJNP4vNR
         OgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9JPwRxOZpiuGc8LaSwFRkiWTX4cPQZfECJ4CU5S5FmE=;
        b=oQaEvYhgDvjM7TxySyojxk/WjMRkzXCK0J3EGECa8N5INRIq/xaFXGkBk69WHjWujF
         p04I73boiL4+9/wxzp42ddGqKv7IAU+GwmMjR24CtaGJFqppIOEbwbSNQAzzy5+L8M2s
         10Y8+1SieihY+tmGz2axHEq42N/qUcvIejSKz11qn/mP/qtrEgtd8NBJep76B9t22Nym
         FUncjNetrVoxmbaxnlU6XvLPolP4zYp93dwtVglHNoWXsQrRfJ3HuOBP1NqkFHlsm19n
         HgWBTSwImkvVU8IJdDu5Xo+oFGnRGUbeMmmLrOtoy6rEKEpyTLv3tnJ2J30xxJRedu3d
         Ax3Q==
X-Gm-Message-State: AOAM533S6jxO3xHGDlF02J4eEfv3In8vrEg4tPkuTb5MvX2ZkcqWbDah
        PFvKzTSrM62KZLeqLRNTZn+FkWCjA2EHZ0Lj016eMu223cI=
X-Google-Smtp-Source: ABdhPJx1Kc802JZNGkERygyfBhPjfvFOk+klvm3rkq6LLHBMgMmSCTmhZBIAlNN3HcYU0JC8U0d3QkqVFuZFqiIttug=
X-Received: by 2002:ab0:134:: with SMTP id 49mr3343890uak.118.1601381387518;
 Tue, 29 Sep 2020 05:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <1599375114-32360-1-git-send-email-jrdr.linux@gmail.com>
 <1599375114-32360-2-git-send-email-jrdr.linux@gmail.com> <8a608871-af25-fee6-24ea-24d78010cd6c@oracle.com>
In-Reply-To: <8a608871-af25-fee6-24ea-24d78010cd6c@oracle.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 29 Sep 2020 17:39:36 +0530
Message-ID: <CAFqt6zbKdzFDq6TTadQqQhwZPsZKJLW0LE9ER-qTHm7y3raw9w@mail.gmail.com>
Subject: Re: [PATCH 2/2] xen/gntdev.c: Convert get_user_pages*() to pin_user_pages*()
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 8:12 PM <boris.ostrovsky@oracle.com> wrote:
>
>
> On 9/6/20 2:51 AM, Souptick Joarder wrote:
> > In 2019, we introduced pin_user_pages*() and now we are converting
> > get_user_pages*() to the new API as appropriate. [1] & [2] could
> > be referred for more information. This is case 5 as per document [1].
> >
> > [1] Documentation/core-api/pin_user_pages.rst
> >
> > [2] "Explicit pinning of user-space pages":
> >         https://lwn.net/Articles/807108/
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Cc: Juergen Gross <jgross@suse.com>
> > Cc: David Vrabel <david.vrabel@citrix.com>
>
>
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Are these 2 patches queued for 5.10-rc1 ?
>
>
