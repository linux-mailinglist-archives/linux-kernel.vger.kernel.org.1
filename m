Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3102027F841
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 05:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbgJADvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 23:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgJADvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 23:51:44 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DA2C061755;
        Wed, 30 Sep 2020 20:51:44 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4C1zhG6HW1z1rrLW;
        Thu,  1 Oct 2020 05:51:42 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4C1zhG4X3rz1qv2g;
        Thu,  1 Oct 2020 05:51:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id u1wdo79cDnla; Thu,  1 Oct 2020 05:51:40 +0200 (CEST)
X-Auth-Info: yGfI2FBjWBItx786/GjvJBpnN4MkPeshWAEEwWHHA5k=
Received: from [192.168.1.106] (82-131-157-111.pool.digikabel.hu [82.131.157.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu,  1 Oct 2020 05:51:40 +0200 (CEST)
Reply-To: hs@denx.de
Subject: Re: [PATCH v2 11/12] ARM: dts: imx6dl: add compatibles for
 Aristainetos boards
To:     Krzysztof Kozlowski <krzk@kernel.org>
References: <20200930190143.27032-1-krzk@kernel.org>
 <20200930190143.27032-12-krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Heiko Schocher <hs@denx.de>
Message-ID: <6b921745-c9bd-8928-38be-9f85e65b1873@denx.de>
Date:   Thu, 1 Oct 2020 05:51:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20200930190143.27032-12-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

Am 30.09.2020 um 21:01 schrieb Krzysztof Kozlowski:
> The Aristainetos and Aristainetos2 boards have only SoC compatible.
> 
> Cc: Heiko Schocher <hs@denx.de>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Use ABB vendor prefix
> ---
>   arch/arm/boot/dts/imx6dl-aristainetos2_4.dts | 2 +-
>   arch/arm/boot/dts/imx6dl-aristainetos2_7.dts | 2 +-
>   arch/arm/boot/dts/imx6dl-aristainetos_4.dts  | 2 +-
>   arch/arm/boot/dts/imx6dl-aristainetos_7.dts  | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
