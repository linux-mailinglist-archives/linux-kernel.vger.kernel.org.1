Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD67E221157
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 17:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgGOPkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 11:40:10 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34576 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgGOPkK (ORCPT
        <rfc822;linux-kernel@vger.Kernel.org>);
        Wed, 15 Jul 2020 11:40:10 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 70DBD2A1F5B
Subject: Re: [PATCH v2 2/2] dt-bindings: mfd: Add DT compatible string
 "google,cros_ec_uart"
To:     Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Eric Peers <epeers@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.Kernel.org,
        Bhanu Prakash Maiya <bhanumaiya@google.com>
References: <20200715082526.1760426-1-bhanumaiya@google.com>
 <20200715082526.1760426-2-bhanumaiya@google.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <473adfb3-c66b-aa5a-ce61-af335002b752@collabora.com>
Date:   Wed, 15 Jul 2020 17:40:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715082526.1760426-2-bhanumaiya@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi bhanu,

Thank you for your patch. This patch has some style problems, please make sure
to fix and resent the patch.

On 15/7/20 10:25, Bhanu Prakash Maiya wrote:
> From: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> 
> Add DT compatible string in
> Documentation/devicetree/bindings/mfd/cros_ec.txt
> 

That's actually removed you should base your changes on top of

https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?h=for-mfd-next&id=46b5780688c0d825b6b8d49b267b13102bea512d


> Series-to: LKML <linux-kernel@vger.kernel.org>
> Series-cc: Raul E Rangel <rrangel@chromium.org>, Furquan Shaikh <furquan@chromium.org>, Duncan Laurie <dlaurie@google.com>, Eric Peers <epeers@google.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
> 

I think you need to fix your patman workflow. This should be removed from here.


> Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> Change-Id: Icfeab15fa04daaffc61280faf5a75cd9b23ee822

The Change-Id is useless upstream, please remove it.

> Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@google.com>

Only one signed-off per person please.

> ---
>  Documentation/devicetree/bindings/mfd/cros-ec.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/cros-ec.txt b/Documentation/devicetree/bindings/mfd/cros-ec.txt
> index 4860eabd0f729..ec8c5d7ecc266 100644
> --- a/Documentation/devicetree/bindings/mfd/cros-ec.txt
> +++ b/Documentation/devicetree/bindings/mfd/cros-ec.txt
> @@ -3,7 +3,7 @@ ChromeOS Embedded Controller
>  Google's ChromeOS EC is a Cortex-M device which talks to the AP and
>  implements various function such as keyboard and battery charging.
>  
> -The EC can be connect through various means (I2C, SPI, LPC, RPMSG) and the
> +The EC can be connect through various means (I2C, SPI, UART, LPC, RPMSG) and the
>  compatible string used depends on the interface. Each connection method has
>  its own driver which connects to the top level interface-agnostic EC driver.
>  Other Linux driver (such as cros-ec-keyb for the matrix keyboard) connect to
> @@ -17,6 +17,10 @@ Required properties (SPI):
>  - compatible: "google,cros-ec-spi"
>  - reg: SPI chip select
>  
> +Required properties (UART):
> +- compatible: "google,cros-ec-uart"
> +- reg: UART baudrate, flowcontrol
> +

That's odd, a reg that is mean to contain the baudrate and the flowcontrol? How?

>  Required properties (RPMSG):
>  - compatible: "google,cros-ec-rpmsg"
>  
> @@ -72,5 +76,6 @@ spi@131b0000 {
>  	};
>  };
>  
> -
>  Example for LPC is not supplied as it is not yet implemented.
> +
> +Example for UART is not supplied as it is not yet implemented.
> 
