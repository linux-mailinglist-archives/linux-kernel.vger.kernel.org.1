Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AAE2D6ECB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 04:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405236AbgLKDlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 22:41:17 -0500
Received: from mail-oo1-f68.google.com ([209.85.161.68]:40288 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395181AbgLKDkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 22:40:36 -0500
Received: by mail-oo1-f68.google.com with SMTP id 9so1828656ooy.7;
        Thu, 10 Dec 2020 19:40:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3YRBa4GWgC9YCCY2RPm1FWrdjkivVayRtW3WlD7hVWA=;
        b=o88az5nUF2k9oFTH47YG0OW6rtUAG8e3tkah9GnzqD4pxkeFA+j5ffIlL9IL0r64mn
         jLLYsEqQJgPlibQ2TrYoY3jM2wTbs2Bkri5G0TbmXZKWyMr7d971OvPHRA0d3Gp6453q
         Z9p6dFdnwa7cT/njRd0hpMYkRCl6A9WYItyfRywnymislApaLXI8YNzE40hTkqDdCGkW
         nwHqUTPICw6SR+yHkhEooaVg3W+fZTuzkx1V/hLy4SOP4UtlEX1tkNNIbFl1WhCf+PHm
         zwojBf91IKXr0zrwf6tg2lzzGqttt4jMhHLOVEWl+jkyuPl+JWxUM6aNtkvZLjzQbQOZ
         RqJg==
X-Gm-Message-State: AOAM533Afs0FVfOAah1xtAFxZr/7pWJ0rHxUU40SUkt9uM+mC2q9/OvH
        XM3PzdR/ncXGI05Bbj09Z+5LRtl2ng==
X-Google-Smtp-Source: ABdhPJz2RGYAkn5XHnZhWN8sgGg/r+W+Q8IytRFAldgI1QEQLVVq2wlLaJHq6YkMHtg74T9h0oy4SA==
X-Received: by 2002:a4a:d795:: with SMTP id c21mr8449439oou.57.1607657995066;
        Thu, 10 Dec 2020 19:39:55 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j73sm1581437otj.37.2020.12.10.19.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 19:39:54 -0800 (PST)
Received: (nullmailer pid 3593580 invoked by uid 1000);
        Fri, 11 Dec 2020 03:39:53 -0000
Date:   Thu, 10 Dec 2020 21:39:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Ondrej Jirman <megous@megous.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: arm: sunxi: note that old PineTab
 compatible has old panel
Message-ID: <20201211033953.GA3593536@robh.at.kernel.org>
References: <20201210083722.1912981-1-icenowy@aosc.io>
 <20201210084558.1917246-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210084558.1917246-1-icenowy@aosc.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Dec 2020 16:45:58 +0800, Icenowy Zheng wrote:
> As the old LCD panel used by PineTab developer samples are discontinued,
> there won't be furtherly any more units of the sample, and this should
> be noted in the document.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
