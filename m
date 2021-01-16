Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A36F2F8A23
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 02:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbhAPBBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 20:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbhAPBBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 20:01:05 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DD1C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 17:00:24 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id o13so15870233lfr.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 17:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v2CT9ktuVNHesPpg5xBPxclzRFEcw4HruqKUslhD9m4=;
        b=QiuPYUo7vUrRxc/EN0esFuL5w10VlWd9caRvCbLA/d/X6LYZROsdT4vbaHT6nrnFLM
         1xN5+VErX6Tg1O8b0AClnWDYk0M2nAUFGSraM415zm1GbXJAtg5ephFHbZRjvM/NzQnU
         GyE0bZB5Q3l1HLl10vDab7iTnQnc27YZ2gfQ9rpk7letMaFTBgQrKBIUHG02lqbMp3nk
         1h4S5mdl0AgdSexkWflLQV3fGvs5MkFkpyQx2lVzTVPpdN2fclHPegLtiimhi2opsN12
         8t9Y3fP1kddvaB18+MxGcIP8SUnbwvLlhwt3TBR0U6K/uIUKU+fAzUFtu8KItK8wxie4
         dYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v2CT9ktuVNHesPpg5xBPxclzRFEcw4HruqKUslhD9m4=;
        b=h9fNJTLwsyUlvmNU5q6/VCicjbgRVYpVt4qmnmBE7+e8/qTGaenT64/+7PZ/XhC0Ky
         qOX2bl6TdywMAAS0s8rr0PYC+QXn04iUgTzdVzDQMctxd80KxQz8on/D3qNu70CEp6lk
         T2bVba9StdZg9RSK+dT6soFoX0mV0YnnYBcCe8i0pt9DBadNG0P1eAKzStYggLgGT4S+
         eg8RvyIUk9yToO+UOc19WHglztpz3XmxEhQja1AyBrMzTCdAhR5YoqJHxOFk1k0Kauew
         oHXZwzby92AX8PpvwFu3j3GzJAEaxLLTWVxfzt5lWibtoPtUSxis3cNSyqkCPby65vBL
         krnw==
X-Gm-Message-State: AOAM532NBFW/+rJFm5+30G9CFvtm/Hds6hiEth6DseYbtqQU/jWyqkn5
        glRFDSKOGNa6JjRpR5Gv47xNbb05t+rdqsKQnIp5XzUw05c=
X-Google-Smtp-Source: ABdhPJyXU+xINJRHQ1dG/X4hLKR7tzjwGClRsWb3mLvwpDcxFLVVD0NSI+tQHhMbaGiT/KR16qb84celHQW+hdkxVAk=
X-Received: by 2002:a19:7507:: with SMTP id y7mr5077158lfe.554.1610758823120;
 Fri, 15 Jan 2021 17:00:23 -0800 (PST)
MIME-Version: 1.0
References: <20210116005812.3753714-1-daeho43@gmail.com>
In-Reply-To: <20210116005812.3753714-1-daeho43@gmail.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Sat, 16 Jan 2021 10:00:12 +0900
Message-ID: <CACOAw_w22xp9Z9uHCPgY2zEmAMZ6kfmQAjhEORBEGoyLccDPqw@mail.gmail.com>
Subject: Re: [PATCH v3] f2fs: add ckpt_thread_ioprio sysfs node
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, ignore this.
I've sent this wrong. :(

2021=EB=85=84 1=EC=9B=94 16=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 9:58, D=
aeho Jeong <daeho43@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Daeho Jeong <daehojeong@google.com>
>
> Added "ckpt_thread_ioprio" sysfs node to give a way to change checkpoint
> merge daemon's io priority. Its default value is "be,3", which means
> "BE" I/O class and I/O priority "3". We can select the class between "rt"
> and "be", and set the I/O priority within valid range of it.
> "," delimiter is necessary in between I/O class and priority number.
>
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v2:
> - adapt to inlining ckpt_req_control of f2fs_sb_info
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs |  8 ++++
>  fs/f2fs/checkpoint.c                    |  2 +-
>  fs/f2fs/f2fs.h                          |  1 +
>  fs/f2fs/sysfs.c                         | 51 +++++++++++++++++++++++++
>  4 files changed, 61 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/=
testing/sysfs-fs-f2fs
> index 3dfee94e0618..0c48b2e7dfd4 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -377,3 +377,11 @@ Description:       This gives a control to limit the=
 bio size in f2fs.
>                 Default is zero, which will follow underlying block layer=
 limit,
