Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3178A2DCFD1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 11:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgLQKzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 05:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgLQKzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:55:09 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DCEC0617A7;
        Thu, 17 Dec 2020 02:54:29 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id j12so26800551ota.7;
        Thu, 17 Dec 2020 02:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NWfjpFuM/rpC5MZB9MgWKSHhG21ysvBu+fpBAMP/93Q=;
        b=HHwg+1MfgtzL6LHwT0LKkVNkzCg/A3jdFTdO4xTm+zc8FFiSDpUVr/kdZpgLuAsQkW
         8TONuogj5uYhYyDjPEBxdH4qZbEpgbbGKLCC9ixKG4+eb++2rl3me7Bm8XdcbA8jpoi1
         XtXZjgK2d+/IO2F0jmz42pv3saXhX8DqrN890wlPAfp7n9QmO7pymxNxfF7vle76K7Sg
         sKCXQiLoW6QcLXO4QG07g6izPZLoldJDLxqmKXk/n8Z9dHLCxX6VNI5fvaZwDfbDRlAb
         AMl7sW4T67fMAot2J4oTeFSlfsGZlHXOef9VIlebJMS1QlrXG3eALLTtbNozPG75zB9h
         Ad3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NWfjpFuM/rpC5MZB9MgWKSHhG21ysvBu+fpBAMP/93Q=;
        b=X1N8QAjKeG5tUPQ5LasC6GZmDcRJj9Ju7oYpbWa6cDjZeI2+MU8ISQT+Dj5sQ57Wdy
         75N6kCj/RwRRaCrWn8IE2ixFojWh5igscbXM4ckpFomS+l88kuYyvUPX2L6jPgQ7+4+u
         I9MJMcompilFlUhao5ntJpgihU/b2XskVfy5r5KsgPEljOsYdomfMHh0MhVqQv4xlxN8
         EMArovx0297UXqrhIP9rKU+rKbUaCtPNQ1xSqypF/fGzeF/Je+7xOEDGaPkXXjg8j83b
         7cPTxyraXk0PBauwjmqyHdsSTpeFlu2XcCs3F9EqFIiwPEYJxfsIVi0oJT0YWelaB2Ik
         e8wg==
X-Gm-Message-State: AOAM531bCLXahkFT7pVWk53BOO6I1bmcKy6zPtBbHsWisn3ZbSUspSRX
        +RyZTc9PjrYbWbnyZdeo/QIRQ0HHSP801IwZIeTIIfcxawieLQ==
X-Google-Smtp-Source: ABdhPJz1vU+kPJYxjV4y+WjTyL540dczG4+1+7EKJwlQ3BtFjGfUXUEbL1jvd+1cB3QxcsntexpHOM64NwS6r9dbbeg=
X-Received: by 2002:a05:6830:2144:: with SMTP id r4mr3298069otd.72.1608202468442;
 Thu, 17 Dec 2020 02:54:28 -0800 (PST)
MIME-Version: 1.0
References: <20201122095556.21597-1-sergio.paracuellos@gmail.com>
 <20201122095556.21597-3-sergio.paracuellos@gmail.com> <160819550615.1580929.14234996916739809712@swboyd.mtv.corp.google.com>
 <CAMhs-H_EiDot_V4Qj1Q8noAf5RNi9BOyy0WmawE+70wY7=FxDg@mail.gmail.com>
 <160819962346.1580929.2348154780751858972@swboyd.mtv.corp.google.com>
 <CAMhs-H_ixfqMxVFOf+J0O-Tp0Q0ngviMm6jHrHJSgCLwZj+Tvw@mail.gmail.com>
 <160820116913.1580929.15821601182796836787@swboyd.mtv.corp.google.com>
 <CAMhs-H9SiZ90NYCGL+3ad9UR7CDUiA1gb99ZcfHp10=SZtVPpg@mail.gmail.com> <160820221883.1580929.5758849422177353179@swboyd.mtv.corp.google.com>
In-Reply-To: <160820221883.1580929.5758849422177353179@swboyd.mtv.corp.google.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 17 Dec 2020 11:54:17 +0100
Message-ID: <CAMhs-H_Zu-yvbcajPYm=AfVo915dM6_3kBf9wpN4rt3LZ6LXpw@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] dt: bindings: add mt7621-clk device tree binding documentation
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        Weijie Gao <hackpascal@gmail.com>,
        COMMON CLK FRAMEWORK <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:MIPS <linux-mips@vger.kernel.org>, open list:STAGING
        SUBSYSTEM <devel@driverdev.osuosl.org>, NeilBrown <neil@brown.name>,
        open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 11:50 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Sergio Paracuellos (2020-12-17 02:38:37)
> > On Thu, Dec 17, 2020 at 11:32 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Sergio Paracuellos (2020-12-17 02:14:10)
> > > > node is to use architecture operations in
> > > > 'arch/mips/include/asm/mach-ralink/ralink_regs.h'
> > > > instead of getting a phandle using the regmap is being currently used...
> > >
> > > Can that be done with
> > >
> > > CLK_OF_DECLARE_DRIVER("mediatek,mt7621-sysc", my_timer_clk_init)
> > >
> > > ? Is the syscon used anywhere besides by the clk driver?
> >
> > Yes, for example all the gates use them to access SYSC_REG_CLKCFG1 in
> > all of their 'mt7621_gate_ops' and also in all 'recalc_rate' functions
> > where SYSC_REG_SYSTEM_CONFIG0, is readed.
>
> That sounds like it's only used by the clk provider/driver? Any other
> code uses the syscon?

The only child node for the syscon for this platform is the clock
driver now, I introduced it in this series, so no other driver is
using this syscon now. All of them use global arch operations in
'arch/mips/include/asm/mach-ralink/ralink_regs.h'.
