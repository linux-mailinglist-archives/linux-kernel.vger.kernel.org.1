Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF442C29E4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389208AbgKXOlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389107AbgKXOk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:40:59 -0500
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CC7C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:40:58 -0800 (PST)
Received: by mail-ua1-x944.google.com with SMTP id v9so6870470uar.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HF0eKk+yfs4OwU+cyYD4lXrGovUGRGwroH1GkGhs2LM=;
        b=DY00A/aElDep7D3sd+uTMMVCHTCOevTdkuz/4ecqWfXzzNm4Lhj7IrvfaxA+BZfaTl
         hHCogKZDx8X75H5UzyXNWO2PswNtF3dex7C0+FVhb5COyHhdeHP8h59ce1dk7GTGLyo3
         Ax+aF3jix3UrtexLgYdvhlG6URSg+Bxbalx3v/qWqq629NLnHT+FAlA/kofjU+64SNtG
         VZpsb8YC2x3IeL4X0mbXN7sNZWroGP7O17i9kCHsoLJtqTXYnCqVS3mUXdl5TfxtQmP9
         JosscI9geHhQ60xXZW/oTRPiwp1cAyEAcIq5swxyY+YGSic8wCeyZHXfmorjj20l3P9A
         kXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HF0eKk+yfs4OwU+cyYD4lXrGovUGRGwroH1GkGhs2LM=;
        b=Hwjvs8zOVHPrp+pWG/ceXDQtdyITdFN04/AbPsrVvo1TMrXnyTowHHhy4oemFWfy3D
         bmlP9RAR3kTECczeRaBiaAbUqDAFaDWmYTbnXAW48DvF5dz6hyIDOKSwGK7B2nXuz/Fi
         Igu23uCTNscfGQ5nAbIAR8hTXHkrq3fnlIA9y0j8TUt2de77i/Fz5n4X7D5gYA1L3CqS
         SKYOnYyjsu/+4QfE3q0Qc7ylEUjh3wdyqq3RGmQPmm+O41Q3yXoblvHbxOJyLM1P67l4
         srKZPupUPBwVhNw5u57O5wvhnCJnAXbRVMg2EGY2Daz0kuUobqbQU6dqNlDaTIfUuhzi
         CQrw==
X-Gm-Message-State: AOAM5320wIN5GWqpxdcOmuFpI40XU70HVwX/JXI0VyN7oLUARmcy1je1
        GpAFN9BjGfWQ2PlMwDHPqGXY9SpH9gJXM+whWoHeHVHO+YfhLA==
X-Google-Smtp-Source: ABdhPJzrhN8oIGePgQXz5u8sBWQw3MmKT3PYzGJ1q07DNkkJjk8lcvizkxhns/w1q9E6NOCvRK9d622HbUIimCqgr6w=
X-Received: by 2002:ab0:c12:: with SMTP id a18mr3249859uak.19.1606228857714;
 Tue, 24 Nov 2020 06:40:57 -0800 (PST)
MIME-Version: 1.0
References: <20201112062422.32212-1-bbudiredla@marvell.com>
 <20201112062422.32212-2-bbudiredla@marvell.com> <CAPDyKFqZij1_aZZs3EeEuNob37WsGYN+6N52H2N0nTzM427j3g@mail.gmail.com>
 <CY4PR1801MB20705DF5A12318AB80EDBD45DEFC0@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFqBWEdAzz0hjk7LhqX1D8qmOomHSS=Be+_vU=upxMr0aA@mail.gmail.com> <CY4PR1801MB2070549B13D3ADD324F4E8EBDEFB0@CY4PR1801MB2070.namprd18.prod.outlook.com>
In-Reply-To: <CY4PR1801MB2070549B13D3ADD324F4E8EBDEFB0@CY4PR1801MB2070.namprd18.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Nov 2020 15:40:21 +0100
Message-ID: <CAPDyKFqZomrJDgjKWvxeOornENnZFXSX+NWTWEerNHf=zf1L8g@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v1 1/2] mmc: Support kmsg dumper based on pstore/blk
To:     Bhaskara Budiredla <bbudiredla@marvell.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Christoph

On Tue, 24 Nov 2020 at 05:09, Bhaskara Budiredla <bbudiredla@marvell.com> w=
rote:
>
>
>
> >-----Original Message-----
> >From: Ulf Hansson <ulf.hansson@linaro.org>
> >Sent: Monday, November 23, 2020 5:49 PM
> >To: Bhaskara Budiredla <bbudiredla@marvell.com>
> >Cc: Kees Cook <keescook@chromium.org>; Colin Cross
> ><ccross@android.com>; Tony Luck <tony.luck@intel.com>; Sunil Kovvuri
> >Goutham <sgoutham@marvell.com>; linux-mmc@vger.kernel.org; Linux
> >Kernel Mailing List <linux-kernel@vger.kernel.org>
> >Subject: Re: [EXT] Re: [PATCH v1 1/2] mmc: Support kmsg dumper based on
> >pstore/blk
> >
> >[...]
> >
> >> >
> >> >As I said above, I would like to avoid host specific deployments from
> >> >being needed. Is there a way we can avoid this?
> >> >
> >>
> >> I don't see an alternative.
> >
> >Well, if not, can you please explain why?
> >
>
> The solution has to be polling based as panic write runs with interrupts =
disabled.

Right, that's a good reason. :-) Please clarify that in the commit
message and add some information around the definition of the new host
ops callbacks should be used.

> I am not sure if there is a way to write a polling function that works of=
 all kinds
> of host/dma drivers. That=E2=80=99s the reason I have provided hooks to d=
efine host
> specific deployments. If you have better ideas, please help.

