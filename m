Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC2C28736E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 13:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgJHLgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 07:36:20 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60966 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgJHLgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 07:36:19 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 098BaANq067425;
        Thu, 8 Oct 2020 06:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602156970;
        bh=bG660JxRSNwbc+hdLLw+VtFmo8ptClkHW+piSLh8Hfs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=fFByA/3pp809nHfA7E2ko/kDFXwZhl2L/lN529VWsDJ9K4vrUKWlpUuCoo2UEydyN
         2LrySbIfX3CWOzKFJuKMVgOEkPI5wUB/dILQnBd3YmHef9K7nIEVcci/zeiNDgCqv3
         TyuJ+u0e3ovxttv5xDa0uO86qEvF4vqSdCiFs6Os=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 098BaAIn113032
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Oct 2020 06:36:10 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 8 Oct
 2020 06:36:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 8 Oct 2020 06:36:10 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 098Ba9RB011843;
        Thu, 8 Oct 2020 06:36:10 -0500
Date:   Thu, 8 Oct 2020 06:36:09 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <t-kristo@ti.com>
CC:     Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>
Subject: Re: [PATCH 0/2] Enable GPIO and I2C configs for TI's J721e platform
Message-ID: <20201008113609.il72lxqpb236umoe@tableware>
References: <20201002164535.9920-1-faiz_abbas@ti.com>
 <68cadd9b-63b1-caaf-080c-e2f346f4a908@ti.com>
 <ce66e552-a816-9e67-5e94-d9a20bbc2bc7@ti.com>
 <f8877ca8-fe32-29e5-cb0c-2ce0af3eb73a@ti.com>
 <0b46dc95-6778-7f01-395a-8d4eaf33b0f7@ti.com>
 <51978593-fe09-3740-ef90-deac8ef3d2f2@ti.com>
 <142b9d12-ea65-320f-aef9-583389aabb3e@ti.com>
 <83e519f3-b8e4-6fe7-2e0b-de7a5484f2b6@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <83e519f3-b8e4-6fe7-2e0b-de7a5484f2b6@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:06-20201008, Tero Kristo wrote:
> On 08/10/2020 12:40, Faiz Abbas wrote:
[...]
> > Thats right. The EPROBE_DEFERs will happen if my patches enabling UHS modes here are merged. I need to repost them for v5.11-rc1:
> > https://lore.kernel.org/linux-arm-kernel/20201001190541.6364-1-faiz_abbas@ti.com/
> 
> Ok I think that would be good enough reason to enable these by default as
> the MMC as boot media won't work anymore without them, and carrying the DTS
> patches would be just silly.
> 
> Acked-by: Tero Kristo <t-kristo@ti.com>


I still think we could squash the patches and explain in the commit message the
rationale for adding these in.

"Enable support for devices compatible with TI's davinci gpio
controllers." Does'nt quite explain the severity of the patches.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
