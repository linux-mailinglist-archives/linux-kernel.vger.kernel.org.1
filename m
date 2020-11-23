Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486922C0561
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 13:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgKWMTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 07:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729270AbgKWMTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 07:19:20 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13540C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 04:19:19 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id i62so3882463vkb.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 04:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0RaSE7DvnDulS9t4LpaUCUe2jf4h9KhFfKphwvJM8JQ=;
        b=w93F2dWxrnvK+FvAXB/n/udbfrv+JwAJ1uQ0QWYZVmiY7b+/3Tx3My5vmdW6U+554C
         ltaXft4sBLXQ/v2Eg6sLqwaQp9MDSKawB7LhdCrembme+GSL1mzvq2UukApuB38WUkUl
         X53RzEnOSc1Y3vsEQolhQa2GaxFf7+DyM6d0s+hYuOWlh6qbwHoOPMFoEP22LSVG15ID
         MrbS3vdJC9Kh7wnm3qubz1fBngI2Z2Dzm38fopmUieFGv6OCjnoSjc7tTvDthLj5ZHpr
         PJitVRSn4MJvtAeTw59kcycHkpl88CJ2cqmCMn6cQShjfnIlzrRsC/WNgOvGuInxk1jT
         avwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0RaSE7DvnDulS9t4LpaUCUe2jf4h9KhFfKphwvJM8JQ=;
        b=gHAvrn58Zr0rMJE70+qpE3m7NWh4f2/yFNmXIw6ucfr8g44HFd7tOV7ghUNUQwzjq+
         g7EgahEyFBxd+LWVZjXVWI1pbmT3A+81WIGAz+CGYM9CfF9Pv6X0fvZUtt8gI96iQ0yt
         qpAgCkbUvPmNZYPR+39nAxvLWZqvlSCE81EUyYF+IayaLXu8+XySHmvkhDYmOV7tfZpM
         taJTABdLXKyvNJJ5PKBcEiMrkIe7H2PDeNSB3AJPy82MUIyDLSq2/UYj4gzoGfu25Gso
         /lujxMJYvMaP+Cio+uhauJXl1dLk9AWz4pHbxgOoO22Iga+nAEMSUfiRoPydvOZN91w5
         xGgw==
X-Gm-Message-State: AOAM531mr/W4y1dx3UINSLb5Uw40ZCCQGdGnsRmF2R6H7Fw+HTyFSwfT
        d8w0iHPKCQbbn8fLa+U6lzXE4+NwdJ4C9joPA6kw2g==
X-Google-Smtp-Source: ABdhPJx/P1YTN6dBnh8JsnFk0CFqI0kBe/rayDpT35PtlocwK9Vtroch+dxh8vMau2/bddJMSJIRbiFSAOunSP5QVEU=
X-Received: by 2002:a1f:2cd4:: with SMTP id s203mr20145788vks.6.1606133955691;
 Mon, 23 Nov 2020 04:19:15 -0800 (PST)
MIME-Version: 1.0
References: <20201112062422.32212-1-bbudiredla@marvell.com>
 <20201112062422.32212-2-bbudiredla@marvell.com> <CAPDyKFqZij1_aZZs3EeEuNob37WsGYN+6N52H2N0nTzM427j3g@mail.gmail.com>
 <CY4PR1801MB20705DF5A12318AB80EDBD45DEFC0@CY4PR1801MB2070.namprd18.prod.outlook.com>
In-Reply-To: <CY4PR1801MB20705DF5A12318AB80EDBD45DEFC0@CY4PR1801MB2070.namprd18.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 23 Nov 2020 13:18:38 +0100
Message-ID: <CAPDyKFqBWEdAzz0hjk7LhqX1D8qmOomHSS=Be+_vU=upxMr0aA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v1 1/2] mmc: Support kmsg dumper based on pstore/blk
To:     Bhaskara Budiredla <bbudiredla@marvell.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> >
> >As I said above, I would like to avoid host specific deployments from be=
ing
> >needed. Is there a way we can avoid this?
> >
>
> I don't see an alternative.

Well, if not, can you please explain why?

[...]

