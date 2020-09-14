Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB45269668
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgINUZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:25:03 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45920 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgINUWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:22:45 -0400
Received: by mail-io1-f68.google.com with SMTP id y74so1501765iof.12;
        Mon, 14 Sep 2020 13:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dPtHCfDUD4ey1ZULXFTKqZNYshevl4kIod3SIiCDEKA=;
        b=tnbceZoMk1tQqYiy1HV2HpZXprKUv6JQObaNqcfyhdWmD0XvpzMvABrc1zVJuAoPjH
         mjZilEO6lSS3/bWqoY1mfgpF3Aqv4M3bGWoBZRcAB3R6BnOmrDuvuOTXl/oqmuA3SnSS
         Iq6Uxx0yf9O1v213Jm7+tHFQ8qxtW66C6DkbV01EVUcIOxB9K0DJzcDBb0G1UldfDKNV
         gYenx8cA2KN82rggjOawAJI/VQzx1PEIIgf3BA/EExkdwXHOXSx5DkDitmLp4Un9YJtf
         DnWenPZjOsnhLaYG0C1m0AqdQu5fIb3dBWVjtRtFVgzoDV7srzTPN1Dp+vSVJy0l197i
         HvoA==
X-Gm-Message-State: AOAM530lqfs42bpm2H0i8Hoh8yXhB/SdHg3xBgJyIMEuInMyCMd47cRA
        DDamaajhZeX0W0UGQBwXQjxoDgUF0Ltg
X-Google-Smtp-Source: ABdhPJx06r/tB4DL4iWET254PrfW3KIT6XCr/JSIxzlso/QDEMYWy8QbdkH2DrY4eebn9IZTUP3KCA==
X-Received: by 2002:a6b:ec04:: with SMTP id c4mr13194264ioh.179.1600114964012;
        Mon, 14 Sep 2020 13:22:44 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id r7sm7556022ilg.27.2020.09.14.13.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:22:43 -0700 (PDT)
Received: (nullmailer pid 177360 invoked by uid 1000);
        Mon, 14 Sep 2020 20:22:41 -0000
Date:   Mon, 14 Sep 2020 14:22:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Lee Jones <lee.jones@linaro.org>, Axel Lin <axel.lin@ingics.com>,
        Keerthy <j-keerthy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: mfd: add LP87524-Q1
Message-ID: <20200914202241.GA177305@bogus>
References: <20200902142259.28349-1-luca@lucaceresoli.net>
 <20200902142259.28349-3-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902142259.28349-3-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Sep 2020 16:22:58 +0200, Luca Ceresoli wrote:
> Add the LP87524-Q1 to the bindings along with an example. This is a variant
> of the LP87565-Q1 and LP87561-Q1 chips which already have bindings.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> 
> ---
> 
> Changes in v5:
>  - describe the "regulators" node too (Rob)
>  - add 'additionalProperties: false' (Rob)
>  - user patternProperties for supplies
>  - simplify supply description
> 
> Changes in v4:
>  - reformat as a standalone file
> 
> Changes in v3:
>  - fix yaml errors
> 
> Changes in v2:
>  - RFC,v1 was based on the txt file, rewrite for yaml
>  - use uppercase consistently in model names (Lee Jones)
>  - replace "regulator" -> "mfd" in subject line (Lee Jones)
>  - replace "dt:" suffix with "dt-bindings:" prefix in subject line
> ---
>  .../bindings/mfd/ti,lp87524-q1.yaml           | 112 ++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
