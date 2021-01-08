Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB2D2EFB61
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 23:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbhAHWuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 17:50:14 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:44721 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbhAHWuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:50:13 -0500
Received: from [77.244.183.192] (port=64828 helo=[192.168.178.24])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1ky0ZW-00DrLE-Eb; Fri, 08 Jan 2021 23:49:30 +0100
Subject: Re: [RFC 1/2] dt-bindings: clk: versaclock5: Add load capacitance
 properties
To:     Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210106173900.388758-1-aford173@gmail.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <833e228f-6fb5-ae98-a367-9566cf5fcf69@lucaceresoli.net>
Date:   Fri, 8 Jan 2021 23:49:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210106173900.388758-1-aford173@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On 06/01/21 18:38, Adam Ford wrote:
> There are two registers which can set the load capacitance for
> XTAL1 and XTAL2. These are optional registers when using an
> external crystal.  Update the bindings to support them.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  .../devicetree/bindings/clock/idt,versaclock5.yaml   | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> index 2ac1131fd922..e5e55ffb266e 100644
> --- a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> +++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> @@ -59,6 +59,18 @@ properties:
>      minItems: 1
>      maxItems: 2
>  
> +  idt,xtal1-load-femtofarads:

I wonder whether we should have a common, vendor independent property.
In mainline we have xtal-load-pf (ti,cdce925.txt bindings) which has no
vendor prefix. However I don't know how much common it is to need
different loads for x1 and x2. Any hardware engineer around?

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 9000
> +    maximum: 25000
> +    description: Optional loading capacitor for XTAL1

Nit: I think the common wording is "load capacitor", not "loading
capacitor".

-- 
Luca
