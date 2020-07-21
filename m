Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986B52284FA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 18:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgGUQKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 12:10:03 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39735 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgGUQKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:10:03 -0400
Received: by mail-io1-f66.google.com with SMTP id z6so4496358iow.6;
        Tue, 21 Jul 2020 09:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5vZnPunGzHzcF0JaBHQsiLzx0dizWC0QJDWGM3L9f5c=;
        b=Qe6l6ChpgZQSHZx99WDVTCgXFqWMSt1vF3QN7sXtysHW0sUBUM29JDgig2QOlB/8em
         mRIgUrnvKNT2m4i7kFeexRcC/zTDD7fXcu/JX8lDuYLZigNMrRpgsWp/L7iz3qhxPELp
         tC2AsQSL4Ggn1b0b2Etf5dGrvmbkj/UDBNZVtWEiaN5XqlGbeU8mzEcxTJ1L07BDyxi7
         MXcTYKtbGZkrEyewIEn/EgInBp6lwK8dakaISqoH1fyc7dlOm7nVyW/BnhFY3IDFQb2A
         U8CutkE/Fj41G8euYJcOd7dDkT4GGr1Ug5EFxwn/HcoJm19AYsPXfIvaPsrotp8UXVjp
         fuHA==
X-Gm-Message-State: AOAM533QJzvS036bwFA0x/0R6LxEOx4wPEk3mcac0+rU8zqUnpqh6YUT
        ya4g31VdNEG5KWqwHZDp6Q==
X-Google-Smtp-Source: ABdhPJw/GMPRXuRPapKDmiimXNT1feeBi8f4deFqtacLZt7Z7EGOGgBWwTEEUTrlaQ4Q9UqmXfWaCA==
X-Received: by 2002:a6b:7210:: with SMTP id n16mr28740129ioc.177.1595347802108;
        Tue, 21 Jul 2020 09:10:02 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id d6sm10604898ilq.27.2020.07.21.09.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:10:01 -0700 (PDT)
Received: (nullmailer pid 388371 invoked by uid 1000);
        Tue, 21 Jul 2020 16:09:58 -0000
Date:   Tue, 21 Jul 2020 10:09:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     robh+dt@kernel.org, dri-devel@lists.freedesktop.org,
        krzk@kernel.org, sboyd@kernel.org, paul.walmsley@sifive.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel@ffwll.ch, airlied@linux.ie
Subject: Re: [PATCH for v5.9] dt-bindings: drm/bridge: Replace HTTP links
 with HTTPS ones
Message-ID: <20200721160958.GA388320@bogus>
References: <20200719174457.60674-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719174457.60674-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jul 2020 19:44:57 +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely
>  or at least not (just) HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
>  Sorry again to all maintainers who complained about subject lines.
>  Now I realized that you want an actually perfect prefixes,
>  not just subsystem ones.
>  I tried my best...
>  And yes, *I could* (at least half-)automate it.
>  Impossible is nothing! :)
> 
> 
>  .../devicetree/bindings/display/bridge/ti,sn65dsi86.txt         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
