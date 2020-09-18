Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCD42703D6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 20:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgIRSS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 14:18:56 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35286 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIRSSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 14:18:55 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08IIIjBs071479;
        Fri, 18 Sep 2020 13:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600453125;
        bh=cFGQg+1KZ4pDx/j/j43AbBotFhKCYoUkrHxGwcXbl9A=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PKCVUz27D3PoAfNXE7rtm2L1nq7bPsZDlB4vsdff/DFAAwOR0iESG/7QDK7rCjFrT
         TOxxlctXXtWlgF5YKb7jRDTWtrqRQ++h+hKUynBv5Gqo4HKao6Pc2Rz/armkI7+Kbf
         KBut5vPJFiB6MCJE/EZW+6KArZ8XVujiJ0S6TK5o=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08IIIjvf110052
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Sep 2020 13:18:45 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Sep 2020 13:18:44 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Sep 2020 13:18:44 -0500
Received: from [10.250.35.164] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08IIIice000609;
        Fri, 18 Sep 2020 13:18:44 -0500
Subject: Re: [PATCH 1/2] ASoC: tas2770: Fix calling reset in probe
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20200918161842.4451-1-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <8bf4ae51-6cf7-aa43-e00b-c875ea5a0548@ti.com>
Date:   Fri, 18 Sep 2020 13:18:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200918161842.4451-1-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All

On 9/18/20 11:18 AM, Dan Murphy wrote:
> tas2770_reset is called during i2c probe. The reset calls the
> snd_soc_component_write which depends on the tas2770->component being
> available. The component pointer is not set until codec_probe so move
> the reset to the codec_probe after the pointer is set.

I have been updating the tas2770 to add another device to the driver and 
I have quite a few unexpected patches on top of these.

I am not even sure how this driver is even working at the moment.

I will re-submit the complete set of patches as Mark pointed out in 
another email chain.

So please ignore these patches for now plus the DT binding patch.

Dan

