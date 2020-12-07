Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620572D1BCC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 22:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbgLGVMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 16:12:40 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46853 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLGVMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 16:12:39 -0500
Received: by mail-oi1-f196.google.com with SMTP id k2so17020125oic.13;
        Mon, 07 Dec 2020 13:12:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IzNY0CwElm/QJnJDMMBdlqBg/MgfFtPxII2T8Hj+zS8=;
        b=KFbITcQqEza3MfNmH0qb98PJPNhV75rrj6FHgSZ7zsmWW3eYumi2h2Mv/W8JWdb84l
         I12QgCjyvbP0tl7vzkFSOawUCtciSnDR2DC0zTHDUPdSzvEikZoD0IRR60nEN6zbr4T6
         ZwfgYII1b9lwMHntbvoGhGp0lXapMkljEGlCv+lBkBt3cuMBvVsSkgKIJ6PPDp7H8lE/
         0fWzTQATzr98CzL+ORk168sNy0FI9lBkAzxQW+O0YYmitDV/u4m+JGSc0+dl3LDovMno
         qZkWdK91YGT2yM8eDYTpWuX6vvMWexlXmeytKxlfQrmfwMgVC2xfHEKgjt9cnvLJgYSg
         +FbA==
X-Gm-Message-State: AOAM530h3TzdUewWnrefO16lBeLuXdP80u4Oy2+Ie48uKi1qxPfuYwJ6
        +7LCWoU2e7FX623mD6x7bw==
X-Google-Smtp-Source: ABdhPJw3z26rlK562TLuxNHSSMN05JPgPz3jf7sHqbTy/4nYe1BJLoxHquChq1NCdJfmyI5a2kTclA==
X-Received: by 2002:aca:cfc2:: with SMTP id f185mr544050oig.136.1607375512716;
        Mon, 07 Dec 2020 13:11:52 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y84sm458321oig.36.2020.12.07.13.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 13:11:51 -0800 (PST)
Received: (nullmailer pid 832101 invoked by uid 1000);
        Mon, 07 Dec 2020 21:11:50 -0000
Date:   Mon, 7 Dec 2020 15:11:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        devicetree@vger.kernel.org, Kun Yi <kunyi@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-doc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/4] dt-bindings: hwmon: convert TI ADS7828 bindings to
 dt-schema
Message-ID: <20201207211150.GA832048@robh.at.kernel.org>
References: <20201117220807.208747-1-krzk@kernel.org>
 <20201117220807.208747-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117220807.208747-3-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020 23:08:06 +0100, Krzysztof Kozlowski wrote:
> Convert the TI ADS7828 bindings to dt-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/hwmon/ads7828.txt     | 25 --------
>  .../devicetree/bindings/hwmon/ti,ads7828.yaml | 57 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  4 --
>  3 files changed, 57 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/ads7828.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ti,ads7828.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
