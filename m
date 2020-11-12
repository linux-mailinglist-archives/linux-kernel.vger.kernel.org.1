Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC48A2B0A59
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgKLQmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 11:42:53 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37190 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbgKLQmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:42:51 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ACGgjIe029624;
        Thu, 12 Nov 2020 10:42:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605199365;
        bh=2DGsLmpm70ck0G0m7wcSLhSHPrIa0aoiLqRCKAIbVp0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=MsSIo2ksmW7EIM3Jqlco/7L9jl/dRstSDGgT8w3b3ehBblu3EZMPQV9GkGEReFM2g
         w+JDu+lRgDh84ndOHOgcBpsDJkV9ovYWvSsxE/6zw2DjEuk/h90XTlHtvxBEUYwsoi
         Gbysehl0jydGiWcnIEhHgTiyBN1FvBOfy29PAnbo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ACGgjTa014006
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 10:42:45 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 10:42:45 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 10:42:45 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ACGgj3N052392;
        Thu, 12 Nov 2020 10:42:45 -0600
Date:   Thu, 12 Nov 2020 10:42:45 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Faiz Abbas <faiz_abbas@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <t-kristo@ti.com>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH 0/3] Add gpio support for TI's J7200 platform
Message-ID: <20201112164245.d6rdmsl4aomplqku@kahuna>
References: <20201102191120.20380-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201102191120.20380-1-faiz_abbas@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 00:41-20201103, Faiz Abbas wrote:
> The following patches add gpio support for TI's J7200 platform.
> 
> These patches were posted as a part of an older series but have now
> been split into three parts. The 3 parts add configs, gpios and MMC/SD
> related dts patches respectively.
> 
> Older series is here:
> https://lore.kernel.org/linux-arm-kernel/20201001190541.6364-1-faiz_abbas@ti.com/
> 
> Series adding configs to arm64 defconfig is here:
> https://lore.kernel.org/linux-arm-kernel/20201102183005.14174-1-faiz_abbas@ti.com/
> 
> Faiz Abbas (3):
>   arm64: dts: ti: k3-j7200-main: Add gpio nodes in main domain
>   arm64: dts: ti: k3-j7200: Add gpio nodes in wakeup domain

I am not sure why we are splitting patches per domain here. We
should just have a single patch that introduces the nodes, I dont see a
specific benefit. In addition, series also introduces additional
 Missing #address-cells in interrupt provider

Which we need a conclusion for and the comments already provided.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
