Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4B82B090E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgKLP4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:56:50 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53786 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbgKLP4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:56:49 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ACFuhx0010130;
        Thu, 12 Nov 2020 09:56:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605196603;
        bh=g4XHRACyB74EFnBh7sne+fEzt5OCqo+r8E/8Xgmz9hk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gRAKKdZFPJwD3ZsEVyGG19qV36QzTN1uQkAcGo+5Mn65+LKW4r4FxXMwxqxNVrNmj
         KhJlQgFjfC2tIu2P6QRBjUO3enl37TP4DXkzlgOV1npZD7D87H0c1INWsXHVEHBP+5
         Z0l7keQudPBM7/9lgJLgQdpDumbPS/KMtvwAhImc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ACFuhNv011269
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 09:56:43 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 09:56:43 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 09:56:43 -0600
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ACFudxk000559;
        Thu, 12 Nov 2020 09:56:39 -0600
Subject: Re: [PATCH V2 5/5] arm64: dts: ti: am65/j721e/j7200: Mark firmware
 used uart as "reserved"
To:     Nishanth Menon <nm@ti.com>, Roger Quadros <rogerq@ti.com>,
        Keerthy <j-keerthy@ti.com>, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20201112014929.25227-1-nm@ti.com>
 <20201112014929.25227-6-nm@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <229f80ed-822d-f536-fec1-f3d79373875e@ti.com>
Date:   Thu, 12 Nov 2020 21:26:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201112014929.25227-6-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/20 7:19 AM, Nishanth Menon wrote:
> Follow the device tree standards that states to set the
> status="reserved" if an device is operational, but used by a non-linux
> firmware in the system.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---

Acked-by: Vignesh Raghavendra <vigneshr@ti.com>

