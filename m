Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F3C2B18D1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 11:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgKMKMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 05:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKMKMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 05:12:52 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0ABC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 02:12:52 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 23so9122087wrc.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 02:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bYjyZqTOCDrHGRUL1z+4uli9h7x1fnPSctKijzCSXr0=;
        b=EXun+O5yMsPnqOcwW13pZOfYYva9oKsRr9VTJkYQa5VytPDGT7man9zlAXoxipjGix
         sDyGxC/9Lfc77WXEDnB0lK4xNBABmslcGopnR+hpnIC25MqX+sa2JYwoeMKL2QvFl4Qr
         X72bnGSR29dAgODAh6dO3qqHApSA1+9zQfgcqttGmLEMTbv78RLcReQrqepRho+ArLuA
         MW8oa/ZQnML6MkocYH5eUUYewNwdigcbJgW+bFtZfBOCX7r4hmxojR7uBLseFaUSEGM5
         ypUierA34oKQSjpPe160zDSi1ZyVhuHCcSKUTbnJSfy8soElW5qdGfsFT3X73MQcaI/m
         3Cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bYjyZqTOCDrHGRUL1z+4uli9h7x1fnPSctKijzCSXr0=;
        b=q7Q8fR2ywTFZdkXTMBWPIZ91juLgH/7Ks5+xlJ+KsPuUOJVVXXQM/uTpRrYVHN0pd8
         oE7frBshtiWWgmpGbdEh1EgZn/AoySZal1XBfwkDDJqUAubtorvcLbq/K+BtHYmgL+PZ
         8ZRhvo45NY77qZYmUz7EJ4E04CW3h2foE2J2rH106Qb7W8845Nj4AgT7TYs4yAxaVSa4
         mGCJ4WnTdwBGfYBHdnimcReoXG/kQd36RT6MTmYyh+gMyCG63ieSmAxlp+1yWtPViUfK
         X5ymD1CdO2axSULwuJKu4CXgxvqMHkCjDhsGsp+NSJ6dY4Utso+P5vZSDSv53GEUSrKS
         0I1A==
X-Gm-Message-State: AOAM532iv+9N09vysRvRbB6feBTvkp4koghLS9eb/y8g1DcT4w1Ud2OO
        OqHDgOikgjVHeqslzILCj5L1TQ==
X-Google-Smtp-Source: ABdhPJzRqnPEcPEIjw03o9yRzMcpx6hV/aMFcS9wdjaevAzbjlpyvPMzBWIJjI39XBmyteWco+RbTQ==
X-Received: by 2002:adf:df83:: with SMTP id z3mr2364988wrl.23.1605262370933;
        Fri, 13 Nov 2020 02:12:50 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id d134sm9496169wmd.8.2020.11.13.02.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 02:12:50 -0800 (PST)
Date:   Fri, 13 Nov 2020 10:12:48 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     michael.srba@seznam.cz
Cc:     Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: rt5033: fix errorneous defines
Message-ID: <20201113101248.GD3718728@dell>
References: <20201110130047.8097-1-michael.srba@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201110130047.8097-1-michael.srba@seznam.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020, michael.srba@seznam.cz wrote:

> From: Michael Srba <Michael.Srba@seznam.cz>
> 
> Fix regulators on rt5033 by converting some values to bitmasks which were 
> errorneously not defined as such in the header file.
> 
> Cc: Beomho Seo <beomho.seo@samsung.com>
> Fixes: 0b271258544b ("mfd: rt5033: Add Richtek RT5033 driver core.")
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> ---
> 
> Tested on Samsung Galaxy A3 (sm-a3ulte).
> 
> Other areas (e.g "RT5033 use internal timer need to set time") still look
> suspicious, but without access to a datasheet it's unfortunately hard
> to evaluate. Moreover, these values are not currently utilized so it's not
> clear what format would be expected. (it's however hard to argue for
> the removal of said values, since with the datasheet not being publicly
> available, this file may be the best documentation of them)
> 
> ---
>  include/linux/mfd/rt5033-private.h | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
