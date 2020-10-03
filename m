Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1DB2820C2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 05:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgJCDWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 23:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgJCDWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 23:22:44 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2786C206FA
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 03:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601695363;
        bh=vshNU8D+9cfgnyb4qi/vgpJ80rl6DobvFOc+lNmiq4A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hFlAjzq6mVuQfPmTTpOyDSjt2poAiniCQC7B4VG6VvKy/a9HVw1KOanp3JnlMwGcz
         OsYAzWC62+LsskUIxEsw5P2ZhQLt09I23uMxY35DuZEk8tPOtZ0iY7dUwa69pddMV+
         SVeJ1Gt2OgHRnTkYSAr6RLFodXInMeh/iwBwen+A=
Received: by mail-ej1-f49.google.com with SMTP id p15so4412570ejm.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 20:22:43 -0700 (PDT)
X-Gm-Message-State: AOAM533hauHQur/PvEDI4Ogh2fk79sKfsR3tBLOfqF2FpOZExdZRGYOq
        NLbwETTPTY7CP6DlPSaeqL4KJxnnMXcjzD0lOA==
X-Google-Smtp-Source: ABdhPJwfK6hFOAL1k6cStLol7QwYclHeuIdUmnRprFtlrITDDNE5+T91NUK9YTbudQEGp0c8nEIdFwMRV6jYoHi1EXo=
X-Received: by 2002:a17:906:158f:: with SMTP id k15mr180684ejd.310.1601695361687;
 Fri, 02 Oct 2020 20:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200927230422.11610-1-chunkuang.hu@kernel.org> <CABb+yY1zq0+sqXuSzkkX9+dTaTZgg5HJyQLC3N-yZx35QLLvDQ@mail.gmail.com>
In-Reply-To: <CABb+yY1zq0+sqXuSzkkX9+dTaTZgg5HJyQLC3N-yZx35QLLvDQ@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 3 Oct 2020 11:22:30 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9bgYK2MDySstc4F2jN0M+Zpmcq2R3G_PdWz2sgt9wp7A@mail.gmail.com>
Message-ID: <CAAOTY_9bgYK2MDySstc4F2jN0M+Zpmcq2R3G_PdWz2sgt9wp7A@mail.gmail.com>
Subject: Re: [PATCH 0/4] Mediatek DRM driver detect CMDQ execution timeout by
 vblank IRQ
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jassi:

Jassi Brar <jassisinghbrar@gmail.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=883=
=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=884:30=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Sun, Sep 27, 2020 at 6:04 PM Chun-Kuang Hu <chunkuang.hu@kernel.org> w=
rote:
> >
> > CMDQ helper provide timer to detect execution timeout, but DRM driver
> > could have a better way to detect execution timeout by vblank IRQ.
> > For DRM, CMDQ command should execute in vblank, so if it fail to
> > execute in next 2 vblank, timeout happen. Even though we could
> > calculate time between 2 vblank and use timer to delect, this would
> > make things more complicated.
> >
> > This introduce a series refinement for CMDQ mailbox controller and CMDQ
> > helper. Remove timer handler in helper function because different
> > client have different way to detect timeout. Use standard mailbox
> > callback instead of proprietary one to get the necessary data
> > in callback function. Remove struct cmdq_client to access client
> > instance data by struct mbox_client.
> >
> > Chun-Kuang Hu (4):
> >   soc / drm: mediatek: cmdq: Remove timeout handler in helper function
> >   mailbox / soc / drm: mediatek: Use mailbox rx_callback instead of
> >     cmdq_task_cb
> >   mailbox / soc / drm: mediatek: Remove struct cmdq_client
> >   drm/mediatek: Detect CMDQ execution timeout
> >
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c  |  54 ++++++---
> >  drivers/mailbox/mtk-cmdq-mailbox.c       |  24 ++--
> >  drivers/soc/mediatek/mtk-cmdq-helper.c   | 146 ++---------------------
> >  include/linux/mailbox/mtk-cmdq-mailbox.h |  25 +---
> >  include/linux/soc/mediatek/mtk-cmdq.h    |  54 +--------
> >  5 files changed, 66 insertions(+), 237 deletions(-)
> >
> Please break this into two patchsets - one for mailbox and one for its us=
ers.
> Also, CC original author and recent major contributors to mtk-cmdq-mailbo=
x.c
>

Agree with you. But for patch [2/4] ("Use mailbox rx_callback instead
of cmdq_task_cb"), I think it would be a long term process.
I would break it into:

1. mtk-cmdq-mailbox.c: add rx_callback and keep  cmdq_task_cb because
client is using cmdq_task_cb.
2. client: change from cmdq_task_cb to rx_callback.
3. mtk-cmdq-mailbox.c: remove cmdq_task_cb.

The three step has dependency, but the 2nd should move to another
series, so I would go 1st step first.

Regards,
Chun-Kuang.

> Thanks.
