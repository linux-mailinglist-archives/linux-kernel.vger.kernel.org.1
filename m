Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463DB280FCF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 11:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387662AbgJBJ0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 05:26:32 -0400
Received: from mail1.perex.cz ([77.48.224.245]:38896 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgJBJ0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 05:26:32 -0400
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Oct 2020 05:26:31 EDT
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 931F9A003E;
        Fri,  2 Oct 2020 11:18:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 931F9A003E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1601630331; bh=vH5bk14pBl7deg6sCuCkKRwOpZPcUNic2gXWFCEF4QA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=t3N97mEjdBWhYNHy8Lji+QPXqzowxkeQkJFGdQwjeyDowdNQsRY/hzYheYHYnluZi
         Ln3P+j0HKpEwHtE5DKlAxAryMH4tpX2C/hAqX5E0S/ZObPVtTifLdifUrvQV3BRsaw
         T/WbJevzYQ6xYcw43Dc0B9po66rY0vftc3rfoIao=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Fri,  2 Oct 2020 11:18:46 +0200 (CEST)
Subject: Re: [PATCH] ALSA: usb-audio: fix spelling mistake "Frequence" ->
 "Frequency"
To:     Takashi Iwai <tiwai@suse.de>, Colin King <colin.king@canonical.com>
Cc:     alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181125231208.14350-1-colin.king@canonical.com>
 <s5hmupw6y6l.wl-tiwai@suse.de>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <8ee34833-7867-f559-0656-b4f34ea6d006@perex.cz>
Date:   Fri, 2 Oct 2020 11:18:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <s5hmupw6y6l.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 26. 11. 18 v 9:27 Takashi Iwai napsal(a):
> On Mon, 26 Nov 2018 00:12:08 +0100,
> Colin King wrote:
>>
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> There are spelling mistakes in equalizer name fields, fix them.
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> In general, it's not good to rename the control names even if they are
> fixes.  But these are rather device-specific ones, and they are EQ's,
> which aren't too fatal to change, so I took it as-is now.

It seems that this patch has not found a way to kernel. It is present
in #master at git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git,
but it is not present in linux-next.

					Thanks,
						Jaroslav

> 
> 
> thanks,
> 
> Takashi
> 
> 
>> ---
>>  sound/usb/mixer_us16x08.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
>> index 26ed23b18b77..4f594f9552a8 100644
>> --- a/sound/usb/mixer_us16x08.c
>> +++ b/sound/usb/mixer_us16x08.c
>> @@ -1119,7 +1119,7 @@ static const struct snd_us16x08_control_params eq_controls[] = {
>>  		.control_id = SND_US16X08_ID_EQLOWFREQ,
>>  		.type = USB_MIXER_U8,
>>  		.num_channels = 16,
>> -		.name = "EQ Low Frequence",
>> +		.name = "EQ Low Frequency",
>>  	},
>>  	{ /* EQ mid low gain */
>>  		.kcontrol_new = &snd_us16x08_eq_gain_ctl,
>> @@ -1133,7 +1133,7 @@ static const struct snd_us16x08_control_params eq_controls[] = {
>>  		.control_id = SND_US16X08_ID_EQLOWMIDFREQ,
>>  		.type = USB_MIXER_U8,
>>  		.num_channels = 16,
>> -		.name = "EQ MidLow Frequence",
>> +		.name = "EQ MidLow Frequency",
>>  	},
>>  	{ /* EQ mid low Q */
>>  		.kcontrol_new = &snd_us16x08_eq_mid_width_ctl,
>> @@ -1154,7 +1154,7 @@ static const struct snd_us16x08_control_params eq_controls[] = {
>>  		.control_id = SND_US16X08_ID_EQHIGHMIDFREQ,
>>  		.type = USB_MIXER_U8,
>>  		.num_channels = 16,
>> -		.name = "EQ MidHigh Frequence",
>> +		.name = "EQ MidHigh Frequency",
>>  	},
>>  	{ /* EQ mid high Q */
>>  		.kcontrol_new = &snd_us16x08_eq_mid_width_ctl,
>> @@ -1175,7 +1175,7 @@ static const struct snd_us16x08_control_params eq_controls[] = {
>>  		.control_id = SND_US16X08_ID_EQHIGHFREQ,
>>  		.type = USB_MIXER_U8,
>>  		.num_channels = 16,
>> -		.name = "EQ High Frequence",
>> +		.name = "EQ High Frequency",
>>  	},
>>  };
>>  
>> -- 
>> 2.19.1
>>
>>


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
