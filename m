Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC0B26B198
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgIOWdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbgIOQRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:17:15 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0587FC061A30;
        Tue, 15 Sep 2020 09:15:14 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u21so3341739ljl.6;
        Tue, 15 Sep 2020 09:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oDmwZqV69ONfDlP5WkAsuibEHA5OimwIA2UcgWGM9tY=;
        b=Ln7C0LzIknZfvK3onMWkZDezxGy8+BvyqOBTBe4pH7X5j6N6dbeSEetYtfct3AY9Te
         3r3dV/KOffGDN7VNdsIfTTS4vyWiLTcI/vRm3C06lx4Vq171QMVBhMNva9Wa7YWBB44i
         QRGSf/QrFsV7RjhihAqcpcA6pLQ0pmOCoNmWYjiAat1QkeK7T6bhcp4rUEpfz1ebpvdN
         EPm89o1fXcon8YhNLk+pLrXxgNhS5sXOLkcI/7BKQpSyCgMtuRy8xgqz/NCjWD8oYTjH
         mqNtJjasPPPPDR9krXG7oYR/ob2Smk01TgcTx7DiaLI0xuJtvWXzmK4x1IXumNKi6TR3
         leGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oDmwZqV69ONfDlP5WkAsuibEHA5OimwIA2UcgWGM9tY=;
        b=pWXcnr/82ipHC0n7Wm4g9oq9rs8PszkPqz3cJ6sXhHhCL5JKsze6LUXylLgaPq0IMk
         MgwS3pPr87/YLbof06lhNMMDrOxTk/obpnzKWwaTFfuG9fRj/auM/B4E+Fm9WDVdnpGD
         wWU203pIbBuzFeEq2J/Cx56B43feGc1ud+9jd44RyXwZPOtLuW23/1pnwxjOIHhcLgMs
         J7eeIQGlsJXeyOJ71lsaaH+Hm252tD6SUkt5gjIiLBEZZgEnN1Al7h/M/RAWlRaLCP+6
         j1MIAX6cUOcOZYj9+3FGBwcVKgTQLM2dgFKWPAgHRhZYnlpSVJJdsNpJOCrwCToNu4xs
         sxZA==
X-Gm-Message-State: AOAM5330isw+ZuuLW+6/bBsTzg/lPQtTyJcyRquIUTBXIZVlPVxDY5It
        /0/IDDYwbA5bhcRJKFv3H8zrCml+QzBFlA==
X-Google-Smtp-Source: ABdhPJyRIxD4Fa1CsUoi3GwfVw9/SasDPCay69suX7DD07Z92Pf/ekdBRCTI1PWOOkU0Ucn5gVba9A==
X-Received: by 2002:a2e:8616:: with SMTP id a22mr6595908lji.466.1600186512213;
        Tue, 15 Sep 2020 09:15:12 -0700 (PDT)
Received: from wasted.omprussia.ru ([2a00:1fa0:42d3:da34:6ad8:5c64:8a52:942b])
        by smtp.gmail.com with ESMTPSA id b141sm4076671lfd.236.2020.09.15.09.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 09:15:11 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] dt-bindings: usb: cdns,usb3: Add
 cdns,phyrst-a-enable property
To:     Roger Quadros <rogerq@ti.com>, balbi@kernel.org
Cc:     pawell@cadence.com, kurahul@cadence.com, nsekhar@ti.com,
        vigneshr@ti.com, robh+dt@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20200915114543.2599-1-rogerq@ti.com>
 <20200915114543.2599-3-rogerq@ti.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <1b45d695-0874-69c7-8398-5d14033f0788@gmail.com>
Date:   Tue, 15 Sep 2020 19:15:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915114543.2599-3-rogerq@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 9/15/20 2:45 PM, Roger Quadros wrote:

> Controller version 0x0002450D has USB2 PHY RX sensitivity issues
> that needs to be worked around by enabling phyrst-a-enable bit
> in PHYRST_CFG register.
> 
> There is no way to know controller version before device controller
> is started and the workaround needs to be applied for both host and
> device modes, so we add this DT property.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/usb/cdns,usb3.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
> index 9b14c8443d39..ac20b98e9910 100644
> --- a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
> +++ b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
> @@ -61,6 +61,10 @@ properties:
>        buffers expressed in KB
>      $ref: /schemas/types.yaml#/definitions/uint32
>  
> +  cdns,phyrst-a-enable:
> +    description: Enable resetting of PHY if Rx fail is detected

   Failure?

[...]

MBR, Sergei
