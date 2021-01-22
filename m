Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0680730076F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 16:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbhAVPeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 10:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbhAVPcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:32:32 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49284C06174A;
        Fri, 22 Jan 2021 07:31:52 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id g69so5579880oib.12;
        Fri, 22 Jan 2021 07:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=WAI9EmxO3OdflrUnEgXpGM4CRb9QLdpplJPoTa7R+cY=;
        b=pGjPfkb55wKYX9mvuZTQi7AZBGV2QCOZFoXy9RzWdf2gyj/GW2FFSyQKljP4zXID50
         v2uASSUdUkQ3mHimoXvFdWvpPvuufAaZoepwM90faKAf2dX6xAvmXcXhVTCyCBJEsL7n
         fV0HG3Oh5ostJFIr3RXkQtWzI8E5nAVY4IxpP3iM1RVH2hg5/O6Gpjtfmw2cPorbuGFN
         E7h/wA8FOlWPXOCrTxGwhOOuPJahWYyOJGEuoP8kp0Fn9T5pvoSnASh4NCCiStEONF/z
         +5M4sOmAEAlWE+9fEctq2pN8XoyuwM0nCvGXpPyi4oWe7qWOpyEyJatW2PPcWsPbc+VQ
         cmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=WAI9EmxO3OdflrUnEgXpGM4CRb9QLdpplJPoTa7R+cY=;
        b=GasVHfsa4Yo8zXAk/k09NKRgk9I+7HAm8eeXMckJgnZpHPqsPIRT9/r3R21+e21zVq
         nGmQe2GoxyE2qdRGkQjyu0s4cuiv51MQxv/eOVCFvbHqUzzta6Oei9vSBhBATOl8QdXb
         3QGyOxwVRc0+shu5M2fDDg7mbtrFMag0CFPVDPuQBWz5NSIL96SKGseJz4VnTkW8Nf7O
         zgwWEyQK7Lv+ZAi54u3tAEARvBapFPcQOjMAhhXzdC9Ka+tQvoZSNjkDScU3GiGVtB7M
         obiBvyHGSS2dBvaRlGSUFQeRwsScalYErpWVkDCqvKv1YRM6y80bYhDuER3ovbHHK1Pe
         h3JQ==
X-Gm-Message-State: AOAM5320MU7L5y0a5CgudKTcK0Mnld/RDzFzXEKJumiXYh3l73uV/S3M
        skw50X/hnmftkC9FuxUjUw==
X-Google-Smtp-Source: ABdhPJz+ggRZGBXu3zz8mjszaqMjK+cra/M1UXcQnQ4rQ57Dsba4pFrBTo5xSMzW1dzsOTjtZu39OQ==
X-Received: by 2002:aca:d417:: with SMTP id l23mr3595479oig.145.1611329511568;
        Fri, 22 Jan 2021 07:31:51 -0800 (PST)
Received: from serve.minyard.net ([47.184.170.156])
        by smtp.gmail.com with ESMTPSA id n82sm1014044oih.39.2021.01.22.07.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 07:31:50 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:ecb8:97e0:27ff:a134])
        by serve.minyard.net (Postfix) with ESMTPSA id A45C7180042;
        Fri, 22 Jan 2021 15:31:49 +0000 (UTC)
Date:   Fri, 22 Jan 2021 09:31:48 -0600
From:   Corey Minyard <minyard@acm.org>
To:     ChiaWei Wang <chiawei_wang@aspeedtech.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        Haiyue Wang <haiyue.wang@linux.intel.com>,
        Cyril Bur <cyrilbur@gmail.com>,
        Robert Lippert <rlippert@google.com>
Subject: Re: [PATCH v5 3/5] ipmi: kcs: aspeed: Adapt to new LPC DTS layout
Message-ID: <20210122153148.GB1157510@minyard.net>
Reply-To: minyard@acm.org
References: <20210114131622.8951-1-chiawei_wang@aspeedtech.com>
 <20210114131622.8951-4-chiawei_wang@aspeedtech.com>
 <c8421730-f8a6-46a7-9e2c-9107eb979276@www.fastmail.com>
 <HK0PR06MB3779C3106D2FC593B5E5243F91A00@HK0PR06MB3779.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0PR06MB3779C3106D2FC593B5E5243F91A00@HK0PR06MB3779.apcprd06.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 09:55:56AM +0000, ChiaWei Wang wrote:
> Hi Corey,
> 
> Could you help to review this patch to kcs_bmc_aspeed.c?
> It mainly fixes the register layout/offsets of Aspeed LPC controller.

I am not really qualified to review this.  It looks ok from a structural
and style point of view, but that's all I can tell.  So I'm ok with it.

Acked-by: Corey Minyard <cminyard@mvista.com>

> 
> Thanks,
> Chiawei
> 
> > -----Original Message-----
> > From: Andrew Jeffery <andrew@aj.id.au>
> > Sent: Wednesday, January 20, 2021 1:03 PM
> > Subject: Re: [PATCH v5 3/5] ipmi: kcs: aspeed: Adapt to new LPC DTS layout
> > 
> > 
> > 
> > On Thu, 14 Jan 2021, at 23:46, Chia-Wei, Wang wrote:
> > > Add check against LPC device v2 compatible string to ensure that the
> > > fixed device tree layout is adopted.
> > > The LPC register offsets are also fixed accordingly.
> > >
> > > Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
> > > Acked-by: Haiyue Wang <haiyue.wang@linux.intel.com>
> > 
> > Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> 
> Thanks for the review.
