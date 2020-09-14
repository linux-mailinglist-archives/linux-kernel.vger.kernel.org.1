Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859D726998C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 01:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgINXPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 19:15:38 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37764 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgINXPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 19:15:36 -0400
Received: by mail-il1-f196.google.com with SMTP id q4so1247161ils.4;
        Mon, 14 Sep 2020 16:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=v8esb+U9dWPq/cRSlE6zwoQk2BH/Rhe+bmOHdQwvImw=;
        b=f0nBvhg1DJApot4ujbH20/s8mWSHH/m0tHFtlBaIYAnrTSO/M6IrDxk4SZT9T9jGji
         RaslzreL68R2eKby+cCnogQgjzCWp+674KKDYbtat4v/So2NGCk9LyZsnoL5ESgHJENA
         RgSAJ1ExhNJmVC1jj6ZoA8PITUa0DOcUoAPXIYXFKDcPmi50yMZ/b4FoWVdaZ9CHU7pl
         B0ph82mPyqW18H+D4QSn3sJ7GnqMJldJj5kfUD9v+rregMmY4jYtkmYy28hQqlXvbbzv
         gCZQ/EXXAgEhZ09WhYiuErFaFIKz7/1mBTEzphtbzz3r55xazmPCuOXBvabwczZtBcRK
         Utlw==
X-Gm-Message-State: AOAM533IqtmE226aMAJsUjCg0T0F0odQzzdGgyG4hY7d0QzrvYGJw5/W
        g3qb18DpowabSFKu3wvIRbwDSCsqRkMe
X-Google-Smtp-Source: ABdhPJxmGewziD3/8IyRxlPkrNIGmiUU5Ubq9us7DBOM/69WSVUyR6yNFe+3kSS6P4ldYsFNYqyFTQ==
X-Received: by 2002:a92:9fcc:: with SMTP id z73mr7524173ilk.234.1600125334943;
        Mon, 14 Sep 2020 16:15:34 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id z2sm3248133ilz.37.2020.09.14.16.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 16:15:34 -0700 (PDT)
Received: (nullmailer pid 454832 invoked by uid 1000);
        Mon, 14 Sep 2020 23:15:33 -0000
Date:   Mon, 14 Sep 2020 17:15:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tom Cubie <tom@radxa.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH 0/3] extcon: Add Type-C Virtual PD
Message-ID: <20200914231533.GA429337@bogus>
References: <20200904191830.387296-1-jagan@amarulasolutions.com>
 <6955091.ERBjKZ0CLf@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6955091.ERBjKZ0CLf@diego>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 11:23:21PM +0200, Heiko Stübner wrote:
> Hi Jagan,
> 
> Am Freitag, 4. September 2020, 21:18:27 CEST schrieb Jagan Teki:
> > USB Type-C protocol supports various modes of operations
> > includes PD, USB3, and Altmode. If the platform design
> > supports a Type-C connector then configuring these modes
> > can be done via enumeration.
> > 
> > However, there are some platforms that design these modes
> > of operations as separate protocol connectors like design
> > Display Port from on-chip USB3 controller. So accessing
> > Type-C Altmode Display Port via onboard Display Port 
> > connector instead of a Type-C connector.
> >  
> > These kinds of platforms require an explicit extcon driver
> > in order to handle Power Delivery and Port Detection.
> > 
> > This series support this Type-C Virtual PD and enable the
> > same in ROCK Pi 4C SBC.
> > 
> > Any inputs?
> 
> I tend to disagree on the design via an extcon.

I don't accept new extcon bindings or users of it either. It's a 
poorly thought out collection of Linux driver properties. Use the usb 
connector binding.

> 
> That the Rockchip rk3399 currently carries that extcon thingy is unfortunate
> and only works for ChromeOS devices based on the rk3399.
> 
> The kernel now has a real type-c framework so we should not extend this
> extcon hack any further, because that will make it even harder to roll back
> later. Also simply because other Rockchip boards currently can't really make
> use of type-c due to this, as they use the fsusb302 phys directly connected.
> 
> ChromeOS actually spend some time to make the cros-ec pd part of the type-c
> framework if I remember correctly, so a viable battle plan would be to:
> 
> (1) move the Rockchip type-c phy driver to actually be part of the type-c
>     framework, with the extcon being a deprecated fallback for old DTs.
> (2) implement your gpio-altmode as part of the type-c framework
>     (which may even already exist)
> 
> 
> In short, please don't extend the rk3399 type-c extcon hack.
> 
> Thanks
> Heiko
> 
> 
> 
> 
