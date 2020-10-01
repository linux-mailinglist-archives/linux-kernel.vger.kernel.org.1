Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB71027F83D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 05:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbgJADtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 23:49:51 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:55851 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgJADto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 23:49:44 -0400
X-Greylist: delayed 63322 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Sep 2020 23:49:43 EDT
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4C1zdx0HNSz1rrLW;
        Thu,  1 Oct 2020 05:49:41 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4C1zdw5chjz1qv2g;
        Thu,  1 Oct 2020 05:49:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id xZI-56jy8Coa; Thu,  1 Oct 2020 05:49:38 +0200 (CEST)
X-Auth-Info: OOaKYsIUogQuvk2zPK95wRAXrIPrtHEnaZAAaol5IZ4=
Received: from [192.168.1.106] (82-131-157-111.pool.digikabel.hu [82.131.157.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu,  1 Oct 2020 05:49:38 +0200 (CEST)
Reply-To: hs@denx.de
Subject: Re: [PATCH v2 09/12] dt-bindings: vendor-prefixes: add ABB
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
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
References: <20200930190143.27032-1-krzk@kernel.org>
 <20200930190143.27032-10-krzk@kernel.org>
From:   Heiko Schocher <hs@denx.de>
Message-ID: <88c7c1bc-86c1-0c08-2a0c-4903c6c431da@denx.de>
Date:   Thu, 1 Oct 2020 05:49:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20200930190143.27032-10-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

Am 30.09.2020 um 21:01 schrieb Krzysztof Kozlowski:
> Document binding for ABB.
> 
> Cc: Heiko Schocher <hs@denx.de>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Use ABB vendor prefix
> ---
>   Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>   1 file changed, 2 insertions(+)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
