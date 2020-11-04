Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB072A70B1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 23:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732506AbgKDWja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 17:39:30 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45754 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730774AbgKDWj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 17:39:29 -0500
Received: by mail-oi1-f196.google.com with SMTP id j7so23909126oie.12;
        Wed, 04 Nov 2020 14:39:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bsqnljYYWE1/ltBUbXEHDTzwBF2aGmIwEaiz3OENEGY=;
        b=hL+k6POJHX8vwXDYvAaLJivxScvAN6VMCTB0pVwVsCBX/B0E5bGud6//rUN6iBZ9mm
         f2TNf9/kSqCNj1ajA92dsbF8C2MqaMrVrlm68tge5gyg6vjzQ9pETVzKOb5Us7bHfHvq
         TvX+fW0DvXfgHNEW53B5FCBO81rV+9ELd4d4KoPyJ680yCGl4WA2AUlpTVnFGogy1wAR
         GNaZWrjjKNgkzlg5dqGVgsQCf9qaQUlpAnXfmTDZtVU98zGHjrz9JQJzJAarxfslKBdF
         qdVudXD/szLkW4ZbchhnJ04Gg2lSUQyutCe6ItXsrMe+zvBzW4q8AtqeWx6Eb78naizo
         qJRw==
X-Gm-Message-State: AOAM530N+A8Paas/5QknsKG0gFyiqdblR/RcjFRgl8INmmAQuNwDHws3
        SltqRpJpHgN/Cx0QmbJ2eA==
X-Google-Smtp-Source: ABdhPJypEFa58WXrfW91mJuemRTt3L2mShRt4pLpp+QEwsSfI2kknkg7HTzTjj9ChwihNYFdu8X4jg==
X-Received: by 2002:aca:fc02:: with SMTP id a2mr27503oii.90.1604529568215;
        Wed, 04 Nov 2020 14:39:28 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z19sm261558otm.58.2020.11.04.14.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 14:39:27 -0800 (PST)
Received: (nullmailer pid 55216 invoked by uid 1000);
        Wed, 04 Nov 2020 22:39:26 -0000
Date:   Wed, 4 Nov 2020 16:39:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ainge Hsu <ainge.hsu@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb: mediatek,mtk-xhci: add
 keep-clock-on
Message-ID: <20201104223926.GA54259@bogus>
References: <1604301530-31546-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604301530-31546-1-git-send-email-macpaul.lin@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 03:18:48PM +0800, Macpaul Lin wrote:
> Option "mediatek,keep-clock-on" means to keep clock on during system
> suspend and resume. Some platform will flush register settings if clock has
> been disabled when system is suspended. Set this option to avoid clock off.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> index ea696c8..a956dde 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> @@ -104,6 +104,12 @@ properties:
>      description: enable USB remote wakeup, see power/wakeup-source.txt
>      type: boolean
>  
> +  mediatek,keep-clock-on:
> +    description: |
> +      Keep clock on during system suspend and resume. Some platform will flush
> +      register settings if clock has been disabled when system is suspended.
> +    type: boolean
> +

This should be implied by the compatible string.

>    mediatek,syscon-wakeup:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      maxItems: 1
> @@ -175,6 +181,7 @@ examples:
>          imod-interval-ns = <10000>;
>          mediatek,syscon-wakeup = <&pericfg 0x400 1>;
>          wakeup-source;
> +        mediatek,keep-clock-on;
>          usb3-lpm-capable;
>      };
>  ...
> -- 
> 1.7.9.5
