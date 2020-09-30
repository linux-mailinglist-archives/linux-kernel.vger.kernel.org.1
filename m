Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6C427E839
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgI3MJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:09:19 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57240 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3MJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:09:19 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08UC9B9L125240;
        Wed, 30 Sep 2020 07:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601467751;
        bh=R+Qlfq/XvKdsTKt62UazgZacJVr+bQyOr5bxAS3WZNQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=CMGz56eIB3hwfmwOAI1/YHIGnLrE2UA2i5SlOHCwr2rIPIHmT45uygLo5isbw37VM
         ar+WWoJduHw7d2AAQTyznADuf58OH1Dlb+2uHPP7VuPvSkitzzZWFtFaFnSSLy/wh9
         Cw3+f4Mwst4EJbMgvMIEr/rvlxUsilOStCEK0egU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08UC9BgT091195
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 07:09:11 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 07:09:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 07:09:11 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UC9Av6029555;
        Wed, 30 Sep 2020 07:09:10 -0500
Date:   Wed, 30 Sep 2020 07:09:10 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     <peda@axentia.se>, <t-kristo@ti.com>, <nsekhar@ti.com>,
        <kishon@ti.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/6] arm64: dts: ti: Add USB support for J7200 EVM
Message-ID: <20200930120910.7qfoesml2icjgxkf@akan>
References: <20200921143941.13905-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200921143941.13905-1-rogerq@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:39-20200921, Roger Quadros wrote:
> Hi Tero/Nishanth,
> 
> This series adds USB2.0 support for the J7200 EVM.
> 
> Series is based on top of:
> 
>     Faiz's MMC/SD support series
>     https://lore.kernel.org/lkml/20200907090520.25313-1-faiz_abbas@ti.com/
>     Lokesh's initial support series
>     https://patchwork.kernel.org/cover/11740039/
>     Vignesh's I2C support series
>     https://lore.kernel.org/patchwork/cover/1282152/
>     Vignesh's Hyperflash series
>     https://lore.kernel.org/patchwork/cover/1285326/
>     MUX binding cleanup
>     https://lore.kernel.org/lkml/20200918165930.2031-1-rogerq@ti.com/
> 
> cheers,
> -roger


Your series does'nt apply on my tree anymore - even after merging
ti-k3-dt-fixes-for-v5.9 . Could you rebase your patches on top of
next-20200930 ?
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
