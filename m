Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9692D187D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgLGSYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 13:24:42 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34568 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgLGSYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:24:42 -0500
Received: by mail-oi1-f196.google.com with SMTP id s75so13369267oih.1;
        Mon, 07 Dec 2020 10:24:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uhGGwifVcUwyCm7WVKGoiGf+4psGN+/N4Ysq2EKKe64=;
        b=Hn1VikQLlh3iYDfj2NBP8E8e4Z1EeVX25UGXNcIn73XwdfrzIx6vPB/KyrXz+2SxDs
         LckJt/8Fs6KL1DiYfedffA0AcQYDTB4IBMnkRmXVn/ezbAB8QLkzkt/JxSjZiOLGLW+B
         UFHQekHWmloRGi3Jf6Wcey4mx6a8f0+/iWQym1C5nDOEWfyQj/1wYZW4k/+SXva+4AmE
         a1kT822m3HySeXSixu42iGRvgE7T94zL8VyDiqSlrqvNPCcheKcBZeJsmLt3IU+RX9DH
         NSp/rr0OUVqcLWHj1JqS4NnjpVF8Cor5mjrfZCEsXOiVBe+QGvJJQQyN5Tgn/hMywrvG
         SV8w==
X-Gm-Message-State: AOAM531WtShH3/JvMgBq71aq81hRNmCxmjk8Segfk98BncVdKsi9kzxL
        ACAqaabx4ghEUy/crnQz8w==
X-Google-Smtp-Source: ABdhPJxoc9Tw7cfX5haN5Kiflo15YdVSaXGkm9Nwgrotk8GgVy/dp4rL8kkPjiAY8D/LBNmK2ZfAxw==
X-Received: by 2002:aca:db06:: with SMTP id s6mr114603oig.52.1607365441384;
        Mon, 07 Dec 2020 10:24:01 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v12sm2719149ooi.46.2020.12.07.10.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 10:24:00 -0800 (PST)
Received: (nullmailer pid 565992 invoked by uid 1000);
        Mon, 07 Dec 2020 18:23:59 -0000
Date:   Mon, 7 Dec 2020 12:23:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: irq: sun7i-nmi: Add binding
 documentation for the V3s NMI
Message-ID: <20201207182359.GA565631@robh.at.kernel.org>
References: <20201206165131.1041983-1-contact@paulk.fr>
 <20201206165131.1041983-2-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206165131.1041983-2-contact@paulk.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Dec 2020 17:51:27 +0100, Paul Kocialkowski wrote:
> The V3s NMI controller seems register-compatible with the A80 (sun9i).
> Add new items for the compatible string, with an entry specific to the V3s
> and the A80 entry.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  .../interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml       | 3 +++
>  1 file changed, 3 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

