Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A682F93EA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 17:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbhAQQOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 11:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729562AbhAQQKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 11:10:49 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F7CC061573;
        Sun, 17 Jan 2021 08:10:08 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id u19so14911182edx.2;
        Sun, 17 Jan 2021 08:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AC5FWFmc+QTt0xSwIGW5Ve415efkuLFNzYSONRpyY3A=;
        b=Z3jIlgWoZFgSihGakcm0/3i9PnUa5Mldf0etdusMFVD6qeABjeb9Bzg/TMV0v8wYS7
         2YP50bGWIYaL7bDG1A1C9LnD9ZDKvcns0g8fxORrfS70yeEq6uaani6aQ4ce63nWqZKb
         XcRC/Pr8aIsx4GyJF0QB1RqXm12XctFH99pmdZvc1cH6qiGGqN9stfgt8w/jFf2icHZb
         hb2cA8rzhusgWU52WHErYn0VksmsInJEjY9qAF/yNxCEVtbK3Jn6ltVhxyX5o2RBbroG
         DHHceUgDFwGHPn740YhOjzdXPNZQcrH4Kv1g9PU/4mi9lRUplXaHt71bJU1jLl9p11xf
         wuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AC5FWFmc+QTt0xSwIGW5Ve415efkuLFNzYSONRpyY3A=;
        b=BvBD4/tz+xoWPKAPFHVRMy041jDe6MYBBY0ZSj9b536lxyFIwfhl3QBKtnpyj9XO5B
         LD+HWCogp1yQ9QAdPyRlrHFBpk8L4P+D5ONETWsQXF0tr9ZGLKRrdLwrHMTANqUiUyZi
         DsS4NNS6PDUKouHF6gSOTTNR5kuuk4TlU5Ocojm/Sr/Q/26CyJEsCbWNlo3VTvgX+vai
         zQPHCB1kXvNPZFohUsy4sT4Xup0h62Og4EBLHt8ft31nCCUYlqQk/UijfNE/femohny5
         a/hsw7saSh+ZdfJwoj81YwQQSf5QTTevKUw7YzZi/o8y4xZD6m7+/NNbeq8Jz8x0DxRb
         MDyw==
X-Gm-Message-State: AOAM530Dkn7oXgVKvuPVn3FPwdjQRXEakR1RUGZw4ImJ8+zzFAWLZWcC
        D76aebR653btm2N/w4gyZSJkcLL07zk=
X-Google-Smtp-Source: ABdhPJyg8dZx1Wx6RZW2DUzsycvLMXgXRa57jQLGpJv594NuwqT+1gHHzty/XrnPy/vGD3Kc0WjhEA==
X-Received: by 2002:a05:6402:17cb:: with SMTP id s11mr16034374edy.119.1610899807548;
        Sun, 17 Jan 2021 08:10:07 -0800 (PST)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id dm6sm4885472ejc.32.2021.01.17.08.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jan 2021 08:10:06 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: powerpc: Add a schema for the 'sleep'
 property
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
References: <20201008142420.2083861-1-robh@kernel.org>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <752e9355-defb-6d3c-248b-f626247d4cee@gmail.com>
Date:   Sun, 17 Jan 2021 17:10:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201008142420.2083861-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

This patch generates notifications in the Rockchip ARM and arm64 tree.
Could you limit the scope to PowerPC only.

Kind regards,

Johan Jonker

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/powerpc/sleep.yaml

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/powerpc/sleep.yaml

Example:

/arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dt.yaml: pinctrl:
sleep: {'ddrio-pwroff': {'rockchip,pins': [[0, 1, 1, 168]]},
'ap-pwroff': {'rockchip,pins': [[1, 5, 1, 168]]}} is not of type 'array'
	From schema: /Documentation/devicetree/bindings/powerpc/sleep.yaml

On 10/8/20 4:24 PM, Rob Herring wrote:
> Document the PowerPC specific 'sleep' property as a schema. It is
> currently only documented in booting-without-of.rst which is getting
> removed.
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/powerpc/sleep.yaml    | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/powerpc/sleep.yaml
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/sleep.yaml b/Documentation/devicetree/bindings/powerpc/sleep.yaml
> new file mode 100644
> index 000000000000..6494c7d08b93
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/sleep.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/powerpc/sleep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PowerPC sleep property
> +
> +maintainers:
> +  - Rob Herring <robh@kernel.org>
> +
> +description: |
> +  Devices on SOCs often have mechanisms for placing devices into low-power
> +  states that are decoupled from the devices' own register blocks.  Sometimes,
> +  this information is more complicated than a cell-index property can
> +  reasonably describe.  Thus, each device controlled in such a manner
> +  may contain a "sleep" property which describes these connections.
> +
> +  The sleep property consists of one or more sleep resources, each of
> +  which consists of a phandle to a sleep controller, followed by a
> +  controller-specific sleep specifier of zero or more cells.
> +
> +  The semantics of what type of low power modes are possible are defined
> +  by the sleep controller.  Some examples of the types of low power modes
> +  that may be supported are:
> +
> +   - Dynamic: The device may be disabled or enabled at any time.
> +   - System Suspend: The device may request to be disabled or remain
> +     awake during system suspend, but will not be disabled until then.
> +   - Permanent: The device is disabled permanently (until the next hard
> +     reset).
> +
> +  Some devices may share a clock domain with each other, such that they should
> +  only be suspended when none of the devices are in use.  Where reasonable,
> +  such nodes should be placed on a virtual bus, where the bus has the sleep
> +  property.  If the clock domain is shared among devices that cannot be
> +  reasonably grouped in this manner, then create a virtual sleep controller
> +  (similar to an interrupt nexus, except that defining a standardized
> +  sleep-map should wait until its necessity is demonstrated).
> +
> +select: true
> +
> +properties:
> +  sleep:
> +    $ref: /schemas/types.yaml#definitions/phandle-array
> +
> +additionalProperties: true
> 

