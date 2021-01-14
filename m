Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455972F5A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 06:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbhANFSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 00:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbhANFSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 00:18:08 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2822C061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 21:17:28 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id q20so2676383pfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 21:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oCahD8foTVoddxYHsMYM6DUY8gEUtNSocwAU/pMxRNk=;
        b=ZOeUZm0TD3YyWm4LhewhwjQFxVnPSXbygDaAWHJ3TPVTHS+J7MaGrTmK/FUY2trwCG
         fF8rrxCErQQrr3WqE2ClGAvCPAKwZqdB0IUE9Y4DdZ7cwntwhLWycL3J1uMDTDDOahS6
         HCxUtIJu7SxBppTbt0XrV6k7FhAofK7EblBeTe0Uc9nI75SD8JuG4aNieP6h83ZwysAU
         JqxYewSU5fOMtkjJeJifNxCpYJHPehNFs4UWbyKWuompazLaHwV1Xe8vTRxffxCuZN6a
         3aE749DB0A/nOk6/5glbIGnnbCV8oGqMTGeBxKKXJ9/3C6WQdQloMCVSZzJtNw2OtUMH
         D2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oCahD8foTVoddxYHsMYM6DUY8gEUtNSocwAU/pMxRNk=;
        b=uK5YvQHU/t1NAnYusI5kNm6Rb3gf54xRMpK9uVpEQrJiVtA1p5jfYbXEumwOFm/6ZI
         x9QBdqnyrTGXxbn7WoGVHYZcOcCx3pCu+DFAYEEqZGY9CHu9mfEMjn31Fpt4PJd+5a3W
         ibxT0ZJThtKTJ6GI5qpuoOiykADazxu01LTyKfkIPsB5hITqFW0L13lrjzGRb9x61McA
         o0LEMDe19Z71YqiZnmQEVFceJGyjwILbOUgSvkEZoIJz4MkBFDRsJXudSpJhZNESjOmh
         PijXb9z90eq9HrhZN7yR5kxpgKpkRXFnQeD5HMkDVJNMFpSPLv9FFq0ZeC/NBzRPacMM
         MR1Q==
X-Gm-Message-State: AOAM533pYsDZnq+9LYO44f+/MFvYILLRyTSqXXS0bE6xr/vERyLAKIra
        Ut463QFqphxHoe58kpKF24Xk8pnUyO+VMowo9/buhjl7xEh93iNe
X-Google-Smtp-Source: ABdhPJzBd6Yn13We5RDVOJOixuf16fxATi7D3gqZDlFC/ZohJYIfooO0M+SlL0eR1HNbkUwSURVk716vAvwyibyv8l4=
X-Received: by 2002:a62:1b14:0:b029:19d:fa85:9f73 with SMTP id
 b20-20020a621b140000b029019dfa859f73mr5608155pfb.25.1610601448212; Wed, 13
 Jan 2021 21:17:28 -0800 (PST)
MIME-Version: 1.0
References: <20210113160621.98615-1-fengli@smartx.com> <SN4PR0401MB35985C08E5FFCDF0F5817A9D9BA90@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <87698545-de26-c0ca-01e9-4dc2ddcacc80@grimberg.me>
In-Reply-To: <87698545-de26-c0ca-01e9-4dc2ddcacc80@grimberg.me>
From:   Feng Li <lifeng1519@gmail.com>
Date:   Thu, 14 Jan 2021 13:17:03 +0800
Message-ID: <CAEK8JBC8SzabKnG_K-axf-7Fbvc6Ng57gh=5CJjfd8U1uqjvRQ@mail.gmail.com>
Subject: Re: [PATCH] nvme: reject the ns when the block size is smaller than a sector
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Li Feng <fengli@smartx.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sagi Grimberg <sagi@grimberg.me> =E4=BA=8E2021=E5=B9=B41=E6=9C=8814=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=886:13=E5=86=99=E9=81=93=EF=BC=9A
>
>
> >> The nvme spec(1.4a, figure 248) says:
> >> "A value smaller than 9 (i.e., 512 bytes) is not supported."
> >>
> >> Signed-off-by: Li Feng <fengli@smartx.com>
> >> ---
> >>   drivers/nvme/host/core.c | 6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> >> index f320273fc672..1f02e6e49a05 100644
> >> --- a/drivers/nvme/host/core.c
> >> +++ b/drivers/nvme/host/core.c
> >> @@ -2161,6 +2161,12 @@ static int nvme_update_ns_info(struct nvme_ns *=
ns, struct nvme_id_ns *id)
> >>
> >>      blk_mq_freeze_queue(ns->disk->queue);
> >>      ns->lba_shift =3D id->lbaf[lbaf].ds;
> >> +    if (ns->lba_shift < 9) {
> >> +            pr_warn("%s: bad lba_shift(%d)\n", ns->disk->disk_name, n=
s->lba_shift);
> >> +            ret =3D -1;
>
> Meaningful errno would be useful. Also better to use dev_warn
>
> >> +            goto out_unfreeze;
> >> +    }
> >> +
> >>      nvme_set_queue_limits(ns->ctrl, ns->queue);
> >>
> >>      if (ns->head->ids.csi =3D=3D NVME_CSI_ZNS) {
> >>
> >
> >
> > But this only catches a physical block size < 512 for NVMe, not any oth=
er block device.
> >
> > Please fix it for the general case in blk_queue_physical_block_size().
>
> We actually call that later and would probably be better to check here..
Thanks for your comments.

The prototype is:
void blk_queue_logical_block_size(struct request_queue *, unsigned int);

So change it to:
bool blk_queue_logical_block_size(struct request_queue *, unsigned int);

And check all callers of this function, right?
