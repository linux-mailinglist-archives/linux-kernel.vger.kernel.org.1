Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66652276FA2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbgIXLPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:15:00 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39192 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgIXLPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:15:00 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08OBErFu043512;
        Thu, 24 Sep 2020 06:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600946093;
        bh=uWdUZaM8EkohU505x+lh9hjsadBIwOSUrH0kO9yN9jI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=E43QpAzgujIuGdacLt65WzKzEFxXbjbOZEUit+fDI8yRAiMRTiYH32ZuqzUn+Yl+3
         zbu3QquEoddpwwb4LQejmQAEgd6+2GlK/tWYpeX2smooJ+IHXFMHznKiPqqRiicSci
         h4gNODXiteqEefTx5pZJl5xJXTfqh3eualmrA7m8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08OBErA1069433
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 06:14:53 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Sep 2020 06:14:53 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Sep 2020 06:14:53 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08OBErMv098870;
        Thu, 24 Sep 2020 06:14:53 -0500
Date:   Thu, 24 Sep 2020 06:14:53 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     <peda@axentia.se>, <t-kristo@ti.com>, <nsekhar@ti.com>,
        <kishon@ti.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/6] dt-bindings: ti-serdes-mux: Add defines for J7200
 SoC
Message-ID: <20200924111453.v4cw5rmzpmz4ulg7@akan>
References: <20200921143941.13905-1-rogerq@ti.com>
 <20200921143941.13905-2-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200921143941.13905-2-rogerq@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:39-20200921, Roger Quadros wrote:
> There are 4 lanes in each J7200 SERDES. Each SERDES lane mux can
> select upto 4 different IPs. Define all the possible functions.
> 
> Cc: Peter Rosin <peda@axentia.se>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  include/dt-bindings/mux/ti-serdes.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/dt-bindings/mux/ti-serdes.h b/include/dt-bindings/mux/ti-serdes.h
> index 146d0685a925..9047ec6bd3cf 100644
> --- a/include/dt-bindings/mux/ti-serdes.h
> +++ b/include/dt-bindings/mux/ti-serdes.h
> @@ -68,4 +68,26 @@
>  #define J721E_SERDES4_LANE3_QSGMII_LANE8	0x2
>  #define J721E_SERDES4_LANE3_IP4_UNUSED		0x3
>  
> +/* J7200 */
> +
> +#define J7200_SERDES0_LANE0_QSGMII_LANE3	0x0
> +#define J7200_SERDES0_LANE0_PCIE1_LANE0		0x1
> +#define J7200_SERDES0_LANE0_IP3_UNUSED		0x2
> +#define J7200_SERDES0_LANE0_IP4_UNUSED		0x3
> +
> +#define J7200_SERDES0_LANE1_QSGMII_LANE4	0x0
> +#define J7200_SERDES0_LANE1_PCIE1_LANE1		0x1
> +#define J7200_SERDES0_LANE1_IP3_UNUSED		0x2
> +#define J7200_SERDES0_LANE1_IP4_UNUSED		0x3
> +
> +#define J7200_SERDES0_LANE2_QSGMII_LANE1	0x0
> +#define J7200_SERDES0_LANE2_PCIE1_LANE2		0x1
> +#define J7200_SERDES0_LANE2_IP3_UNUSED		0x2
> +#define J7200_SERDES0_LANE2_IP4_UNUSED		0x3
> +
> +#define J7200_SERDES0_LANE3_QSGMII_LANE2	0x0
> +#define J7200_SERDES0_LANE3_PCIE1_LANE3		0x1
> +#define J7200_SERDES0_LANE3_USB			0x2
> +#define J7200_SERDES0_LANE3_IP4_UNUSED		0x3
> +
>  #endif /* _DT_BINDINGS_MUX_TI_SERDES */
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

I recommend Peter's ack before we take this series in.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
