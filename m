Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6966E2F0851
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 17:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbhAJQNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 11:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbhAJQNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 11:13:25 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE860C061786;
        Sun, 10 Jan 2021 08:12:44 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id p22so16218516edu.11;
        Sun, 10 Jan 2021 08:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pkhzx66anNUURuXnoFRsV190plIqgcKOBoJUhFMocmU=;
        b=K+2hL02iuYOFg8kd0ZklVzbG/O4T9mljkKBUB1YX2jlvfzJ4uQD6Az6MyyUjAmdQJC
         Z//XO6w/rr0pDXzx/ThnqeNmaUsx7HKZ1azaVYOHoYXCNMHAwp7uPdEr91mGa+awx6ha
         yBjewBAJuEttZfef5AO1tkY9NyFE1jq54DjDWu+c7haeoH4CPutgBNR7mpO9GkLXTiJs
         K9HH+qxZuT8AvRpq14x2Q/FgYRWwKPRu6WQcOIl2Z3Sd37QguE1wTMSkHGlJyyFw7W+y
         egvNWe7FYngTuFauHvcUZWkQNsNJuHuwck4P8GI/IE9+KpO09MdExL+nMI+kHsxIR2+J
         tA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pkhzx66anNUURuXnoFRsV190plIqgcKOBoJUhFMocmU=;
        b=VABtbRKkcYIUipIgIzG8ZLGBOJnj8+TSKfWYZSUKXrAdlZf4DTM3sSVRfxbb+/GbbE
         6xkSX6wAk8L4ChWf2W/Enr8zQLyqo2Ng/IZmch0egUI553tkSDb+G5l87w7JG26ItSyl
         CAstLs6847NLmXLHWpPXQlX3jUddif+3RimPzz+fEOiNTq/KXJUxncr0shg65fTDnQ+O
         puoHFwzEsRNCLcvXxJXrHjiiqcZzqklCRpuc15C8aiZeiIa/g6sErO1xQ/8kyzglix7l
         9gDv/+ToXPg/ySc/aKquTFuhfw7McHF6x7DcSUgaOm+763N9p66+qSi5d/3xbynqVmrh
         h5Wg==
X-Gm-Message-State: AOAM532HJGlstUBccWyo0TapB+BkXJEuoB3ZmXRFyPUehGeQU/j5yo9W
        eHf4gLxhD6FOdfungmFHv70=
X-Google-Smtp-Source: ABdhPJz4NlXIH44Up6kriEihCMzY49jx4itdsN3hhYT71mxqlsAmJRROm2hnw0VwJGDR/pPev9+yNg==
X-Received: by 2002:a50:f089:: with SMTP id v9mr11933883edl.353.1610295163130;
        Sun, 10 Jan 2021 08:12:43 -0800 (PST)
Received: from localhost (ip1f10d3e8.dynamic.kabel-deutschland.de. [31.16.211.232])
        by smtp.gmail.com with ESMTPSA id t12sm6534378edy.49.2021.01.10.08.12.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2021 08:12:42 -0800 (PST)
Date:   Sun, 10 Jan 2021 17:12:32 +0100
From:   Oliver Graute <oliver.graute@gmail.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>, parthitce@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 2/3] ARM: dts: Add support for i.MX6 UltraLite DART
 Variscite Customboard
Message-ID: <20210110161232.GB7264@ripley>
References: <1610144511-19018-1-git-send-email-oliver.graute@gmail.com>
 <1610144511-19018-3-git-send-email-oliver.graute@gmail.com>
 <CAOMZO5AGro=rGTPV0CAWPh_=Q9KqCYWO199FWn57xBc=eUWdog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5AGro=rGTPV0CAWPh_=Q9KqCYWO199FWn57xBc=eUWdog@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/21, Fabio Estevam wrote:
> On Fri, Jan 8, 2021 at 7:23 PM Oliver Graute <oliver.graute@gmail.com> wrote:
> 
> > +       panel1: panel-lcd {
> > +               compatible = "sgd,gktw70sdad1sd";
> > +
> > +               backlight = <&backlight_lcd>;
> > +               power-supply = <&reg_touch_3v3>;
> > +               label = "gktw70sdad1sd";
> > +
> > +               display-timing {
> 
> If you pass the compatible, then you don't need to add the
> display-timing in the device tree.

thx I`ll drop it

Best Regards,

Oliver
