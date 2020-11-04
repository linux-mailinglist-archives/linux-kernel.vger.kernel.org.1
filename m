Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FD42A67DE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 16:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbgKDPkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 10:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729992AbgKDPkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 10:40:09 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E208CC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 07:40:08 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h22so2762553wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 07:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wep9eHIlHmt9345GeonA3mlm93DwH2S4gpNglLx7w/I=;
        b=MxLEJVVqf/UWjuxQqDE7m/MC1xrKr/vmmDW7S2f4+oE4dqHNfSTeiVwhu2LvHCyqSg
         cIQovCeOxuYkjFDnU38UiZbpq9mLg1FaMCyClaL8xAbQLIldhy/TdU5/AMdcSuTreYht
         zWvrGGotrXjF5i3vNEFNYHemFmLncCiBAn37cqTRUXfShys9k2NWUcBEIFAVSVQcq3nd
         0CPfUxC1O5Osk+06teqg8aE6/Os33n+3XG6+IbCDL67+vXLfZ+pNWI2RofrTWLTUr5Sa
         9G5CIdHdPHyaLCIBBhJdehSN5PZFyBxiBsYjCc2eWaQUYxm+s1/wyXa398lONNNz7dYt
         QtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wep9eHIlHmt9345GeonA3mlm93DwH2S4gpNglLx7w/I=;
        b=uCxCqWXi3qMHl17SiUlJFipvODBsk29ZZ9i6UuvbMzYjfcXyTP2cdRvLhK69CKFepW
         r2Wl9yBOjiboACqvgRFmHNFrlz72xv4JYoX2pk7pwHAzc+DIHeLg6CEXJMqjd2KDAhTO
         Q+ihnOKe7bleUq21kUM6+LLcoI9gm0oTk+xhIv8opUSZCrP4XcLEiuQ0+FU24jO6UsPZ
         1kH1cNmPv00evOw9lylWghyo+0c7wqqOZVG9F0Az5J2Xoj5BPCTKG9j0da8c3IuhyqYv
         3IdoxcrT00jVdIzzOcgdbPCFYPt3Ix2d89I6BopzrLYdPyIjvenfT4vBWRoRp2HzSRRR
         Za2g==
X-Gm-Message-State: AOAM531auOYtZx6cJ+6s/ZvUdjw//E5qTkNKNDbhCncReIN9bK6NLWEs
        DECDuKAKU8Wb7M7G8l8u1XN/6EF82TbY4iyR
X-Google-Smtp-Source: ABdhPJxlOHljiEnt3GDydsV/OEjm43XGIwK18G3+FSOhlvM6g73pTtGZhTVIW3rJaRcdqYOaq1+KNQ==
X-Received: by 2002:a7b:c157:: with SMTP id z23mr5214407wmi.70.1604504407665;
        Wed, 04 Nov 2020 07:40:07 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id j71sm2807895wmj.10.2020.11.04.07.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 07:40:06 -0800 (PST)
Date:   Wed, 4 Nov 2020 15:40:05 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH RESEND 1/2] mfd: madera: Add reset as part of resume
Message-ID: <20201104154005.GO4488@dell>
References: <20201027094132.16472-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201027094132.16472-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Oct 2020, Charles Keepax wrote:

> The DCVDD supply does not always power down when the CODEC enters
> suspend, for example shared regulators or always-on regulators. In
> these cases if a register is written back to the default value whilst
> the CODEC is in suspend that register will retain the previous value.
> As DCVDD never powered down, the register retains its old value and
> as the cache sync only synchronises registers that differ from the
> default the new value is never written out.
> 
> Ensure the registers are in the expected state after suspend by always
> resetting the CODEC on resume. This also has the benefit of being
> recommended by the datasheet for DCVDD supplies that take longer than
> 2mS to rise.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/madera-core.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
