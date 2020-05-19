Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4121D8FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 08:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgESGVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 02:21:40 -0400
Received: from mail82c50.megamailservers.eu ([91.136.10.92]:32888 "EHLO
        mail18c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726841AbgESGVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 02:21:40 -0400
X-Authenticated-User: 017623705678@o2online.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
        s=maildub; t=1589869278;
        bh=bICxOQkKWptX/IVuhwdUQBYTZXOzDZV8tWkiB06kPZk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aIRDb6AHzj4Zkla7eGQfHpE8+9vTBNWYZUfl2fNGe6h0cc50ecNkd0pYGfcl4cyi5
         n9NhB7/VsEcr76oqLrtfc9qexTGR9DkYfBJFAr+VSqh6trtStfIXo5nygWor+NuqdH
         dhmdXqhrVaLexdPKzgvdwy8r6yuxdQ9wVyqZTknc=
Feedback-ID: 017623705678@o2
Received: from [192.168.2.2] (dslb-178-011-017-047.178.011.pools.vodafone-ip.de [178.11.17.47])
        (authenticated bits=0)
        by mail18c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id 04J6LE8B005870;
        Tue, 19 May 2020 06:21:15 +0000
Subject: Re: RTL8723BS driver doesn't work for,me but I can help testing
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <bcefba5b-107c-716b-bb60-5b4b2476894b@o2online.de>
 <CAFBinCD8-tr97GCVhBi5R1nzxLhy=_6VuLY8ubUO1SDTFjiELw@mail.gmail.com>
 <22af498b-44a0-ced3-86f3-114427a73910@o2online.de>
 <CAFBinCCGAkhPCwOW=mAvsV2qdixq8Gf8yQw1gYErHpz7KmuAZg@mail.gmail.com>
 <5de6db87-a71f-d14c-390d-b0caeab5d650@o2online.de>
 <CAFBinCDB9c2uMRXO9DKSX4hC7EBgnRfBa+BM5-VdEPZeieKn_w@mail.gmail.com>
 <813dfc08-f13a-dcac-0bd9-821d188bba08@o2online.de>
 <CAFBinCCgZF5Pu944q-_+V0yQ-nc6q82xDjJHjsnj6=uOQL+DEw@mail.gmail.com>
 <8cbbf90c-54ba-8fa3-3386-022c9c997a20@o2online.de>
 <CAFBinCBukGbzgO-Y1dCRYXZHhX2PcSEQQ_XvhHqLcnw0fGDP8w@mail.gmail.com>
 <a95f5fe1-4376-f872-961a-c2237c36811c@o2online.de>
 <CAFBinCCgFtv=u4ZKW3rdoDPZ_jh3jU03MDxHoDk=pbi+4pxB_w@mail.gmail.com>
From:   Tobias Baumann <017623705678@o2online.de>
Message-ID: <c244b34f-8958-0cbd-38e6-a786aef56e7c@o2online.de>
Date:   Tue, 19 May 2020 08:21:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCCgFtv=u4ZKW3rdoDPZ_jh3jU03MDxHoDk=pbi+4pxB_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
X-Antivirus: AVG (VPS 200518-0, 18.05.2020), Outbound message
X-Antivirus-Status: Clean
X-CTCH-RefID: str=0001.0A782F1A.5EC37A8E.0094,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
X-CSC:  0
X-CHA:  v=2.3 cv=K8Zc4BeI c=1 sm=1 tr=0 a=cfXdPu6Ul6OsnrHrce2WRQ==:117
        a=cfXdPu6Ul6OsnrHrce2WRQ==:17 a=IkcTkHD0fZMA:10 a=oCcaPWc0AAAA:8
        a=DZZeUtYjHzpd_z8FqtsA:9 a=QEXdDO2ut3YA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

good morning

i got the new image from oleg(balbes150) 20200518 RC5  and some more 
feedback

with my patch and oleg RC5 hotstart(shutdown now)  do not work with my 
box ( wlan goes back to sleep mode always)

with my patch chance  1 of 5 till 1 of 3 that my wlan is up and not 
sleep from cold start

with oleg chance 1 of 2 till 1of 3 from cold start that wlan is up  . 
(maybe because of phandle order?)

i thing there is maybe a timming problem between  wlan dis , sdio  data 
and  host wake up wlan .

it could be that GPIOAO_6 is the host wake up wlan ? is it possible to 
change the activation order for the gpio pins by change it in dts ?

Tobias



Am 18.05.2020 um 22:37 schrieb Martin Blumenstingl:
> Hi Tobias,
>
> On Mon, May 18, 2020 at 7:59 AM Tobias Baumann <017623705678@o2online.de> wrote:
>> hi martin
>>
>> i activate your patch ; wlan works ;  also with only  edit GPIOX_11 wlan
>> works
>>
>> its now GPIO-402 out high ACTIVE_LOW  ( 3.3V on pin12)
> great, thank you for doing the research!
>
> did you find out if GPIOAO_6 is needed at all?
> the 3.10 kernel enables it and sets it to HIGH. my understanding is
> that you didn't change this one so the output is still LOW.
> so I'm wondering if it is needed at all (I wouldn't be surprised if it
> was not needed, these 3.10 kernel .dts files seem to be copy&pasted
> from various vendors and do not necessarily reflect the actual
> hardware setup inside the box)
>
>> i also attached the performance infos  Wlan0->Router and RAM->SDHC
> that's pretty good, great to see that it works fine for you :-)
>
>
> Martin
>

-- 
Diese E-Mail wurde von AVG auf Viren geprüft.
http://www.avg.com

