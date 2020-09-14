Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A0F2686CD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 10:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgINIGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 04:06:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53653 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgINIEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 04:04:47 -0400
Received: from [125.35.49.90] (helo=[10.0.0.22])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <hui.wang@canonical.com>)
        id 1kHjTJ-0002K5-2f; Mon, 14 Sep 2020 08:04:21 +0000
Subject: Re: [PATCH] ALSA: hda/realtek: Enable front panel headset LED on
 Lenovo ThinkStation P520
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, tiwai@suse.com
Cc:     "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Kailang Yang <kailang@realtek.com>,
        Thomas Hebb <tommyhebb@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20200914070231.13192-1-kai.heng.feng@canonical.com>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <c4a9ed79-1c9d-8fbc-8c3b-eab191bd56bd@canonical.com>
Date:   Mon, 14 Sep 2020 16:04:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200914070231.13192-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Kaiheng, and we just had one P520 in the Beijing office and I 
also worked on this issue happenly. Does the led change according to 
jack plugging in or plugging out with your patch? I also prepared a 
patchset but my patchset has more code than yours, please take a look. :-)

Thanks.

Hui.

On 2020/9/14 下午3:02, Kai-Heng Feng wrote:
> On Lenovo P520, the front panel headset LED isn't lit up right now.
>
> Realtek states that the LED needs to be enabled by ALC233's GPIO2, so
> let's do it accordingly to light the LED up.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>   sound/pci/hda/patch_realtek.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index c521a1f17096..ba941bd0b792 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -6017,6 +6017,7 @@ static void alc_fixup_thinkpad_acpi(struct hda_codec *codec,
>   #include "hp_x360_helper.c"
>   
>   enum {
> +	ALC269_FIXUP_GPIO2,
>   	ALC269_FIXUP_SONY_VAIO,
>   	ALC275_FIXUP_SONY_VAIO_GPIO2,
>   	ALC269_FIXUP_DELL_M101Z,
> @@ -6194,6 +6195,10 @@ enum {
>   };
>   
>   static const struct hda_fixup alc269_fixups[] = {
> +	[ALC269_FIXUP_GPIO2] = {
> +		.type = HDA_FIXUP_FUNC,
> +		.v.func = alc_fixup_gpio2,
> +	},
>   	[ALC269_FIXUP_SONY_VAIO] = {
>   		.type = HDA_FIXUP_PINCTLS,
>   		.v.pins = (const struct hda_pintbl[]) {
> @@ -7013,6 +7018,8 @@ static const struct hda_fixup alc269_fixups[] = {
>   	[ALC233_FIXUP_LENOVO_MULTI_CODECS] = {
>   		.type = HDA_FIXUP_FUNC,
>   		.v.func = alc233_alc662_fixup_lenovo_dual_codecs,
> +		.chained = true,
> +		.chain_id = ALC269_FIXUP_GPIO2
>   	},
>   	[ALC233_FIXUP_ACER_HEADSET_MIC] = {
>   		.type = HDA_FIXUP_VERBS,
