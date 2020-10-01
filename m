Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A1D27FE5E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 13:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731951AbgJAL3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 07:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731670AbgJAL3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 07:29:14 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01C6C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 04:29:13 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w5so5253523wrp.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 04:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RBzhaq1QTDsCmP+j+XwlnjdZ6fXeqGUq7x/CRDlU94o=;
        b=h4W+V31NRlENcALCJvo5DYM+iBJ3zPJAjFZomOeoZcDG6CxRUrImpCwGTUyUejVYHo
         3McL0OHAXeZQGwPTrh9V8r9H0HftDsfN2nClT1r0iHuKjAds2iS7cgcZt37JSOzqIFUk
         lMGjt4/yZ6uRy4H+jy4UCb9h644hne5/aJPw0PuA6NgYufjOHha1rvVU5g96svMjPxeS
         wMaV3i2jqPdXBwarXC/9g5h4bFh0rbQmbI9SuKgmtOJ3dxcEra6ZhptG08/nwrqhCCpD
         o7jDHdSctF6nw6ANP8WR5OYoQP9jfiyAcA2Avt2ii55pTgLEhKFYE/JUb3V8n3HHOhjB
         86SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RBzhaq1QTDsCmP+j+XwlnjdZ6fXeqGUq7x/CRDlU94o=;
        b=DEleIJGiPbMTEtAm2oJeFgqasujZnq11LCy6rTHiZNq8ngznax8piiAu8NxlZaHcaW
         zGIO6W1TZY5IxDvVwgnBDtTjIOfPZIr82xh6JOcAFeKlCAzjIQev6BclB5KijaHvQxnv
         8q4vpVGEf3XhsKOcLKTQLXbQ4m98b8rsIXpxo9HGZFvjln3l/1YGAByNhOnga+Ca/3lX
         GAB58iird+yGmdeLfSdWf9Rsp6QmiwZ5QkIRaCS5OdY5/VV9SI7aHvEWqZaXyYUxZax8
         3mIqwSOZoMrZ3J2CZvill0zEvZ5A2QmAtESSdL8TaI5hWW2b7u03l7RfI5p4caX1CABs
         wpSQ==
X-Gm-Message-State: AOAM533NioUNCWPVbUvndEKUNj87Iqz8btKcUlcA310PxiA6rswO34MK
        A5LKWInec9wT9ZBdbrGW5I7pKg==
X-Google-Smtp-Source: ABdhPJxDMutN0ciYw0+6lxB3h9W30Gun+e3sEeG/4ZjLvqfEtSdB3W+BHwAmMEgp6hYKDiWzHzf6gg==
X-Received: by 2002:a5d:4247:: with SMTP id s7mr8344135wrr.167.1601551752631;
        Thu, 01 Oct 2020 04:29:12 -0700 (PDT)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id y14sm8249720wma.48.2020.10.01.04.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 04:29:12 -0700 (PDT)
Date:   Thu, 1 Oct 2020 12:29:10 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 41/52] docs: kgdb.rst: fix :c:type: usages
Message-ID: <20201001112910.rknvq3gswwdvhmkx@holly.lan>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
 <556f72684846c3cc30eb2f0a1e064183d4e1bdc9.1601467849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <556f72684846c3cc30eb2f0a1e064183d4e1bdc9.1601467849.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 03:25:04PM +0200, Mauro Carvalho Chehab wrote:
> Which Sphinx 3, :c:type:  can't be used anymore for structs,
> as this should be used only for typedefs.
> 
> Rely on automarkup.py for struct references.
> 
> This file has an special case, though: it uses the tag also
> to point to an array. Let's use, instead, :c:expr: for such
> purpose, as it should do the right thing.
> 
> This should fix this warning:
> 
> 	./Documentation/dev-tools/kgdb.rst:875: WARNING: Unparseable C cross-reference: 'kdb_poll_funcs[]'
> 	Invalid C declaration: Expected end of definition. [error at 14]
> 	  kdb_poll_funcs[]
> 	  --------------^
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


> ---
>  Documentation/dev-tools/kgdb.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kgdb.rst b/Documentation/dev-tools/kgdb.rst
> index c908ef4d3f04..77b688e6a254 100644
> --- a/Documentation/dev-tools/kgdb.rst
> +++ b/Documentation/dev-tools/kgdb.rst
> @@ -726,7 +726,7 @@ The kernel debugger is organized into a number of components:
>     -  contains an arch-specific trap catcher which invokes
>        kgdb_handle_exception() to start kgdb about doing its work
>  
> -   -  translation to and from gdb specific packet format to :c:type:`pt_regs`
> +   -  translation to and from gdb specific packet format to struct pt_regs
>  
>     -  Registration and unregistration of architecture specific trap
>        hooks
> @@ -846,7 +846,7 @@ invokes a callback in the serial core which in turn uses the callback in
>  the UART driver.
>  
>  When using kgdboc with a UART, the UART driver must implement two
> -callbacks in the :c:type:`struct uart_ops <uart_ops>`.
> +callbacks in the struct uart_ops.
>  Example from ``drivers/8250.c``::
>  
>  
> @@ -875,7 +875,7 @@ kernel when ``CONFIG_KDB_KEYBOARD=y`` is set in the kernel configuration.
>  The core polled keyboard driver for PS/2 type keyboards is in
>  ``drivers/char/kdb_keyboard.c``. This driver is hooked into the debug core
>  when kgdboc populates the callback in the array called
> -:c:type:`kdb_poll_funcs[]`. The kdb_get_kbd_char() is the top-level
> +:c:expr:`kdb_poll_funcs[]`. The kdb_get_kbd_char() is the top-level
>  function which polls hardware for single character input.
>  
>  kgdboc and kms
> -- 
> 2.26.2
> 
