Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231022DA1EF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 21:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503123AbgLNUs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 15:48:59 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34429 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733110AbgLNUs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:48:58 -0500
Received: by mail-oi1-f194.google.com with SMTP id s75so20761560oih.1;
        Mon, 14 Dec 2020 12:48:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KjFGVZd72pXYoR/y+HMGePZrAg7DWAslzGxHpf0TdRo=;
        b=q1bCoWKl7yHPTJYBC80RHm4WDeI4yazfHCg18YPmlgIT6rzUq7exiF0VhQaX5oFRTJ
         CWnu9aXwLAuaXA7rI+9GGSv0C0Wh9d9+KYRZrNk28yybCZkBlfaLx2MhsUUwF1EStHIC
         xodE3CbTk4OamlQKKSYX8efxdEDCD6RRKA/wj951zEkW23AVznq5ENTKokZj8hr1G662
         gMXCZcBpa2PCWVjTKBiV8Fgwdbc+hsYnfUNhLAiGdxf0zkq9L/mscmN/wiboAGLsoEMU
         PPozPQVlTnpyQJ6utJxQnhHPq4ei6OReWt3VjsEFp9sZa4ciV5H+6TqWNBIpeJq6Vg8T
         y+TA==
X-Gm-Message-State: AOAM533Ubrd875svU7V5+usftb3d+s+7m1iBS14Ev9Noqq04CUZFGnPQ
        +1D/kJRcnZpXcV1TgXySudFVEsP/yw==
X-Google-Smtp-Source: ABdhPJysSLBGwj8J6AGyRoOcBvSVCOlD/wWCyNt2RmhNbY8v4M8gpszrh6UltONzuXLdEMNcAmSFkg==
X-Received: by 2002:aca:eccb:: with SMTP id k194mr19645940oih.112.1607978897703;
        Mon, 14 Dec 2020 12:48:17 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k63sm4495917oia.14.2020.12.14.12.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 12:48:16 -0800 (PST)
Received: (nullmailer pid 2369015 invoked by uid 1000);
        Mon, 14 Dec 2020 20:48:15 -0000
Date:   Mon, 14 Dec 2020 14:48:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@ti.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: usb: Add new compatible string for AM64
 SoC
Message-ID: <20201214204722.GA2365525@robh.at.kernel.org>
References: <20201214140109.21955-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214140109.21955-1-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 07:31:09PM +0530, Aswath Govindraju wrote:
> Add compatible string in j721e-usb binding file as the same USB subsystem
> is present in AM64.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
> 
> Changes since v4:
>  - used oneOf instead of enum, as the schema has to convey that the strings
>    ti,j721e-usb and ti,am64-usb can be used combined or seperately in the
>    DT nodes.
> 
> Changes since v3:
>  - used enum instead of anyOf.
> 
> Changes since v2:
>  - added changes done over the versions.
> 
> Changes since v1:
>  - replaced the '\t' at the beginning of the lines with spaces as it was
>   causing the dt_binding_check to fail.
> 
>  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> index 388245b91a55..21e51ceca293 100644
> --- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> @@ -11,8 +11,12 @@ maintainers:
>  
>  properties:
>    compatible:
> -    items:
> +    oneOf:
>        - const: ti,j721e-usb
> +      - const: ti,am64-usb
> +      - items:
> +          - ti,j721e-usb
> +          - ti,am64-usb

               ^

const needed before the strings

>  
>    reg:
>      description: module registers
> -- 
> 2.17.1
> 
