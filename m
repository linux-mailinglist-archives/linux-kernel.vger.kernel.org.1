Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC5529092D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 18:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410554AbgJPQEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 12:04:43 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45614 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409186AbgJPQEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:04:43 -0400
Received: by mail-ot1-f66.google.com with SMTP id f37so2824604otf.12;
        Fri, 16 Oct 2020 09:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B5r1iVyK3g5LOaEPbQH7PWrVHl8ge6O5axWBuh2PZeE=;
        b=l1EBPh/e8uhUIDn3cWc29EiMAzyQhyh9Hjy84EceuVl6uHyM99/xmDfLZrWqF0Lf2c
         L6m/mLjPkf6z8mJZiD1wgJx3nzKwJAwHBDtNcnJlTJI6rkkd3mGbKpAC7VdWoUnY4Fwl
         vpIJ3CT7eZZtbcc2cyPNl4aEdPIJTv2lePElY1RLgNmTWVdks3nKXY+XA6TgVY8UKeO2
         r1lOUyyOUKrWjjfTCmaWB1jhjTUgzGLdSS57TC0AtQxcQwWFwUXcRCayGUorU9V01bN+
         WqVswGiHIFj8wrMR5UYb80uNuw1IlEiwoSJzY2iW1fHkGQPmtJxe3/1N/V7yM00HEFZi
         1wmg==
X-Gm-Message-State: AOAM5325aEzJvGi9P7Svp6a0ZZNqEkNevl5sFx8n5TYszEqr7oYnOhBC
        FVrmzdEjettVWyTaaf2i5w==
X-Google-Smtp-Source: ABdhPJws7R2VvBCs0QwPLkKNqMNgdPLcfuPj1pTN4MciCqactZNQnAW0FdCyTT6OPwznRy+xGlaMOg==
X-Received: by 2002:a9d:7850:: with SMTP id c16mr3017265otm.342.1602864278409;
        Fri, 16 Oct 2020 09:04:38 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k6sm1087596otp.33.2020.10.16.09.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 09:04:37 -0700 (PDT)
Received: (nullmailer pid 1495855 invoked by uid 1000);
        Fri, 16 Oct 2020 16:04:37 -0000
Date:   Fri, 16 Oct 2020 11:04:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Caesar Wang <wxt@rock-chips.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, heiko@sntech.de,
        Rob Herring <robh+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, Collabora Kernel ML <kernel@collabora.com>
Subject: Re: [PATCH v4] dt-bindings: power: rockchip: Convert to json-schema
Message-ID: <20201016160437.GB1494813@bogus>
References: <20201015101944.407487-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015101944.407487-1-enric.balletbo@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 12:19:44 +0200, Enric Balletbo i Serra wrote:
> Convert the soc/rockchip/power_domain.txt binding document to json-schema
> and move to the power bindings directory.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Rob, I didn't add a number of clocks neither a number of pm_qos because will
> be a finger in the air number. If you still want I add it, I can add a
> number based on the actual users of this binding but no guarantee that
> we don't need to change that number in the future.
> 
> Changes in v4:
> - Use hex for unit-addresses.
> - Use space between compatibles in the example.
> - Define child nodes for nested power domains even are duplicated but
>   more clear that adding a regex scaped to be a valid URI.
> 
> Changes in v3:
> - Fixed tab errors found by bot
> 
> Changes in v2:
> - Fixed a warning that says that 'syscon' should not be used alone.
> - Use patternProperties to define a new level for power-domains.
> - Add const values for power-domain-cells, address-cells, etc.
> 
>  .../power/rockchip,power-controller.yaml      | 283 ++++++++++++++++++
>  .../bindings/soc/rockchip/power_domain.txt    | 136 ---------
>  2 files changed, 283 insertions(+), 136 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> 


My bot found errors running 'make dt_binding_check' on your patch:

./Documentation/devicetree/bindings/power/rockchip,power-controller.yaml:61:13: [warning] wrong indentation: expected 10 but found 12 (indentation)
./Documentation/devicetree/bindings/power/rockchip,power-controller.yaml:106:17: [warning] wrong indentation: expected 14 but found 16 (indentation)
./Documentation/devicetree/bindings/power/rockchip,power-controller.yaml:138:21: [warning] wrong indentation: expected 18 but found 20 (indentation)


See https://patchwork.ozlabs.org/patch/1382558

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

