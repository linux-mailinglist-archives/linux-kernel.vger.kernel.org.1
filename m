Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCDA52CDE61
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbgLCTBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbgLCTBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:01:48 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC1AC061A51
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 11:01:08 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id v3so2916793ilo.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 11:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a4TzLhSlXQL4BX3NXjaBKeKvdDoyftB11mno/cFqqgc=;
        b=CtEs0+OV59yTqK3NKLK4J4vF//6Tx2WdMA0S3nICi8MiQUsQeGqd2GzSwH6jgVSQQz
         tP+QRdmQa3z9hoUDeXpKSfjbRy6TzGVuKkNY5LXkWL6sgU4Ixto9X0allkp27J5u2BmM
         mLbMlh+snF92AmqnQTR5GhxAGq/KX19jS8vnq3H+Ynhe9EnDyAeM9BS+PVR352zXgE7i
         qY4EKKXIoKrvCTmBnL/OfeMVl1q1StKDOb0SY1eebn69mDX8lq3Ytdrq7rTEuEWdqqV7
         8fQVUKulAXXOi+JzQ6/dGtq9DBP4dk2tZ2MXsmOwLjXPEBalbkTi1PoLrqYzE4zU+R12
         0RUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a4TzLhSlXQL4BX3NXjaBKeKvdDoyftB11mno/cFqqgc=;
        b=pWfkgRHoqFGgpPLWW64MEjeinc2nsn2zYaE0rtkFoPWA3bbYfOdZYJRb92hgO0WibP
         k/0YmOpbDE3lv46EsbYeMPLDXLSLox8WziRmbAbNbY8hlGhzm+9YMF6EztkDlxroBpK1
         TNIDyNrNdxyVh1ioa4QtaU4tWFezIEnXCn8vTyHuUjSCRhIn2lvZ4CThXh2apmE1G5PG
         xNJbxshgB54btUvDmAzmO5n8kBE1RFgnvbFUo9Zh153tGHayjf4U6bv4NW+xitdUIIKh
         F+DHSInDE2acYwQBD8cgnl3dTjVrHjA2NlgZVzROwQizPuByWg6TJ5DdzjZR6ysL5XAs
         m3mQ==
X-Gm-Message-State: AOAM533whbhZEaK77GB3wglltaiz6jRz0eL3wbAWdEL0YJgf+3i99ksw
        ZD3Uj9qTYhupOpWtAtUdMcpwp3u1jy/J0EGLLUsjJ92psoM=
X-Google-Smtp-Source: ABdhPJyTIPxh2syZtAqKyljBRNEMpYCL7sobb1pR//WO+gVSqg/SnvI2ZHTbZiXgxHnOVVW+8VeaqKv7+GOU3CWFrDo=
X-Received: by 2002:a92:512:: with SMTP id q18mr646027ile.147.1607022067522;
 Thu, 03 Dec 2020 11:01:07 -0800 (PST)
MIME-Version: 1.0
References: <280235acc0e91365f3fd3b5be5a5244eced1ff61.camel@perches.com>
 <20201202183045.9309-1-yashsri421@gmail.com> <5afbcd1423ee8fc2dfad191d94aef6efc17198c8.camel@perches.com>
 <a2c74693-93ae-cd5a-7836-4ffff643fc09@gmail.com> <CAKXUXMxPMdGmnOWdYnS0VQXaAH9dTe7uNfUUPp-GLy2xTXuABw@mail.gmail.com>
 <X8k1CaSlaJpJdmcC@kroah.com>
In-Reply-To: <X8k1CaSlaJpJdmcC@kroah.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 3 Dec 2020 20:00:58 +0100
Message-ID: <CAKXUXMye+ppB1DhGu9xwqRa2BEuLKzsQVL3_RUNySy+zKXHoLg@mail.gmail.com>
Subject: Re: [Linux-kernel-mentees] [PATCH -mmots] checkpatch: add fix for
 non-standard signature - co-authored-by
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Aditya <yashsri421@gmail.com>, Joe Perches <joe@perches.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 7:56 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Dec 03, 2020 at 11:59:54AM +0100, Lukas Bulwahn wrote:
> > On Thu, Dec 3, 2020 at 10:59 AM Aditya <yashsri421@gmail.com> wrote:
> > >
> > > On 3/12/20 12:26 am, Joe Perches wrote:
> > > > On Thu, 2020-12-03 at 00:00 +0530, Aditya Srivastava wrote:
> > > >> Currently, checkpatch.pl warns us for BAD_SIGN_OFF on the usage of
> > > >> non-standard signatures.
> > > >>
> > > >> An evaluation on v4.13..v5.8 showed that out of 539 warnings due to
> > > >> non-standard signatures, 43 are due to the use of 'Co-authored-by'
> > > >> tag, which may seem correct, but is not standard.
> > > >>
> > > >> The standard signature equivalent for 'Co-authored-by' is
> > > >> 'Co-developed-by'.
> > > >
> > > > I'm not going to ack this as I don't mind non-standard signatures.
> > > >
> > >
> > > What do you suggest?
> > > Should I drop this patch and move on?
> > >
> >
> > Joe does not ack this, but he also does not nack it.
> >
> > You either move on (which is perfectly fine), or
> >
> > you either wait that Andrew Morton reviews it and accepts it because
> > he thinks it useful, or
> >
> > you reach out to the git committers that have been using
> > Co-authored-by in the past and ask them if this kind of feature would
> > have been helpful for them and you get an ack from them that convinces
> > Andrew Morton to pick this.
>
> co-developed-by is the correct tag for this.  It is documented exactly
> for this reason, please do not try to use something that is not already
> accepted by the kernel developers for this type of thing.
>

Well, Greg, so do we get your Acked-by on a feature that checkpatch
warns that Co-authored-by is non-standard and that then fixes up the
patch automatically to Co-developed-by with checkpatch --fix?

If so, please add your Acked-by on this patch here and let Andrew know
to pick it...

Lukas
