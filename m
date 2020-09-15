Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6126426AD26
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgIOTKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:10:19 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36654 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgIOTGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:06:18 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08FJ5pRn058642;
        Tue, 15 Sep 2020 14:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600196751;
        bh=FwOp1+5tY+FzI+nWDtzQ/kM21d7eLdPx/kZA6dPG+Rk=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=VcqG6mYy7tqwIB8G28svBpcMM2FbvJFBSCBgmQLAi4Hi5IbNgT6FHWGI3FFZJ2eo8
         Mq64x9ulrjuMzFQrFmo1X82smEKecxdpzfTu0AgQnh81mWfE4k15mzNWqPtIfoFMBk
         uRNr5ioCDWXky4tFxBNC6UznhMvLgQ3cEFtdg1MM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FJ5pnO038065;
        Tue, 15 Sep 2020 14:05:51 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Sep 2020 14:05:51 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Sep 2020 14:05:51 -0500
Received: from [10.250.38.37] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FJ5okH006371;
        Tue, 15 Sep 2020 14:05:50 -0500
Subject: Re: [PATCH v2 2/3] ASoC: tlv320adcx140: Add support for configuring
 GPIO pin
From:   Dan Murphy <dmurphy@ti.com>
To:     Camel Guo <camel.guo@axis.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Camel Guo <camelg@axis.com>
References: <20200911080753.30342-1-camel.guo@axis.com>
 <20200911080753.30342-2-camel.guo@axis.com>
 <da35edb3-bc41-967c-d530-4df4363ddddf@ti.com>
Message-ID: <6833eff3-39d3-f707-d0e6-c0db9f86157c@ti.com>
Date:   Tue, 15 Sep 2020 14:05:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <da35edb3-bc41-967c-d530-4df4363ddddf@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Camel

On 9/15/20 1:41 PM, Dan Murphy wrote:
> Camel
>
> On 9/11/20 3:07 AM, Camel Guo wrote:
>> From: Camel Guo <camelg@axis.com>


One other thing for the device tree you need to add Rob Herring and 
devicetree@vger.kernel.org