>                 whereas, if it has a certain bytes value, f2fs won't subm=
it a
>                 bio larger than that size.
> +What:          /sys/fs/f2fs/<disk>/ckpt_thread_ioprio
> +Date:          January 2021
> +Contact:       "Daeho Jeong" <daehojeong@google.com>
> +Description:   Give a way to change checkpoint merge daemon's io priorit=
y.
> +               Its default value is "be,3", which means "BE" I/O class a=
nd
> +               I/O priority "3". We can select the class between "rt" an=
d "be",
> +               and set the I/O priority within valid range of it. "," de=
limiter
> +               is necessary in between I/O class and priority number.
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index ef6ad3d1957d..30e3fe161bb4 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1854,7 +1854,7 @@ int f2fs_start_ckpt_thread(struct f2fs_sb_info *sbi=
)
>                 return PTR_ERR(cprc->f2fs_issue_ckpt);
>         }
>
> -       set_task_ioprio(cprc->f2fs_issue_ckpt, DEFAULT_CHECKPOINT_IOPRIO)=
;
> +       set_task_ioprio(cprc->f2fs_issue_ckpt, cprc->ckpt_thread_ioprio);
>
>         return 0;
>  }
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f2ae075aa723..517eb0eda638 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -276,6 +276,7 @@ struct ckpt_req {
>
>  struct ckpt_req_control {
>         struct task_struct *f2fs_issue_ckpt;    /* checkpoint task */
> +       int ckpt_thread_ioprio;                 /* checkpoint merge threa=
d ioprio */
>         wait_queue_head_t ckpt_wait_queue;      /* waiting queue for wake=
-up */
>         atomic_t issued_ckpt;           /* # of actually issued ckpts */
>         atomic_t total_ckpt;            /* # of total ckpts */
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 30bae57428d1..ddd70395148d 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -11,6 +11,7 @@
>  #include <linux/f2fs_fs.h>
>  #include <linux/seq_file.h>
>  #include <linux/unicode.h>
> +#include <linux/ioprio.h>
>
>  #include "f2fs.h"
>  #include "segment.h"
> @@ -34,6 +35,7 @@ enum {
>         FAULT_INFO_TYPE,        /* struct f2fs_fault_info */
>  #endif
>         RESERVED_BLOCKS,        /* struct f2fs_sb_info */
> +       CPRC_INFO,      /* struct ckpt_req_control */
>  };
>
>  struct f2fs_attr {
> @@ -70,6 +72,8 @@ static unsigned char *__struct_ptr(struct f2fs_sb_info =
*sbi, int struct_type)
>         else if (struct_type =3D=3D STAT_INFO)
>                 return (unsigned char *)F2FS_STAT(sbi);
>  #endif
> +       else if (struct_type =3D=3D CPRC_INFO)
> +               return (unsigned char *)&sbi->cprc_info;
>         return NULL;
>  }
>
> @@ -255,6 +259,23 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
>                 return len;
>         }
>
> +       if (!strcmp(a->attr.name, "ckpt_thread_ioprio")) {
> +               struct ckpt_req_control *cprc =3D &sbi->cprc_info;
> +               int len =3D 0;
> +               int class =3D IOPRIO_PRIO_CLASS(cprc->ckpt_thread_ioprio)=
;
> +               int data =3D IOPRIO_PRIO_DATA(cprc->ckpt_thread_ioprio);
> +
> +               if (class =3D=3D IOPRIO_CLASS_RT)
> +                       len +=3D scnprintf(buf + len, PAGE_SIZE - len, "r=
t,");
> +               else if (class =3D=3D IOPRIO_CLASS_BE)
> +                       len +=3D scnprintf(buf + len, PAGE_SIZE - len, "b=
e,");
> +               else
> +                       return -EINVAL;
> +
> +               len +=3D scnprintf(buf + len, PAGE_SIZE - len, "%d\n", da=
ta);
> +               return len;
> +       }
> +
>         ui =3D (unsigned int *)(ptr + a->offset);
>
>         return sprintf(buf, "%u\n", *ui);
> @@ -308,6 +329,34 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>                 return ret ? ret : count;
>         }
>
> +       if (!strcmp(a->attr.name, "ckpt_thread_ioprio")) {
> +               const char *name =3D strim((char *)buf);
> +               struct ckpt_req_control *cprc =3D &sbi->cprc_info;
> +               int class;
> +               long data;
> +               int ret;
> +
> +               if (!strncmp(name, "rt,", 3))
> +                       class =3D IOPRIO_CLASS_RT;
> +               else if (!strncmp(name, "be,", 3))
> +                       class =3D IOPRIO_CLASS_BE;
> +               else
> +                       return -EINVAL;
> +
> +               name +=3D 3;
> +               ret =3D kstrtol(name, 10, &data);
> +               if (ret)
> +                       return ret;
> +               if (data >=3D IOPRIO_BE_NR || data < 0)
> +                       return -EINVAL;
> +
> +               cprc->ckpt_thread_ioprio =3D IOPRIO_PRIO_VALUE(class, dat=
a);
> +               ret =3D set_task_ioprio(cprc->f2fs_issue_ckpt,
> +                               cprc->ckpt_thread_ioprio);
> +
> +               return count;
> +       }
> +
>         ui =3D (unsigned int *)(ptr + a->offset);
>
>         ret =3D kstrtoul(skip_spaces(buf), 0, &t);
> @@ -567,6 +616,7 @@ F2FS_RW_ATTR(FAULT_INFO_TYPE, f2fs_fault_info, inject=
_type, inject_type);
>  #endif
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, data_io_flag, data_io_flag);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, node_io_flag, node_io_flag);
> +F2FS_RW_ATTR(CPRC_INFO, ckpt_req_control, ckpt_thread_ioprio, ckpt_threa=
d_ioprio);
>  F2FS_GENERAL_RO_ATTR(dirty_segments);
>  F2FS_GENERAL_RO_ATTR(free_segments);
>  F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
> @@ -652,6 +702,7 @@ static struct attribute *f2fs_attrs[] =3D {
>  #endif
>         ATTR_LIST(data_io_flag),
>         ATTR_LIST(node_io_flag),
> +       ATTR_LIST(ckpt_thread_ioprio),
>         ATTR_LIST(dirty_segments),
>         ATTR_LIST(free_segments),
>         ATTR_LIST(unusable),
> --
> 2.30.0.296.g2bfb1c46d8-goog
>
