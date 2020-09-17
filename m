Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CD426D047
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 02:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgIQA6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 20:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgIQA57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 20:57:59 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F393C0612F2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 17:48:00 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k8so134886pfk.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 17:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IMde5+fYLTM+LOpHLAIsusiBE2VPJ2NXLJ4iOEOG7wU=;
        b=aUt3jA0/JEquIMq6Bi8plKnqKOdfJW1ODHcJcvZKrvECJwNR0m4dKcgN5SVSfE5Bad
         MRZE6XLXjgGx7HG9zPSUAne9BRoUjvCrYhli0NoJGnwmWnldf+TD0ehElLXcM3PQWvbo
         sjFCmiUclRBH9IF8dW5pSz1KiDgdtzdi2yUZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IMde5+fYLTM+LOpHLAIsusiBE2VPJ2NXLJ4iOEOG7wU=;
        b=Nx/pxiNRhndoOtlalBviG6Bmb/wl2MxmHj+yar2TvFSlrfvQrayPaVTrhIUS5d6UTl
         sKQ+YRAcwmt6y5BFzLIjWEDvyJ7rCk8K6PKnRrOeTU861Gs71HmqsMIUsn3erOimUJgt
         o2R1ad31hyY1lz18HwHu6HHLCnUp0XlOAH4XnRW9CzdzACyg4R8aisKg6hTH8IbUMJKv
         URjYAurxPQ2dAyQM18NvTcK8qYMhwM0KpdRW8fpwSCTB8fdr137/VKNXAuAE4krVh3vf
         +gvCSLnXcceqO4uScyxJ9Z8QBCkPrqllJ9qbswPgI8py5FVTCRsVMbGKKCOcB7AlmpvO
         e+yw==
X-Gm-Message-State: AOAM530s8In3019AC8b6cfg/jdBmgjzRYdcgGON5/qfpGTb7Z6yMsUmU
        jo4nA1PK8sJ/jwFFbX3QRnY+sA==
X-Google-Smtp-Source: ABdhPJzYFfzVAE8rlAhPr5U+QgUbg0E1wVpjBgma6AiQLVXZtRMtOe4ImZGaaD0CzGvgiOD0pW8tmg==
X-Received: by 2002:aa7:8a54:0:b029:142:2501:34f6 with SMTP id n20-20020aa78a540000b0290142250134f6mr8783278pfa.79.1600303679889;
        Wed, 16 Sep 2020 17:47:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id o15sm15519028pgi.74.2020.09.16.17.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 17:47:59 -0700 (PDT)
Date:   Wed, 16 Sep 2020 17:47:58 -0700
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
Message-ID: <20200917004758.GD3560556@google.com>
References: <20200914112716.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200914112716.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <20200915025426.GA17450@b29397-desktop>
 <20200915050207.GF2022397@google.com>
 <AM7PR04MB715735A8A102F3EC9041EA328B200@AM7PR04MB7157.eurprd04.prod.outlook.com>
 <20200915230345.GF2771744@google.com>
 <20200916081821.GA14376@b29397-desktop>
 <20200916191607.GB3560556@google.com>
 <20200917002646.GA23310@b29397-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917002646.GA23310@b29397-desktop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 12:27:29AM +0000, Peter Chen wrote:
