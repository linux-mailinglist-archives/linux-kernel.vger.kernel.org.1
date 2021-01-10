Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5BF2F09A2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 21:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbhAJUJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 15:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbhAJUJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 15:09:52 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7290BC061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 12:09:12 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id i24so16657820edj.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 12:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kUyUrQs3xayATQiBWATvxgCd0SP5l5aLWIuYGmxV8Jg=;
        b=mDR2LUmfkn2nNOs0YdM2bPqrC9RQ3FZoumw6mJ+AGC0Xvi+kKiCZ+JDVdSm3P+x8W2
         sEbqxl1gLTMpJ1cL4y1AOcquOlDcANECEWWxxI7TaKsFv/SSF9N5hiaBkdEup9y3YGov
         gy21SN97OlMRzxibSNmKt+arB6gSE+g/ajtGbVOrVzw9yvlgf+21fJm0hfEOVd6WilMU
         vVxZQs3EJ1mOktZvvVB3xzaEf396p1FDP+EdqG35WhZ/Q/FFVUHVW5O9kX+exI1tbyFe
         yHtPpfw2rbNsJNse5w3qoHZdijULR4KxfOIJzVGbw/yfvPoI3molydO9gYqwGHDP7L86
         v43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kUyUrQs3xayATQiBWATvxgCd0SP5l5aLWIuYGmxV8Jg=;
        b=hpEd039BHAeTVgU86IaF8FOYLIXDpIZkUNTHXSVM4ngiMfRX6SZiOn7C6+3xkMi67P
         BdmGP3EfdjJfI4FaaGtbXX66y0u5zTvB8CdEudq4kbAXU9SsnNbq8Y/WeJtwGslRFbtT
         z5MGvwZVQPmmObWbMOg4pQH8sQ9Q6j6JKehq40VaDLaDwo2BSo7TjAZPUK+WlCGrHlmX
         xhYCOLJAqK/9WeROzTOGMmN8zPMIOE9aL1FAJ6g/FKfBzv3nXCiwW3WbyXDRzIrA3lmk
         8KSXzvlGi9uMqqGMQIYAYuQDpv+MxuGkoNm1IzmBUL5LA/Fc3/iEKkqXSzGjESvP10AZ
         zPTg==
X-Gm-Message-State: AOAM53067ZuY49Se+vTwQWdqX+efjeLn6RkTPINe/J3tammqP1tGXW1L
        M/h5MraalVTIt6HQgCsEAKM=
X-Google-Smtp-Source: ABdhPJwBV78e3ELX9S6MpKm1ZyGlpFi7ZJ+UjlJDv/dZs/CrDycgWvTGrDXLNdNiVWCW6jDV/xw7MA==
X-Received: by 2002:a05:6402:22e1:: with SMTP id dn1mr12351863edb.347.1610309350980;
        Sun, 10 Jan 2021 12:09:10 -0800 (PST)
Received: from localhost (ip1f10d3e8.dynamic.kabel-deutschland.de. [31.16.211.232])
        by smtp.gmail.com with ESMTPSA id dh19sm6773536edb.78.2021.01.10.12.09.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2021 12:09:10 -0800 (PST)
Date:   Sun, 10 Jan 2021 21:06:06 +0100
From:   Oliver Graute <oliver.graute@gmail.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] drm/panel: simple: add SGD GKTW70SDAD1SD
Message-ID: <20210110200606.GD7264@ripley>
References: <1608381853-18582-1-git-send-email-oliver.graute@gmail.com>
 <20210108214313.GA7979@ripley>
 <CAOMZO5AXgeGYt4+4NMBRL1Hm-9M4X2DngdEBsJEAHq8+MRhQgQ@mail.gmail.com>
 <20210110153532.GA7264@ripley>
 <CAOMZO5C_hDWeVrCh7k+3OiA0jhQfawhGWE6hxnnFn=wA+dkTGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5C_hDWeVrCh7k+3OiA0jhQfawhGWE6hxnnFn=wA+dkTGQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/21, Fabio Estevam wrote:
> Hi Oliver,
> 
> On Sun, Jan 10, 2021 at 12:35 PM Oliver Graute <oliver.graute@gmail.com> wrote:
> 
> > the first two errors are gone. But I still get this:
> >
> > [   42.387107] mxsfb 21c8000.lcdif: Cannot connect bridge: -517
> >
> > The panel is still off perhaps I miss something else.
> 
> Some suggestions:
> 
> - Take a look at arch/arm/boot/dts/imx6ul-14x14-evk.dtsi as a
> reference as it has display functional
> - Use imx_v6_v7_defconfig to make sure all the required drivers are selected

ok I checked imx6ul-14x14-evk.dtsi and use imx_v6_v7_defconfig

> - If it still does not work, share the dts and schematics

here the schematics and my dts. The board is using a LVDS connector for
the display.

https://www.variscite.de/wp-content/uploads/2017/12/VAR-6ULCustomboard-Schematics.pdf
https://lore.kernel.org/linux-arm-kernel/1610144511-19018-3-git-send-email-oliver.graute@gmail.com/

Thx for your help,

Best Regards,

Oliver
