Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696982A637E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 12:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbgKDLk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 06:40:27 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59720 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbgKDLkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:40:17 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A4Be8gU113375;
        Wed, 4 Nov 2020 05:40:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604490008;
        bh=u+EmaCcZGZfOS7Kpjqe/4peuPvaBmXgfP0TZ1evlUoE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Req7LZhdNEp43QOcjZYef0Yu+acx212Z+Kn45iVwidd+0MzCYWYLM6+dM+Ui92/hk
         24RJTiIs55B7EsvgzfNFvaOozfFteTXraupY4mQD4o/X/6PtP5ZMq7K4ahaIzd33oL
         p9GQQL0flYKhR9ZjCMF1vW8LCoY5XSxqI51ey+iI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A4Be8JW085269
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Nov 2020 05:40:08 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 4 Nov
 2020 05:40:08 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 4 Nov 2020 05:40:08 -0600
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A4Be5sV097994;
        Wed, 4 Nov 2020 05:40:06 -0600
Subject: Re: [PATCH 0/3] Add gpio support for TI's J7200 platform
To:     Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <nm@ti.com>, <t-kristo@ti.com>, <robh+dt@kernel.org>
References: <20201102191120.20380-1-faiz_abbas@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <f6f7c9ee-46b6-e2f5-0762-0a264a3bb2e9@ti.com>
Date:   Wed, 4 Nov 2020 17:10:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20201102191120.20380-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/11/20 12:41 am, Faiz Abbas wrote:
> The following patches add gpio support for TI's J7200 platform.
> 
> These patches were posted as a part of an older series but have now
> been split into three parts. The 3 parts add configs, gpios and MMC/SD
> related dts patches respectively.

Series looks good to me.

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh
