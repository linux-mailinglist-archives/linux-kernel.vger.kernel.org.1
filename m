Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848C02704CF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 21:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgIRTNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 15:13:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42824 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRTNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 15:13:45 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08IJDbN2086743;
        Fri, 18 Sep 2020 14:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600456417;
        bh=AHq/5X/zt7ouB8G4cT7Ae9eA79pwUrSvwVhNR0JQuWk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dKhxMio8DpXhdFrvlOPT7PeTHaFsgOu/ybn/oNVNgrpXqJlPChoqCEPDAe8J+Jj7C
         O2YCzNyAwei+j4Ngx/eF1qYv7AkXCqS/o0ZnOZGMttn06jcaW6REb+6oz02zoQsus6
         EsAyMoOUZqp4mHTVv5w+lk5olvoOfM1hXPUQYuVQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08IJDbPs110407;
        Fri, 18 Sep 2020 14:13:37 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Sep 2020 14:13:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Sep 2020 14:13:36 -0500
Received: from [10.250.35.164] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08IJDamK028660;
        Fri, 18 Sep 2020 14:13:36 -0500
Subject: Re: [PATCH] dt-bindings: tas2770: Fix I2C addresses for the TAS2770
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20200918164320.11577-1-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <bcae2b35-8b64-6736-4fc1-23cfa5912924@ti.com>
Date:   Fri, 18 Sep 2020 14:13:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200918164320.11577-1-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All

On 9/18/20 11:43 AM, Dan Murphy wrote:
> The I2C addresses listed in the yaml are not correct. The addresses can
> range from 0x41 through 0x48 based on register configurations. Fix the
> example and the description.

Please ignore this patch I added this patch intp a different patch 
series because there were just that many fixes.

https://lore.kernel.org/patchwork/project/lkml/list/?series=463738

Dan

