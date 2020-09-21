Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B832732A7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgIUTTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:19:08 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52316 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgIUTTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:19:08 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08LJIrMh014804;
        Mon, 21 Sep 2020 14:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600715933;
        bh=n6AcmAnZQPAOcrHBCbDDHL+97WDS2HL4O3BZYyKbAQ4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dDMKxawedHj+J//4dkP1vrW4eEkNGEbPocQpxb24SkUsqm8PFBC9S6tjyugqYFTGZ
         jTNHpoIeU9zF5Q9ArOlsI4PJMXtM+kSd3pMSrDk/fQDYn3Ib518Tq9og9wsKouMgyo
         M91PondY8rkBhP7H6SiAyxoIrb3EpasO5UcxdDkk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08LJIrfm047334;
        Mon, 21 Sep 2020 14:18:53 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 21
 Sep 2020 14:18:52 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 21 Sep 2020 14:18:53 -0500
Received: from [10.250.35.164] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08LJIqpb084280;
        Mon, 21 Sep 2020 14:18:52 -0500
Subject: Re: [PATCH 6/9] ASoC: tas2770: Convert bit mask to GENMASK in header
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20200918190548.12598-1-dmurphy@ti.com>
 <20200918190548.12598-6-dmurphy@ti.com> <20200921190437.GJ4792@sirena.org.uk>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <bea218c8-c71d-2ce8-da92-14af73ac4da5@ti.com>
Date:   Mon, 21 Sep 2020 14:18:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200921190437.GJ4792@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark

On 9/21/20 2:04 PM, Mark Brown wrote:
> On Fri, Sep 18, 2020 at 02:05:45PM -0500, Dan Murphy wrote:
>> Update the hardcoded masks with the GENMASK macro. Also update some of
>> the hardcoded bits with the BIT macro
> Cleanups like this should come after any fixes in the series, that way
> fixes can be sent as fixes if needed which isn't appropriate for random
> cleanups.

OK I can re-order so the clean up comes at the end.  During the clean up 
I found patch 7-9.

Dan

