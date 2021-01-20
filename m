Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353E02FD3D4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 16:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390061AbhATPTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 10:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390949AbhATPSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:18:40 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA09C061575;
        Wed, 20 Jan 2021 07:18:00 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id k4so19798424ybp.6;
        Wed, 20 Jan 2021 07:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1QF0838Q2mOKIXn1l947NcF9CM6M/0gAJkWSquMRYw4=;
        b=IWG6lpKFBP3I2FEVkM2MNyWDyHsJ/2pVF4SW1z3n5wM4FR3HYhc0nHfFSRq/xlshhJ
         A010/u8tkEblV0rkboFLFL7PJ+VKKjiRAi3MPCqgrnCdKJDEVY3OSQcQjYdsTT5DUHev
         9PzpsYGKbDOW1hGCQ1RJfkx80uDudpcjqFSeHIe/blFMkC8qX5OZuvbD65EeBTmxKeDf
         JFCrdEidpuC7PR/Li73WasL9jUh508vS3Z6szZ1/Vs9KAHha38a/WhGIk5kD8XA+O/nq
         hOSZzGR/yLVbS10k5ARj1VPPUau3IaCB2TBuFwNfbGHoVrgEWkvbAfrNmWP3OhzApcFN
         iDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1QF0838Q2mOKIXn1l947NcF9CM6M/0gAJkWSquMRYw4=;
        b=neOT+xe+ynqdXC8TTZRGd5MKB4Ozu8czAz29gH53ScHNp6J/zPkiNsxXxohPlWuLrx
         z+rDn1E0RIEhZvr4EpGPC9Ay1UnjV0U2yVy/tsRYeQawTaoIMPDcgwECa7DTzfAb3Ytu
         gFd+6uzu6274mU1lmkw7wjeXErkVuqgBtQVrf9ZVlHJnpBmJ1pg8Ls8FviggMawzlo01
         JfMyl+8xPBlV+MV+c9D9GaH8bFc85O2/Kdtz3UbpgsBF1gQyPJqyvOqziIOheYUq9mKs
         c36fvBkQzccat6X1neeB0qmnGvjYIOM4hXnE7r4DIroTMzKcK7N62OzTb/BH6F3ArB6c
         TP1g==
X-Gm-Message-State: AOAM531GoNOJnfOo9MktHrqXQiK1LV4rthLqEdpuESwxfHz0KH0HvUKC
        utVLB8pzE4wI1yIY0RBF1oNPwWshQIjFDfBJi3A=
X-Google-Smtp-Source: ABdhPJwZm8l3po5mR9bLp+Ns2Vs4cCmdbTy+DKzrEibxLAXMNa7i1KEWMX+wOhF3QEEfY0J6nY9jXh67EbSQqKabYbk=
X-Received: by 2002:a25:c04f:: with SMTP id c76mr13165714ybf.443.1611155879500;
 Wed, 20 Jan 2021 07:17:59 -0800 (PST)
MIME-Version: 1.0
References: <20210119105727.95173-1-roger.pau@citrix.com> <CALUcmUkd9Eeau6tC9ZWHbLdvHTYfY34LvK6KKpOOxreYF67Myg@mail.gmail.com>
 <20210120143515.v2vgyhcxrhnnng6r@Air-de-Roger>
In-Reply-To: <20210120143515.v2vgyhcxrhnnng6r@Air-de-Roger>
From:   Arthur Borsboom <arthurborsboom@gmail.com>
Date:   Wed, 20 Jan 2021 16:17:43 +0100
Message-ID: <CALUcmU=6aAUrkg8KkJQvsQvNr1yL3E88Uy5xsD+u+XOrbUAhCQ@mail.gmail.com>
Subject: Re: [PATCH v2] xen-blkfront: allow discard-* nodes to be optional
To:     =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Cc:     linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This time the patch applied cleanly.

The trim command seems to work as well, meaning no error messages and
a certain amount of blocks (5GB) is trimmed.
The trimming did consume a bit of time (10-20 seconds), assuming it is
actually discarding the blocks at the host.

First run:

[arthur@test-arch ~]$ sudo fstrim -v /
/: 5.7 GiB (6074368000 bytes) trimmed

Second run:

[arthur@test-arch ~]$ sudo fstrim -v /
/: 0 B (0 bytes) trimmed

No errors were reported in the dmesg of the VM; no errors in Dom0 and
no errors in dmesg of Xen (xl dmesg).

Based on this single test, it seems to work.
You can add me as Tested-By.

On Wed, 20 Jan 2021 at 15:35, Roger Pau Monn=C3=A9 <roger.pau@citrix.com> w=
rote:
>
> On Wed, Jan 20, 2021 at 03:23:30PM +0100, Arthur Borsboom wrote:
> > Hi Roger,
> >
> > I have set up a test environment based on Linux 5.11.0-rc4.
> > The patch did not apply clean, so I copied/pasted the patch manually.
> >
> > Without the patch the call trace (as reported) is visible in dmesg.
> > With the patch the call trace in dmesg is gone, but ... (there is alway=
s a
> > but) ...
> >
> > Now the discard action returns the following.
> >
> > [arthur@test-arch ~]$ sudo fstrim -v /
> > fstrim: /: the discard operation is not supported
> >
> > It might be correct, but of course I was hoping the Xen VM guest would =
pass
> > on the discard request to the block device in the Xen VM host, which is=
 a
> > disk partition.
> > Any suggestions?
>
> Hm, that's not what I did see on my testing, the operation worked OK,
> and that's what I would expect to happen in your case also, since I
> know the xenstore keys.
>
> I think it's possible your email client has mangled the patch, I'm
> attaching the same patch to this email, could you try to apply it
> again and report back? (this time it should apply cleanly)
>
> Thanks, Roger.



--=20
Arthur Borsboom
