Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F09228510
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 18:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbgGUQNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 12:13:22 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:41873 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgGUQNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:13:20 -0400
Received: by mail-il1-f195.google.com with SMTP id q3so16871086ilt.8;
        Tue, 21 Jul 2020 09:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3hEvd6e5qQIyO2q50icuN5FjIQ5q4rwekadksksXza4=;
        b=FoSg4oj+xbTGpENAvqh3FefVJNVTa9QVT++v1Ohdv0D7Mom9ootnHgLnly9OexqzCq
         9Rdt6NX/uBHLHHyoXMs5ZuPa/um7y8pyxCzU2D4RlrmbsqDa3N1l3Sy+BtN9qyAyYdpo
         xSJ9ZBJjYadFSZHKk3mOm9E0RG4G+TWvDVUjvMti1PB+xBmEp9OJ9aPWB7/2Mc1cER5j
         hTUcPusuTclHm/4Ifr9Wy89X0o0k82uBR2e6MDmBhpdnkQQhUg4Jk/KlI7zmSrZYpUSN
         il+3AricB2ispAV8va/eVCI+skzwZz/sgJ/RFB2ZznV6KuObzFHmL/HlsFDNsenCT7dd
         lKoA==
X-Gm-Message-State: AOAM532zQ3YonK9v2ApmJg0V0JvAmHAGfSTcrduaomVJ9VxqqN7RU02M
        PAn96CyF3B0DR0+y/ibVLw==
X-Google-Smtp-Source: ABdhPJwZyjj1eCmbDB8qodPjQFtYDmTZBEcJbwfaZKYhQLlgyU4nhZLjz4sJOcRtVBR5wxuFep/Rtw==
X-Received: by 2002:a92:58d6:: with SMTP id z83mr28467802ilf.186.1595347999985;
        Tue, 21 Jul 2020 09:13:19 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b14sm10999389ilg.86.2020.07.21.09.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:13:18 -0700 (PDT)
Received: (nullmailer pid 393136 invoked by uid 1000);
        Tue, 21 Jul 2020 16:13:17 -0000
Date:   Tue, 21 Jul 2020 10:13:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     robh+dt@kernel.org, andrew@aj.id.au, joel@jms.id.au,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lee.jones@linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: aspeed-lpc: Replace HTTP links with
 HTTPS ones
Message-ID: <20200721161317.GA393067@bogus>
References: <CACPK8Xc_iwvRtUVjY8G8rS8UbZf6-Q6FTGaNweJXk06A=Y459Q@mail.gmail.com>
 <20200720212110.64214-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720212110.64214-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 23:21:10 +0200, Alexander A. Klimov wrote:
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
>  v2: Left only links to be only HTTPSified.
> 
>  Documentation/devicetree/bindings/mfd/aspeed-lpc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
