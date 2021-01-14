Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585082F6627
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 17:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbhANQly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 11:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbhANQlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:41:53 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367EBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:41:13 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id w24so100507ybi.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D+BmvCFWRLkA7Rq+8+HAffylejgMTO0t+Xl+DVgoXxA=;
        b=SuvR1Xho7USYBOUKOMwurqVjLwKuMIaUDHpECDeE7kkjOAAbEr8VbtJ90iTnt5fM/5
         X8P6lvkesGPjFdWNPstWUpRkiNcqXNFz4JbSVFlTnJz/A9JHLYLgaZw3mpV81Yrl6L9Y
         +frW1Zt19QP0uhpPthKlLqefHvP2MZd5lMJI8T8T9R7gxf3C5xpaL96Ii+MNISpX9BLe
         XoZrm8Rv3BeNOHHmzam7W/pi9IteR0Wi5oOIXtcBH5u+Udy+0jQmtZduddyWef3VIX+S
         o0v+WVgwawULGlJNr+Vp4L9BqpGkVFQbVvKZueA9p8nIhcQ/qS7piHOe7/OCH9Y7r3wS
         v86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D+BmvCFWRLkA7Rq+8+HAffylejgMTO0t+Xl+DVgoXxA=;
        b=mP2rLinSXlICyj4pleERU0SUuhx+HXIB6I4lqMafwNAZ/D3+D5+gdzcMMDINOtiKek
         egGpmc25I4gNpaUbFONnIYL3E8I3eUL2HTHi+jaFtWffuN0QYBjdAPOBNUAMryYfDPyk
         uidlwKLyYqNmCjCiMufp/hF4JtUAHui7b9K1ilq6bIt2yGof+SxX7sUEbMZWJl1hCUu5
         +SbZcBX4rXcdTVQLMAeL2fzguV1tj4URZMisbHRiNFxKlAoeWKl2VR6YxR2yqnNlUXmf
         CCgoldhaRkzMs8nqV401/Xiks5DRPJRbBTP6CJ9JTiy4o2MVBtJThozKTJdAyWBlmAWC
         NnyQ==
X-Gm-Message-State: AOAM532i65SFcRKi++dQeMuAWJkh/mgSDqDTvVrUtz2mwv/D612lzOol
        SVkj5XyXj6mCk+27YveCsZVRGKdjlc5sKUt9YM/PYw==
X-Google-Smtp-Source: ABdhPJzcBka6FCI4W4FK+68t+EIujVLMBcaCKK0eaAK11y+/dlf6iD+d3K5NXDM/fGfqkfMGtSHjX/5c2PiEhkZDM4U=
X-Received: by 2002:a25:6604:: with SMTP id a4mr12224326ybc.412.1610642472224;
 Thu, 14 Jan 2021 08:41:12 -0800 (PST)
MIME-Version: 1.0
References: <20201218031703.3053753-1-saravanak@google.com>
 <X/dpkgTnUk+inKHK@kroah.com> <e28e1f38d87c12a3c714a6573beba6e1@kernel.org>
 <ba2fcbfb-d714-2f73-3bd0-962f49363b62@nvidia.com> <CAGETcx8pdPnH1ndOCoi7Qyz8DDshCfMTzDLQM=oEaCjyds9reA@mail.gmail.com>
 <17703ac8-2238-0b64-3c98-ddadc7ae8a36@nvidia.com>
In-Reply-To: <17703ac8-2238-0b64-3c98-ddadc7ae8a36@nvidia.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 14 Jan 2021 08:40:35 -0800
Message-ID: <CAGETcx-=y4Ps41Lb0b_MTCbNTC_ah0cJTmPP+GajywFBc7kEfw@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Enable fw_devlink=on by default
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 3:35 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 13/01/2021 21:29, Saravana Kannan wrote:
>
> ...
>
> >> I am seeing the same problem on Tegra30 Cardhu A04 where several regulators
> >> are continuously deferred and prevents the board from booting ...
> >>
> >> [    2.518334] platform panel: probe deferral - supplier regulator@11 not ready
> >>
> >> [    2.525503] platform regulator@1: probe deferral - supplier 4-002d not ready
> >>
> >> [    2.533141] platform regulator@3: probe deferral - supplier regulator@101 not ready
> >>
> >> [    2.540856] platform regulator@5: probe deferral - supplier regulator@101 not ready
> >>
> >> [    2.548589] platform regulator@6: probe deferral - supplier regulator@101 not ready
> >>
> >> [    2.556316] platform regulator@7: probe deferral - supplier regulator@101 not ready
> >>
> >> [    2.564041] platform regulator@8: probe deferral - supplier regulator@101 not ready
> >>
> >> [    2.571743] platform regulator@9: probe deferral - supplier regulator@101 not ready
> >>
> >> [    2.579463] platform regulator@10: probe deferral - supplier regulator@101 not ready
> >>
> >> [    2.587273] platform regulator@11: probe deferral - supplier regulator@101 not ready
> >>
> >> [    2.595088] platform regulator@12: probe deferral - supplier regulator@104 not ready
> >>
> >> [    2.603837] platform regulator@102: probe deferral - supplier regulator@104 not ready
> >>
> >> [    2.611726] platform regulator@103: probe deferral - supplier regulator@104 not ready
> >>
> >> [    2.620137] platform 3000.pcie: probe deferral - supplier regulator@5 not ready
> >
> > Looks like this is not the whole log? Do you see any "wait for
> > supplier" logs? That's what all these boot issues should boil down to.
> > And as usual, pointer to DT for this board please.
>
> Ah yes I see ...
>
>  platform regulator@1: probe deferral - wait for supplier tps65911@2d

Do you mind sharing the full log please? It's hard to tell you
anything useful with bits and pieces of logs.

> Yes the device-tree for this board can be found here [0]. Looks like
> there is a circular dependency between the vddctrl_reg and vddcore_reg.
> This is part of coupled regulators which have a two-way linkage [1]. So
> this change appears to conflict with this.

fw_devlink doesn't track "regulator-coupled-with". So that's probably
not it. Also, this patch series was made to handle simple cycles
properly. It'll functionally disable the device links it created when
it comes to probe ordering. Only two overlapping cycles might cause
issues -- and even that, not all the time. So yeah, full log please.

-Saravana

> Jon
>
> [0]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/tegra30-cardhu-a04.dts
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/regulator/regulator.yaml#n129
>
> --
> nvpublic
