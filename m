Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D162C29A229
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 02:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503827AbgJ0BWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 21:22:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51270 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437035AbgJ0BWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 21:22:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id v5so20548wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 18:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iIJeX2Fh5ytYIob9dHSaaH2/ylmiguRy29mP6CRcfZs=;
        b=feNTJdGsXTjsVMkZKs9iln2pR4eBAorp3CbBgbvbwtk1DlLjfk9KwaRBwPzdWJ61pz
         7mEcI8f4oc30bQ0NVA1iPE5HQkHODfQyvkrG18GycAip4H/NEm+O69gpTrHhTuCwyBLd
         dIINZrweFqAkGn3WBloEj7u/XBn5HP5+HzaqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iIJeX2Fh5ytYIob9dHSaaH2/ylmiguRy29mP6CRcfZs=;
        b=ewDntdVAeGBEsVo7/Odc90gj/QMy+OHEEymlZHW8DEs2RH0paD1aLhyjToM9kQP9iM
         cjweUALWsnn3/ZT16fT5Ro78uZVaX26UFH4+q03il3UPlQzOiYb0Z3py0dR2gEKx7L0M
         rG7ktZQgPTyUtHu962fmLTPExq21GLMQd15L+OjgubkoICHhPwG1j66QceWwUDwjCPI7
         KDPFmRqhnFx9asrtPe1bOZWMZc1XAVsf3nXu0ewBY2PP4wYCl4kLBbGdakR5ij93+3HL
         u4qj15+qqo4K7ZaHLAfChRxcBOqNuKqPUzBp9ZBwUWvdzT93f6FG9BCKqx7dWXAZLjAu
         oFzg==
X-Gm-Message-State: AOAM53101Skd3AnsBF4K87ONfy4/PlPwlosHEA/1aax7fLJOFJD7yOE3
        eYHyp+K8K2fCjJvzvT4eGi3aEkVKpw2M6zDAJCkqMQ==
X-Google-Smtp-Source: ABdhPJzgOTg9sDSj8N9OjuJdjilCzmNwktb9eWS/su5d41VkIrCCcgtFW3D2Czhyq3JKxI67Wz3PAGi3QBy1O5EWvpQ=
X-Received: by 2002:a1c:6804:: with SMTP id d4mr57273wmc.94.1603761761836;
 Mon, 26 Oct 2020 18:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200930155100.11528-1-keitasuzuki.park@sslab.ics.keio.ac.jp> <yq1d0148xza.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1d0148xza.fsf@ca-mkp.ca.oracle.com>
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Date:   Tue, 27 Oct 2020 10:22:31 +0900
Message-ID: <CAEYrHjmJRmcKX+F8R_wjd146FXnSHekodauG_eNQBXArE4OBeA@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] scsi: hpsa: fix memory leak in hpsa_init_one
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Takafumi Kubota <takafumi@sslab.ics.keio.ac.jp>,
        Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Kevin Barnett <kevin.barnett@microsemi.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Scott Teel <scott.teel@microsemi.com>,
        esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thanks for the review.

> I suggest you submit a fix for just the leak. And then, if the hpsa
> maintainers agree, we can entertain a separate patch to improve the
> naming.

I'll revert the labels to numbered labels and resend the patch.

Thanks,
Keita

2020=E5=B9=B410=E6=9C=8827=E6=97=A5(=E7=81=AB) 6:49 Martin K. Petersen <mar=
tin.petersen@oracle.com>:
>
>
> Keita,
>
> > When hpsa_scsi_add_host fails, h->lastlogicals is leaked since it lacks
> > free in the error handler.
> >
> > Fix this by adding free when hpsa_scsi_add_host fails.
> >
> > This patch also renames the numbered labels to detailed names.
>
> While I am no fan of numbered labels, these initialization stages are
> referenced several other places in the driver. As a result, renaming the
> labels makes the rest of the code harder to follow.
>
> I suggest you submit a fix for just the leak. And then, if the hpsa
> maintainers agree, we can entertain a separate patch to improve the
> naming.
>
> Thank you!
>
> --
> Martin K. Petersen      Oracle Linux Engineering
