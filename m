Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6952EA596
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 07:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbhAEGtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 01:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbhAEGtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 01:49:00 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F58C061796
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 22:48:20 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id a12so70216118lfl.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 22:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OpxZsk9jJXP2U2C3iXiY0AGX43J+hhnzXoyfUqqDyT8=;
        b=HV5OYzJgzdKgjV9ln/TJArILsakLGNM5bDtgfkhefjmw5Rjatol/WFLS8x5J9vBayF
         NNbDlXIhYKxeTK84AQs6308kIYuhgja4K2FcvnPEMnE6qP1yFaPaExh7FApoQ8dH2ygl
         sAhG0WYQfKUUVgjCWKTlwEl68DmiJlL7vOaf4CZo55hQoLXojOnMwdenbRd+dHhjEVE9
         FxW5PXJoF10b3h1rYCPSxF8mje4wd8ClYJx31klEpPZpHKWmFNCp9rSFVjLdtGhOoQs7
         BVFqEOjq/CEobKvNG6SnrwpShUKMGI3gAxo9/Gx7s0lzsz7uCT+EUAak2F4ixcgJO5lw
         93QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OpxZsk9jJXP2U2C3iXiY0AGX43J+hhnzXoyfUqqDyT8=;
        b=fkdUhzJbffG3DnF6l+uZIJbGYpKDydGpXVzNBuYrMkVRMJFPIaboEwNMG57oBigXdh
         HjPDVO04bYf/gdKMq6nhWosjZEUpGtCvWAFuiXhH87SNxv/3E+SK0PAqYaURybkB1DbQ
         TFZrH7GNUEc/eDdgkIYSrLZzWMEjlFPGAFb2Q7m44SkuKoHihEfFdwN/44dt1mM1maOY
         4uqUpGAtrmZ7I91U7qyln0jyC5m+v6sTTXjrlYKvvaIzPJ1yw/TzvH8/MqH23TRFNgyj
         J+AK8ko8mHks6tAHFGQIwjQAzP4cqQj5kUHwg+6asgqcfknTMPzw+Tfp1DwWe4/VIL4J
         PcXA==
X-Gm-Message-State: AOAM532CZPPjwApcHdigW8QGeDnCICdvfmqhjbFnDL/3VqWO6DGU2Yxo
        h5fuX92t4fTxz1rm9BTwgt/nu9ytZYpSpdgOzkHJdw==
X-Google-Smtp-Source: ABdhPJww36k15/BzfzFNtkEkRVVb1J7oNB6wbeGsjMWSPdmmxrY7TpN0ZzAMFQcC6cOlpcf5nxALWSLSOVFaPwQ1AgI=
X-Received: by 2002:a2e:9dc1:: with SMTP id x1mr35175313ljj.32.1609829298531;
 Mon, 04 Jan 2021 22:48:18 -0800 (PST)
MIME-Version: 1.0
References: <1609760177-6083-1-git-send-email-charante@codeaurora.org> <0dcbf9c5-3c28-0f57-0069-3fe5dc3aa7f6@gmail.com>
In-Reply-To: <0dcbf9c5-3c28-0f57-0069-3fe5dc3aa7f6@gmail.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Tue, 5 Jan 2021 12:18:07 +0530
Message-ID: <CAO_48GEKimoZ0KiGj+TmQf9DvTitMDbFxRCvhusA2VcHwAGfug@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH] dmabuf: fix use-after-free of dmabuf's file->f_inode
To:     Christian Koenig <christian.koenig@amd.com>
Cc:     Charan Teja Reddy <charante@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Linaro MM SIG <linaro-mm-sig@lists.linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charan,

On Mon, 4 Jan 2021 at 17:22, Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 04.01.21 um 12:36 schrieb Charan Teja Reddy:
> > It is observed 'use-after-free' on the dmabuf's file->f_inode with the
> > race between closing the dmabuf file and reading the dmabuf's debug
> > info.
> >
> > Consider the below scenario where P1 is closing the dma_buf file
> > and P2 is reading the dma_buf's debug info in the system:
> >
> > P1                                            P2
> >                                       dma_buf_debug_show()
> > dma_buf_put()
> >    __fput()
> >      file->f_op->release()
> >      dput()
> >      ....
> >        dentry_unlink_inode()
> >          iput(dentry->d_inode)
> >          (where the inode is freed)
> >                                       mutex_lock(&db_list.lock)
> >                                       read 'dma_buf->file->f_inode'
> >                                       (the same inode is freed by P1)
> >                                       mutex_unlock(&db_list.lock)
> >        dentry->d_op->d_release()-->
> >          dma_buf_release()
> >            .....
> >            mutex_lock(&db_list.lock)
> >            removes the dmabuf from the list
> >            mutex_unlock(&db_list.lock)
> >
> > In the above scenario, when dma_buf_put() is called on a dma_buf, it
> > first frees the dma_buf's file->f_inode(=3Ddentry->d_inode) and then
> > removes this dma_buf from the system db_list. In between P2 traversing
> > the db_list tries to access this dma_buf's file->f_inode that was freed
> > by P1 which is a use-after-free case.
> >
> > Since, __fput() calls f_op->release first and then later calls the
> > d_op->d_release, move the dma_buf's db_list removal from d_release() to
> > f_op->release(). This ensures that dma_buf's file->f_inode is not
> > accessed after it is released.
> >
> > Fixes: 4ab59c3c638c ("dma-buf: Move dma_buf_release() from fops to dent=
ry_ops")
> > Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
>
> Not an expert on the debugfs stuff in DMA-buf, but the explanation
> sounds perfectly correct to me.
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Thanks for your fix; I will queue it up in the fixes branch. Can you
please also send it to be queued to 5.4+ stable branches?

>
> > ---
> >   drivers/dma-buf/dma-buf.c | 21 +++++++++++++++++----
> >   1 file changed, 17 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index 0eb80c1..a14dcbb 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -76,10 +76,6 @@ static void dma_buf_release(struct dentry *dentry)
> >
> >       dmabuf->ops->release(dmabuf);
> >
> > -     mutex_lock(&db_list.lock);
> > -     list_del(&dmabuf->list_node);
> > -     mutex_unlock(&db_list.lock);
> > -
> >       if (dmabuf->resv =3D=3D (struct dma_resv *)&dmabuf[1])
> >               dma_resv_fini(dmabuf->resv);
> >
> > @@ -88,6 +84,22 @@ static void dma_buf_release(struct dentry *dentry)
> >       kfree(dmabuf);
> >   }
> >
> > +static int dma_buf_file_release(struct inode *inode, struct file *file=
)
> > +{
> > +     struct dma_buf *dmabuf;
> > +
> > +     if (!is_dma_buf_file(file))
> > +             return -EINVAL;
> > +
> > +     dmabuf =3D file->private_data;
> > +
> > +     mutex_lock(&db_list.lock);
> > +     list_del(&dmabuf->list_node);
> > +     mutex_unlock(&db_list.lock);
> > +
> > +     return 0;
> > +}
> > +
> >   static const struct dentry_operations dma_buf_dentry_ops =3D {
> >       .d_dname =3D dmabuffs_dname,
> >       .d_release =3D dma_buf_release,
> > @@ -413,6 +425,7 @@ static void dma_buf_show_fdinfo(struct seq_file *m,=
 struct file *file)
> >   }
> >
> >   static const struct file_operations dma_buf_fops =3D {
> > +     .release        =3D dma_buf_file_release,
> >       .mmap           =3D dma_buf_mmap_internal,
> >       .llseek         =3D dma_buf_llseek,
> >       .poll           =3D dma_buf_poll,
>

Best,
Sumit.
