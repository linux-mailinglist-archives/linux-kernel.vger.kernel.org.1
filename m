Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB1B2BAAE6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 14:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgKTNQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 08:16:09 -0500
Received: from www381.your-server.de ([78.46.137.84]:51368 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgKTNQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 08:16:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=uNlmvTkJlfUfkP1mNVRlX6byRmlW03DDOuT/fy6Pb1s=; b=ca0XXgVYissccmdKgaqut10/FO
        TAtmChNCYpNV89EasjoGQIDrEctV7V6CPclmKyJOWw+zsRFnSr4Au5MONgXwyKSQnat4ipk2TizpY
        fRarKyOct1Zg7jjRizKZUxEm2VCKviawLgjQfzRd8pPyWCLlVB/Mj7hjPQrBZywYKuxpzMrAvJ/K4
        q9acNRrRnuxyKoaj7WbyhejLQUuCN9Mikz3YfPCfb4JA6O4bndMpfjO/Qvbwa2lkI9IYgHJ5yKkE7
        gEyBZ8l/xrX2O13LRtPXxr6kRiXcaRblQ/9DBNPbsUw5K1OVFGCZbGXnPRGw/LJDH4ZV3IKfE7fBr
        5uVDzPhA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kg6Gf-0004jy-6g; Fri, 20 Nov 2020 14:16:02 +0100
Received: from [62.216.202.98] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kg6Ge-0008B9-Ue; Fri, 20 Nov 2020 14:16:01 +0100
Subject: Re: [Cocci] Proposal for a new checkpatch check; matching
 _set_drvdata() & _get_drvdata()
To:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>
Cc:     Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Robo Bot <apw@canonical.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        cocci <cocci@systeme.lip6.fr>
References: <CA+U=Dspy5+RE9agcLr6eY9DCMa1c5+++0JLeugMMBRXz4YLj1w@mail.gmail.com>
 <CAHp75VcT5hZH6m0Dri1h_EFjc7=4+1XoE7sRuQyfO75k9A0GKA@mail.gmail.com>
 <b74517242de5790f8ab0cd9be00a70b9ab96564c.camel@perches.com>
 <alpine.DEB.2.22.394.2011201140480.2750@hadrien>
 <CA+U=Dsp8Aws7_GARfgNE4w_1pK-hDVW9WVsWHF1TfZUEUo0Hbw@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <4af50412-a22f-4ca1-adb0-d732438c6669@metafoo.de>
Date:   Fri, 20 Nov 2020 14:16:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CA+U=Dsp8Aws7_GARfgNE4w_1pK-hDVW9WVsWHF1TfZUEUo0Hbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25993/Thu Nov 19 14:11:24 2020)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/20 12:54 PM, Alexandru Ardelean wrote:
> On Fri, Nov 20, 2020 at 12:47 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>>
>>
>> On Thu, 19 Nov 2020, Joe Perches wrote:
>>
>>> On Thu, 2020-11-19 at 17:16 +0200, Andy Shevchenko wrote:
>>>> On Thu, Nov 19, 2020 at 4:09 PM Alexandru Ardelean
>>>> <ardeleanalex@gmail.com> wrote:
>>>>> Hey,
>>>>>
>>>>> So, I stumbled on a new check that could be added to checkpatch.
>>>>> Since it's in Perl, I'm reluctant to try it.
>>>>>
>>>>> Seems many drivers got to a point where they now call (let's say)
>>>>> spi_set_drvdata(), but never access that information via
>>>>> spi_get_drvdata().
>>>>> Reasons for this seem to be:
>>>>> 1. They got converted to device-managed functions and there is no
>>>>> longer a remove hook to require the _get_drvdata() access
>>>>> 2. They look like they were copied from a driver that had a
>>>>> _set_drvdata() and when the code got finalized, the _set_drvdata() was
>>>>> omitted
>>>>>
>>>>> There are a few false positives that I can notice at a quick look,
>>>>> like the data being set via some xxx_set_drvdata() and retrieved via a
>>>>> dev_get_drvdata().
>>>> I can say quite a few. And this makes a difference.
>>>> So, basically all drivers that are using PM callbacks would rather use
>>>> dev_get_drvdata() rather than bus specific.
>>>>
>>>>> I think checkpatch reporting these as well would be acceptable simply
>>>>> from a reviewability perspective.
>>>>>
>>>>> I did a shell script to quickly check these. See below.
>>>>> It's pretty badly written but it is enough for me to gather a list.
>>>>> And I wrote it in 5 minutes :P
>>>>> I initially noticed this in some IIO drivers, and then I suspected
>>>>> that this may be more widespread.
>>>> It seems more suitable for coccinelle.
>>> To me as well.
>> To me as well, since it seems to involve nonlocal information.
>>
>> I'm not sure to understand the original shell script. Is there
>> something interesting about pci_set_drvdata?
> Ah, it's a stupid script I wrote in 5 minutes, so I did not bother to
> make things smart.
> In the text-matching I did in shell, there are some entries that come
> from comments and docs.
> It's only about 3-4 entries, so I just did a visual/manual ignore.
>
> In essence:
> The script searches for all strings that contain _set_drvdata.
> The separators are whitespace.
> It creates a list of all  xxxx_set_drvdata functions.
> For each xxxx_set_drvdata function:
>      It checks all files that have a xxxx_set_drvdata entry, but no
> xxxx_get_drvdata
>
> I piped this output into a file and started manually checking the drivers.
> There is one [I forget which function] that is xxxx_set_drvdata() but
> equivalent is xxxx_drvdata()
>
> As Andy said, some precautions must be taken in places where
> xxxx_set_drvdata() is called but dev_get_drvdata() is used.
> Cases like PM suspend/resume calls.
> And there may be some cases outside this context.
>
Doing something like this with coccinelle is fairly easy.

But I'd be very cautious about putting such a script into the kernel. It 
will result in too many false positive drive-by patches. Such a script 
will not detect cases such as:

  * Driver is split over multiple files. One file does 
..._set_drvdata(), another does ..._get_drvdata().

  * Framework uses drvdata to exchange data with the driver. E.g driver 
is expected to call set_drvdata() and then the framework uses 
get_drvdata() to retrieve the data. This is not a very good pattern, but 
there are some palces int he kernel where this is used. I believe for 
example V4L2 uses this.

- Lars

