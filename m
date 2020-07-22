Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996C8229ACA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 16:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732796AbgGVO5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 10:57:25 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57058 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732143AbgGVO5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:57:24 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06MEvBpk004910;
        Wed, 22 Jul 2020 09:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595429831;
        bh=4Uf4TRn5vUb8L0d8FDIOQK0Qy4pBZfSImAAgzuqEAOI=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=mL54vk1csAw2axZ2LgbskInwLF51fwF3sqNSAbtJmQPnQ+NO8K+aigcaM2ZgLIiWd
         jyRAPQKq+uyfL2ZoIGSZMXzlI7a8uCGPISwHFS4WI45IZLPPYrYlnqHlr4dUlB640r
         w2gFe2LMSAvbbRB84nDLNHy7f70k5ZbcXbpBEWrU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06MEv67o090277
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jul 2020 09:57:11 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 22
 Jul 2020 09:57:06 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 22 Jul 2020 09:57:06 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06MEv4fq071548;
        Wed, 22 Jul 2020 09:57:05 -0500
Subject: Re: [PATCH -next] ASoC: ti: fix SND_SOC_J721E_EVM warnings & errors
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>
References: <e74c690c-c7f8-fd42-e461-4f33571df4ef@infradead.org>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <8a5baa38-e5a9-ab82-d186-9939733e4d7e@ti.com>
Date:   Wed, 22 Jul 2020 17:58:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e74c690c-c7f8-fd42-e461-4f33571df4ef@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On 20/07/2020 21.32, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>=20
> SND_SOC_J721E_EVM should not select SND_SOC_PCM3168A_I2C when I2C
> is not enabled. That causes build errors, so make this driver's
> symbol depend on I2C.

Thank you for the fix!

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> WARNING: unmet direct dependencies detected for SND_SOC_PCM3168A_I2C
>   Depends on [n]: SOUND [=3Dm] && !UML && SND [=3Dm] && SND_SOC [=3Dm] =
&& I2C [=3Dn]
>   Selected by [m]:
>   - SND_SOC_J721E_EVM [=3Dm] && SOUND [=3Dm] && !UML && SND [=3Dm] && S=
ND_SOC [=3Dm] && (DMA_OMAP [=3Dy] || TI_EDMA [=3Dm] || TI_K3_UDMA [=3Dn] =
|| COMPILE_TEST [=3Dy]) && (ARCH_K3_J721E_SOC [=3Dn] || COMPILE_TEST [=3D=
y])
>=20
> ../sound/soc/codecs/pcm3168a-i2c.c:59:1: warning: data definition has n=
o type or storage class
>  module_i2c_driver(pcm3168a_i2c_driver);
>  ^~~~~~~~~~~~~~~~~
> ../sound/soc/codecs/pcm3168a-i2c.c:59:1: error: type defaults to =E2=80=
=98int=E2=80=99 in declaration of =E2=80=98module_i2c_driver=E2=80=99 [-W=
error=3Dimplicit-int]
> ../sound/soc/codecs/pcm3168a-i2c.c:59:1: warning: parameter names (with=
out types) in function declaration
> ../sound/soc/codecs/pcm3168a-i2c.c:49:26: warning: =E2=80=98pcm3168a_i2=
c_driver=E2=80=99 defined but not used [-Wunused-variable]
>  static struct i2c_driver pcm3168a_i2c_driver =3D {
>                           ^~~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
>=20
>=20
> Fixes: 6748d0559059 ("ASoC: ti: Add custom machine driver for j721e EVM=
 (CPB and IVI)")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Mark Brown <broonie@kernel.org>
> ---
>  sound/soc/ti/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>=20
> --- linux-next-20200720.orig/sound/soc/ti/Kconfig
> +++ linux-next-20200720/sound/soc/ti/Kconfig
> @@ -222,6 +222,7 @@ config SND_SOC_DM365_VOICE_CODEC_MODULE
>  config SND_SOC_J721E_EVM
>  	tristate "SoC Audio support for j721e EVM"
>  	depends on ARCH_K3_J721E_SOC || COMPILE_TEST
> +	depends on I2C
>  	select SND_SOC_PCM3168A_I2C
>  	select SND_SOC_DAVINCI_MCASP
>  	help
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

