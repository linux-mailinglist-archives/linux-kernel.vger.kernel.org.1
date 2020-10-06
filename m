Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2242D284B1F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 13:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgJFLvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 07:51:33 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46896 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgJFLvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 07:51:33 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 096BpP3b123455;
        Tue, 6 Oct 2020 06:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601985085;
        bh=0ru6/7C6AlR/JGZ/P7YTFTc/JWwzi6YwnBCPrkJVync=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XYED2l4xonPF7w59P11mwSrgVaNW2NVtl0GT+PKJFA/IwiZ6JldpNoWD1bRCdShFD
         D/aNl++tx07hhjaCk6qDtp1eAokLe5PMe5DCDWjSW5hbxpk30hh3GDABr4jkmVvlkR
         /2ejAbdgO4iUhDbmeuPqFGI3eFNbCxlYhjbP500U=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 096BpPpZ005047
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Oct 2020 06:51:25 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 6 Oct
 2020 06:51:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 6 Oct 2020 06:51:25 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 096BpM3U008069;
        Tue, 6 Oct 2020 06:51:23 -0500
Subject: Re: [PATCH 0/2] Enable GPIO and I2C configs for TI's J721e platform
To:     Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <will@kernel.org>, <catalin.marinas@arm.com>, <nm@ti.com>
References: <20201002164535.9920-1-faiz_abbas@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <68cadd9b-63b1-caaf-080c-e2f346f4a908@ti.com>
Date:   Tue, 6 Oct 2020 14:51:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002164535.9920-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2020 19:45, Faiz Abbas wrote:
> The following patches enable configs in the arm64 defconfig to support
> GPIO and I2C support on TI's J721e platform.
> 
> Faiz Abbas (2):
>    arm64: defconfig: Enable OMAP I2C driver
>    arm64: defconfig: Enable DAVINCI_GPIO driver
> 
>   arch/arm64/configs/defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 

Why are you enabling these?

Are they required for booting the board?

If not, they shall not be enabled, as it just clutters the arm64 
defconfig unnecessarily.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
