Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638132B0983
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgKLQHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 11:07:49 -0500
Received: from mail-oo1-f65.google.com ([209.85.161.65]:42085 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbgKLQHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:07:48 -0500
Received: by mail-oo1-f65.google.com with SMTP id g4so1428583oom.9;
        Thu, 12 Nov 2020 08:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u+fc+jZoo4rryAb6EXgFaAApuHJmifAKwrkVc68Jfnc=;
        b=Z1uuRBY6IB/XAZSiwCylW8Kx5GiJRey+PBr4HjGtEKx4naHSdVKyUHrIi0DKFCk/zW
         nixW21DBFMPizTlsAAR8HRr32T01OOuaIoJXZV3K6oIBhYAhP6Vo1K580KERmaITEZSu
         OwV9cgPH0JmL9B7p/o0afMldUIMDBbQB0aw2eFujkykK4L6KcgLO7gi5eVXDcxoWEeve
         yE5n3Hs5anr4NNZ8wea/FmRzUFIEVsmgVNfOglYkd6Ywv3ev8caFFKPl4Qq5fjmTEjKm
         f7CYskcECxlGLjosqenKYNk74OPOru/ZYei0pcDdFeAGPa4jJSwiqUa/pXDnVF67pjFh
         4yNQ==
X-Gm-Message-State: AOAM530c444ahbQ+om5NFAULRZgoND1LbXwEIbVHTmaIeyZVVxUN9W9A
        phWTyZY8raQdWZgqZEugRkg9XmboLw==
X-Google-Smtp-Source: ABdhPJwIgA6W6Kn5XcmLSnjP3jXT6JXWKJfF+QPpkH57f9faLQ3g9lYAoE12cGCNrp8Ih5IU7Kq4zA==
X-Received: by 2002:a4a:6b1a:: with SMTP id g26mr21465516ooc.13.1605197267992;
        Thu, 12 Nov 2020 08:07:47 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j16sm1360618oot.24.2020.11.12.08.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 08:07:47 -0800 (PST)
Received: (nullmailer pid 3683064 invoked by uid 1000);
        Thu, 12 Nov 2020 16:07:46 -0000
Date:   Thu, 12 Nov 2020 10:07:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     broonie@kernel.org, kuninori.morimoto.gx@renesas.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: renesas,rsnd: Update audio graph references
Message-ID: <20201112160746.GA3681609@bogus>
References: <1605097613-25301-1-git-send-email-spujar@nvidia.com>
 <1605097613-25301-3-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605097613-25301-3-git-send-email-spujar@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 05:56:53PM +0530, Sameer Pujar wrote:
> Since audio graph schema is refactored now update the related
> references here.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  Documentation/devicetree/bindings/sound/renesas,rsnd.yaml | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

This should be part of the first patch. Things break in between.

> 
> diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
> index 51f4dca..fc2ae22 100644
> --- a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
> +++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
> @@ -112,12 +112,10 @@ properties:
>          - pattern: '^clk_(a|b|c|i)$'
>  
>    port:
> -    description: OF-Graph subnode
> -    $ref: "audio-graph-card.yaml#/properties/port"
> +    $ref: /schemas/sound/audio-graph.yaml#/properties/port
>  
>    ports:
> -    description: multi OF-Graph subnode
> -    $ref: "audio-graph-card.yaml#/properties/ports"
> +    $ref: /schemas/graph.yaml#/properties/ports
>  
>  # use patternProperties to avoid naming "xxx,yyy" issue
>  patternProperties:
> -- 
> 2.7.4
> 
