Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B9F292F48
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 22:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbgJSUTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 16:19:34 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36764 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgJSUTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 16:19:34 -0400
Received: by mail-ot1-f66.google.com with SMTP id 32so986412otm.3;
        Mon, 19 Oct 2020 13:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pFVYwGbvjYZt+Y4dMIuBZyDTcqeFVg/W+aboOI0kneE=;
        b=LJzCgKdlr4zYudKkE0IiQKkn1x3ECR/LtzP3cN+T82TpY/SCUznraKDU7JLuZIwLny
         vNXICzkFg26S8fL69Lan0pBLcQ97hm1l5sLhiC+TVxkXh7eo86Ofs3L/rL/6noaEBlGk
         F7NgofXnpAEEHyKNRIzMEsDuhgS03qAuunoMse0NuehcFCmkyY3vb0oveH9L6fUzeD0I
         9LwIY9YDIOsHp+ncmoN8rKav2o2BdWHXWeqNAYZ4IiDvELjW5AMc2w9BAYXjQEFdJKHk
         TIWLtJzY9mzLfNKZK9IPoHOGwdcPUiCxQt/wW5arZ+3HwsZisi8Tux6jP6GKbkpHVw9a
         4iiA==
X-Gm-Message-State: AOAM533WUF8isSKFbs+W7zoz9NExfJefDwP8XJUaIszDYJxL78umRBzE
        wvgQKUBXhzJ6ueIsuz8BaQ==
X-Google-Smtp-Source: ABdhPJwm2sKEGxPab15bFqC6e+o7TbvNrDHGFHRmbMQUStLT4Ap7CjBmb2W2nZ028uxLLQLn4TxnyQ==
X-Received: by 2002:a9d:3b84:: with SMTP id k4mr1297034otc.4.1603138773193;
        Mon, 19 Oct 2020 13:19:33 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z10sm186841ota.70.2020.10.19.13.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:19:32 -0700 (PDT)
Received: (nullmailer pid 3539290 invoked by uid 1000);
        Mon, 19 Oct 2020 20:19:31 -0000
Date:   Mon, 19 Oct 2020 15:19:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: Add support for Broadcom USB pin map
 driver
Message-ID: <20201019201931.GA3539237@bogus>
References: <20201012200007.8862-1-alcooperx@gmail.com>
 <20201012200007.8862-2-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012200007.8862-2-alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 16:00:06 -0400, Al Cooper wrote:
> Add DT bindings for the Broadcom USB pin map driver. This driver allows
> some USB input and output signals to be mapped to any GPIO instead
> of the normal dedicated pins to/from the XHCI controller.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  .../bindings/usb/brcm,usb-pinmap.yaml         | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
