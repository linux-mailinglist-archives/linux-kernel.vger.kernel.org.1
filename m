Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD63B2AC38A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbgKISSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729426AbgKISSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:18:45 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B45C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:18:45 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id s25so13664169ejy.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FiNrwUISwF83ew9A0Wb1PQjOzvs7NmR058vtWFkrXSA=;
        b=XCKiiSxj265kGAovEwvBErEpKXrR6NnlpN/l4thHKYBPZIZKDcg4dHWM8nIft7kpHB
         NBpYPeBcfAU2oahKXuFBy01lLXh/2DNgCKS6996KJt5gbAd7N2jAYSO11FCvpw9fWPyS
         Qip37jpS+ODYXRdYrj2F6WBpennsHxDNnDaIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FiNrwUISwF83ew9A0Wb1PQjOzvs7NmR058vtWFkrXSA=;
        b=AHn+8I7QpNNln2aYODh2ONAKSf1dAbBq1bBGp69OtrBCFbwekHhK7wegL23OLKmS2b
         KZv4eZvYBnVsSFfe6GkaRkW8utIa//aiLRSDhVhu3v3953E4pBbOOg95g03ejtDlyqrw
         K8W3L2ynIjGs4Y8YYYf6uwSdOibK3zI1f4fcJSn/h6ijqObLT7HjW4mxKhuPzy+O4eu5
         VNdAo6JE60o0nTMvExS4yq0n3R9GEC+IxKGXy65uDnQi9dUKFO4I6AKwCiIrENVkDZKd
         xNUClWKZYH647P0THIdVdSi1kS2HIAXZLQyTiIxQ/a0Z3n021o/hU9AQfU3pGu8lY+0x
         MIBQ==
X-Gm-Message-State: AOAM532N+Pd7TRODGMu/aQ3tom5ydUobbNtfg8pzVVoDwwzHjfKZQUlo
        EoLhSDLWxgJ/0LOlQm+7j/q3qFIoCuSTIMzztV+5Sw==
X-Google-Smtp-Source: ABdhPJwIZbj832ZQWCgre/0E9MllmcikcplewmTeRE+FTjaDLQ9UlEBsbnle0ZDh8exswvBRFOgXVH1TjGRq+nNjHnA=
X-Received: by 2002:a17:906:5e02:: with SMTP id n2mr15222726eju.295.1604945923889;
 Mon, 09 Nov 2020 10:18:43 -0800 (PST)
MIME-Version: 1.0
References: <20200929083217.25406-1-jagan@amarulasolutions.com> <2320954.tcIoyGMtcG@phil>
In-Reply-To: <2320954.tcIoyGMtcG@phil>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 9 Nov 2020 23:48:32 +0530
Message-ID: <CAMty3ZBtQ2f2poAmQCZrws5TZOGX8sn8v-DSpEohi+4=rTYwsw@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] arm64: dts: rockchip: Add Engicam PX30.Core
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 4:45 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi,
>
> Am Dienstag, 29. September 2020, 10:32:10 CET schrieb Jagan Teki:
> > PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.
> >
> > PX30.Core needs to mount on top of Engicam baseboards for creating
> > complete platform boards.
> >
> > Possible baseboards are,
> > - EDIMM2.2 Starter Kit
> > - C.TOUCH 2.0 Carrier Board
> >
> > Changes for v4:
> > - collect Rob A-b
> > Changes for v3:
> > - resolved Johan comments about sorting node properties
> > - add copyright to Amarula Solutions
> > - update px30 dtsi author
> > Changes for v2:
> > - include C.TOUCH 2.0 carrier board
> > - skip 10" OF LCD as it requires separate dts with panel support.
> >
> > Note: These baseboards can be used for i.MX8 SOM's as well. So having
> > baseboard on respective SoC seems to be easy rather than making it
> > common across all.
> >
> > Any inputs?
> > Jagan.
> >
> > Jagan Teki (6):
> >   dt-bindings: arm: rockchip: Add Engicam PX30.Core EDIMM2.2 Starter Kit
> >   arm64: dts: rockchip: px30: Add Engicam EDIMM2.2 Starter Kit
> >   arm64: dts: rockchip: Add Engicam PX30.Core EDIMM2.2 Starter Kit
> >   dt-bindings: arm: rockchip: Add Engicam PX30.Core C.TOUCH 2.0
> >   arm64: dts: rockchip: px30: Add Engicam C.TOUCH 2.0
> >   arm64: dts: rockchip: Add Engicam PX30.Core C.TOUCH 2.0
> >
> > Michael Trimarchi (1):
> >   arm64: dts: rockchip: Add Engicam PX30.Core SOM
>
> I've applied the patches for 5.11 with some changes:
> (1) engicam,px30-px30-core became engicam,px30-core
> (2) px30-px30-core.dtsi became px30-engicam-px30-core.dtsi
>
> That double px30 is unnecessary and confusing in compatibles
> and the px30-core thingy needed something less generic, as that is
> not px30-specific but specific to the engicam boards.

Agreed with the updates and thanks for picking up.

Other than these few patches around the mailing list,  let me know
your comments, thanks!

https://patchwork.kernel.org/project/linux-arm-kernel/patch/20200731160324.142097-1-jagan@amarulasolutions.com/
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20201023181814.220974-1-jagan@amarulasolutions.com/

Jagan.
