Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8690322B29C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 17:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgGWPdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 11:33:37 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34544 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgGWPdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:33:36 -0400
Received: by mail-io1-f65.google.com with SMTP id q74so6700648iod.1;
        Thu, 23 Jul 2020 08:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ge+pWdg+Toeqp3bSA1KgQjI8Zmp56KH/a+tvzolN8yI=;
        b=K5+blPN91/mTsPX9a2yV7ExoVqQF1NF+i3ZkD2aUJfOh52JWrAm0kj08JP3BoKtrop
         3WAIWWNrDQqaSEujndXaY31f3IuKLaBKB3ivcicFoBImspUUfUMHFgg6v9J01or/k5W0
         Q/bmgrewRsCh6/eapjtTWX7/hfS3P5522Embsasyo1bU83NBXEndt6e7oafd33tqbkix
         VZn51dc6pWz6Conlcprz91jKuA0DPfYAlPkioE600LPG3ig/r9fIe5IC7MlE1V2Jx01g
         vPDPI7CqN4mq4em0D6B11V4nMbVcCsufOueX+mJgmOamkOAem8+SLreO2Lv+SmvDsFJS
         YVKg==
X-Gm-Message-State: AOAM530z+JEqkq3XSxEnPhxe8TU2Tv2kfybhy57GzcZIloTkh+l1lhrx
        OWfzv+PgQMKA3U+aKdr9lA==
X-Google-Smtp-Source: ABdhPJwBy8wFjjv8KG4HasLW4CnpKcT+XNgxoLZ2WOOzGZ0RjayRagVj5gTPdhA/BivvFyGaYjbZNQ==
X-Received: by 2002:a6b:6d07:: with SMTP id a7mr5465452iod.166.1595518415792;
        Thu, 23 Jul 2020 08:33:35 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id d16sm1524807ill.47.2020.07.23.08.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 08:33:35 -0700 (PDT)
Received: (nullmailer pid 412626 invoked by uid 1000);
        Thu, 23 Jul 2020 15:33:31 -0000
Date:   Thu, 23 Jul 2020 09:33:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     a.hajda@samsung.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, nsekhar@ti.com, jonas@kwiboo.se,
        jsarha@ti.com, mparab@cadence.com, jernej.skrabec@siol.net,
        daniel@ffwll.ch, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        praneeth@ti.com, tomi.valkeinen@ti.com, yamonkar@cadence.com
Subject: Re: [PATCH v7 1/3] dt-bindings: drm/bridge: Document Cadence MHDP
 bridge bindings
Message-ID: <20200723153331.GB407329@bogus>
References: <1595403640-12816-1-git-send-email-sjakhade@cadence.com>
 <1595403640-12816-2-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595403640-12816-2-git-send-email-sjakhade@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jul 2020 09:40:38 +0200, Swapnil Jakhade wrote:
> From: Yuti Amonkar <yamonkar@cadence.com>
> 
> Document the bindings used for the Cadence MHDP DPI/DP bridge in
> yaml format.
> 
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  .../bindings/display/bridge/cdns,mhdp.yaml    | 127 ++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.example.dt.yaml: example-0: dp-bridge@f0fb000000:reg:0: [240, 4211081216, 0, 16777216] is too long


See https://patchwork.ozlabs.org/patch/1333631

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

