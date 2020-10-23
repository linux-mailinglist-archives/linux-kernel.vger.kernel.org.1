Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A4B29704C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 15:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373083AbgJWNVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 09:21:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S372480AbgJWNVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 09:21:34 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE6D520878;
        Fri, 23 Oct 2020 13:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603459293;
        bh=tcIf+YLtp09S6ktv2lmr+RmiL/UpMdZ1xUk88JleAx4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V7YP8pcGUA997rXsYpwdd2ACAVF9hRXJJWKeBUjnAfzK7u6alSW8fET5E7J7zgwWR
         EEAEjv4CtK8m6Y/sFVTX9pK5jpP0i3Ooo7/D48Y2W0CcCoj4QuuG3z8hSyDpHEkH/s
         P4F6KIFWfFMnK0l2ZgMy8HndS02MQKbJMeZRAPkc=
Received: by mail-oi1-f175.google.com with SMTP id l4so1794237oii.13;
        Fri, 23 Oct 2020 06:21:33 -0700 (PDT)
X-Gm-Message-State: AOAM532mhopd9331kv57uRIZhzSC6Vt2/FUsOGYIqCHxG43JM0xdff5c
        h+Ij1zfZdeX1leL0L9wakeQBHdCxS5koQfTUQg==
X-Google-Smtp-Source: ABdhPJxvPfyz6rm5n/WXwNeFZtY47gjlfmj9ctFWS6FN1er0aQ5AFtUPdDWxy3CB/VaS1ZHKpcDLnBRCQJ+QjvkFc0Q=
X-Received: by 2002:aca:5dc2:: with SMTP id r185mr1712876oib.106.1603459292939;
 Fri, 23 Oct 2020 06:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201020203710.10100-1-sudeep.holla@arm.com> <CAL_JsqKH9pN7E7o+UY7YmOrOKCUigrMTxY3f3AH4PdpQUAaawg@mail.gmail.com>
 <20201021163021.lkqhum3xnyzt6pir@bogus>
In-Reply-To: <20201021163021.lkqhum3xnyzt6pir@bogus>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 23 Oct 2020 08:21:21 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJFu-kn8uY9Jv0B-i2uNkx9wXg86N-aVTTH+zYz2MrxDA@mail.gmail.com>
Message-ID: <CAL_JsqJFu-kn8uY9Jv0B-i2uNkx9wXg86N-aVTTH+zYz2MrxDA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm,scmi: Do not use clocks for SCMI
 performance domains
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 11:30 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Oct 21, 2020 at 11:20:27AM -0500, Rob Herring wrote:
> > On Tue, Oct 20, 2020 at 3:37 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > Commit dd461cd9183f ("opp: Allow dev_pm_opp_get_opp_table() to return
> > > -EPROBE_DEFER") handles -EPROBE_DEFER for the clock/interconnects within
> > > _allocate_opp_table() which is called from dev_pm_opp_add and it
> > > now propagates the error back to the caller.
> > >
> > > SCMI performance domain re-used clock bindings to keep it simple. However
> > > with the above mentioned change, if clock property is present in a device
> > > node, opps can't be added until clk_get succeeds. So in order to fix the
> > > issue, we can register dummy clocks which is completely ugly.
> > >
> > > Since there are no upstream users for the SCMI performance domain clock
> > > bindings, let us introduce separate performance domain bindings for the
> > > same.
> > >
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >  .../devicetree/bindings/arm/arm,scmi.txt      | 19 ++++++++++++++++---
> > >  1 file changed, 16 insertions(+), 3 deletions(-)
> > >
> > > Hi Rob/Viresh,
> > >
> > > This is actually a fix for the regression I reported here[1].
> > > I am not adding fixes tag as I am targeting in the same release and
> > > also because it is not directly related.
> > >
> > > Regards,
> > > Sudeep
> > >
> > > [1] https://lore.kernel.org/r/20201015180555.gacdzkofpibkdn2e@bogus
> > >
> > > P.S.:/me records that this binding needs to be moved to yaml in v5.11
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > > index 55deb68230eb..0a6c1b495403 100644
> > > --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > > +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > > @@ -44,7 +44,7 @@ as described in the following sections. If the platform supports dedicated
> > >  mboxes, mbox-names and shmem shall be present in the sub-node corresponding
> > >  to that protocol.
> > >
> > > -Clock/Performance bindings for the clocks/OPPs based on SCMI Message Protocol
> > > +Clock bindings for the clocks based on SCMI Message Protocol
> > >  ------------------------------------------------------------
> > >
> > >  This binding uses the common clock binding[1].
> > > @@ -52,6 +52,19 @@ This binding uses the common clock binding[1].
> > >  Required properties:
> > >  - #clock-cells : Should be 1. Contains the Clock ID value used by SCMI commands.
> > >
> > > +Performance bindings for the OPPs based on SCMI Message Protocol
> > > +------------------------------------------------------------
> > > +
> > > +Required properties:
> > > +- #perf-domain-cells: Should be 1. Contains the performance domain ID value
> > > +                     used by SCMI commands.
> >
> > When is this not 1 (IOW, you only need this if variable)? How would it
> > be used outside SCMI (given it has a generic name)?
> >
>
> Ah, I thought we need this if phandle is followed by 1 or more arguments.
> If it is not compulsory I can drop this or make it scmi specific if we
> need it.

No, your options are fixed or variable number of cells. If this is
generic, then maybe it needs to be variable. If it's SCMI specific
then it can likely be fixed unless you can think of other information
you may need in the cells.

> > > +
> > > +* Property arm,scmi-perf-domain
> >
> > Yet this doesn't have a generic name. You mentioned on IRC this is
> > aligned with QCom, but why can't QCom use the same property here?
> >
>
> This is SCMI firmware driven while they have hardware driven perf/freq
> domains. So different drivers, need to distinguish between the two.

So what if they are different drivers. That's *always* the case. The
clock provider(s) for 'clocks' is different for every SoC? I doesn't
matter who is the provider, it's the same information being described.

Rob
