Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3307D287645
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbgJHOke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729770AbgJHOkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:40:33 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA938C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 07:40:33 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k6so6428755ior.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 07:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OrarTPaiL7rQzQ6WaV9Vzo7o6PowYGEC+IvlSkhfyxw=;
        b=O9lHoaLrMAK3vOFNIsTiAx6cZ90MKULCkFhsAnj2eqrPqmFz4WJty/1Xkx9zNqIb1i
         NWcc+FHknFMRr2cOBpQOIiMeJm+AOVRv7zmN63BhpmJFxqksfdN62IVLnX2xzhOVPj1A
         GZ1bEFwovvV+DgsINyrATjQ2aSUgx2N4KNh+7AX9Kp9/eSplQeB1pDMrkXJ/Qna/CIaE
         k5/lgSQoMpBk3OSltWIMa6k3een1c6EVUg/WfSYHbjEzEBZYiEXsZ8NU37FoDcDsmfae
         F1YQ+qoiN5XYv+SAyLhfT5TvJ80eCQuiVTxXNqwMXBtOCEZW5yOyxT27Qr8kt12GJUpT
         tMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OrarTPaiL7rQzQ6WaV9Vzo7o6PowYGEC+IvlSkhfyxw=;
        b=dbkM85DpO3p+sUSQDWydB9fkJ0Ez5fUDyZMRQWXrIDWEuFg0KNQYA8PxoWqbFzPecn
         x6PjI/OU3ARuVrIV7BsWdvpOnH1jDpARS2Pxl6WFef9JI5+gwZ8oKllodX2K4OjIt/yE
         YRYGd70jJ6m7OuW2FryC+I358CPhHwof3L+ErUqED7qdVoBzd9/cjer1jHkUES4aiftA
         MxEQNSaotr8Nv07sCYDlM6B6tbEvdhkKLDpkHQX+68jsqsKJ96XIPy7XopeMWOTA8Aqj
         t3l26RJ8g7Ic8cBDgQZIYBKegIvXn1zO4J4yXxDeGZc8tSHccedoeDoXn+5Grwq0VErI
         vd0g==
X-Gm-Message-State: AOAM5327I1m0q/Qpw4FdIDDGDaKGC5mwuhzKdmv14AYhKDqAo0++HB9k
        QPXxK+UB/XDyoueXvuGYDCDjsitlA2Nr++rTQYcniQ==
X-Google-Smtp-Source: ABdhPJxNOOckiO18DkXVMnX9YaryLbjZZ/gNbT8isUPNLeELzwXey5GFv8x/+B1pxgGdacdCVveNP4BEwkpzAaLulqY=
X-Received: by 2002:a5d:80cc:: with SMTP id h12mr965908ior.73.1602168033069;
 Thu, 08 Oct 2020 07:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200927064131.24101-1-peng.fan@nxp.com> <DB6PR0402MB2760EA531095AADAA1B967D9880B0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB2760EA531095AADAA1B967D9880B0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 8 Oct 2020 08:40:22 -0600
Message-ID: <CANLsYkxXZdFdLYRY6kEj4Fa_LsR4TVfCxqtX=2_N7OEsgjgEXg@mail.gmail.com>
Subject: Re: [PATCH V2 0/7] remoteproc: imx_rproc: support iMX8MQ/M
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Oct 2020 at 18:52, Peng Fan <peng.fan@nxp.com> wrote:
>
> Mathieu, Oleksij
>
> > Subject: [PATCH V2 0/7] remoteproc: imx_rproc: support iMX8MQ/M
>
> Do you have time to give a look at this patchset?

I will review your patchset after you have reviewed mine[1].

[1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=339079

>
> Thanks,
> Peng.
>
> >
> > V2:
> >  Rebased on linux-next
> >  Dropped early boot feature to make patchset simple.
> >  Drop rsc-da
> >
> > V1:
> >  https://patchwork.kernel.org/cover/11682461/
> >
> > This patchset is to support i.MX8MQ/M coproc.
> > The early boot feature was dropped to make the patchset small in V2.
> >
> > Since i.MX specific TCM memory requirement, add elf platform hook.
> > Several patches have got reviewed by Oleksij and Mathieu in v1.
> >
> > Peng Fan (7):
> >   remoteproc: elf: support platform specific memory hook
> >   remoteproc: imx_rproc: add elf memory hooks
> >   remoteproc: imx_rproc: correct err message
> >   remoteproc: imx_rproc: use devm_ioremap
> >   remoteproc: imx_rproc: add i.MX specific parse fw hook
> >   remoteproc: imx_rproc: support i.MX8MQ/M
> >   remoteproc: imx_proc: enable virtio/mailbox
> >
> >  drivers/remoteproc/imx_rproc.c             | 273
> > ++++++++++++++++++++-
> >  drivers/remoteproc/remoteproc_elf_loader.c |  20 +-
> >  include/linux/remoteproc.h                 |   2 +
> >  3 files changed, 287 insertions(+), 8 deletions(-)
> >
> > --
> > 2.28.0
>
