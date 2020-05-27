Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA3C1E33BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 01:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgEZXbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 19:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgEZXbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 19:31:14 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB3AC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 16:31:14 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b6so26697356ljj.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 16:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=guzman.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NUHQ87HXBhNLKdg5M4S8WpnQd9u0DanCJ6FWlFhn50g=;
        b=kMBEkytO421Sme01FUYPg/RhFeCsWxOBXVi7dHrRMP/yX14dsQeccuifaus5xaz/9e
         wjjpnmeM9D+ccEq+VUAB48plmUqyKLQSBCKqiLDJ28D9pzenSdcyuoNl08yWm5uNOqIg
         AR2sai4gvUcXNsVVu12PJ6aQYJhyLkKAXuNqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NUHQ87HXBhNLKdg5M4S8WpnQd9u0DanCJ6FWlFhn50g=;
        b=EFPma9yCXNzUJzZ3aS39JYzgB6C4IHTLxnwQswyGyGyu0XVSSsmDwHKlnqwwMEg4ik
         26NoPMXxRvWfv4MBYJwd+fl35jwYQJuFaa00IbgXrCMiY+MOUCRUywUU79b/3A8WYoT9
         MVUGfXrTXh0CSRLLl1rcGFteg9m89hbflV78q7uKVfVOYAJoDnreMEaTkF9Udy+TVWUx
         YQfrwqEr0+KWMzoTpiY6dxx23IfmSFfh86GRl9p5QHYQFaw9XJ7F7vDSZ/Ck+1VVFlhp
         tdfMgC2s3qkirI/TsnvWn1AO/Ct5zp8gPbH0d7OD+zBoUHqymW9B6AoLzuViOiPoaDn1
         iG6g==
X-Gm-Message-State: AOAM533GZCd7Gky5y1BcCz0qbL0t4zDgqWtu1X5DMlW2xIRnPY2RBOE7
        HLJ7ZqnBYQJtOUgXC0cK1JFyeA7kcEznsPPU2U4HYQ==
X-Google-Smtp-Source: ABdhPJyR5HMQaW5UuV5jbkhlc66/+xKqzQdlsnkgoPumeuNFswLStR1xI7PXaz9cnvI14E06uxSyqrbryw1y/M5jLZ4=
X-Received: by 2002:a2e:8654:: with SMTP id i20mr1474327ljj.79.1590535872825;
 Tue, 26 May 2020 16:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200526183213.20720-1-mario.limonciello@dell.com>
 <1590520454.11810.40.camel@HansenPartnership.com> <ccf055cbf1a14f28bc95a6b02e29a2f6@AUSX13MPC105.AMER.DELL.COM>
 <1590521924.15108.1.camel@HansenPartnership.com> <da3027a2aa9d1b7110a65de919e88f42ef2e13bb.camel@guzman.io>
 <1590534370.15108.17.camel@HansenPartnership.com>
In-Reply-To: <1590534370.15108.17.camel@HansenPartnership.com>
From:   Alex Guzman <alex@guzman.io>
Date:   Tue, 26 May 2020 16:31:01 -0700
Message-ID: <CAJ7-PMaoFyi89OFgYsNknc2d0Fr4RHLmmHo-puNiKchM=0mU6w@mail.gmail.com>
Subject: Re: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING mode"
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 4:06 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2020-05-26 at 15:19 -0700, Alex Guzman wrote:
> [...]
> > When using your patch, I get a hang when trying to use tpm2_getcap,
> > and dmesg shows some info.
>
> Are you sure it's all applied?  This
>
> > [  570.913803]  tpm_tcg_write_bytes+0x2f/0x40
> > [  570.913805]  release_locality+0x49/0x220
> > [  570.913807]  tpm_relinquish_locality+0x1f/0x40
> > [  570.913808]  tpm_chip_stop+0x21/0x40
> > [  570.913810]  tpm_put_ops+0x9/0x30
> > [  570.913811]  tpm_common_write+0x179/0x190
> > [  570.913813]  vfs_write+0xb1/0x1a0
>
> Implies an unmatched tpm_put_ops() in the async write path, as though
> this hunk:
>
> > @@ -211,11 +202,19 @@ ssize_t tpm_common_write(struct file *file,
> > const char __user *buf,
> >         if (file->f_flags & O_NONBLOCK) {
> >                 priv->command_enqueued = true;
> >                 queue_work(tpm_dev_wq, &priv->async_work);
> > -               tpm_put_ops(priv->chip);
> >                 mutex_unlock(&priv->buffer_mutex);
> >                 return size;
> >         }
>
> Is missing.  I actually booted the patch in my TPM based VM and it all
> seems to work OK when I execute tpm2_getcap (I verified it's using
> O_NONBLOCK) and tssgetcapability in sync mode.
>
> James
>

Oh, I did miss that bit. The patch had issues applying for some reason
and I missed the single-line removal when I was looking at the diff.

I gave it a spin on my machine again. getcap seems to work correctly
with and without having the async config flag set for tpm2-tss. The
pkcs11 plugin seems to work correctly again too. :)
