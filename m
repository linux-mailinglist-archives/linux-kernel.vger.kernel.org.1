Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A962F5665
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbhANBrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbhANAz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 19:55:56 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6FFC0617A2;
        Wed, 13 Jan 2021 16:55:03 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id c79so2358283pfc.2;
        Wed, 13 Jan 2021 16:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8PvMhL6fxWNFHCVbbnqtdK4bZl7XKsjepw1o5suSyi8=;
        b=TaTQmWAqV5uxDSklOLTXDoqh/CSQNEG2k/gb4SnywDb4Qi1K0fouvgrAfTPzQTRBBM
         BNXwEHK63XMrDPkvUiNQ7Htk4EhhCpoztLYZYnqUbH0Q9SJiNdHptS7qW56HG+bc7Sx5
         J4oLIRGJUrT8ywmjhttvHyjMjiu3mF9QCyBOVDckBiBUfiEZ20bEYateyzUuFKd5hl5n
         UAdQ5MJzLgJ3yE0P0gQ+m5fZFEW0HQm+K4GM7v8arLEl64K7rG+oJ7I4fUHu1C9iE4V8
         0ikiHBQ9fshpVEx1zaDfcgsJNLwwgPsQyMil4Rw8+WJn8fqeeX8CQxjAj4SbsvlClY9b
         Ogkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8PvMhL6fxWNFHCVbbnqtdK4bZl7XKsjepw1o5suSyi8=;
        b=XhwtXqLqYWWaF4mmqjq1ZtdGSpyF8vHIu9XZNkGdCLEKwkNW+uvEZmWFYIRo6JKhhd
         bNg52RmTlZ1xPOSEiK4DNRVVcLDu/exps3zP7ZdRw2ZBFKmNAU3QHvQZF1x0VhIubVbf
         nsvIC1LVBm0hva2jY1mkHD1+cjR3lDQfiPojCajGC4bC7oQZR5FjJcm9+LENNzdSX1WT
         Fhpox9m2mhJrZM7ujCWCJuAj7zwy7WW8vFkxbtkQ3XrdSnA1vKR2nvVQnbX6hsj4F6RC
         LX98ukAInbR+WzrvuDK/hMmUuI+Q/cLFMSLXENGp298SI0ukON8OkqAW8Hm4rFLWvGEL
         1zKQ==
X-Gm-Message-State: AOAM5321Gk8mfXwpLKRUvGkHGTmwgxPmPUuL3SbyupyZL3W2HWJrSinj
        YLK7ZE3wuYlTzYkHkEpNZUw=
X-Google-Smtp-Source: ABdhPJwGUNDoxClo0cBJX397ofAV3IAu6fO+8ouOGUg4pvmoNqoUpOq8314GAmgztD8lidpYbnMtvg==
X-Received: by 2002:a63:f404:: with SMTP id g4mr4694268pgi.114.1610585702870;
        Wed, 13 Jan 2021 16:55:02 -0800 (PST)
Received: from b29397-desktop ([84.17.34.154])
        by smtp.gmail.com with ESMTPSA id f64sm3661663pfb.146.2021.01.13.16.54.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jan 2021 16:55:02 -0800 (PST)
Date:   Thu, 14 Jan 2021 08:54:54 +0800
From:   Peter Chen <hzpeterchen@gmail.com>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>, Thierry Reding <treding@nvidia.com>
Subject: Re: Infinite recursion in device_reorder_to_tail() due to circular
 device links
Message-ID: <20210114005454.GA14220@b29397-desktop>
References: <X/ycQpu7NIGI969v@gerhold.net>
 <CAJZ5v0gAsZ45O8mv-gz0UvbyxnKA6fQBYvambBYEH6OSk3-m3g@mail.gmail.com>
 <CAJZ5v0h8bNp-=1zVfY5gZ1ezr8JRV4L8cEV45e+0f-aRSJnb1A@mail.gmail.com>
 <X/7XCzdDG7kbiNfM@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/7XCzdDG7kbiNfM@gerhold.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-01-13 12:18:35, Stephan Gerhold wrote:
> 
> Also, on a completely different note I looked again at the chipidea USB
> driver that produces this situation. To request the PHY (which ends up
> in the circular device link) it does:
> 
> 	/* Look for a generic PHY first */
> 	ci->phy = devm_phy_get(dev->parent, "usb-phy");
> 
> To me it doesn't really seem great to use the devm_* helpers on the
> parent device either, so I will check if I can refactor this somehow.
> Perhaps this situation can be prevented entirely.
> 

Hi Stephan,

You could try to get the PHY at parent driver
(drivers/usb/chipidea/ci_hdrc_msm.c) to see the difference.

-- 

Thanks,
Peter Chen

