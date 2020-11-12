Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73012B016E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 09:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgKLI7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 03:59:36 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51572 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgKLI7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 03:59:36 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AC8wLtO120801;
        Thu, 12 Nov 2020 02:58:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605171501;
        bh=UmSY0edIf57Yap12ihdDOUqAqI05HX2cAZc82RxQrXk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=msUEzorsyk84ZK/LOeX29FtcG5Xk9UIHfWWUpKlVqM8GumH10EMxUNv/E1TYh70Dr
         aOll4/ApPVGZiVIlCu6kBuVm139LOesTK/z+zWom/zuyY6eJNPuz0/5IeaAx14cDo3
         UJeg2SjBSg/vn2F1jryUC6OeV/RX0us8fdx/hFXw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AC8wL1U090221
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 02:58:21 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 02:58:21 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 02:58:20 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AC8wIj8011893;
        Thu, 12 Nov 2020 02:58:19 -0600
Subject: Re: [PATCH] ASoC: pcm512x: Add support for data formats RJ and LJ
To:     Kirill Marinushkin <kmarinushkin@birdec.com>
CC:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Reichl <hias@horus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20201109212133.25869-1-kmarinushkin@birdec.com>
 <690508c7-7029-6781-a1a2-0609e37cb9e6@ti.com>
 <a3df4fb0-35cd-4757-2037-d4ff80e9f74c@birdec.com>
 <d0f76607-c3a5-9b87-dc0e-eddbce585558@ti.com>
 <6e14cdc3-2d45-d7bc-14eb-30c6ea568078@birdec.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <43973577-f719-b414-395c-91a4e1a3b460@ti.com>
Date:   Thu, 12 Nov 2020 10:59:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <6e14cdc3-2d45-d7bc-14eb-30c6ea568078@birdec.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

On 12/11/2020 9.57, Kirill Marinushkin wrote:
>> The set_fmt callback is there to set the bus format, it has nothing to
>> do (in most cases) with the sample format (hw_params). Bus coding, clock
>> source has nothing to do with hw_params.
>>
>> When you bind a link you will use set_fmt for the two sides to see if
>> they can agree, that both can support what has been asked.
>>
>> The pcm512x driver just saves the fmt and say back to that card:
>> whatever, I'm fine with it. But runtime during hw_params it can fail due
>> to unsupported bus format, which it actually acked to be ok.
>>
>> This is the difference.
>>
>> Sure, some device have constraint based on the fmt towards the hw_params
>> and it is perfectly OK to do such a checks and rejections or build
>> rules/constraints based on fmt, but failing hw_params just because
>> set_fmt did not checked that the bus format is not even supported is not
>> a nice thing to do.
> 
> Those are good arguments
> 
>>> Would you agree?
>>
>> I don't have a device to test, I'm just trying to point out what is the
>> right thing to do.
> 
> I have a device to test. I will move format checks into `pcm512x_set_fmt()`,
> ensure that it works properly, and submit as patch v3.

Thank you. I know it is slightly more work.

When you send v3 please do not use --in-reply-to, let it be itself.

Regards,
- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
