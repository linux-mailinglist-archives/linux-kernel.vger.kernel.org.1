Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2E324A693
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 21:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgHSTLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 15:11:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40060 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHSTLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:11:34 -0400
Received: by mail-ed1-f67.google.com with SMTP id a14so19026162edx.7;
        Wed, 19 Aug 2020 12:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/p+rpWf5THdb/F5fw2hvL+B8c1zMsLILKJouEIRFrTw=;
        b=YgwulQeGfQia2HUKXylcBXMWorYQOC/LMO50ufG4slxFATTdzV4CbQY9DUE+OsE1w/
         9HSxgE6VZ5eNA/P02fm5k8ZXVhvRVJQ9Yr1xkMkI/lE3EzWO0LzN/XMg65dALXllcd1U
         H78YirVhKPEL9gEJKteEFNxwJ1C62ZJVXS65xj+2iUxWyobwotDLSWWK6HSh5ch/BdqF
         byzfdDSyYA+qe1J85kDxytcXUXaHnkNGAxcG6cnR3SJXy5p9bJFqh3qFK1Ds6fpNpqGw
         5nvtP7kQyQlCN4irhYaQpwRVYpieZdnV5nIL1/h51aw7umBtpjcrmoLMFn6vk00EYvUx
         SWDw==
X-Gm-Message-State: AOAM532iyVzvTD2qXSx0lgQa9Vey1soDhYMgVXVS4to+R8h0IEpUxPkd
        +gj3apxkAxg5G8O0aDN/3bdxJLnmWe9vQw==
X-Google-Smtp-Source: ABdhPJz05KL81rpEg12X6qhvazsMeQzWg96ReAGVByn1S7IXawceJiUgrzgEkuoZOH6yQXGcFsLy7w==
X-Received: by 2002:a05:6402:1591:: with SMTP id c17mr25661925edv.111.1597864292944;
        Wed, 19 Aug 2020 12:11:32 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id y25sm19290320ejq.36.2020.08.19.12.11.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Aug 2020 12:11:32 -0700 (PDT)
Date:   Wed, 19 Aug 2020 21:11:30 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: s3c: Remove unused 'udc' variable
Message-ID: <20200819191130.GA5213@kozik-lap>
References: <20200731074122.6484-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200731074122.6484-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 09:41:22AM +0200, Krzysztof Kozlowski wrote:
> Remove unused 'udc' variable to fix compile warnings:
> 
>     drivers/usb/gadget/udc/s3c2410_udc.c: In function 's3c2410_udc_dequeue':
>     drivers/usb/gadget/udc/s3c2410_udc.c:1268:22: warning: variable 'udc' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/usb/gadget/udc/s3c2410_udc.c | 3 ---

Applied along with other mach-s3c (and related usb) cleanups to
samsung-soc.

Best regards,
Krzysztof

