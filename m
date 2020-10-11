Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC86E28A746
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 13:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387737AbgJKL7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 07:59:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60526 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387690AbgJKL7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 07:59:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C04021F4426D
Subject: Re: [PATCH v6 2/2] dt-bindings: mfd: Add DT compatible string
 "google,cros_ec_uart"
To:     Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Raul E Rangel <rrangel@chromium.org>, devicetree@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Duncan Laurie <dlaurie@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Eric Peers <epeers@google.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>
References: <20201009132732.v6.1.Ic98067cd92a0b7fed9cd3dfb7b4e736e76551cda@changeid>
 <20201009132732.v6.2.I8d7530d8372e4ef298ddaaaad612a2cdd24ed93e@changeid>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <8cfa923c-cc7a-6dd3-9541-8a18b98091b7@collabora.com>
Date:   Sun, 11 Oct 2020 13:59:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201009132732.v6.2.I8d7530d8372e4ef298ddaaaad612a2cdd24ed93e@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhanu,

Thank you for your patch.

On 9/10/20 23:01, Bhanu Prakash Maiya wrote:
> Add DT compatible string in
> Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> 

The problem with this patchset continues being the same. You are using the trick
of using a DT compatible string to instantiate an ACPI-only driver. You should
have an ACPI ID for that device or use a DMI table to match the device and
instantiate it (see for example the platform/chrome/cros_ec_lpc.c).

Thanks,
 Enric

> Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> 
> Changes in v6:
> - No change
> 
> Changes in v5:
> - No change
> 
> Changes in v4:
> - Changes in commit message.
> 
> Changes in v3:
> - Rebased changes on google,cros-ec.yaml
> 
> Changes in v2:
> - No change
> 
>  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> index 6a7279a85ec1c..552d1c9bf3de4 100644
> --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> @@ -10,11 +10,12 @@ maintainers:
>    - Benson Leung <bleung@chromium.org>
>    - Enric Balletbo i Serra <enric.balletbo@collabora.com>
>    - Guenter Roeck <groeck@chromium.org>
> +  - Bhanu Prakash Maiya <bhanumaiya@chromium.org>
>  
>  description:
>    Google's ChromeOS EC is a microcontroller which talks to the AP and
>    implements various functions such as keyboard and battery charging.
> -  The EC can be connected through various interfaces (I2C, SPI, and others)
> +  The EC can be connected through various interfaces (I2C, SPI, UART and others)
>    and the compatible string specifies which interface is being used.
>  
>  properties:
> @@ -29,6 +30,9 @@ properties:
>        - description:
>            For implementations of the EC is connected through RPMSG.
>          const: google,cros-ec-rpmsg
> +      - description:
> +          For implementations of the EC is connected through UART.
> +        const: google,cros-ec-uart
>  
>    google,cros-ec-spi-pre-delay:
>      description:
> 
