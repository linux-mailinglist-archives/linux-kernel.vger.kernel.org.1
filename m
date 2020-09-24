Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36562776C8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbgIXQbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:31:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgIXQbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:31:12 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 409262395C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 16:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600965071;
        bh=r0fXoMmW8h7GGpdSSFHKUZuN2PTtugZd7ZmhkM7BICE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OaTraEupyZ54lp+T+8e3JvWNMZXsQiBunsO0FSVdntf2jqBGe6EEmMGnXhBrO1CRx
         NUNNv4G3STsoa8dRsW/HbkH/67T8eho4pFlOUf9lx/04YDjbrHSYCtXVF33G7N1nPm
         ettThb0eJVqUQi80piD/75gmFYdNr4gBp7EFlG0I=
Received: by mail-ot1-f48.google.com with SMTP id y5so3749193otg.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 09:31:11 -0700 (PDT)
X-Gm-Message-State: AOAM530oaS94YhMh8Jmk61IMOkrqqkHslJYB4sAXq2ScSrXogNltN2vn
        WROByLIPEDON3Orifbi74etpWjZ9MmjqT+QJ+Q==
X-Google-Smtp-Source: ABdhPJzj1CbARNhNH5q6VXh2fdWD9g7kADI+PYIEHwYD4Dl0dHVcbfd6FBfOKcpKnNfg2+mUtzZkTCD8UDostGjeQJs=
X-Received: by 2002:a9d:6ada:: with SMTP id m26mr31760otq.192.1600965070486;
 Thu, 24 Sep 2020 09:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <1595606355-1329-1-git-send-email-richard.gong@linux.intel.com> <0d445238-fcf5-39f4-92b3-69346e681efa@linux.intel.com>
In-Reply-To: <0d445238-fcf5-39f4-92b3-69346e681efa@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 24 Sep 2020 10:30:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJomTPg6g_tfry3V2sT02+_kA_FcMXj6vygPKFwtnjP2g@mail.gmail.com>
Message-ID: <CAL_JsqJomTPg6g_tfry3V2sT02+_kA_FcMXj6vygPKFwtnjP2g@mail.gmail.com>
Subject: Re: [RESEND PATCHv1] MAINTAINERS: altera: change maintainer for
 Altera drivers
To:     Richard Gong <richard.gong@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Gong <richard.gong@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 9:26 AM Richard Gong
<richard.gong@linux.intel.com> wrote:
>
> Hi,
>
> Sorry for asking.
>
> This patch was submitted on July and is pending for approval. Would you
> mind reviewing that?

That's because get_maintainers.pl gave you crap for who to send it to
(now fixed, kind of) and this has nothing to do with DT, networking,
media, nor serial/char/USB. This should go to whomever would take the
driver changes (I2C, MFD, GPIO). Or you could ask Andrew Morton to
pick it up.

Rob

>
> Regards,
> Richard
>
> On 7/24/20 10:59 AM, richard.gong@linux.intel.com wrote:
> > From: Richard Gong <richard.gong@intel.com>
> >
> > Thor is moving to a new position and I will take over the maintainershi=
p.
> > Add myself as maintainer for 3 Altera drivers below:
> > 1. Altera I2C driver
> > 2. Altera System Manager driver
> > 3. Altera System Resource driver
> >
> > Signed-off-by: Richard Gong <richard.gong@intel.com>
> > Acked-by: Thor Thayer <thor.thayer@linux.intel.com>
> > ---
> >   MAINTAINERS | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b4a43a9..d87a307 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -750,7 +750,7 @@ R:        Pali Roh=C3=A1r <pali@kernel.org>
> >   F:  drivers/input/mouse/alps.*
> >
> >   ALTERA I2C CONTROLLER DRIVER
> > -M:   Thor Thayer <thor.thayer@linux.intel.com>
> > +M:   Richard Gong <richard.gong@linux.intel.com>
> >   S:  Maintained
> >   F:  Documentation/devicetree/bindings/i2c/i2c-altera.txt
> >   F:  drivers/i2c/busses/i2c-altera.c
> > @@ -767,13 +767,13 @@ S:      Maintained
> >   F:  drivers/gpio/gpio-altera.c
> >
> >   ALTERA SYSTEM MANAGER DRIVER
> > -M:   Thor Thayer <thor.thayer@linux.intel.com>
> > +M:   Richard Gong <richard.gong@linux.intel.com>
> >   S:  Maintained
> >   F:  drivers/mfd/altera-sysmgr.c
> >   F:  include/linux/mfd/altera-sysmgr.h
> >
> >   ALTERA SYSTEM RESOURCE DRIVER FOR ARRIA10 DEVKIT
> > -M:   Thor Thayer <thor.thayer@linux.intel.com>
> > +M:   Richard Gong <richard.gong@linux.intel.com>
> >   S:  Maintained
> >   F:  drivers/gpio/gpio-altera-a10sr.c
> >   F:  drivers/mfd/altera-a10sr.c
> >
