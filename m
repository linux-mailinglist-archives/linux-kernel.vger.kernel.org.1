Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6AE296E25
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 14:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463380AbgJWMDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 08:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463372AbgJWMDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 08:03:14 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB66C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 05:03:13 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l2so1785953lfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 05:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dP/opn4RNSZDnMUPHovJYcbSCr6w6hoguGGpHuZqJt8=;
        b=Gj2ZIGL+XgGRYmTNmS4mXA3XXXIqAShL6n9rh0Na53wpR2k0Jamyaepdnv7+NYUkOX
         cCQ4L9H+rqSoTq2B45FljM4ZG7PNnjL9xkalnRk4apJ6w0f3rvxs0jSBpT9KM8cBx+//
         6wj3LTUdMcmoSb9ASwlJSkQJLp3TAEXQx3oV/1p8M2I9LVGIB395bUtVCZqn2FEORT3j
         +NCZ5QnJuWUFz3BXh1Ms6dmWobXd2Nf0Nz3Rph3rMieXW+A2SxaYmWPoDLsycZqNGefR
         TLPtTFhQtgHIVye7gnoz8epz29hwlDB8uJGFFwey56Rx/ozTZDEcZhlcMVPk7LZlTzR8
         ACLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dP/opn4RNSZDnMUPHovJYcbSCr6w6hoguGGpHuZqJt8=;
        b=EYGd9nWxG3GOAEB2iDNyCx9SE8mcekm9HwvH+7ivp1kXs29JsVC+kb+UKkCzbJ60bF
         v0DBAvu/C9nbPpn1y3uCNbqnezTOpI/aKDY/dXL+YDk25zNb49GjFdPa71s/+ZTN2UIm
         geHmJTB0g48dvtLworHlzbFs+qEdFA90n+Keb8pRNy3eOQbL1m2Iid9Wwc9g48n42Qoh
         QK8u4PicweZW9KVZ0sanrjl8XME14iSsee4075zb8fx03KTa9XUKQkLCsaTYix78RWGg
         hYRQKbAmaUpdVZVjGdR2KwNDlHozOfPZBbn36C/qCU3CJcXdtq8KpmkbFw+CKXDrwYJ5
         8npA==
X-Gm-Message-State: AOAM530haIxmEuDiIfKtwe1CWkI5NKHBdnMKCo6/Z9I25BC4eGFq8ULj
        i33ViE/2e4J3eBreRrcUZFWd/wVmu9iER2J0Xhk=
X-Google-Smtp-Source: ABdhPJwCOZO+tpMwLl9I/Q9laS2vOtIjKjGfYoC04k6PpKF3oPoBI30mUmMzNABI65S4Enn8PFE4nv6+QQ0NO5j7byw=
X-Received: by 2002:a19:941:: with SMTP id 62mr681861lfj.227.1603454592013;
 Fri, 23 Oct 2020 05:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201022035848.976286-2-daeho43@gmail.com> <20201023120036.GY1042@kadam>
In-Reply-To: <20201023120036.GY1042@kadam>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 23 Oct 2020 21:03:01 +0900
Message-ID: <CACOAw_zgDKW1gqaeBYedPOn-7FFnJ0mQ2Cy_g5e7Zd+R37NPBg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        lkp@intel.com, kbuild-all@lists.01.org,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yep, sure~!

2020=EB=85=84 10=EC=9B=94 23=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 9:00, =
Dan Carpenter <dan.carpenter@oracle.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> Hi Daeho,
>
> url:    https://github.com/0day-ci/linux/commits/Daeho-Jeong/f2fs-add-F2F=
S_IOC_GET_COMPRESS_OPTION-ioctl/20201022-115947
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git =
dev-test
> config: x86_64-randconfig-m001-20201022 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> New smatch warnings:
> fs/f2fs/file.c:4011 f2fs_ioc_set_compress_option() error: uninitialized s=
ymbol 'ret'.
>
> Old smatch warnings:
> fs/f2fs/f2fs.h:2127 dec_valid_block_count() warn: should 'count << 3' be =
a 64 bit type?
> fs/f2fs/file.c:2525 f2fs_ioc_gc_range() warn: inconsistent returns 'sbi->=
gc_lock'.
> fs/f2fs/file.c:2941 f2fs_ioc_flush_device() warn: potential spectre issue=
 'sbi->devs' [w] (local cap)
