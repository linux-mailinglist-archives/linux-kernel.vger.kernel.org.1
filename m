Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8270F27F83F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 05:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbgJADuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 23:50:44 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:43917 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgJADuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 23:50:44 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4C1zg61qbjz1qrfx;
        Thu,  1 Oct 2020 05:50:42 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4C1zg61RFBz1qv2d;
        Thu,  1 Oct 2020 05:50:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id b0Z0x_Tn_LT3; Thu,  1 Oct 2020 05:50:39 +0200 (CEST)
X-Auth-Info: g1JrOTbVm5d6Esh59L6aBLVOKptMJ6xCSVXCG93sxzQ=
Received: from [192.168.1.106] (82-131-157-111.pool.digikabel.hu [82.131.157.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu,  1 Oct 2020 05:50:39 +0200 (CEST)
Reply-To: hs@denx.de
Subject: Re: [PATCH v2 10/12] dt-bindings: arm: fsl: document i.MX6DL
 Aristainetos boards
To:     Krzysztof Kozlowski <krzk@kernel.org>
References: <20200930190143.27032-1-krzk@kernel.org>
 <20200930190143.27032-11-krzk@kernel.org>
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
Message-ID: <0dc1d70b-b24b-c542-4764-bb5a7fa0edec@denx.de>
Date:   Thu, 1 Oct 2020 05:50:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20200930190143.27032-11-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

Am 30.09.2020 um 21:01 schrieb Krzysztof Kozlowski:
> Document and adjust the compatibles for i.MX6DL based Aristainetos
> boards from ABB.
> 
> Cc: Heiko Schocher <hs@denx.de>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Use ABB vendor prefix
> ---
>   Documentation/devicetree/bindings/arm/fsl.yaml | 4 ++++
>   1 file changed, 4 insertions(+)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
