Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190B12F2105
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391058AbhAKUmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:42:44 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:38598 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387768AbhAKUmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:42:43 -0500
Received: by mail-oi1-f172.google.com with SMTP id x13so752867oic.5;
        Mon, 11 Jan 2021 12:42:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aGgwNrRCg33BLJ97oko34wtt2smAT8qIYrmBDpmvMvQ=;
        b=YAaKUmwc9BVYWtldUvtOQPsbGZnQUGLWDj8sK/GPYk74nvi1JO6eRGQFtU8nlxMBoo
         RYP1zkkCpvUNOjfVtnXEtwcSA7gqnNyfLpJ/0n4Yw7t35UIEcfW3eTPmejzmSxwUOjEK
         Z4/ME3ueG96VvqMskHBVNa+E1yqVVHMRJw3cXKZNy2iaeV5gEZ7sA3T/K6z2yguBGFH2
         d6CcBXugw7dL+pwXGVMMWirY5KXvhQ0Za2cYCaGsB60hxnnS4NGPJA+zZ3bvNEeqppgN
         4N15NeA0H+YaxVpNHwspym0PLCaxILab1uwPO6rcXv5SYR44YqDKlA52xKzDNqtXtmVV
         oeyg==
X-Gm-Message-State: AOAM530iHFcHwRS93qBGWeGe5xP9oPHlxfoFTnaXNk/jPGpB7yG/PAUR
        w/QRJuTedrj+KOz8CO7FkQ==
X-Google-Smtp-Source: ABdhPJyvp3/nIKDHi+VOblaZxyMgmOzRu9UWU+8wUs+0W397pXkerxPJvF6QmD0QEsz/vfz33nCPsA==
X-Received: by 2002:a05:6808:4cf:: with SMTP id a15mr371482oie.147.1610397722190;
        Mon, 11 Jan 2021 12:42:02 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e17sm185589otf.32.2021.01.11.12.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 12:42:01 -0800 (PST)
Received: (nullmailer pid 3030625 invoked by uid 1000);
        Mon, 11 Jan 2021 20:42:00 -0000
Date:   Mon, 11 Jan 2021 14:42:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Charles Hsu <hsu.yungteng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: (hwmon/pm6764tr) Add PM6764TR hwmon driver
 bindings
Message-ID: <20210111204200.GA3026535@robh.at.kernel.org>
References: <20201229071723.2219360-1-hsu.yungteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201229071723.2219360-1-hsu.yungteng@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 03:17:23PM +0800, Charles Hsu wrote:
> Document device tree bindings for STMicroelectronics PM6764tr Voltage
> Regulator.

Subject space is valuable and you have 'hwmon', 'pm6764tr', and 
'bindings' twice.

> 
> Signed-off-by: Charles Hsu <hsu.yungteng@gmail.com>
> ---
>  .../bindings/hwmon/pmbus/st,pm6764tr.yaml     | 47 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 +
>  2 files changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/st,pm6764tr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/st,pm6764tr.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/st,pm6764tr.yaml
> new file mode 100644
> index 000000000000..b4b0d5614d8d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/pmbus/st,pm6764tr.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/pmbus/st,pm6764tr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PM6764TR voltage regulator
> +
> +maintainers:
> +  - Charles Hsu <hsu.yungteng@gmail.com>
> +
> +description: |
> +  The PM6764/66 is a high performance digital controller designed to power
> +  Intel’s VR12.5 processors (PM6766) and memories (PM6764): all required
> +  parameters are programmable through a PMBus™ interface.
> +  The device utilizes digital technology to implement all control and
> +  power management functions to provide maximum flexibility and performance.
> +  The NVM is embedded to store custom configurations.
> +
> +  https://www.st.com/resource/en/data_brief/pm6764.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - st,pm6764tr
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pm6764tr@68 {
> +            compatible = "st,pm6764tr";
> +            reg = <0x68>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index bdc2dc318178..0a2dcd03220b 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -260,6 +260,8 @@ properties:
>            - socionext,synquacer-tpm-mmio
>              # i2c serial eeprom  (24cxx)
>            - st,24c256
> +            # STMicroelectronics Voltage Regulator
> +          - st,pm6764tr

It should be either in trivial-devices or its own schema file, not both.

>              # Ambient Light Sensor with SMBUS/Two Wire Serial Interface
>            - taos,tsl2550
>              # Temperature Monitoring and Fan Control
> -- 
> 2.25.1
> 