No, at this point I don't, sorry. I will think more about it.

>
> >[...]
> >
> >> >> +
> >> >> +void mmcpstore_card_set(struct mmc_card *card, const char
> >> >> +*disk_name) {
> >> >> +       struct mmcpstore_context *cxt =3D &oops_cxt;
> >> >> +       struct pstore_blk_config *conf =3D &cxt->conf;
> >> >> +       struct pstore_device_info *dev =3D &cxt->dev;
> >> >> +       struct block_device *bdev;
> >> >> +       struct mmc_command *stop;
> >> >> +       struct mmc_command *cmd;
> >> >> +       struct mmc_request *mrq;
> >> >> +       struct mmc_data *data;
> >> >> +       int ret;
> >> >> +
> >> >> +       if (!conf->device[0])
> >> >> +               return;
> >> >> +
> >> >> +       /* Multiple backend devices not allowed */
> >> >> +       if (cxt->dev_name[0])
> >> >> +               return;
> >> >> +
> >> >> +       bdev =3D  mmcpstore_open_backend(conf->device);
> >> >> +       if (IS_ERR(bdev)) {
> >> >> +               pr_err("%s failed to open with %ld\n",
> >> >> +                               conf->device, PTR_ERR(bdev));
> >> >> +               return;
> >> >> +       }
> >> >> +
> >> >> +       bdevname(bdev, cxt->dev_name);
> >> >> +       cxt->partno =3D bdev->bd_part->partno;
> >> >> +       mmcpstore_close_backend(bdev);
> >> >> +
> >> >> +       if (strncmp(cxt->dev_name, disk_name, strlen(disk_name)))
> >> >> +               return;
> >> >> +
> >> >> +       cxt->start_sect =3D mmc_blk_get_part(card, cxt->partno, &cx=
t->size);
> >> >> +       if (!cxt->start_sect) {
> >> >> +               pr_err("Non-existent partition %d selected\n", cxt-=
>partno);
> >> >> +               return;
> >> >> +       }
> >> >> +
> >> >> +       /* Check for host mmc panic write polling function definiti=
ons */
> >> >> +       if (!card->host->ops->req_cleanup_pending ||
> >> >> +                       !card->host->ops->req_completion_poll)
> >> >> +               return;
> >> >> +
> >> >> +       cxt->card =3D card;
> >> >> +
> >> >> +       cxt->sub =3D kmalloc(conf->kmsg_size, GFP_KERNEL);
> >> >> +       if (!cxt->sub)
> >> >> +               goto out;
> >> >> +
> >> >> +       mrq =3D kzalloc(sizeof(struct mmc_request), GFP_KERNEL);
> >> >> +       if (!mrq)
> >> >> +               goto free_sub;
> >> >> +
> >> >> +       cmd =3D kzalloc(sizeof(struct mmc_command), GFP_KERNEL);
> >> >> +       if (!cmd)
> >> >> +               goto free_mrq;
> >> >> +
> >> >> +       stop =3D kzalloc(sizeof(struct mmc_command), GFP_KERNEL);
> >> >> +       if (!stop)
> >> >> +               goto free_cmd;
> >> >> +
> >> >> +       data =3D kzalloc(sizeof(struct mmc_data), GFP_KERNEL);
> >> >> +       if (!data)
> >> >> +               goto free_stop;
> >> >> +
> >> >> +       mrq->cmd =3D cmd;
> >> >> +       mrq->data =3D data;
> >> >> +       mrq->stop =3D stop;
> >> >> +       cxt->mrq =3D mrq;
> >> >> +
> >> >> +       dev->total_size =3D cxt->size;
> >> >> +       dev->flags =3D PSTORE_FLAGS_DMESG;
> >> >> +       dev->read =3D mmcpstore_read;
> >> >> +       dev->write =3D mmcpstore_write;
> >> >> +       dev->erase =3D NULL;
> >> >> +       dev->panic_write =3D mmcpstore_panic_write;
> >> >> +
> >> >> +       ret =3D register_pstore_device(&cxt->dev);
> >> >
> >> >By looking at all of the code above, lots are duplicated from the mmc
> >> >block device implementation. Isn't there a way to make the pstore
> >> >block device to push a request through the regular blk-mq path instea=
d?
> >> >
> >> The regular path has pre, post processing=E2=80=99s and locking semant=
ics that
> >> are not suitable for panic write scenario. Further, the locking
> >> mechanisms are implemented in host drivers. This is preferred to
> >> quickly complete the write before the kernel dies.
> >
> >I am sorry, but this doesn't make sense to me.
>
> It seems there was some confusion. My comments were specific to
> mmcpstore_panic_write() as it runs with interrupts disabled.
> mmcpstore_read()/mmcpstore_write() indeed go through regular
> blk-mq path.
>
> >
> >When it comes to complete the data write, the regular block I/O path is
> >supposed to be optimized. If there is a problem with this path, then we =
should
> >fix it, rather than adding a new path along the side (unless there are v=
ery good
> >reasons not to).
> >
> >>
> >> >That said, I wonder why you don't call register_pstore_blk(), as I
> >> >thought that was the interface to be used for regular block devices, =
no?
> >> >
> >> register_pstore_blk() is for arbitrary block devices for which best ef=
fort is not
> >defined.
> >
> >Exactly why isn't "best effort" good enough for mmc?
> >
>
> register_pstore_blk() definitely does the work. If you prefer to take tha=
t route,
> it should be fine.

It looks like Christoph is planning for some rewrite of the pstore
code, so let's see what that means in regards to this.

[...]

Kind regards
Uffe
