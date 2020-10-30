Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD54E29FAB0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 02:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgJ3Bqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 21:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ3Bqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 21:46:30 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2792AC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 18:46:29 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 141so5843305lfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 18:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fzIBdE11fRPXVpK/5f4gJOiYBzS/DWloWXyL0lox/F8=;
        b=OxJq8Wye4Jib/cR24NDT8S9LhUd0FrRqhkVj7Y5sYQr+wBOY7Mkg60jKF3r/ES06gR
         z30on/Hc3e4TIsfkf9E50y09ioQp6pfsSzUY8nsQxzS70iL4TDCIqSXQQDaabjKeig32
         PGc5a7qrgELguAr8mGObU2IZPNkzjI1SPWdAkf0TLs/AgLEc2lzpSrXP4VJCooCu8Fhc
         9Zbwq7ZSsyUgdl/C0sI6rd5BeiWyR52tJo0FFX0NKv2UdGYVjFMz8AHnw1DFqdATfOKp
         b+3/VMZzBB9dLTq/Nbe9b9eQlTkR659hY2IozF/7cHUdqzGaI+sv7M2la0zn7RnhKO0o
         2CtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fzIBdE11fRPXVpK/5f4gJOiYBzS/DWloWXyL0lox/F8=;
        b=sA6B39x4g6wDovJLPFUqCzM7+4W9P3GbMND0IuvoS/MY5b1U/+5qqOknUxXGIWC3ow
         q1+jg3XK6qhOyrLWSHWcIHAJGBwNhOwyGPCMJ1iUB6GR06cZBs1fiVVVG+Hkf6G+Pe+k
         bkK2eiOnG/uO0ovpgzqY5TgL9AhFi0N7Q/lk41MYAAjYInSfjGDFFRcFMj8moK3fJduj
         okA5pZNsFS8qy3apbGizlanhfYJqEedgQYhzl5Ic69/HBccbICahbMo5N5gs1SJQnC76
         +N4HrIlIzxeKtN2nNlbobf67j0N7QyU1RVTya4kjacNSJQM/BtZGVsL4cfT0xCtYlWxr
         F0og==
X-Gm-Message-State: AOAM530yo4ZkxECKf/5umtxoewBZqIpfkWM61Zv6pqAJH1YNS9p+bAx7
        3wcwxQPsBMg+2Mu4tG6V/ZTT/BnFOtt8cZcqjA4=
X-Google-Smtp-Source: ABdhPJxnuRCWaAMORoO5AoECX4a4MDfVIv2Z7I16KDl5XTotB4z7o9iKC+y46fnn1yvHTbNzKSscXzwzd9j4fkoT454=
X-Received: by 2002:a19:420b:: with SMTP id p11mr2420961lfa.326.1604022387151;
 Thu, 29 Oct 2020 18:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201029041538.4165209-1-daeho43@gmail.com> <20201029041538.4165209-2-daeho43@gmail.com>
 <92f4da8e-27a1-7577-84f9-39038eaa88cb@huawei.com> <20201029155453.GB849@sol.localdomain>
In-Reply-To: <20201029155453.GB849@sol.localdomain>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 30 Oct 2020 10:46:16 +0900
Message-ID: <CACOAw_xc5KYhVgp-b8NTs8vapWxiLF3m-qUMO2qgjp4gQQb2Pw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v5 2/2] f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chao, got it on f2fs_is_compress_algorithm_valid().
I also agree on Eric's opinion on that error value.

2020=EB=85=84 10=EC=9B=94 30=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 12:54,=
 Eric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Oct 29, 2020 at 03:29:17PM +0800, Chao Yu wrote:
> > > +static int f2fs_ioc_set_compress_option(struct file *filp, unsigned =
long arg)
> > > +{
> > > +   struct inode *inode =3D file_inode(filp);
> > > +   struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> > > +   struct f2fs_comp_option option;
> > > +   int ret =3D 0;
> > > +
> > > +   if (!f2fs_sb_has_compression(sbi))
> > > +           return -EOPNOTSUPP;
> > > +
> > > +   if (!(filp->f_mode & FMODE_WRITE))
> > > +           return -EBADF;
> > > +
> > > +   if (copy_from_user(&option, (struct f2fs_comp_option __user *)arg=
,
> > > +                           sizeof(option)))
> > > +           return -EFAULT;
> > > +
> > > +   if (!f2fs_compressed_file(inode) ||
> > > +                   option.log_cluster_size < MIN_COMPRESS_LOG_SIZE |=
|
> > > +                   option.log_cluster_size > MAX_COMPRESS_LOG_SIZE |=
|
> > > +                   option.algorithm >=3D COMPRESS_MAX)
> > > +           return -EINVAL;
> > > +
> > > +   file_start_write(filp);
> > > +   inode_lock(inode);
> > > +
> > > +   if (f2fs_is_mmap_file(inode) || get_dirty_pages(inode)) {
> > > +           ret =3D -EBUSY;
> > > +           goto out;
> > > +   }
> > > +
> > > +   if (inode->i_size !=3D 0) {
> > > +           ret =3D -EFBIG;
> > > +           goto out;
> > > +   }
> >
> > Hmm...
> >
> > Shouldn't it be:
> >
> > if (algorithm >=3D COMPRESS_MAX) {
> >       ret =3D -ENOPKG;
> >       goto out;
> > }
> >
> > if (!f2fs_cops[algorithm])
> >       f2fs_warn(...);
>
> Note that my intent with recommending ENOPKG was for it to be returned in=
 the
> !f2fs_cops[algorithm] case, similar to how opening an encrypted file when=
 the
> encryption algorithm is recognized but not supported by the kernel return=
s
> ENOPKG.  For a truly unrecognized algorithm (algorithm >=3D COMPRESS_MAX)=
, EINVAL
> would probably be more appropriate.  So if !f2fs_cops[algorithm] is now a=
llowed,
> then ENOPKG should no longer be among the error codes this ioctl returns.
>
> - Eric
