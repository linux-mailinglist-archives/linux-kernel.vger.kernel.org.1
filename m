Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8A726951E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 20:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgINSm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 14:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgINSmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 14:42:38 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E0EC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 11:42:31 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d9so338351pfd.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 11:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/0N1kgY4YSskKhtqicU+MJ56FlC+m73zDjYCiR+Q+4A=;
        b=U8JwsRuQylQ/N4j0Os9z7VbzjHcCPIh2U1adn08h+ARrGqo9UqxlRe19UQwz36Cvul
         9rTibomVDcAgcJf052jJoNC5xh7phJQLQwX13DhEzR23K8TLI57Iz70v3bso0BvbwATi
         WNFQIJHVJcXamKwjH/iet5kkUdrrCfa+lMKyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/0N1kgY4YSskKhtqicU+MJ56FlC+m73zDjYCiR+Q+4A=;
        b=ZW6zwK6jJlxdserh/mAG63RYVHMYpuiutHk2MKw0mp2ZtSdyPzJ/PZoQFKt28VByxk
         qWwVrevQREKxdyC22p/wDbW16Q4KeWxUp8/h7XzCae21BTtY9GBnWr3jDFTP18AsvIyA
         cF7KUFEoJYttgpi9e5Z2eLCiY1J4qTv3xBCRLpJRB0NLdmqSBbTSYUqcZrbGBjlTf0Se
         v7dCkuzSx7mNq0WM15evhaT86GBU9H+zP3LhLyfZamotsd89hwmI99lteq+gG/Envjm6
         gAsaV8ewJoVbvKAqyDZcTg4EmOxp7qJ+FBQPjgCUb4i9ew4bq1sBwvbTmUin3ishaig4
         eDlw==
X-Gm-Message-State: AOAM532zKrWk/vAylEwwfE/46Z08Ughjwa6ZWKdmU28PduHgOpXWwxq9
        R15pvrGzMIHijanzu93TNJ4hFw==
X-Google-Smtp-Source: ABdhPJxJXJLZVn7PXxzlK/sOGuAY0mmNTwXAWorffgP/IANILSesIVCB6gXi809M/9nfMwGvaRbCIQ==
X-Received: by 2002:a63:7b16:: with SMTP id w22mr11501114pgc.17.1600108950799;
        Mon, 14 Sep 2020 11:42:30 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id s24sm9072901pgv.55.2020.09.14.11.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 11:42:30 -0700 (PDT)
Date:   Mon, 14 Sep 2020 11:42:29 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Peter Chen <peter.chen@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [RFC PATCH] USB: misc: Add usb_hub_pwr driver
Message-ID: <20200914184229.GC2022397@google.com>
References: <20200901132005.RFC.1.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <20200902053048.GB6837@b29397-desktop>
 <20200902174536.GE3419728@google.com>
 <20200903014559.GB11250@b29397-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200903014559.GB11250@b29397-desktop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

sorry for the delayed reply, I got distracted by other things and ran into
issues with my mail setup.

On Thu, Sep 03, 2020 at 01:46:18AM +0000, Peter Chen wrote:
> On 20-09-02 10:45:36, Matthias Kaehlcke wrote:
> > > 
> > > Hi Matthias,
> > > 
> > > I did similar several years ago [1], but the concept (power sequence)
> > > doesn't be accepted by power maintainer.
> > 
> > Yeah, I saw that, I think I even reviewed or tested some early version
> > of it :)
> > 
> > > Your patch introduce an new way to fix this long-term issue, I have an
> > > idea to fix it more generally.
> > 
> > > - Create a table (say usb_pm_table) for USB device which needs to do
> > > initial power on and power management during suspend suspend/resume based
> > > on VID and PID, example: usb/core/quirks.c
> > > - After hub (both roothub and intermediate hub) device is created, search
> > > the DT node under this hub, and see if the device is in usb_pm_table. If
> > > it is in it, create a platform device, say usb-power-supply, and the
> > > related driver is like your usb_hub_psupply.c, the parent of this device
> > > is controller device.
> > 
> > This part isn't clear to me. How would the DT look like? Would it have a
> > single node per physical hub chip or one node for each 'logical' hub?
> > Similarly, would there be a single plaform device or multiple?
> 
> One power supply platform device for one physical device, and DT only
> describes physical device. HUB driver only probes non-SS HUB port to
> avoid create two power supply device for SS HUB, there should be no
> SS-only HUB.

I agree that there should be only one platform device per physical device.
Probing only the non-SS hub should work to avoid multiple instances, however
it doesn't work for the extended use case, where the hub is powered off
during system suspend, but only when no wakeup capable devices are connected
to any of the 'logical' hubs. For this to work the driver that controls the
regulators, GPIOs, ... needs to have knowledge of all 'logical' hubs.

I just sent v1 of this driver, which reworks things a bit, but for now
there is still one platform device instantiated through the DT, and
one DT entry for every 'logical' hub.

I'm open to keep discussing alternative designs, as long as they can also
cover the use case of conditionally powering the hub off during system
suspend. We can probably continue the discussion on v1, unless it takes
me longer than