> fs/f2fs/file.c:2966 f2fs_ioc_flush_device() warn: inconsistent returns 's=
bi->gc_lock'.
> fs/f2fs/file.c:3305 f2fs_precache_extents() error: uninitialized symbol '=
err'.
>
> vim +/ret +4011 fs/f2fs/file.c
>
> d869d11ac39edb Daeho Jeong 2020-10-22  3969  static int f2fs_ioc_set_comp=
ress_option(struct file *filp, unsigned long arg)
> d869d11ac39edb Daeho Jeong 2020-10-22  3970  {
> d869d11ac39edb Daeho Jeong 2020-10-22  3971     struct inode *inode =3D f=
ile_inode(filp);
> d869d11ac39edb Daeho Jeong 2020-10-22  3972     struct f2fs_sb_info *sbi =
=3D F2FS_I_SB(inode);
> d869d11ac39edb Daeho Jeong 2020-10-22  3973     struct f2fs_comp_option o=
ption;
> d869d11ac39edb Daeho Jeong 2020-10-22  3974     int ret;
> d869d11ac39edb Daeho Jeong 2020-10-22  3975
> d869d11ac39edb Daeho Jeong 2020-10-22  3976     if (!f2fs_sb_has_compress=
ion(sbi))
> d869d11ac39edb Daeho Jeong 2020-10-22  3977             return -EOPNOTSUP=
P;
> d869d11ac39edb Daeho Jeong 2020-10-22  3978
> d869d11ac39edb Daeho Jeong 2020-10-22  3979     if (!f2fs_compressed_file=
(inode))
> d869d11ac39edb Daeho Jeong 2020-10-22  3980             return -EINVAL;
> d869d11ac39edb Daeho Jeong 2020-10-22  3981
> d869d11ac39edb Daeho Jeong 2020-10-22  3982     if (!(filp->f_mode & FMOD=
E_WRITE))
> d869d11ac39edb Daeho Jeong 2020-10-22  3983             return -EBADF;
> d869d11ac39edb Daeho Jeong 2020-10-22  3984
> d869d11ac39edb Daeho Jeong 2020-10-22  3985     if (copy_from_user(&optio=
n, (struct f2fs_comp_option __user *)arg,
> d869d11ac39edb Daeho Jeong 2020-10-22  3986                             s=
izeof(option)))
> d869d11ac39edb Daeho Jeong 2020-10-22  3987             return -EFAULT;
> d869d11ac39edb Daeho Jeong 2020-10-22  3988
> d869d11ac39edb Daeho Jeong 2020-10-22  3989     if (option.log_cluster_si=
ze < MIN_COMPRESS_LOG_SIZE ||
> d869d11ac39edb Daeho Jeong 2020-10-22  3990                     option.lo=
g_cluster_size > MAX_COMPRESS_LOG_SIZE ||
> d869d11ac39edb Daeho Jeong 2020-10-22  3991                     !f2fs_is_=
compress_algorithm_ready(option.algorithm))
> d869d11ac39edb Daeho Jeong 2020-10-22  3992             return -EINVAL;
> d869d11ac39edb Daeho Jeong 2020-10-22  3993
> d869d11ac39edb Daeho Jeong 2020-10-22  3994     file_start_write(filp);
> d869d11ac39edb Daeho Jeong 2020-10-22  3995     inode_lock(inode);
> d869d11ac39edb Daeho Jeong 2020-10-22  3996
> d869d11ac39edb Daeho Jeong 2020-10-22  3997     if (f2fs_is_mmap_file(ino=
de) ||
> d869d11ac39edb Daeho Jeong 2020-10-22  3998                     get_dirty=
_pages(inode) || inode->i_size) {
> d869d11ac39edb Daeho Jeong 2020-10-22  3999             ret =3D -EINVAL;
> d869d11ac39edb Daeho Jeong 2020-10-22  4000             goto out;
> d869d11ac39edb Daeho Jeong 2020-10-22  4001     }
> d869d11ac39edb Daeho Jeong 2020-10-22  4002
> d869d11ac39edb Daeho Jeong 2020-10-22  4003     F2FS_I(inode)->i_compress=
_algorithm =3D option.algorithm;
> d869d11ac39edb Daeho Jeong 2020-10-22  4004     F2FS_I(inode)->i_log_clus=
ter_size =3D option.log_cluster_size;
> d869d11ac39edb Daeho Jeong 2020-10-22  4005     F2FS_I(inode)->i_cluster_=
size =3D 1 << option.log_cluster_size;
> d869d11ac39edb Daeho Jeong 2020-10-22  4006     f2fs_mark_inode_dirty_syn=
c(inode, true);
>
>
> "ret" is uninitialized on the success path.
>
> d869d11ac39edb Daeho Jeong 2020-10-22  4007  out:
> d869d11ac39edb Daeho Jeong 2020-10-22  4008     inode_unlock(inode);
> d869d11ac39edb Daeho Jeong 2020-10-22  4009     file_end_write(filp);
> d869d11ac39edb Daeho Jeong 2020-10-22  4010
> d869d11ac39edb Daeho Jeong 2020-10-22 @4011     return ret;
> d869d11ac39edb Daeho Jeong 2020-10-22  4012  }
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
