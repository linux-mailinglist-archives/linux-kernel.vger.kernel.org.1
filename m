Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6392525EE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 05:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgHZD62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 23:58:28 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58918 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgHZD62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 23:58:28 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07Q3w1gA014048;
        Tue, 25 Aug 2020 22:58:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598414281;
        bh=CtyJsITbLPrbJAwnu9VnTqWuNELfBVy8JYlgQwbFDbc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jf9PJ3GoyUztO5u3hAUb6aFCfU5XVRzq/QJ55ACJF1MrZFFHlT/EkfF99YU4M1ta2
         LrqjRY+mNCdHPa4jg+12i8XrKtMblGBrfOUV1ExvsI4oXcpY9DqVRLDuAl9pAoKn95
         9ouT7p42+LvGVh76z1LqM6PtbH1OvGVXO/A86OKo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07Q3w1Jr091999
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Aug 2020 22:58:01 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 25
 Aug 2020 22:58:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 25 Aug 2020 22:58:01 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07Q3vtMK004834;
        Tue, 25 Aug 2020 22:57:58 -0500
Subject: Re: [PATCH -next] irqchip/ti-sci-inta: Fix unsigned comparison to
 zero
To:     YueHaibing <yuehaibing@huawei.com>, <nm@ti.com>, <t-kristo@ti.com>,
        <ssantosh@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <maz@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200826035430.21060-1-yuehaibing@huawei.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <252e422a-6f7b-59db-685f-a4a489a8dee8@ti.com>
Date:   Wed, 26 Aug 2020 09:27:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200826035430.21060-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/08/20 9:24 am, YueHaibing wrote:
> ti_sci_inta_xlate_irq() return -ENOENT on fail, p_hwirq
> should be int type.
> 
> Fixes: 5c4b585d2910 ("irqchip/ti-sci-inta: Add support for INTA directly connecting to GIC")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>


Acked-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh

