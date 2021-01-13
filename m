Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE902F41F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 03:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbhAMCnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 21:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbhAMCno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 21:43:44 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B477C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:43:04 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id b23so326260vsp.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BjikdSxVJuWtDCApwFIqnQuJzIPxFoxDVd2b4oaxUSY=;
        b=JlI17E+sO+XTZR/W5kqKOp/sZhm4fCRtWa4+1tWhLkK9I+nRkvWiV50g8klS61ww+a
         WCNa95s0HnmRRvsEAVbFJuuo8/ReTZ9QnFPFt3QI50GasK7RXkWcZxvisTH03Sr8Uln6
         6k7Hbb/U9cbTjFL2GCcypUtTfp0B95qvZWR8xaSQFFI6wBZpqSwy6aPT6oh3/tibz1Iz
         x26TQs7eaxl24AYCUk8gnW4ZPFGwUok1W38Nn47kdI7I0qTtTDqGKwWSA36oajsriC9g
         B7RZuKwYye8y8a4So6MYggollLby2as0oixirrCT5FQt+qSYmIdxoq2dxSm5VFFzOZJX
         qMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BjikdSxVJuWtDCApwFIqnQuJzIPxFoxDVd2b4oaxUSY=;
        b=LcbEVSzlpD5gJ7lzaqN97RMxhTvEPsHWQp3Ius88PJC11E+Vz/IrQSNHQSFB9bjhov
         r6Y/qjoJPmfUkRiu7RGrgT2fc9maS5GvvJQ1jUFaVz7RbZnNZZajNUoplJJOpRNL910H
         OVFIFtsmE3WacSoyH0cGiOKvYsvRwqGyKWkDlQ7qJYWvB+lLRvYfUpiXF70qfqaaFPz6
         f+1vR77PQpPc+MAduPCwZNldCCKB1GlYgehNpiUvBpBSD0aRzCk6uRkXqPpbbFdy6Wvh
         v8JXkuybFkYTwfu6cJvlv2BlLtK7xBjv8xF0OSOzxvpUlnu6gBfEYJJ0jsGeBexWcl+U
         VI+A==
X-Gm-Message-State: AOAM532ACzdITN8I6ES4YvUKoG9qilSGv1m6ugPyIDjCjy20XQ6O5woj
        Sd4ubpc2mGectnrgOV2PVuoV0/62zeMZXJpDeiPKkg==
X-Google-Smtp-Source: ABdhPJz55y7jUqnw5KSt0bYT3CU8ooCCqrBfvwWtvPoJYQUcMVmWnxgLCkS8F1kcXG5H0qV7/lP3Ltvza0/hJImzI9A=
X-Received: by 2002:a67:2287:: with SMTP id i129mr93145vsi.15.1610505783440;
 Tue, 12 Jan 2021 18:43:03 -0800 (PST)
MIME-Version: 1.0
References: <20210112152951.154024-1-fengli@smartx.com> <20210112155502.426331-1-fengli@smartx.com>
 <yq1v9c25bm1.fsf@ca-mkp.ca.oracle.com> <CAEK8JBALYE0_OzfhrppF38=dD7HKSn-U0ggPJTGgx5849Gfiiw@mail.gmail.com>
 <DM5PR0401MB3591FDAC44CD5665D6CEBDC39BAA0@DM5PR0401MB3591.namprd04.prod.outlook.com>
 <yq1pn2a59u3.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1pn2a59u3.fsf@ca-mkp.ca.oracle.com>
From:   Li Feng <fengli@smartx.com>
Date:   Wed, 13 Jan 2021 10:42:53 +0800
Message-ID: <CAHckoCwMz2Tqo4ZVkXAmAqfvY1APhqSHDkdS6OPXaqzOMUTh_w@mail.gmail.com>
Subject: Re: [PATCH v2] blk: avoid divide-by-zero with zero granularity
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Feng Li <lifeng1519@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, Reject the device is the right fix. I will try to send another fix.
By the way, I think this fix is good protection, maybe some other devices
violate this block size constraint.

Divide zero is unacceptable.

Thanks,
Feng Li

Martin K. Petersen <martin.petersen@oracle.com> =E4=BA=8E2021=E5=B9=B41=E6=
=9C=8813=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=881:48=E5=86=99=E9=81=
=93=EF=BC=9A
>
>
> Johannes,
>
> >> I use the nvme-tcp as the host, the target is spdk nvme-tcp target,
> >> and set a wrong block size(i.g. bs=3D8), then the host prints this oop=
s:
> >
> > I think the better fix here is to reject devices which report a block s=
ize
> > small than a sector.
>
> Yep, Linux doesn't support logical block sizes < 512 bytes.
>
> Also, the NVMe spec states:
>
>         "A value smaller than 9 (i.e., 512 bytes) is not supported."
>
> --
> Martin K. Petersen      Oracle Linux Engineering
