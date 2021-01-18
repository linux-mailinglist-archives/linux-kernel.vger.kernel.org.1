Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8622F9DDE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388951AbhARLSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387914AbhARKrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:47:00 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CB4C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:46:17 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l12so10738600wry.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+fkffY+nPqGD3vYic1AfpbGuHGz6tUdaM1VMSnDCxTM=;
        b=eg6HqEaviaXtmJLqNG0sbWZO58l9omPjV2/Yf+1OWKiXo2xQfIY3haYyAYjYyOCZk3
         3fVnpqsVfaW14kqGbl8zwW1AUDPssaRsVg1j/mJodMaA9R6dE4o7eW9XiIXHkJrWVL/7
         XeEzy9sN/QjDOOYPniuzLHg06bw3oXf7qTEYTWfGRngw9kht7v6r1k2Liv91uWLynABR
         o7bfJE4qDpQUTNmaPNjJe5K49oWyX8HjFecW1QRfScIlw5pkyk5LYaNGRXToH1d4fHbr
         SynCXSvir5+2SVwVvM7IE3/3ZkLtkvOSvgXRl6cIpf7ubRURKqu2h1T7mArmkXZGBSmf
         XVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+fkffY+nPqGD3vYic1AfpbGuHGz6tUdaM1VMSnDCxTM=;
        b=ALSZCysJeOPut8JmVZRo4Dto4dNkYSOIGNQqf+iWSr5RCqPS2DVwHwh3AwWKE3YoDn
         1PYtm3+iM2sPEtw2ate8u/Vb6aKMHudnHuDdb6lSjBjWYOVIn538e+8xilKJqDKmcO5U
         nZVKGTQqTpwIFTmXZOpNVqVAjA8BH99FTSPpp+LaPauKsH2ygwd67Oc/ln7/iI0UMc01
         g350sHFrlOuHE+e+GtTTqz/4b7+2bunXhZt3naOVPqeZlPy/ZfsrGJSWYUaPThQlxYoW
         i74LY7PA8gnaKdwNuQFh39FmtM6PKRQ4yzANiHLQ7DQDeTjXTlxbd3RsTzBx9OyN7Xi9
         2MGA==
X-Gm-Message-State: AOAM532jfGetuLayDFIWquJ36fAjp5UfZy0MW9H0upm3T+fi3Dojiqu3
        NRLZgSe6iJE2M77HleEXG35+mrtiV0aO+3KC
X-Google-Smtp-Source: ABdhPJzUDa5H9rvD47XC6RgKN8RmkNCjX7fOcG4ws8rg8O6vdS2h6s7hb0qR4QqfcY1T3hqI0qxp/A==
X-Received: by 2002:a5d:6a4f:: with SMTP id t15mr26079176wrw.62.1610966776009;
        Mon, 18 Jan 2021 02:46:16 -0800 (PST)
Received: from dell ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a12sm32467478wrh.71.2021.01.18.02.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 02:46:15 -0800 (PST)
Date:   Mon, 18 Jan 2021 10:46:13 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: intel-lpss: Add Intel Alder Lake PCH-P PCI IDs
Message-ID: <20210118104613.GC4903@dell>
References: <20210105153925.62283-1-andriy.shevchenko@linux.intel.com>
 <20210114102220.GS3975472@dell>
 <20210118103035.GY4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210118103035.GY4077@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jan 2021, Andy Shevchenko wrote:

> On Thu, Jan 14, 2021 at 10:22:20AM +0000, Lee Jones wrote:
> > On Tue, 05 Jan 2021, Andy Shevchenko wrote:
> > 
> > > Add Intel Alder Lake LPSS PCI IDs.
> 
> > Applied, thanks.
> 
> Thanks.
> 
> Any news about [1]?

It had fallen through the cracks.

Now applied.

> [1]: https://lore.kernel.org/lkml/20201027104616.49098-1-andriy.shevchenko@linux.intel.com/

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