> >> +
> >> +void mmcpstore_card_set(struct mmc_card *card, const char *disk_name)
> >> +{
> >> +       struct mmcpstore_context *cxt =3D &oops_cxt;
> >> +       struct pstore_blk_config *conf =3D &cxt->conf;
> >> +       struct pstore_device_info *dev =3D &cxt->dev;
> >> +       struct block_device *bdev;
> >> +       struct mmc_command *stop;
> >> +       struct mmc_command *cmd;
> >> +       struct mmc_request *mrq;
> >> +       struct mmc_data *data;
> >> +       int ret;
> >> +
> >> +       if (!conf->device[0])
> >> +               return;
> >> +
> >> +       /* Multiple backend devices not allowed */
> >> +       if (cxt->dev_name[0])
> >> +               return;
> >> +
> >> +       bdev =3D  mmcpstore_open_backend(conf->device);
> >> +       if (IS_ERR(bdev)) {
> >> +               pr_err("%s failed to open with %ld\n",
> >> +                               conf->device, PTR_ERR(bdev));
> >> +               return;
> >> +       }
> >> +
> >> +       bdevname(bdev, cxt->dev_name);
> >> +       cxt->partno =3D bdev->bd_part->partno;
> >> +       mmcpstore_close_backend(bdev);
> >> +
> >> +       if (strncmp(cxt->dev_name, disk_name, strlen(disk_name)))
> >> +               return;
> >> +
> >> +       cxt->start_sect =3D mmc_blk_get_part(card, cxt->partno, &cxt->=
size);
> >> +       if (!cxt->start_sect) {
> >> +               pr_err("Non-existent partition %d selected\n", cxt->pa=
rtno);
> >> +               return;
> >> +       }
> >> +
> >> +       /* Check for host mmc panic write polling function definitions=
 */
> >> +       if (!card->host->ops->req_cleanup_pending ||
> >> +                       !card->host->ops->req_completion_poll)
> >> +               return;
> >> +
> >> +       cxt->card =3D card;
> >> +
> >> +       cxt->sub =3D kmalloc(conf->kmsg_size, GFP_KERNEL);
> >> +       if (!cxt->sub)
> >> +               goto out;
> >> +
> >> +       mrq =3D kzalloc(sizeof(struct mmc_request), GFP_KERNEL);
> >> +       if (!mrq)
> >> +               goto free_sub;
> >> +
> >> +       cmd =3D kzalloc(sizeof(struct mmc_command), GFP_KERNEL);
> >> +       if (!cmd)
> >> +               goto free_mrq;
> >> +
> >> +       stop =3D kzalloc(sizeof(struct mmc_command), GFP_KERNEL);
> >> +       if (!stop)
> >> +               goto free_cmd;
> >> +
> >> +       data =3D kzalloc(sizeof(struct mmc_data), GFP_KERNEL);
> >> +       if (!data)
> >> +               goto free_stop;
> >> +
> >> +       mrq->cmd =3D cmd;
> >> +       mrq->data =3D data;
> >> +       mrq->stop =3D stop;
> >> +       cxt->mrq =3D mrq;
> >> +
> >> +       dev->total_size =3D cxt->size;
> >> +       dev->flags =3D PSTORE_FLAGS_DMESG;
> >> +       dev->read =3D mmcpstore_read;
> >> +       dev->write =3D mmcpstore_write;
> >> +       dev->erase =3D NULL;
> >> +       dev->panic_write =3D mmcpstore_panic_write;
> >> +
> >> +       ret =3D register_pstore_device(&cxt->dev);
> >
> >By looking at all of the code above, lots are duplicated from the mmc bl=
ock
> >device implementation. Isn't there a way to make the pstore block device=
 to
> >push a request through the regular blk-mq path instead?
> >
> The regular path has pre, post processing=E2=80=99s and locking semantics=
 that
> are not suitable for panic write scenario. Further, the locking mechanism=
s are
> implemented in host drivers. This is preferred to quickly complete the wr=
ite
> before the kernel dies.

I am sorry, but this doesn't make sense to me.

When it comes to complete the data write, the regular block I/O path
is supposed to be optimized. If there is a problem with this path,
then we should fix it, rather than adding a new path along the side
(unless there are very good reasons not to).

>
> >That said, I wonder why you don't call register_pstore_blk(), as I thoug=
ht that
> >was the interface to be used for regular block devices, no?
> >
> register_pstore_blk() is for arbitrary block devices for which best effor=
t is not defined.

Exactly why isn't "best effort" good enough for mmc?

As there are no other users of register_pstore_blk(), it makes me
wonder, when it should be used then?

[...]

> >> +
> >> +static void __exit mmcpstore_exit(void) {
> >> +       struct mmcpstore_context *cxt =3D &oops_cxt;
> >> +
> >> +       unregister_pstore_device(&cxt->dev);
> >> +       kfree(cxt->mrq->data);
> >> +       kfree(cxt->mrq->stop);
> >> +       kfree(cxt->mrq->cmd);
> >> +       kfree(cxt->mrq);
> >> +       kfree(cxt->sub);
> >> +       cxt->card =3D NULL;
> >
> >Can we do this via mmc_blk_remove() instead?
> >
> The unregisters here are related to mmcpstore, nothing specific to card.

I am not sure I understand. If a card is removed, which has been
registered for pstore - then what should we do?

At least, it looks like a card removal will trigger a life cycle issue
for the allocated data structures. No?

[...]

Kind regards
Uffe
