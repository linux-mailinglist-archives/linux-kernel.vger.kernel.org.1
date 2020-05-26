Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E02C1E0F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 15:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390755AbgEYNEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 09:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390747AbgEYNED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 09:04:03 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EB5C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 06:04:03 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id k5so20639866lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 06:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qbKlh9rvr/ToxEMzUAmGtxv+hAZbxzL0uknOsgFGASk=;
        b=Aau+5lIM+AAKCnFmFHUwdB2fv88scc7+W1ocRo4djN5kn3UtOI9CaWpntIC4SIhSvO
         nbtEPvrzVgr8JhykJWbfZQI9hYmyzl5rY3zYQo8yxf5aqx7+0+B4XcTA3UHq32QEJR3M
         bY1nbC+YgbUoM624DQJ6nPudjKipLU5yDLoFsH+bZmAfrzDuJLPhcpO368a8wwNWdGlN
         Viys9iWK5f0YOtkmcBTIqXxRisLghvb6jwdu+HPh3f0BUyJSgxmYz3Th+4VrncZ2SQoR
         5jARHOVzaQIIZQX8Y9ea8DeTwsX95QwZihQlcRBHE2IkGCohhYDRZrxRcYUcJM20QB8+
         EqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qbKlh9rvr/ToxEMzUAmGtxv+hAZbxzL0uknOsgFGASk=;
        b=lALTZRntCCeQPluGtNLoFKY3JmMVPvPq1hw780AjR18QkO3AYMGUw+ibEOP7J2uoN4
         sy1TWfiFlynlhShFEOT+3wUBHIJQSxQm3YJ9+mL7I+S/kyU5/KP+krNWc9ZOPs+8FAil
         RLXCFIIhKkPbP7sYvq0MP7MebJo0zDfW5Zm9QWVjUen7Xb7OCm6SxyZhH/KtZ31FbiiT
         QUIRWwMx29hn/QodwbpqFx1+ySD4GPJMPex7ufIbp/hmpkHkXq3Qj+iS9gHAOrxmPlkv
         x89v8ZTXH7VCLzw9CRVfYV6TRYsRBbOc1ZYMzyRqRn6/BBVwsKp2Kro55kvuIquNmg78
         y1Vw==
X-Gm-Message-State: AOAM531CC6fabp/4nXqsHaub7pwRHh80ebRrWHiQ7B0LJpLfyL5VDYGv
        dbNEKcfVH4rH7QxAOUVHtdsxsNgUYlxAzzqyyZR6mw==
X-Google-Smtp-Source: ABdhPJxaHb2+gGS6W87P/n0XsJZ033bv/Oc6w4sdtxU1dzhwlkkN3Kp7Vteg43GSp/rNBOXzokfNg43+fcFtvQ0PwGk=
X-Received: by 2002:a2e:8e91:: with SMTP id z17mr10887714ljk.144.1590411841474;
 Mon, 25 May 2020 06:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200508165821.GA14555@x1> <CACRpkdb+ZP6rfjGg6Ef9_wYvNf6qmSc7LZyYBVKA3XWCtxPfqQ@mail.gmail.com>
 <20200518141843.GA916914@x1> <20200520220203.GA363398@x1> <CACRpkdYV4Pd2rL=Kha6HxL8J5+vFy_M0hV7+qMghS4AVxd9D2w@mail.gmail.com>
 <20200525120710.GA898135@x1>
In-Reply-To: <20200525120710.GA898135@x1>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 15:03:50 +0200
Message-ID: <CACRpkdZLRjcE0FGwVR-Q7a50aEmpB=xO4q6H8_EaV199fGr0OA@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: am33xx-bone-common: add gpio-line-names
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 2:07 PM Drew Fustini <drew@beagleboard.org> wrote:
> On Mon, May 25, 2020 at 11:23:17AM +0200, Linus Walleij wrote:
> > On Thu, May 21, 2020 at 12:02 AM Drew Fustini <drew@beagleboard.org> wrote:
> >
> > > I've posted a v2 which I hope improves the intent of the line names. [0]
> > >
> > > I'm happy to integrate any feedback and create a v3 - especially if it
> > > is prefered for me to list the specific peripherial signals instead of
> > > an abstract term like "[ethernet]" or "[emmc]".  This is for lines that
> > > can not be used because they are not routed to the expansion headers.
> > >
> > > [0] https://lore.kernel.org/linux-omap/20200520214757.GA362547@x1/T/#u
> >
> > This looks good to me. FWIW
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Yours,
> > Linus Walleij
>
> Linus -
>
> I have posted a newer patch that targets am335x-beagleblack.dts [0]
> instead of am335x-bone-common.dtsi as Grygorii Strashko pointed out
> that these line names are not applicable to all BeagleBone models.
>
> The gpio line naming scheme is the same, is it ok to add your Ack?

Yes FWIW
Acked-by.

Linus Walleij
