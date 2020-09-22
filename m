Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0813127460B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 18:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgIVQET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 12:04:19 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:33290 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgIVQEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:04:15 -0400
Received: by mail-il1-f196.google.com with SMTP id y2so7120105ila.0;
        Tue, 22 Sep 2020 09:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y5UBXUYHwiRbLDcx9i+bBAPlyBEamPYidNq5SghUBeA=;
        b=ijQGf49zeA+VOxjS0pruYXdCndTID6YG9Sp4Pjmwyq4ieF88yIWuStnn2O0C1Gn5eS
         73PQcKQQsCW9PamkXzoLceIV+O/QRxtqXUlilS+87g9FpYDaH9AlfXn8Duw/jW87hK38
         9VtSDJE9oj7okwDK0ULfVorkVAy/HkrNsW24RiXK8PBMCfUFuH58ZMVZR4ocWXyFUWFx
         Kc/VQcXWcBLgqWZEu/iMrySkYczMRamuTTcCbweZD7JAE+6Z1C5RAy5stDUOzAjAycJk
         0HbCUcMNpCrys66fvD+Pxhg3wC0tF9cbzWt0XmCB0mplwgfwkN4zBs7B9kDiTGJrBjYO
         0qdQ==
X-Gm-Message-State: AOAM530KJHsl5t8HY/pK0jMO2mNRhaOdlPtZRLuslHiVbKHodRZv25qr
        uktvxG+WLn9A+7aLSpXMTQ==
X-Google-Smtp-Source: ABdhPJwfnzMWGepFKpgu7yurXWMFsieJecm07nvuf24tFNfnFoNylfhg3XyYdwCTmcovJXzxu6JHBA==
X-Received: by 2002:a92:d842:: with SMTP id h2mr2347658ilq.176.1600790653559;
        Tue, 22 Sep 2020 09:04:13 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id f21sm7521752ioh.1.2020.09.22.09.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 09:04:12 -0700 (PDT)
Received: (nullmailer pid 2767983 invoked by uid 1000);
        Tue, 22 Sep 2020 16:04:11 -0000
Date:   Tue, 22 Sep 2020 10:04:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v8 05/11] dt-bindings: connector: Add property to set
 initial current cap for FRS
Message-ID: <20200922160411.GB2759479@bogus>
References: <20200921195555.1050731-1-badhri@google.com>
 <20200921195555.1050731-5-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921195555.1050731-5-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 12:55:49PM -0700, Badhri Jagan Sridharan wrote:
> This change adds frs-typec-current which allows setting the initial current
> capability of the new source when vSafe5V is applied during PD3.0
> sink Fast Role Swap.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
> Changes since v1:
> - Changing patch version to v6 to fix version number confusion.
> 
> Changes since v6:
> - Removed the redundant usb-connector.txt that I created by mistake.
> - Moved to yaml.
> 
> Changes since v7:
> - Rebase 
> ---
>  .../devicetree/bindings/connector/usb-connector.yaml   |  8 ++++++++
>  include/dt-bindings/usb/pd.h                           | 10 ++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index 9bd52e63c935..1ca8e6a337e5 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -142,6 +142,14 @@ properties:
>      required:
>        - port@0
>  
> +  frs-typec-current:
> +    description: Initial current capability of the new source when vSafe5V
> +      is applied during PD3.0 Fast Role Swap. "Table 6-14 Fixed Supply PDO - Sink"
> +      of "USB Power Delivery Specification Revision 3.0, Version 1.2" provides the
> +      different power levels and "6.4.1.3.1.6 Fast Role Swap USB Type-C Current"
> +      provides a detailed description of the field.
> +    $ref: /schemas/types.yaml#/definitions/uint32

Looks the same/similar to this[1]. Please come up with a common 
approach to cover both.

Rob

https://lore.kernel.org/linux-arm-kernel/20200902075707.9052-2-amelie.delaunay@st.com/
