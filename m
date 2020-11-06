Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3282D2A994C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgKFQRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:17:34 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46702 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgKFQRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:17:33 -0500
Received: by mail-oi1-f193.google.com with SMTP id q206so1823226oif.13;
        Fri, 06 Nov 2020 08:17:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WhNIeGRJTGUy5TIPo/bLFio0vUxrOA2JUyr+eH9gH1I=;
        b=FNEzD2lq6lmU1OsZikb/N+jZ91jonBi7MzeTd/r8gf+6+E1WSvLZ9l1DpncDDBVeB9
         EB8pL5LVjemvldAULJwEfWtdGFSTcdLNTw8BJLfgTqLZhVBn+9wOaz6nfKLEbQoMKM9j
         uYR3CiUOkp0Ahg8eBK2DGDubNUx+V63FJcjiJvFwwZ9uThh9rXHr9j9srJANrpgsWB/p
         kMILJRFD9dccgbAecVqwJH/zi0oEGg00yqyzV/GjaSqIEK9xnoqTNrRm4IdEuIw8Ib+x
         dOQwrVwEdqtpJOnXih5vGzX7P4yzooea1uRMUhiEracALjf4bZKIX3LDHKm8YU1FyF2v
         iVXg==
X-Gm-Message-State: AOAM533h0CUg1R2Djs1NghWwB36P1Y36Akz0ukAFSDdX5ndGU+Yp9LC4
        UmB9p7VRGVx1ygk29rHtXg==
X-Google-Smtp-Source: ABdhPJxuxAPTWUVzp/R/MIuKz3b7AtavlWQ3e1kc3Zhr+6Ge6ZUtHLXtMitxwZMkKAtGDve0fOfH8w==
X-Received: by 2002:a54:4199:: with SMTP id 25mr1468238oiy.50.1604679452378;
        Fri, 06 Nov 2020 08:17:32 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 8sm360326oii.45.2020.11.06.08.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 08:17:31 -0800 (PST)
Received: (nullmailer pid 3298774 invoked by uid 1000);
        Fri, 06 Nov 2020 16:17:30 -0000
Date:   Fri, 6 Nov 2020 10:17:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     lars@metafoo.de, broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        bogdan.togorean@analog.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH] dt-bindings: adau1977: convert text binding to yaml
 format
Message-ID: <20201106161730.GA3298561@bogus>
References: <20201106102052.32582-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106102052.32582-1-alexandru.ardelean@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Nov 2020 12:20:52 +0200, Alexandru Ardelean wrote:
> This change converts the old device-tree binding for ADAU1977 from text
> format to the new yaml format.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  .../bindings/sound/adi,adau1977.txt           | 61 ---------------
>  .../bindings/sound/adi,adau1977.yaml          | 77 +++++++++++++++++++
>  2 files changed, 77 insertions(+), 61 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/adi,adau1977.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/adi,adau1977.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/sound/adi,adau1977.example.dts:28.37-38 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/sound/adi,adau1977.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1364: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1395607

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

