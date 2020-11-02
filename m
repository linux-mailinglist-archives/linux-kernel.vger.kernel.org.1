Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB1B2A2698
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 10:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgKBJH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 04:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgKBJH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:07:28 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FDCC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 01:07:28 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id b3so7706891wrx.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 01:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eh9Kx6+5Xx4FIWIBxaCzilDxfbxHKWBRRWt/h8bX/rs=;
        b=cXswJPQd/xUllwAxQLU9ImRdH4jkz6aY2eu6KPOyi/5Wp8hxpCloXAZPtyMpw4LyN4
         4Bf5RY8F9D+7eziCzUE7qYHLQjLEXpww0+CXxnmHDVo7P+ItIQwWU+hpWQmJBUdXu7ne
         MLK+nap0AfUL2guPiI69O1B10CEgY0QWC9UqDCJPrwdHtMYlkl2yFOkzedgwX2xibZjX
         VVKvvUvqdmrM+yOjMNgos5Y9vetvGT+C4PYW7KCddIjdzIbm9YmxY5j9e/0dwI74zE+j
         4fF81aw4jhdrcoGfgnegNs7OFAFydYwc452hKsZ5paJr+t6iel5fMcTDz2Rq5bf3KZh+
         HoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eh9Kx6+5Xx4FIWIBxaCzilDxfbxHKWBRRWt/h8bX/rs=;
        b=PTASd4djSojwHSF2T5TAAzQ3I76sn80d4C0lpGC/FzXRjW+qE6kTVjq/12A4xYyTqs
         Ph6djSAFwR/KdLlfAjiil4BV2lvTHQmtw1ds1lj+vTBW9KQWskWzQL/cg9jubOW64w08
         43EGjQu/mDVVd5qREin0RcFQtGCoAdIVpZZ3axjTuNY7wX1G8e4/Qyefes7CZ0VBzqjQ
         02Kx3r0Gbx7qGEKKzgXfZKID5MLOKt6/icUAtdvX9gA+8yy+fHize+6YclNtUEGJPGrA
         xA13eTPUcARRogKINDn1CV3qgk8wlQXlhoIahqtmeOLwwYUWPk0K/eSGlZqn1fLKOJit
         dA6A==
X-Gm-Message-State: AOAM532XPotUpUVXknH5ATyL9QGjYciDNN/eMkfkqBw8NxsnGjEU6Grs
        L07w/sRj9lcgySZzPYuWWbJQjA==
X-Google-Smtp-Source: ABdhPJw0w9JaxbWwnT/snRspP1tY78SzVXqSX83vCHLL7UV8wAMcDcQXL3WFGzMPjViP4T/aiIZ5Og==
X-Received: by 2002:adf:c3c2:: with SMTP id d2mr19425327wrg.191.1604308047090;
        Mon, 02 Nov 2020 01:07:27 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id 66sm14827582wmb.3.2020.11.02.01.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 01:07:26 -0800 (PST)
Date:   Mon, 2 Nov 2020 09:07:24 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Codrin.Ciubotariu@microchip.com
Cc:     Nicolas.Ferre@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        richard.genoud@gmail.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com
Subject: Re: [PATCH] ARM: dts: at91: add serial MFD sub-node for usart
Message-ID: <20201102090724.GG4127@dell>
References: <20201030110702.886638-1-codrin.ciubotariu@microchip.com>
 <b054ce5c-58fd-dd86-2cb6-1e1f06a0899e@microchip.com>
 <f370bbf7-5cfc-1524-8103-061698ba6b67@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f370bbf7-5cfc-1524-8103-061698ba6b67@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Oct 2020, Codrin.Ciubotariu@microchip.com wrote:

> On 30.10.2020 15:38, Nicolas Ferre wrote:
> > On 30/10/2020 at 12:07, Codrin Ciubotariu wrote:
> >> The "atmel,at91sam9260-usart" driver is a MFD driver, so it needs 
> >> sub-nodes
> >> to match the registered platform device. For this reason, we add a serial
> >> subnode to all the "atmel,at91sam9260-usart" serial compatible nods. This
> >> will also remove the boot warning:
> >> "atmel_usart_serial: Failed to locate of_node [id: -2]"
> > 
> > I don't remember this warning was raised previously even if the MFD 
> > driver was added a while ago (Sept. 2018).
> > 
> > I would say it's due to 466a62d7642f ("mfd: core: Make a best effort 
> > attempt to match devices with the correct of_nodes") which was added on 
> > mid August and corrected with 22380b65dc70 ("mfd: mfd-core: Ensure 
> > disabled devices are ignored without error") but maybe not covering our 
> > case.
> 
> Well, it's not covering our enabled devices.
> 
> > 
> > So, well, I don't know what's the best option to this change. Moreover, 
> > I would say that all other USART related properties go into the child 
> > not if there is a need for one.
> > 
> > Lee, I suspect that we're not the only ones experiencing this ugly 
> > warning during the boot log: can you point us out how to deal with it 
> > for our existing atmel_serial.c users?
> 
> My understading is that platform devices registered by MFD should have a 
> correspondig DT node. The parrent properties are also available for the 
> other usart device (usart-spi), so I think we should keep them in the 
> parrent.

Device Tree and MFD are unrelated.  MFDs don't even exist - they are a
figment of a Linux Kernel Engineer's imagination - we made them up!

The DT should describe the hardware and nothing else.  If we wish to
mess with devices for our own gain i.e. organise them into different
subsystems, we have to do that in software.  That's what MFD is for. 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
