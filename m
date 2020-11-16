Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E9A2B4382
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbgKPMSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:18:51 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59334 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgKPMSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:18:51 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AGCHaep060296;
        Mon, 16 Nov 2020 06:17:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605529056;
        bh=DIzdKScpm9h/Phr262Uk9Tdbqx0xp32Mf9AFx75nzB0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=e5Ab2GKkOznRhDYPpDG57S+gkzD4pdj45CZ6bqBVPveXPeiQzus51pS6ieO5XYrb9
         RzMQbgMj/CBGKq8St2GXCH8+YYR57EdsMCBa95eUzQ1fUJj/cCOpsOXpdJGpKQSzzN
         1Rm5B1lkLWms0Fv6aEablWKAakqj3xdp3pT3/uew=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AGCHZmf116773
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 06:17:35 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 16
 Nov 2020 06:17:35 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 16 Nov 2020 06:17:35 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AGCHXCN051472;
        Mon, 16 Nov 2020 06:17:33 -0600
Subject: Re: [PATCH v3 0/4] ASoC: pcm512x: Patch series to set fmt from
 `set_fmt()`
To:     Kirill Marinushkin <kmarinushkin@birdec.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     Matthias Reichl <hias@horus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20201115122306.18164-1-kmarinushkin@birdec.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <adecfa94-7907-a0e0-1ad2-fb32cf7a0db8@ti.com>
Date:   Mon, 16 Nov 2020 14:18:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201115122306.18164-1-kmarinushkin@birdec.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill,

On 15/11/2020 14.23, Kirill Marinushkin wrote:
> Set format from `set_fmt()` func instead of `hw_params()`, plus supportive
> commits

Thank you for the clean series!

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Kirill Marinushkin (4):
>   ASoC: pcm512x: Fix not setting word length if DAIFMT_CBS_CFS
>   ASoC: pcm512x: Rearrange operations in `hw_params()`
>   ASoC: pcm512x: Move format check into `set_fmt()`
>   ASoC: pcm512x: Add support for more data formats
> 
>  sound/soc/codecs/pcm512x.c | 134 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 84 insertions(+), 50 deletions(-)
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
