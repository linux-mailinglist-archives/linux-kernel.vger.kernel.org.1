Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D1B2952A1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 21:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502385AbgJUTCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 15:02:35 -0400
Received: from mleia.com ([178.79.152.223]:57654 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441167AbgJUTCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 15:02:35 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 79EE4412CE5;
        Wed, 21 Oct 2020 19:02:33 +0000 (UTC)
Received: from [192.168.43.55] (85-76-32-245-nat.elisa-mobile.fi [85.76.32.245])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.mleia.com (Postfix) with ESMTPSA id 7BECE412CA6;
        Wed, 21 Oct 2020 19:02:32 +0000 (UTC)
Subject: Re: [PATCH 10/29] arm: dts: lpc18xx: Harmonize EHCI/OHCI DT nodes
 name
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-11-Sergey.Semin@baikalelectronics.ru>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <64cad126-0be3-a989-97f1-425851f3f4d7@mleia.com>
Date:   Wed, 21 Oct 2020 22:02:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020115959.2658-11-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20201021_190233_525648_78872986 
X-CRM114-Status: UNSURE (   9.46  )
X-CRM114-Notice: Please train this message. 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/20 2:59 PM, Serge Semin wrote:
> In accordance with the Generic EHCI/OHCI bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "generic-ehci" and "generic-ohci"-compatible
> nodes are correctly named.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>   arch/arm/boot/dts/lpc18xx.dtsi | 4 ++--

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
