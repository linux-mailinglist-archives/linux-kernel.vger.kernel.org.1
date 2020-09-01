Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10F6258D65
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 13:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgIAL0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 07:26:02 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46660 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgIALYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:24:06 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 081BMlwr066864;
        Tue, 1 Sep 2020 06:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598959367;
        bh=6lc8AOIxQaWAqkTCg0KZdf8W6u0jyi4qjd/xMZyZOoM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=J9Is2TM39XtwqTfxN/+j+uUdd5Zk9U9xSrewcxongeE/OP+48uK8f6FIWYPpWDNEs
         Fies7Sa+STz1Gql1B2xdfj39MqZflk+a/orGBbjGt9UDZzsXzmL6GwI1Z4+4+tq3FO
         xvXK0ZRsWTYudwAINjUrYdGxn8l4m0un5sS8ejQ0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 081BMlhZ107840
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Sep 2020 06:22:47 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 1 Sep
 2020 06:22:47 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 1 Sep 2020 06:22:47 -0500
Received: from [10.250.38.37] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 081BMkXv065418;
        Tue, 1 Sep 2020 06:22:46 -0500
Subject: Re: [PATCH] ASoC: tlv320adcx140: Fix accessing uninitialized
 abcx140->dev
To:     Camel Guo <camel.guo@axis.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Camel Guo <camelg@axis.com>
References: <20200901072710.2031-1-camel.guo@axis.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <daa7dd49-7a5a-a366-4f88-93d256ff9d99@ti.com>
Date:   Tue, 1 Sep 2020 06:22:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901072710.2031-1-camel.guo@axis.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Camel

On 9/1/20 2:27 AM, Camel Guo wrote:
> From: Camel Guo <camelg@axis.com>
>
> in adcx140_i2c_probe, adcx140->dev is accessed before its
> initialization. This commit fixes this bug.

s/abc/adc in the subject

and

s/in/In

Also please add a Fixes tag.

Otherwise

Acked-by: Dan Murphy <dmurphy@ti.com>