> On 20-09-16 12:16:07, Matthias Kaehlcke wrote:
> > Hi Peter,
> > 
> > On Wed, Sep 16, 2020 at 08:19:07AM +0000, Peter Chen wrote:
> > > On 20-09-15 16:03:45, Matthias Kaehlcke wrote:
> > > > Hi Peter,
> > > > 
> > > > On Tue, Sep 15, 2020 at 07:05:38AM +0000, Peter Chen wrote:
> > > > >   
> > > > > > > > +	hub->cfg.power_off_in_suspend =
> > > > > > of_property_read_bool(dev->of_node, "power-off-in-suspend");
> > > > > > > > +	hub->cfg.wakeup_source = of_property_read_bool(dev->of_node,
> > > > > > > > +"wakeup-source");
> > > > > > >
> > > > > > > Do you really need these two properties? If the device (and its
> > > > > > > children if existed) has wakeup enabled, you keep power in suspend,
> > > > > > > otherwise, you could close it, any exceptions?
> > > > > > 
> > > > > > That would work for my use case, but I'm not sure it's a universally good
> > > > > > configuration.
> > > > > > 
> > > > > > I don't have a specific USB device in mind, but you could have a device that
> > > > > > shouldn't lose it's context during suspend or keep operating autonomously (e.g.
> > > > > > a sensor with a large buffer collecting samples). Not sure if something like this
> > > > > > exists in the real though.
> > > > > > 
> > > > > > I'm not an expert, but it seems there are USB controllers with wakeup support
> > > > > > which is always enabled. A board with such a controller then couldn't have a
> > > > > > policy to power down the hub regardless of wakeup capable devices being
> > > > > > connected.
> > > > > > 
> > > > > 
> > > > > Whether or not it is a wakeup_source, it could get through its or its children's
> > > > > /sys/../power/wakeup value, you have already used usb_wakeup_enabled_descendants
> > > > > to know it.
> > > > 
> > > > I conceptually agree, but in practice there are some conflicting details:
> > > > 
> > > > wakeup for the hubs on my system is by default disabled, yet USB wakeup works
> > > > regardless, so the flag doesn't really provide useful information. I guess we
> > > > could still use it if there is no better way, but it doesn't seem ideal.
> > > > 
> > > > Similar for udev->bus->controller, according to sysfs it doesn't even have wakeup
> > > > support. Please let me know if there is a reliable way to check if wakeup is
> > > > enabled on the controller of a device.
> > > 
> > > Then, how could your code work, you use usb_wakeup_enabled_descendants
> > > to get if HUB or the descendants under the HUB has wakeup enabled?
> > 
> > Doing just that would not allow to switch the hub off when wakeup enabled
> > descendants are connected, which might be desirable in some configurations.
> > 
> > > If you use dwc3, you need to enable xhci-plat.c's wakeup entry if your
> > > system needs xHCI connect/disconnect wakeup event. I have one pending
> > > patch to do it:
> > > 
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Flinux-usb%2Fmsg199406.html&amp;data=02%7C01%7Cpeter.chen%40nxp.com%7C02c4cc75e26a47d0224d08d85a74f945%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637358805725394858&amp;sdata=cjZhSmQiXVJoLsN5PjFACsLwsikH%2BeRTztPhsckJFNs%3D&amp;reserved=0
> > 
> > Thanks, my system has indeed a dwc3(-qcom) controller, your patch adds
> > the missing wakeup entry to sysfs. So it seems your patch should solve
> > my problem (sharp timing!), however you mention specifically the 'xHCI
> > connect/disconnect wakeup event', so I wonder if the xHCI wakeup flag
> > isn't applicable to other wakeup events. I know the dwc3-qcom platform
> > device has its own wakeup flag. The driver currently enables wakeup
> > interrupts unconditionally, I sent a patch to change that
> > (https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fpatchwork%2Fpatch%2F1305894%2F&amp;data=02%7C01%7Cpeter.chen%40nxp.com%7C02c4cc75e26a47d0224d08d85a74f945%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637358805725394858&amp;sdata=6IjiiHJql%2FW4vzDla9q3qdfiiOzOQy1Vk7ryUhKOOTc%3D&amp;reserved=0), however I now wonder
> > if it should evaluate the xHCI wakeup flag instead of its own.
> > 
> 
> You may need both (glue & xhci), it depends on system design, and
> usually, these two kinds of wakeup setting isn't conflict.

Ok, thanks. So if I understand correctly the onboard hub driver should
check the wakeup state of the xHCI to determine if remote wakeup is
enabled for the controller (after all it doesn't know anything about
the platform device). Wakeup might not work properly if it is disabled
for the platform device, but it's the responsability of the board
software/config to make sure it is enabled (possibly this could be done
by making the dwc3-qcom driver understand the 'wakeup-source' property,
as the xhci-mtk driver does).
