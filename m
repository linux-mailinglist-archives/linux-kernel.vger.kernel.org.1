Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003142D50C5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 03:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgLJCRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 21:17:12 -0500
Received: from mail-oo1-f67.google.com ([209.85.161.67]:44341 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbgLJCQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 21:16:33 -0500
Received: by mail-oo1-f67.google.com with SMTP id n20so915534ooq.11;
        Wed, 09 Dec 2020 18:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kig++s2HW24HAPkqPX1OgjRI23AmXcrz8TrgPWK8wUA=;
        b=FYHqV+KL91p3tDkroOCK3cGZh8kejy487noAJTnaJ6khrXP+Zkizl9AJ5Nty3uss33
         g2fvqzMAnrU0A/NkEax5PtcHKT7kddkmxYOfBDj5QPVyPAG7nl2heQEhmFVh+zj/Dsi/
         HTHqX92rXDmsC7MN5NXKffLS1V1NRwHXkU5jCt6Ew4JJsnls/IP/0uPVjfCURBL3eJ1d
         SbCTCBAEV+7kwj0R8P689Fzx6fzUuLjuYO+mx36gBMSDli9dKg14v8SjDs8uFE8tA6nA
         sjYWaBcVjMdw4V8fuDnUcCaIIIOebharuAR8KOR4xyVJ9qQMHqWkgseDCKoFzDPz+dgG
         LkVw==
X-Gm-Message-State: AOAM530HjpSppjgCUVXhjq6KV0wCdDgzXXFkSmOZ7OYXg1B9ozIZHIM6
        beRaUyTwpW/tJazE3/DQ9hG2l7upWQ==
X-Google-Smtp-Source: ABdhPJwT1EYRtwvWlEwB64Z4MD4vnsrU10z1MOaFcXuH8IyRQ02iULJwh8Qn9dR2ZrcyXDio8612Zw==
X-Received: by 2002:a4a:aac4:: with SMTP id e4mr4420261oon.2.1607566552359;
        Wed, 09 Dec 2020 18:15:52 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k13sm836582otl.72.2020.12.09.18.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 18:15:51 -0800 (PST)
Received: (nullmailer pid 1498781 invoked by uid 1000);
        Thu, 10 Dec 2020 02:15:50 -0000
Date:   Wed, 9 Dec 2020 20:15:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     broonie@kernel.org, kuninori.morimoto.gx@renesas.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: audio-graph-card: Drop remote-endpoint as required
 property
Message-ID: <20201210021550.GA1498001@robh.at.kernel.org>
References: <1607498532-19518-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607498532-19518-1-git-send-email-spujar@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 12:52:12PM +0530, Sameer Pujar wrote:
> The remote-endpoint may not be available if it is part of some
> pluggable module. One such example would be an audio card, the
> Codec endpoint will not be available until it is plugged in.
> Hence drop 'remote-endpoint' as a required property.

Please hold off on this. I have more changes coming.

> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  Documentation/devicetree/bindings/sound/audio-graph-port.yaml | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
> index 2005014..766e910 100644
> --- a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
> +++ b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
> @@ -71,9 +71,6 @@ properties:
>              description: CPU to Codec rate channels.
>              $ref: /schemas/types.yaml#/definitions/uint32
>  
> -        required:
> -          - remote-endpoint
> -
>    ports:
>      description: multi OF-Graph subnode
>      type: object
> -- 
> 2.7.4
> 
