Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E5129FC25
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgJ3DZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 23:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3DZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 23:25:19 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACDFC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 20:25:18 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id k25so5396279lji.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 20:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q9dGjCASe4qWBi3GAUQrS92wx12xsyqvkjY3ZpGJK04=;
        b=LqcmPBdyGJPXEn6+gMCKB9Mm6nOIUnqvu1r6Ble/fx6SuFlrdS/EvR/MDIp+kpVmpy
         EmmfWbHoo1PHgDDRd6kk5+6ZQWEx8LnXPNe2lAtP/B1NQcGYQ0Q+fuZM4B2baG66cnBx
         Ia3Lvleo3DlvoZrUcrQW3vXDLYu7jqxtr4GoGEzhXWy0K/3Odda7NJF2YkYTYKLRl/Xx
         2B6C/w6k2BfeQmTumJ3njxUCjYyL8OlCUKNvFNZcEg4fWWvmDYIDStkIrtAjZwP/2F++
         aMxMpDaiP8FKgYV2f/lcSHi453Wj+rgAYlfMfgUygrOU6AAFd4f6Tf261oB/aUQE3MFY
         PJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q9dGjCASe4qWBi3GAUQrS92wx12xsyqvkjY3ZpGJK04=;
        b=iZPdhOT/b87jzhzXyJYKL2qt0ar04N6Fkjf0CUFXmV3NtcLT2Sx1scutblnzk+QQzH
         NhPbDGV9HT1c0Kq5yf+D45VQVyVEj4bTwEJmRQDLSAQ41FkM0e+dNgSpeqXgl3Ix8Cp7
         xqZdFO5nCNyUz8lOvDVoK50CTqhFy+TZ5Ss5juPTefEN5x3JAYDDfKPdFgmF2qHVaxj0
         i84bE8zNUqNPPIgVsavarNkphm/NvDKFn9SM6zzayqtzq9RGXeeOsCUt4J0HgXz0haJV
         OUkn9jY7b8/rwORqb3ndph+CTV+XMyqixaEbVik4uP7cr2zQ/Vk0TrbCRu/IgBWge1l6
         bulw==
X-Gm-Message-State: AOAM531/vxFLvGdtrlVaiGznfsmz6qATjH4DLWJufCfBAsH8LjgBoTQA
        xY+5pWu3j9aqejaZhRhXU1Y7pearLJ6K23BawA8=
X-Google-Smtp-Source: ABdhPJxBokkVQP1gYf3zsHpnOJXP0FEn9vAd8MKCJGJKF6imUQBIy1+pl8ND3Qg+PWOD8rt39ahifROZYzMBOO6GJwE=
X-Received: by 2002:a2e:700a:: with SMTP id l10mr144269ljc.265.1604028317337;
 Thu, 29 Oct 2020 20:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201029041538.4165209-1-daeho43@gmail.com> <861e569d-feae-c521-35b7-dcb8b79cdfba@huawei.com>
 <61d43f5d-f26c-525a-6405-bae0ca495c6d@huawei.com>
In-Reply-To: <61d43f5d-f26c-525a-6405-bae0ca495c6d@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 30 Oct 2020 12:25:06 +0900
Message-ID: <CACOAw_xHM-FB3pRfFnjF-9eVgo=cxPh=tsLyEX30NHaz2gAbtQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v5 1/2] f2fs: add F2FS_IOC_GET_COMPRESS_OPTION ioctl
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Opps, I missed this.
We need v7... lol

2020=EB=85=84 10=EC=9B=94 30=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 11:37,=
 Chao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2020/10/29 15:24, Chao Yu wrote:
> > On 2020/10/29 12:15, Daeho Jeong wrote:
>
> >> +    inode_lock(inode);
> >
> > It's minor,
> >
> > inode_lock_shared()?
> >
> >> +
> >> +    if (!f2fs_compressed_file(inode)) {
> >> +            inode_unlock(inode);
> >
> > inode_unlock_shared()?
> >
> >> +            return -ENODATA;
> >> +    }
> >> +
> >> +    option.algorithm =3D F2FS_I(inode)->i_compress_algorithm;
> >> +    option.log_cluster_size =3D F2FS_I(inode)->i_log_cluster_size;
> >> +
> >> +    inode_unlock(inode);
> >
> > ditto.
>
> Any comments?
>
> Thanks,
