Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B6E26DAB3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgIQLss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:48:48 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56090 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbgIQLrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:47:18 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08GBkfEo058813;
        Wed, 16 Sep 2020 06:46:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600256801;
        bh=f39L0NtWeT8nBr11AnFqXf2qSwpEqyvlCAO4NHzHrU0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QXK9GTpNryajUTxJIsXPNZHPLqrQAG++6RL8xwA3V9ppbIcLLnB/lOtyNJULXStcr
         71TU6C9oESqozmPi6m/I/lr9VojL59oyE9CKQbphi4U/1AYCGmRqH6HvYSf8qgoKtJ
         XqPHG9p7MayDqEuA/U40mJJGTe/kr0o8ciEqgf6Q=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08GBkfmm116875
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 06:46:41 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 16
 Sep 2020 06:46:40 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 16 Sep 2020 06:46:40 -0500
Received: from [10.250.71.177] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08GBkekj049033;
        Wed, 16 Sep 2020 06:46:40 -0500
Subject: Re: [PATCH v2 3/3] ASoC: tlv320adcx140: Add proper support for master
 mode
To:     Camel Guo <camelg@axis.com>, Camel Guo <Camel.Guo@axis.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
References: <20200911080753.30342-1-camel.guo@axis.com>
 <20200911080753.30342-3-camel.guo@axis.com>
 <c2fb617e-fa61-e9d1-449f-7d8806168b9a@ti.com>
 <507f2f53-e236-f894-cb17-4fc84cf00326@axis.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <7065684e-5e57-8c63-daef-89f4b2ab1605@ti.com>
Date:   Wed, 16 Sep 2020 06:46:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <507f2f53-e236-f894-cb17-4fc84cf00326@axis.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Camel

On 9/16/20 2:52 AM, Camel Guo wrote:
> Please forget about this patch since Dan will upload a similar one.
>
> @Dan, see my comment below.
>
I have cc'd you on my patchset and as you can see I did not add any of 
the master mode programming only setting of the master mode bits.

So this patch is still viable it's just the master mode bit programming 
that needs to be looked at.

Dan

