Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD7B28187D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388185AbgJBRCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:02:20 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37954 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgJBRCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:02:19 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 092H2Bdx103623;
        Fri, 2 Oct 2020 12:02:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601658131;
        bh=gRMpgWrxoOd1aYTqRiRElYmSwRNQr2JwAegkZsYfks8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=L6G0wHCgV562Me8CDObxZR/McmCf2LEWY+RbQLxnGDFYCr0Sy6mG1bV19yNi12hEU
         c9H1Psdg8jdfPCllD6AvMyVvd6t5FQ9tq9DGGz4ow7EMY/yqWSFNSqF1VVNqb6Tt7y
         SBbp3vkRhVGMRsvZCRhPmuzXBpjudoKBNZiZ8l9s=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 092H2Bgl011000
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Oct 2020 12:02:11 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 2 Oct
 2020 12:02:11 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 2 Oct 2020 12:02:11 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 092H2BVN076414;
        Fri, 2 Oct 2020 12:02:11 -0500
Date:   Fri, 2 Oct 2020 12:02:11 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Faiz Abbas <faiz_abbas@ti.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, <t-kristo@ti.com>
Subject: Re: [PATCH 0/2] Enable GPIO and I2C configs for TI's J721e platform
Message-ID: <20201002170211.ghzbjqt6nti6mssh@attakatha>
References: <20201002164535.9920-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201002164535.9920-1-faiz_abbas@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22:15-20201002, Faiz Abbas wrote:
> The following patches enable configs in the arm64 defconfig to support
> GPIO and I2C support on TI's J721e platform.
> 
> Faiz Abbas (2):
>   arm64: defconfig: Enable OMAP I2C driver
>   arm64: defconfig: Enable DAVINCI_GPIO driver
> 
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)


Could we do an audit and make sure nothing else is missing - Say ALSA /
DRM or something else?

And I don't really see the need to split these into individual patches,
maybe, take a hint from [1]


[1] https://lore.kernel.org/linux-arm-kernel/20200630171500.11438-1-geert+renesas@glider.be/
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
