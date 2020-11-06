Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08EA2A8C6F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733038AbgKFCEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732610AbgKFCEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:04:45 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF6FC0613D3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 18:04:45 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id z3so2883695pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 18:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y7icUUEiNIrPUlaj0x+1jC39o2LcOwmDsvjuVu94new=;
        b=X/VcN7fDxkB6QNSvA1o2/JBoKO1kyCOga7PWJMgYprv0D+hCk05vwNG5tM4H+lbYDN
         Eldz8M/XVvrr/91fsElEf3XPA2itpiP2n3qLu5MBMZ2JDeuf8FY3lKvlseWBtpIRUxns
         VDIwHa7TvMx+KH8+pYQZdqw3LCb0juFqvS2VY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y7icUUEiNIrPUlaj0x+1jC39o2LcOwmDsvjuVu94new=;
        b=MtJBzrnFk9XMMKJYynJyvjNuajPeK578CZ3P2wQcWuiQ5gcGmgPO0aPdaitIrrqbdw
         IHEVIDyUq0hcpK0o+MO3ue2NoxNNvFco77ZpeldHD4FhUWm6damyGnhUB0aB+4oo9O5r
         PGyOXyZid96ptNJcMh2JPjBsOCCCKiD/H2pITb5xNSsaseHyxvv1f7fOC4+iRIPim+th
         E7fKoYW8xIQTfM14STqlq+V0JQ1PSOWJK35s8LrL6DezYYoCMsfJut54jwLlhBhe+XSu
         9gLX9UwxRCZB+GQRPKgHGyzxHNXuWCowlU2zAERC0VZVqDY0qi2iEThbkdghYJEtrmPg
         4X/g==
X-Gm-Message-State: AOAM5303sqnt6YVmNBVvMsdgFoJT3LEYITlaxeQbe+CqUpAu8Uz9Cel5
        EoB3nOMCpgFwCV/RGwkJGbYXQ0wqUL3NdQ==
X-Google-Smtp-Source: ABdhPJwtl5hZ0u87DJo55K2CGbET+7/W7Ihy/p7yM6/ZRxZrLq0X52Z9iBVMA1bZ22zg6DAS+hn3UA==
X-Received: by 2002:a17:90b:1413:: with SMTP id jo19mr5193301pjb.221.1604628285166;
        Thu, 05 Nov 2020 18:04:45 -0800 (PST)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id m10sm502259pjr.3.2020.11.05.18.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 18:04:44 -0800 (PST)
Date:   Thu, 5 Nov 2020 18:04:43 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: sc7180: Add sc7180-lazor-r2
Message-ID: <20201106020443.GA4128558@google.com>
References: <20201105163724.v2.1.I5a75056d573808f40fed22ab7d28ea6be5819f84@changeid>
 <CAD=FV=WVVjj1Su2Ta9wQebDEWXs=9dNs9EO9EvTH=EjT4Fr8jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=WVVjj1Su2Ta9wQebDEWXs=9dNs9EO9EvTH=EjT4Fr8jg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 04:55:40PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Thu, Nov 5, 2020 at 4:37 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > One important delta with respect to rev1 is a switch of the power
> > supply for the onboard USB hub from 'pp3300_l7c' to 'pp3300_a' + a
> > load switch. The actual regulator switch is done by the patch 'arm64:
> > dts: qcom: sc7180-trogdor: Make pp3300_a the default supply for
> > pp3300_hub', since it affects the entire trogdor platform. Here we
> > only add the .dts files for lazor rev2 and replace the generic
> > compatible entries in the rev1 .dts files.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >
> > Changes in v2:
> > - patch added to the series
> >
> >  arch/arm64/boot/dts/qcom/Makefile              |  3 +++
> >  .../dts/qcom/sc7180-trogdor-lazor-r1-kb.dts    |  4 ++--
> >  .../dts/qcom/sc7180-trogdor-lazor-r1-lte.dts   |  4 ++--
> >  .../boot/dts/qcom/sc7180-trogdor-lazor-r1.dts  |  4 ++--
> >  .../dts/qcom/sc7180-trogdor-lazor-r2-kb.dts    | 17 +++++++++++++++++
> >  .../dts/qcom/sc7180-trogdor-lazor-r2-lte.dts   | 18 ++++++++++++++++++
> >  .../boot/dts/qcom/sc7180-trogdor-lazor-r2.dts  | 15 +++++++++++++++
> >  7 files changed, 59 insertions(+), 6 deletions(-)
> 
> So it's pretty unlikely that this change actually happened in "-rev2".
> "-rev2" was a _very_ small batch of boards that I don't think made it
> into too many people's hands.  You probably want "-rev3".

Ah right, now that you mention it ...

> > diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r2-kb.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r2-kb.dts
> > new file mode 100644
> > index 000000000000..7c3a702ef209
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r2-kb.dts
> > @@ -0,0 +1,17 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Google Lazor board device tree source
> > + *
> > + * Copyright 2020 Google LLC.
> > + */
> > +
> > +#include "sc7180-trogdor-lazor-r1.dts"
> 
> Should have been updated to not point to '-r1', no?

ack

> ===
> 
> If you want to compare, you can also look at my (abandoned) CL:
> https://crrev.com/c/2481550
> 
> ...that forked out a "-rev3" to tag the WiFi slightly differently, but
> we ended up abandoning it because we found a better way to handle the
> WiFi stuff.

Ok, thanks
