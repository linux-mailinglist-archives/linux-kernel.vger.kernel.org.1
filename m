Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2240E290A92
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 19:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391117AbgJPRW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 13:22:56 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46775 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390593AbgJPRW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 13:22:56 -0400
Received: by mail-oi1-f195.google.com with SMTP id s81so3198378oie.13;
        Fri, 16 Oct 2020 10:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BJybATZoycDgLTmbffuI2naHa9L9rg82JqRTegGqLik=;
        b=Ny5soEWnq3PBstrE46+qpflaN8GOlLie9UyqcrpnaDv3YQQZuPEv7ceZFN/WiJW0NS
         vN4e9wB7NUW+/Yk9KtwEzSmBKZ/NOVVF4Vp1anhj8D0C1NqLQ/i9FFPS6Sg5mhoQC4kg
         eONteaOeEdrq0gBWBqQ+qClYmhJRkNw7BYZhg/x1+U6abNqV72YtqDV7THUyGHfvmKo5
         4cPB7gyDTWXlAsbr18Qa0z/uBgdvhZVKzmuctGApl8mrKC1H2wV2QCpFRhP8AgtqYyhN
         OfLJAPVayyQcEI1Wv9b9mNgOyVFsBcVUmdrlFcJOJNwsYbvVNDGyiSRLK0xN8pI/IXm5
         1Mbg==
X-Gm-Message-State: AOAM531fv8l2f3l/W75RSAvhay6x+PxKe5hK/mdRBIYbgcuRRbBVRWV/
        by6nPgKZIJcd7G5WUwCdSA==
X-Google-Smtp-Source: ABdhPJxp9sgI5G8aybjKcCWmzMoG+26CI+MfMzp2N6g+7MDS4qq9xh60m6rvafSWTPabVDr9QAnNvg==
X-Received: by 2002:a05:6808:b24:: with SMTP id t4mr2957434oij.93.1602868975325;
        Fri, 16 Oct 2020 10:22:55 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 91sm1124825ott.55.2020.10.16.10.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 10:22:54 -0700 (PDT)
Received: (nullmailer pid 1604743 invoked by uid 1000);
        Fri, 16 Oct 2020 17:22:53 -0000
Date:   Fri, 16 Oct 2020 12:22:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
        robh+dt@kernel.org, linux-clk@vger.kernel.org, mdf@kernel.org,
        devicetree@vger.kernel.org, lars@metafoo.de,
        mturquette@baylibre.com, sboyd@kernel.org
Subject: Re: [PATCH v2] dt-bindings: clock: adi,axi-clkgen: convert old
 binding to yaml format
Message-ID: <20201016172253.GA1604546@bogus>
References: <20201001085035.82938-1-alexandru.ardelean@analog.com>
 <20201013143421.84188-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013143421.84188-1-alexandru.ardelean@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Oct 2020 17:34:20 +0300, Alexandru Ardelean wrote:
> This change converts the old binding for the AXI clkgen driver to a yaml
> format.
> 
> As maintainers, added:
>  - Lars-Peter Clausen <lars@metafoo.de> - as original author of driver &
>    binding
>  - Michael Hennerich <michael.hennerich@analog.com> - as supporter of
>    Analog Devices drivers
> 
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
> 
> Changelog v1 -> v2:
> * add 'additionalProperties: false'
> * changed 'clock@...' -> 'clock-controller@...' in example
> * added Acked-by for Michael & Lars on the re-licensing
> * updated description for 'clocks' property
> 
>  .../bindings/clock/adi,axi-clkgen.yaml        | 53 +++++++++++++++++++
>  .../devicetree/bindings/clock/axi-clkgen.txt  | 25 ---------
>  2 files changed, 53 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
>  delete mode 100644 Documentation/devicetree/bindings/clock/axi-clkgen.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
