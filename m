Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F36D2732AA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgIUTTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:19:46 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52460 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgIUTTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:19:46 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08LJJauw014971;
        Mon, 21 Sep 2020 14:19:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600715976;
        bh=uR02JwKo0qvxv+nT1lRsSAEq7fVnd6Fv2/1txQvzfl0=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=jchyOjN+uz1OKUIZqBNt6b08imte/+khyvE71NE3rEfZaAo6pUMvuR1p8PsOiTc/s
         OFnlzWS2PSTx8xC4QtsuIuinuiwWE+VLW7OnxiiWNuh5veLV7yW7f2JARM+bLEX8ni
         4bgqn9mELKmHg/z+Vh3ZQIXqJ39oDmDnTHydX9zQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08LJJapJ122091
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Sep 2020 14:19:36 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 21
 Sep 2020 14:19:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 21 Sep 2020 14:19:36 -0500
Received: from [10.250.35.164] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08LJJaN7051871;
        Mon, 21 Sep 2020 14:19:36 -0500
Subject: Re: [PATCH 6/9] ASoC: tas2770: Convert bit mask to GENMASK in header
From:   Dan Murphy <dmurphy@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20200918190548.12598-1-dmurphy@ti.com>
 <20200918190548.12598-6-dmurphy@ti.com> <20200921190437.GJ4792@sirena.org.uk>
 <bea218c8-c71d-2ce8-da92-14af73ac4da5@ti.com>
Message-ID: <2ca0647d-1ebf-1290-0f75-61bb97324165@ti.com>
Date:   Mon, 21 Sep 2020 14:19:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bea218c8-c71d-2ce8-da92-14af73ac4da5@ti.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark

On 9/21/20 2:18 PM, Dan Murphy wrote:
> Mark
>
> On 9/21/20 2:04 PM, Mark Brown wrote:
>> On Fri, Sep 18, 2020 at 02:05:45PM -0500, Dan Murphy wrote:
>>> Update the hardcoded masks with the GENMASK macro. Also update some of
>>> the hardcoded bits with the BIT macro
>> Cleanups like this should come after any fixes in the series, that way
>> fixes can be sent as fixes if needed which isn't appropriate for random
>> cleanups.
>
> OK I can re-order so the clean up comes at the end.  During the clean 
> up I found patch 7-9.
>
Forgot to ask are you going to take 1-5? If so I can rebase on top of 
for-5.10 and re-submit.

Dan


> Dan
>
