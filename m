Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6862B15A1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 06:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgKMFwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 00:52:43 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44424 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgKMFwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 00:52:42 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AD5qTRH053314;
        Thu, 12 Nov 2020 23:52:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605246749;
        bh=vuJfh9AQJMyy3MZgJH8Zx/NqXWNXFJq17wpkrVCtTwM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dlvvDRn99hbHzYsyc5Kqmay1UBwleWs58LcKdzHnscSU+ASxKyzU+q3utcHdF/d33
         ByxHmnj5/ZF+F35nLqu6gMmvl1A2otP0JGZJlsRmaBJDK1I7I0AvmveByxZM3BNWUu
         EuB04pdBlpgUQWd9SpZys25iJsHI/MUXr5QA5hNI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AD5qTYr043745
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 23:52:29 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 23:52:28 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 23:52:28 -0600
Received: from [10.24.69.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AD5qOKp088941;
        Thu, 12 Nov 2020 23:52:25 -0600
Subject: Re: [RESEND PATCH] arm64: dts: ti: k3-j7200-mcu-wakeup: Enable ADC
 support
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20201029050950.4500-1-vigneshr@ti.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <9b9698da-b3a8-5ddc-28a9-f59790adc431@ti.com>
Date:   Fri, 13 Nov 2020 11:22:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201029050950.4500-1-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/20 10:39 AM, Vignesh Raghavendra wrote:
> J7200 has a single instance of 8 channel ADC in MCU domain. Add DT node
> for the same.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
