Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01872AF8D6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 20:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgKKTSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 14:18:12 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41819 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgKKTSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 14:18:11 -0500
Received: by mail-oi1-f196.google.com with SMTP id m13so3403612oih.8;
        Wed, 11 Nov 2020 11:18:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dyEeJt9nKugdWpL04ZKWH+UXJAulW34IvqV/SnkPbEQ=;
        b=aK2m/Cwb738OMPgeIbAJcgHmE6q6w+vdRkwvM1ICq0lGz7CgdIjGBHoyZ+OsIUjtLL
         UW+kY4ku3/E2fOH8f+sk20e0+vKIwEJVnCaiJyCyLWoBZdEWUG/gZTD4iltaM52KP0kX
         4ke/SH0/Nu+JhbXTshGX6gJUDdZjh5iIi/MNeSZvVzNeHh4NW5NrSkklayPB62Ju6j5o
         YBmzcN3BDFlGfF56Da5VbBQbxPetBhQamVzXQ4oIJevBYdnC5pYIb63FXcrPziTAIInu
         GhlAp3UH1F8fm3AHd30wwcDrmFbGV0U2B3LqQgwLUl/w6Eqd50gqkU2hdxG9cenZ1w/5
         6xlQ==
X-Gm-Message-State: AOAM533stbyV7KbRVHsh6BoMz1+jv54K8Erq+reImUYOgsTGzPfp3BRF
        W3f3ocOZ5RnFCngRYtIqAg==
X-Google-Smtp-Source: ABdhPJwB14taliF6U+AUf/N1OtoYTH8z013eOiMtyiinNMjQGcQuTpoj1Dzd40dASYXXh/ijQBZabA==
X-Received: by 2002:aca:378a:: with SMTP id e132mr2977001oia.112.1605122290641;
        Wed, 11 Nov 2020 11:18:10 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t199sm606106oif.25.2020.11.11.11.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:18:10 -0800 (PST)
Received: (nullmailer pid 1860547 invoked by uid 1000);
        Wed, 11 Nov 2020 19:18:09 -0000
Date:   Wed, 11 Nov 2020 13:18:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH V4] dt-bindings: soc: imx: Add binding doc for spba bus
Message-ID: <20201111191809.GA1859246@bogus>
References: <20201111152523.76254-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111152523.76254-1-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Nov 2020 09:25:23 -0600, Adam Ford wrote:
> Add binding doc for fsl,spba-bus.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> make dt_binding_check showed no errors if I did this right.
> 
> V4:  Remove an accidental makefile change
>      Move type:object under additional properties
> 
> V3:  Rebase sample from aips-bus example
>      Split off from series adding i.MX8M Nano functions to reduce noise
> 
> V2:  Attempted to update yaml from feedback
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dt.yaml: bus@30000000: reg: [[805306368, 1048576]] is not of type 'object'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml


See https://patchwork.ozlabs.org/patch/1398351

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

