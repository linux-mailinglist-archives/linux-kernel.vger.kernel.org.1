Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E43D2C2282
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgKXKHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgKXKHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:07:47 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DB1C0613D6;
        Tue, 24 Nov 2020 02:07:47 -0800 (PST)
Received: from ip4d149f6e.dynamic.kabel-deutschland.de ([77.20.159.110] helo=[192.168.66.101]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1khVEc-0001AA-Ey; Tue, 24 Nov 2020 11:07:42 +0100
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
References: <cover.1606137108.git.linux@leemhuis.info>
 <c07e51e153f453c83c77a75513ad3d5ec70ef1be.1606137108.git.linux@leemhuis.info>
 <20201124091852.GB11695@lst.de>
 <04eae024-811d-d11e-b8bd-52f0dd0e225f@leemhuis.info>
 <20201124093658.GA13174@lst.de>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v3 1/3] LICENSES: Add the CC-BY-4.0 license
Message-ID: <e424e24f-08d3-0b83-3d5b-ac500c753792@leemhuis.info>
Date:   Tue, 24 Nov 2020 11:07:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201124093658.GA13174@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1606212467;8782e6b7;
X-HE-SMSGID: 1khVEc-0001AA-Ey
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.11.20 um 10:36 schrieb Christoph Hellwig:
> On Tue, Nov 24, 2020 at 10:31:33AM +0100, Thorsten Leemhuis wrote:
>> Am 24.11.20 um 10:18 schrieb Christoph Hellwig:
>>> On Tue, Nov 24, 2020 at 09:00:01AM +0100, Thorsten Leemhuis wrote:
>>>> For context: Patch 2 of this series adds a text to the Documentation/ directory
>>>> which (for now) uses "GPL-2.0+ OR CC-BY-4.0", as I want to make it easy and
>>>> attractive for others to base their work on it. I'm not strongly attached to
>>>> CC-BY-4.0, but it seemed like the best choice: it's designed for such usage and
>>>> afaics better than using MIT for text files.
>>>
>>> And you've not Cced me on that patch 2 or patch 3, which makes Ccing
>>> me on this pretty useless as I can't judge the context.
>>
>> Argh, sorry, slipped through. You can find it here:
>>
>> https://lore.kernel.org/linux-doc/2f314e58cb14c1579f843f8c72bdb4bbb83ac20a.1606137108.git.linux@leemhuis.info/
>>
>> FWIW, here it is for easy access (just sent with thunderbird instead of
>> git send-mail, hopefully should be enough for this):
> 
> So what is so special with this documentation that it needs a
> (for the kernel tree) unusual license?

There is nothing special with this text, it's just that GPL is known to 
not be really ideal for documentation. That makes it hard for people to 
reuse parts of the docs outside of the kernel context, say in books or 
on websites. But it IMHO would be good for us if others could simply use 
this text as a base in such places. Otherwise they'd often face a 
situation where they had to write something completely new themselves, 
which afsics often leads to texts that can be incomplete, inaccurate or 
actually missleading. That can lead to bad bug reports, which is 
annoying both for reporters and kernel developers.

That's why I came up with the thought "make the text available under 
more liberal license in addition to the GPLv2 is a good idea here". I 
considered MIT, but from what I see CC-BY 4.0 is a way better choice for 
documentation that is more known to authors.

And I hope others pick up the idea when they write new documentation for 
the kernel, so maybe sooner or later it's not unusual anymore.

>  How to we make sure people
> don't accidentally end up including things they can't?

Well, the license in only specified in the header and not visible in the 
rendered HTML, which reduces the risk already. To make it even smaller I 
could add something like this to the header:

```
In case you want to use this text under CC-BY-4.0, make sure to take the 
plaintext version
  straight from the Linux kernel sources as base. This is because 
processed versions of this text (like one rendered to HTML or PDF) will 
have text in them
  that is taken from other files which that are not available under 
CC-BY-4.0
  license.
```

Ciao, Thorsten
