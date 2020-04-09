Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5123E1A2EEA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 08:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgDIGAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 02:00:18 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33370 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgDIGAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 02:00:18 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 039602cF076105;
        Thu, 9 Apr 2020 01:00:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1586412002;
        bh=s4NGEtbZ5WYEhRGTwG73IITDcV3DTILxumrNxiY14yA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KInjLFJRVLXusMx96Svk4Gbi7ix1TYjECmt+JP9oO+41VlD5G3Qug1F6vWKoJCF6L
         VBCs6iVLXV4EyB3eRU0Zvt3zMCoW9Iu6O76KcEp/0R+lgfKddbtVTM3FtLoKTnGphA
         M62uMWshi3CGYn0cMeZArdLCXbgM3DIRhe22IIq8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 039601YW128360
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Apr 2020 01:00:01 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 9 Apr
 2020 01:00:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 9 Apr 2020 01:00:01 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0395xvDZ048578;
        Thu, 9 Apr 2020 00:59:58 -0500
Subject: Re: [PATCH] irqchip/ti-sci-inta: fix processing of masked irqs
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
CC:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20200408191532.31252-1-grygorii.strashko@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <85de7f21-2e9b-da16-589e-b4c2144f3ab4@ti.com>
Date:   Thu, 9 Apr 2020 11:29:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200408191532.31252-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/04/20 12:45 AM, Grygorii Strashko wrote:
> The ti_sci_inta_irq_handler() does not take into account INTA IRQs state
> (masked/unmasked) as it uses INTA_STATUS_CLEAR_j register to get INTA IRQs
> status, which provides raw status value.
> This causes hard IRQ handlers to be called or threaded handlers to be
> scheduled many times even if corresponding INTA IRQ is masked.
> Above, first of all, affects the LEVEL interrupts processing and causes
> unexpected behavior up the system stack or crash.
> 
> Fix it by using the Interrupt Masked Status INTA_STATUSM_j register which
> provides masked INTA IRQs status.
> 
> Fixes: 9f1463b86c13 ("irqchip/ti-sci-inta: Add support for Interrupt Aggregator driver")
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh

