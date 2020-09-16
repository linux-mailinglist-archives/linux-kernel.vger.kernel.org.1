Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEE826C9AB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgIPTQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbgIPTQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:16:09 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B5FC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:16:09 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k13so3714467plk.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zr61f+8hOqxxTqD74nqUMvtoYbdbG1ifRMQ2x2Wo47k=;
        b=bbdj+cQGEJp6ctFF99Cjmvo7Dl8c5lDllAMrLmBhmCreCk4CCxJLDuT86uYHIpH65i
         wGSuUdeoCbqvPWQEyDmbIMuYr11zya+MEL9LgDgHjw9wW2Jrvop4jDknOASk+2eHrGK9
         okgBawmmoBqLNMmWc5eB7lENEkN0v3Z7v53pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zr61f+8hOqxxTqD74nqUMvtoYbdbG1ifRMQ2x2Wo47k=;
        b=IIw831QGqjlAGfkUMXwfwlBL6ZdMKlzBTXkTrCsoBMyn9P2Ork8CgDLF2OgKF4Ae0b
         ZvbINJDgEiAAeE5Pokq3D2B7KKY2q8EXJ3PnhlxL6BBtomES3dmk92lnyN/PgmVxg0KR
         e6OsvUxj+sb/QA37wjNlp2IceSw2z/bZ8an+2gSHOpb4FYrs8SVk/ym3xdvil2sz+OWe
         r/woG1Oflrnar1IC5v+U15fuv+6usCEoVT8uFzKnDQZGEINgKDOfEc3+1XJB8W431rHg
         vDQsfQvfH+70Qef3GegKsGZ3YFrN99Kwoo/nG9cGv1fW1n6Oxk2ICsMjSLIDALSEmGR1
         S4xg==
X-Gm-Message-State: AOAM532QD0kEl3T577/jLd3T/pmLTBIjywTT2vbDRyr44KfxXfqdWuLd
        3KW9a8D6/Fv/48Zou9QVn7iaRw==
X-Google-Smtp-Source: ABdhPJwJM+OTHnJPdEHq/T/i96CODtoGOWb2LXGarjGhYsFmNfb+leoxpAvdm2/ZWY9u0FqoTifTpQ==
X-Received: by 2002:a17:90b:208b:: with SMTP id hb11mr5334533pjb.201.1600283768911;
        Wed, 16 Sep 2020 12:16:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id ih11sm3258735pjb.51.2020.09.16.12.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 12:16:08 -0700 (PDT)
Date:   Wed, 16 Sep 2020 12:16:07 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Peter Chen <peter.chen@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 2/2] USB: misc: Add onboard_usb_hub driver
Message-ID: <20200916191607.GB3560556@google.com>
References: <20200914112716.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200914112716.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <20200915025426.GA17450@b29397-desktop>
 <20200915050207.GF2022397@google.com>
 <AM7PR04MB715735A8A102F3EC9041EA328B200@AM7PR04MB7157.eurprd04.prod.outlook.com>
 <20200915230345.GF2771744@google.com>
 <20200916081821.GA14376@b29397-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200916081821.GA14376@b29397-desktop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, Sep 16, 2020 at 08:19:07AM +0000, Peter Chen wrote:
> On 20-09-15 16:03:45, Matthias Kaehlcke wrote:
> > Hi Peter,
> > 
> > On Tue, Sep 15, 2020 at 07:05:38AM +0000, Peter Chen wrote:
> > >   
> > > > > > +	hub->cfg.power_off_in_suspend =
> > > > of_property_read_bool(dev->of_node, "power-off-in-suspend");
> > > > > > +	hub->cfg.wakeup_source = of_property_read_bool(dev->of_node,
> > > > > > +"wakeup-source");
> > > > >
> > > > > Do you really need these two properties? If the device (and its
> > > > > children if existed) has wakeup enabled, you keep power in suspend,
> > > > > otherwise, you could close it, any exceptions?
> > > > 
> > > > That would work for my use case, but I'm not sure it's a universally good
> > > > configuration.
> > > > 
> > > > I don't have a specific USB device in mind, but you could have a device that
> > > > shouldn't lose it's context during suspend or keep operating autonomously (e.g.
> > > > a sensor with a large buffer collecting samples). Not sure if something like this
> > > > exists in the real though.
> > > > 
> > > > I'm not an expert, but it seems there are USB controllers with wakeup support
> > > > which is always enabled. A board with such a controller then couldn't have a
> > > > policy to power down the hub regardless of wakeup capable devices being
> > > > connected.
> > > > 
> > > 
> > > Whether or not it is a wakeup_source, it could get through its or its children's
> > > /sys/../power/wakeup value, you have already used usb_wakeup_enabled_descendants
> > > to know it.
> > 
> > I conceptually agree, but in practice there are some conflicting details:
> > 
> > wakeup for the hubs on my system is by default disabled, yet USB wakeup works
> > regardless, so the flag doesn't really provide useful information. I guess we
> > could still use it if there is no better way, but it doesn't seem ideal.
> > 
> > Similar for udev->bus->controller, according to sysfs it doesn't even have wakeup
> > support. Please let me know if there is a reliable way to check if wakeup is
> > enabled on the controller of a device.
> 
> Then, how could your code work, you use usb_wakeup_enabled_descendants
> to get if HUB or the descendants under the HUB has wakeup enabled?

Doing just that would not allow to switch the hub off when wakeup enabled
descendants are connected, which might be desirable in some configurations.

> If you use dwc3, you need to enable xhci-plat.c's wakeup entry if your
> system needs xHCI connect/disconnect wakeup event. I have one pending
> patch to do it:
> 
> https://www.spinics.net/lists/linux-usb/msg199406.html

Thanks, my system has indeed a dwc3(-qcom) controller, your patch adds
the missing wakeup entry to sysfs. So it seems your patch should solve
my problem (sharp timing!), however you mention specifically the 'xHCI
connect/disconnect wakeup event', so I wonder if the xHCI wakeup flag
isn't applicable to other wakeup events. I know the dwc3-qcom platform
device has its own wakeup flag. The driver currently enables wakeup
interrupts unconditionally, I sent a patch to change that
(https://lore.kernel.org/patchwork/patch/1305894/), however I now wonder
if it should evaluate the xHCI wakeup flag instead of its own.

Thanks

Matthias
