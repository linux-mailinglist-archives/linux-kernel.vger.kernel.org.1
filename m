Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271FF2686DF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 10:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgINIK0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Sep 2020 04:10:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53733 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgINIHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 04:07:35 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kHjWO-0002va-Nw
        for linux-kernel@vger.kernel.org; Mon, 14 Sep 2020 08:07:32 +0000
Received: by mail-pf1-f200.google.com with SMTP id e12so11538192pfm.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 01:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zo3pdzsKIkzlbj1WG0EnGKhILut8FQ3dpUKvkK6/2FM=;
        b=jr+I3Dpq0C+dSvgv8Ap6I0BDqu1e+YGnGGzHA3IWZx9OPBlaOsBTDXQbxfJM/pZxXA
         nhdjhIj1+MPUWdHKgtOMcgvHUYGDuhwb/xan3tvtBmOfciDN4lpo1LNGvqI+uEkQnmnv
         fU61TbY4YmRtDVdXfbeQvnZnFE1jXNbeUHmDktw2gv7AXNnMAjCq4VYbCDo01HML/PwQ
         YEo1eTGPP+FT/xUJulW+KN8w/ocLDSem/ppW4+4M5BFVFr9xCLTZB7wl5kLgn3j5l4La
         cBOIsBnTMFKodCZ8B7FRiz8cCisZoqAffKV7jigOO5Rk+pSYeZuL4Aro4kWM1nWYctwl
         g2vA==
X-Gm-Message-State: AOAM5323oyp8MTNvG2BvWijUheHBIC0gJaF7VfHFtWqKJ0sQamNj6ywi
        dF3Q7PbEyRiuULIKBy+7NCgkdXtYnxkfauu6WFGuzREduID1UWN5mQyIauEK3gba9h6pxZSvmp7
        i32fwo7Vf+BRgLm5p7I6vJyqaC+3QsdqiAEgJ6IqMnw==
X-Received: by 2002:aa7:9a41:: with SMTP id x1mr12261882pfj.138.1600070846346;
        Mon, 14 Sep 2020 01:07:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeeibKrL/0ryrp1aCikm5u5wDocL8VqaZztsbEb5RFmxLASgOic7X43Z+dg7pTcx0XiOx9Kw==
X-Received: by 2002:aa7:9a41:: with SMTP id x1mr12261858pfj.138.1600070845958;
        Mon, 14 Sep 2020 01:07:25 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id d8sm8169517pjs.47.2020.09.14.01.07.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Sep 2020 01:07:18 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] ALSA: hda/realtek: Enable front panel headset LED on
 Lenovo ThinkStation P520
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <c4a9ed79-1c9d-8fbc-8c3b-eab191bd56bd@canonical.com>
Date:   Mon, 14 Sep 2020 16:07:15 +0800
Cc:     tiwai@suse.com,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Kailang Yang <kailang@realtek.com>,
        Thomas Hebb <tommyhebb@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Content-Transfer-Encoding: 8BIT
Message-Id: <07CC762F-BA94-43C0-A8C8-5B3C43291F3E@canonical.com>
References: <20200914070231.13192-1-kai.heng.feng@canonical.com>
 <c4a9ed79-1c9d-8fbc-8c3b-eab191bd56bd@canonical.com>
To:     Hui Wang <hui.wang@canonical.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hui,

> On Sep 14, 2020, at 16:04, Hui Wang <hui.wang@canonical.com> wrote:
> 
> Thanks Kaiheng, and we just had one P520 in the Beijing office and I also worked on this issue happenly. Does the led change according to jack plugging in or plugging out with your patch?

No, the LED won't reflect the jack plugging status.

The LED is always on under Windows, so we are doing the same here.

Kai-Heng

> I also prepared a patchset but my patchset has more code than yours, please take a look. :-)
> 
> Thanks.
> 
> Hui.
> 
> On 2020/9/14 下午3:02, Kai-Heng Feng wrote:
>> On Lenovo P520, the front panel headset LED isn't lit up right now.
>> 
>> Realtek states that the LED needs to be enabled by ALC233's GPIO2, so
>> let's do it accordingly to light the LED up.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>  sound/pci/hda/patch_realtek.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>> 
>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>> index c521a1f17096..ba941bd0b792 100644
>> --- a/sound/pci/hda/patch_realtek.c
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -6017,6 +6017,7 @@ static void alc_fixup_thinkpad_acpi(struct hda_codec *codec,
>>  #include "hp_x360_helper.c"
>>    enum {
>> +	ALC269_FIXUP_GPIO2,
>>  	ALC269_FIXUP_SONY_VAIO,
>>  	ALC275_FIXUP_SONY_VAIO_GPIO2,
>>  	ALC269_FIXUP_DELL_M101Z,
>> @@ -6194,6 +6195,10 @@ enum {
>>  };
>>    static const struct hda_fixup alc269_fixups[] = {
>> +	[ALC269_FIXUP_GPIO2] = {
>> +		.type = HDA_FIXUP_FUNC,
>> +		.v.func = alc_fixup_gpio2,
>> +	},
>>  	[ALC269_FIXUP_SONY_VAIO] = {
>>  		.type = HDA_FIXUP_PINCTLS,
>>  		.v.pins = (const struct hda_pintbl[]) {
>> @@ -7013,6 +7018,8 @@ static const struct hda_fixup alc269_fixups[] = {
>>  	[ALC233_FIXUP_LENOVO_MULTI_CODECS] = {
>>  		.type = HDA_FIXUP_FUNC,
>>  		.v.func = alc233_alc662_fixup_lenovo_dual_codecs,
>> +		.chained = true,
>> +		.chain_id = ALC269_FIXUP_GPIO2
>>  	},
>>  	[ALC233_FIXUP_ACER_HEADSET_MIC] = {
>>  		.type = HDA_FIXUP_VERBS,

