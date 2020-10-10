Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D6F28A220
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgJJWzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731386AbgJJTQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:16:27 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13611C05BD2E
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 08:47:23 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id l85so13601212oih.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 08:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AKYfmmabE8KOoTAXGrClJCoRVz0CjdSEkOQL4jxspvU=;
        b=TMcXAZrRfYPUlVVMqLHurJyxKYO7uLfZdqiy/dQdWJBKlajqOsxPBpzmWfWUpNve1H
         PABd4y6TAUg2tSZ6vLlfZEbrfUp7L0iQ7LdwmebfjDpqwFxU7VROgPA5t8IrBZoNRZ2Q
         je6cwwQ6KTL23vyQYXTZ6Sm2+CZqiq3o4DvGS73jjiZf213IgvmbKdhsKpq7WguuVWAz
         JzEEAXjfdGJ1tdp6lc0u2sXf53xg864s+P6sFrJohT8HK4vmBMz3GIn6/WhBvrGDmagV
         ByvNRoSclRqE2tEiII5O8EdREJ8ga4s7o0UG/wgaPXeMAB1fVeuXz/DjOb+Pv4t6bO0s
         hPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AKYfmmabE8KOoTAXGrClJCoRVz0CjdSEkOQL4jxspvU=;
        b=trCl7F7ViMC07q1mkYKupodwFgp5lUhKH2u55pjjHJ+h0kA5P4PJ+HIaGclNs+8MKP
         hTQ/GyoLDjXLwRtk6Ijb6WWhQrpwq020SLVyUnZxoxdOWKcS2Fxjov4J3klajFK/wy+y
         VToS1sPu24lsba3TQpcowJBVvNR+GUpj4ZOuPc18CAGojkqT+Wb8sgi52T+cgc1Z4lrv
         W3thDgCd679VCxuFQy2Jv8QPY2jF/AMiDS7Nkpwvq2sFVMekoLD+rAftzAuEozsohgx1
         izWM7l22tQMk4TxUZPIZnUmHAVtLq2o+qDU9KzSp8zxpbQ1Dn/gGVbOq5j2N3CWg1y4s
         uFJw==
X-Gm-Message-State: AOAM5336Wk59pRS3iMrSK5equ/TF4SXSnir27jRBJfRR+RWDK+B1c3iJ
        w5qiDEJefEYyc+t55mkqBxo=
X-Google-Smtp-Source: ABdhPJzTUQelH4fbTvHgpdzJXuB1btp4s+BO8ILt2x6I8u+q/CkUot2GYZ2WYhHzu9r45kO2TgMdfw==
X-Received: by 2002:aca:2301:: with SMTP id e1mr6159156oie.177.1602344842523;
        Sat, 10 Oct 2020 08:47:22 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u2sm8186515oig.48.2020.10.10.08.47.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Oct 2020 08:47:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 10 Oct 2020 08:47:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wilken Gottwalt <wilken.gottwalt@mailbox.org>
Cc:     linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: Re: [PATCH] watchdog: via_wdt: add VX900 support
Message-ID: <20201010154721.GB248582@roeck-us.net>
References: <20201010130716.GA84929@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201010130716.GA84929@monster.powergraphx.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 03:07:16PM +0200, Wilken Gottwalt wrote:
> Adds watchdog support for the VIA VX900 chip-set, which is fully
> backwards compatible to the older VIA chip-set watchdogs.
> 
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@mailbox.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/via_wdt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/via_wdt.c b/drivers/watchdog/via_wdt.c
> index eeb39f96e72e..b452ab253ac7 100644
> --- a/drivers/watchdog/via_wdt.c
> +++ b/drivers/watchdog/via_wdt.c
> @@ -244,6 +244,7 @@ static const struct pci_device_id wdt_pci_table[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_CX700) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VX800) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VX855) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VX900) },
>  	{ 0 }
>  };
>  
> -- 
> 2.28.0
> 
