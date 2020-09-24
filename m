Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D51277047
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbgIXLu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:50:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48908 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgIXLu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:50:27 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08OBoOCF060034;
        Thu, 24 Sep 2020 06:50:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600948224;
        bh=jcNWHhGPu1Ikd/YQGWpK265untLOjRLtIljXEJdpu8w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qcZrDN/pmwKnykbhy8qTR27HoHNJcCFkzEIyINvPdJUiMExFt8QJKSrzlVCBr4orM
         Wn5LZZEYmYjIDixzyo5/FXhbp9wW1mDSTLceHnBgOeL/XRWQaTqx1oGWi4N8mnlX0H
         c104AcrNfInHojDK1WqjOnZ2GXDaGOxNiviMMPA0=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08OBoOkL026592
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 06:50:24 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Sep 2020 06:50:24 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Sep 2020 06:50:24 -0500
Received: from [10.24.69.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08OBoLSr075688;
        Thu, 24 Sep 2020 06:50:22 -0500
Subject: Re: [PATCH v2 0/2] Add support for MMC/SD on j7200-evm
To:     Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <t-kristo@ti.com>
References: <20200924112644.11076-1-faiz_abbas@ti.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <6a5fa65a-6b42-87e1-71f0-5fa41dab5348@ti.com>
Date:   Thu, 24 Sep 2020 17:20:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200924112644.11076-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/20 4:56 PM, Faiz Abbas wrote:
> The following patches add dt support for MMC/SD on TI's j7200-evm.
> 
> Currently, eMMC support upto HS200 speed and SD card supports upto high
> speed speed mode.

To be sure, the TRM calls for SD card speed up to DDR50. And I believe
there is work going on to go higher too. That needs voltage switching
though and can come in as follow-on patches. This is good first step.

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
