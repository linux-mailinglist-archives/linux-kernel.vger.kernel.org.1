Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EF71C25F5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 May 2020 15:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgEBNwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 May 2020 09:52:01 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:49021 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbgEBNwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 09:52:00 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 8205630000889;
        Sat,  2 May 2020 15:51:58 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5396F26497D; Sat,  2 May 2020 15:51:58 +0200 (CEST)
Date:   Sat, 2 May 2020 15:51:58 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        andriy.shevchenko@linux.intel.com, matwey.kornilov@gmail.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        giulio.benetti@micronovasrl.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v2 5/7] dt-bindings: serial: Add binding for rs485
 receiver enable GPIO
Message-ID: <20200502135158.zphroi533ocualot@wunner.de>
References: <20200325231422.1502366-1-heiko@sntech.de>
 <20200325231422.1502366-6-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325231422.1502366-6-heiko@sntech.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 12:14:20AM +0100, Heiko Stuebner wrote:
> --- a/Documentation/devicetree/bindings/serial/rs485.yaml
> +++ b/Documentation/devicetree/bindings/serial/rs485.yaml
> @@ -44,6 +44,10 @@ properties:
>     description: enables the receiving of data even while sending data.
>     $ref: /schemas/types.yaml#/definitions/flag
>  
> +  rs485-rx-enable-gpios:
> +   description: GPIO to handle a separate RS485 receive enable signal
> +   $ref: /schemas/types.yaml#/definitions/flag
> +

This isn't a flag, so you need the "maxItems: 1" line instead,
as you correctly did below:

>    rs485-term-gpios:
>      description: GPIO pin to enable RS485 bus termination.
>      maxItems: 1
