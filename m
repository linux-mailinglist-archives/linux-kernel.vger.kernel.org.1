Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134C9295754
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 06:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444121AbgJVEhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 00:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2444084AbgJVEhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 00:37:11 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907A0C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 21:37:10 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id p15so474422ljj.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 21:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W+1qv0093yWO2OvV4srP8myTrrB3NSN2Lqth7k1NMr8=;
        b=XmCRWoZxfFHScV1GEp0Xh0YTgmb1tQh82LM7jsEJfuKCpnrVT80VdsDy0pPOMsI8L3
         niM2u9eKwdKaQD5zNLVNNKigtNDdBD6QI70bEKxWKdRVwQCcXs+bq5wfXnDuIbZCIALx
         Unnpnzyf9V3Y+IPrAvDIs73cBeS85p07csnRgcEsxJb8Lp4pOsnqIPsQsL2txvckKMbw
         PXdisinFPMhOzsXNwiS5IUAZ3ZwBU0a3Us2gNRqe9avm6rbhyjFpdxCTpRWlS5RNBk0i
         8D6ZuHpE8koVyJTBrQWjE8wgZYN4GTZIAnya9C7U3Gt2YfXDQ+VekGOk5BikZpcVOovW
         Gi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W+1qv0093yWO2OvV4srP8myTrrB3NSN2Lqth7k1NMr8=;
        b=POhb7pOJhdcChrezAUgqW0dBouiPOX718THalFSOynJuKdrSVT3pmN7DmC/9+R9tm+
         bE9JMMpEMkfFTT8B4mBTmVYZBXjzlbA6nGnQ486mpCvoYooGrounORAFrApFLay3g0Jl
         w53jBaZSDQHstMaOrWAfkDci8vlFYSNFzXEk9lhY0DeRDh1CMRTu2yWtOGyQRpN/PZZ5
         kwqG32nm/PNlvhVrTJOoYwZeJDRMmc1zqX+U8+UyT360HGY5DxUKH0rS5aySdZHJHobk
         ZWIh81+g76cYMEfd1TjLqezwx81wqWQ6vmjqracRTOHF5p2UUj9gSXROlHYLNNcM8NwH
         uGgA==
X-Gm-Message-State: AOAM532Cd1r1N+2F62DOha4IWdwTh6+cKQxIWz5b/j4cCkm+i49dQvI1
        thXTl3hW6bzS5d53zoHzdZI20RoO7y/uOEwTuAA=
X-Google-Smtp-Source: ABdhPJwWFEKL4gECmX9VHJVAui5KkthGto3dSB+WwW90vDCk1UCn8aZE2ruacrRaKjS5E5JtSyBCj8dmqA/ss4LdpY8=
X-Received: by 2002:a05:651c:130d:: with SMTP id u13mr305576lja.265.1603341428939;
 Wed, 21 Oct 2020 21:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201022035848.976286-1-daeho43@gmail.com> <20201022035848.976286-2-daeho43@gmail.com>
 <20201022042608.GB857@sol.localdomain>
In-Reply-To: <20201022042608.GB857@sol.localdomain>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 22 Oct 2020 13:36:58 +0900
Message-ID: <CACOAw_y1Njm0zswqFXS4EXWcetYAvCGgHpQPqYqaRKh=+JmU8Q@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The use of ?: here is a bit strange.  How about:
>
>         return algorithm < COMPRESS_MAX && f2fs_cops[algorithm] !=3D NULL=
;
>

Ack

> Likewise, EINVAL tends to be over-used, which makes it ambiguous.  Maybe =
use
> ENOPKG for the case where algorithm < COMPRESS_MAX but the algorithm wasn=
't
> compiled into the kernel?  That would be similar to how opening an encryp=
ted
> file fails with ENOPKG when the encryption algorithm isn't available.

Ack

> How about EBUSY for f2fs_is_mmap_file(inode) || get_dirty_pages(inode),
> and EFBIG for inode->i_size !=3D 0?

Ack

Thanks~!

2020=EB=85=84 10=EC=9B=94 22=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 1:26, =
Eric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Oct 22, 2020 at 12:58:48PM +0900, Daeho Jeong wrote:
> > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > index 7895186cc765..3b58a41223f8 100644
> > --- a/fs/f2fs/compress.c
> > +++ b/fs/f2fs/compress.c
> > @@ -514,6 +514,11 @@ bool f2fs_is_compress_backend_ready(struct inode *=
inode)
> >       return f2fs_cops[F2FS_I(inode)->i_compress_algorithm];
> >  }
> >
> > +bool f2fs_is_compress_algorithm_ready(unsigned char algorithm)
> > +{
> > +     return algorithm >=3D COMPRESS_MAX ? false : f2fs_cops[algorithm]=
;
> > +}
>
> The use of ?: here is a bit strange.  How about:
>
>         return algorithm < COMPRESS_MAX && f2fs_cops[algorithm] !=3D NULL=
;
>
> > +     if (option.log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
> > +                     option.log_cluster_size > MAX_COMPRESS_LOG_SIZE |=
|
> > +                     !f2fs_is_compress_algorithm_ready(option.algorith=
m))
> > +             return -EINVAL;
>
> Likewise, EINVAL tends to be over-used, which makes it ambiguous.  Maybe =
use
> ENOPKG for the case where algorithm < COMPRESS_MAX but the algorithm wasn=
't
> compiled into the kernel?  That would be similar to how opening an encryp=
ted
> file fails with ENOPKG when the encryption algorithm isn't available.
>
> > +     if (f2fs_is_mmap_file(inode) ||
> > +                     get_dirty_pages(inode) || inode->i_size) {
> > +             ret =3D -EINVAL;
> > +             goto out;
> > +     }
>
> How about EBUSY for f2fs_is_mmap_file(inode) || get_dirty_pages(inode),
> and EFBIG for inode->i_size !=3D 0?
>
> - Eric
