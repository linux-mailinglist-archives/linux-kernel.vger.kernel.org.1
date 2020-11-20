Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4CC2BB061
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgKTQWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:22:55 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37196 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728960AbgKTQWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:22:54 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AKGLxI3099103;
        Fri, 20 Nov 2020 10:21:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605889319;
        bh=SED0EgoaZJAwVnlKBinfvNnqRxNjjlAXaMmJe99UIAw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DE8YPTTAqhBUxvvFp81BwkV/Z2TnqYh79N0FeO3YBANRU0GpHiagJpzegDSNJfZJ+
         pnn/BU/4VipYGDeQyFVQ+lS7OlwqZiNE82uleRq1pxxRnlkVOAwLmx1HvtHpeI0ax7
         r47NnnQQLJWIixPdoArkCisEaQGNZHHFEyRn9oPQ=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AKGLxvG111484
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Nov 2020 10:21:59 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 20
 Nov 2020 10:21:59 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 20 Nov 2020 10:21:58 -0600
Received: from [10.250.70.26] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AKGLu7C011150;
        Fri, 20 Nov 2020 10:21:57 -0600
Subject: Re: [PATCH 29/38] ASoC: tas2562: skip of_device_id table when
 !CONFIG_OF
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Jonghwan Choi <charlie.jh@kakaocorp.com>
References: <20201120161653.445521-1-krzk@kernel.org>
 <20201120161653.445521-29-krzk@kernel.org>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <cacd0acf-708d-0b56-8229-b76690b2d289@ti.com>
Date:   Fri, 20 Nov 2020 10:21:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201120161653.445521-29-krzk@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 11/20/20 10:16 AM, Krzysztof Kozlowski wrote:
> The driver can match by multiple methods.  Its of_device_id table is
> referenced via of_match_ptr() so it will be unused for !CONFIG_OF
> builds:
>
>    sound/soc/codecs/tas2562.c:805:34: warning: ‘tas2562_of_match’ defined but not used [-Wunused-const-variable=]
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   sound/soc/codecs/tas2562.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
> index f1ff204e3ad0..19965fabe949 100644
> --- a/sound/soc/codecs/tas2562.c
> +++ b/sound/soc/codecs/tas2562.c
> @@ -802,6 +802,7 @@ static const struct i2c_device_id tas2562_id[] = {
>   };
>   MODULE_DEVICE_TABLE(i2c, tas2562_id);
>   
> +#ifdef CONFIG_OF

Should we use #if IS_ENABLED(CONFIG_OF) ?

Dan
