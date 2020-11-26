Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07BD2C58FD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 17:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391385AbgKZQEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 11:04:14 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59490 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391161AbgKZQEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 11:04:13 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AQG41VU090194;
        Thu, 26 Nov 2020 10:04:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606406641;
        bh=WL14XJtJnVu7XrP6LYgAMjN2uYAWt+wAixafOIJ89zQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bsXfK0vp8cgBE11RNQtJtqU6sufPrXNW5qp4tlpLCXxDmjXd+rRhu2GAVh3Ku/dLc
         r8dVKHYvFDVJfvr7L3a5bojiEjbDIFcND/ygyqlVZpa59u0vTDgWK+itfKQYYv/H1+
         Kgx6GEP/aTWTjUhJjgwtjB74anSKFHmhhyK8AyI0=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AQG41W6040942
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Nov 2020 10:04:01 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 26
 Nov 2020 10:04:01 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 26 Nov 2020 10:04:00 -0600
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AQG3vJ1120415;
        Thu, 26 Nov 2020 10:03:58 -0600
Subject: Re: [PATCH v2 0/2] arm64: dts: ti: k3-j7200-som/cpb: Correct i2c bus
 representations
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <nm@ti.com>,
        <t-kristo@ti.com>
CC:     <devicetree@vger.kernel.org>, <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>
References: <20201120073533.24486-1-peter.ujfalusi@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <3a970cea-84e2-03f3-d48d-da7b9054a8f2@ti.com>
Date:   Thu, 26 Nov 2020 18:03:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201120073533.24486-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/11/2020 09:35, Peter Ujfalusi wrote:
> Hi,
> 
> Changes since v1:
> - Added REviewed-by from Vignesh
> - Comment block to explain main_i2c1 connection to CPB
> 
> The main_i2c0 missed the ioexpander present on the SOM itself to control muxes
> to route signals to CPB connectors.
> 
> The main_i2c1 of J7200 is _not_ connected to the i2c1 of CPB, it is connected to
> i2c3, so the devices on the CPB's i2c1 bus are not avalible, but the ones on the
> CPB i2c3 are available under the main_i2c1.
> 
> Add nice line names at the same time to these.
> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (2):
>    arm64: dts: ti: k3-j7200-som-p0: main_i2c0 have an ioexpander on the
>      SOM
>    arm64: dts: ti: k3-j7200-common-proc-board: Correct the name of io
>      expander on main_i2c1
> 
>   .../dts/ti/k3-j7200-common-proc-board.dts     | 23 ++++++++--------
>   arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   | 26 +++++++++++++++++++
>   2 files changed, 37 insertions(+), 12 deletions(-)
> 

Thank you.
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
