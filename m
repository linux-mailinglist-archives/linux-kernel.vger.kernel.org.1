Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DDF2DDDCD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 06:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbgLRFTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 00:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgLRFTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 00:19:15 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B52C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 21:18:35 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id d20so913324otl.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 21:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1xKkDaNrjtK4OKEl9Wb54qF1vD0YdQD4dbYCh/to+q4=;
        b=ane+fuQjd558kpfHw/YF/pe55ifrQlW1QI2/CjVfrfsG4uB7sMBpBTnbmxpVpAh/jY
         aY+IoJbRApixHa4675zUGvg8Wl8WNQ+G1KK24kMVW9PDQXAkAK0PBtq7IDzyOrTngQqQ
         ZSBb85X6FKrkWIA69B9jL3GD/aUdH9lMXTfpZ9A3D0aaTUhnvbHnjpNj3P28ymToGI1T
         gOWSt5IcGZs3OfGWC19tqQ1RjRBiFHx9cmzQnHqdEUDdYlaZAxGReGvcKiFjFUkYADL1
         7b52grFxzyrNAkD7Qo0676NMhfN6Wc40ouEN5+kQnLONNvL3rao6knSw5pxRqhCqvMjf
         SGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1xKkDaNrjtK4OKEl9Wb54qF1vD0YdQD4dbYCh/to+q4=;
        b=RgoX0J40gr2xjYcfUxl4lnH8aZQYuK4QukK4dWLG/bCoArkkKi0aE1UtDF1Q6JOVS+
         Yc6uK0QksrXMsXITDOxc1aYtL1NwBXFYsMfm0M7LKnFOxtskyAh1SM89Gl16IEEd4yzi
         rysRyr5pfTd05eyvpVux0Ikq7bniZ0P2bruLAFqqPJiRaKLywzPXck3h0RbyaTVAMQog
         fj4AUPfjMmgezR6NGe9bFO60aSXlelPEeauCeeKS57v2E/Xhd+KaaiBdbUKfFUxwMN5q
         KUUZ/IyI0EyZkYnO52zzOSJLXVw9iBGkNyzuuc1EN0dcgIX79zaUQyf5pD4K0jpN1AQZ
         fsTQ==
X-Gm-Message-State: AOAM531sxN+u8lZwJKiEZk0u/l9pH02RHiJKEj+QnHmr24jy0vSxUCS/
        hAGWkeBIGpLr4bzi9LksRiA=
X-Google-Smtp-Source: ABdhPJzoEwTjMMqOkjAmOWNDwWGu6lhuPijqSziI0e40zyo/Ht0Gi4tuDKwWCDLK6VLwb8zPgvE11w==
X-Received: by 2002:a9d:7ac1:: with SMTP id m1mr1764384otn.186.1608268714129;
        Thu, 17 Dec 2020 21:18:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h7sm1723710otq.21.2020.12.17.21.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 21:18:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 3/5] irqchip/bcm2836: Make IPIs use
 handle_percpu_devid_irq()
To:     Marc Zyngier <maz@kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andrew Lunn <andrew@lunn.ch>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Scott Branden <sbranden@broadcom.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
References: <20201109094121.29975-1-valentin.schneider@arm.com>
 <20201109094121.29975-4-valentin.schneider@arm.com>
 <20201215002134.GA182208@roeck-us.net>
 <38f8fbe9ceb7a0adb47e62d62260b297@kernel.org>
 <1795afb5-a4fd-3a90-99c4-71373476ad65@roeck-us.net>
 <9007dd8a0d5334141d083b14121ba11c@kernel.org>
 <c9fb4ab3-a5cb-648c-6de3-c6a871e60870@roeck-us.net>
 <dff83a32c64bad6e3880dba8804cea6c@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <0334f005-1c62-cad0-37e0-3b1eb3ee4082@roeck-us.net>
Date:   Thu, 17 Dec 2020 21:18:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <dff83a32c64bad6e3880dba8804cea6c@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/20 7:46 AM, Marc Zyngier wrote:
> On 2020-12-15 15:39, Guenter Roeck wrote:
>> On 12/15/20 7:26 AM, Marc Zyngier wrote:
>>> On 2020-12-15 15:21, Guenter Roeck wrote:
>>>> Hi Marc,
>>>>
>>>> On 12/15/20 2:19 AM, Marc Zyngier wrote:
>>>>> Hi Gunter,
>>>>>
>>>>> On 2020-12-15 00:21, Guenter Roeck wrote:
>>>>>> On Mon, Nov 09, 2020 at 09:41:19AM +0000, Valentin Schneider wrote:
>>>>>>> As done for the Arm GIC irqchips, move IPIs to handle_percpu_devid_irq() as
>>>>>>> handle_percpu_devid_fasteoi_ipi() isn't actually required.
>>>>>>>
>>>>>>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>>>>>>
>>>>>> This patch results in boot failures (silent stall) for the qemu
>>>>>> raspi2 emulation. Unfortunately it can not be reverted because
>>>>>> handle_percpu_devid_fasteoi_ipi no longer exists in next-20201214,
>>>>>> so I don't know if it is the only problem.
>>>>>
>>>>> This is odd. This works just fine for me on both the RPi2 and 3
>>>>> emulation, running a full Debian userspace. Could this be caused
>>>>> by the version of QEMU you are using? Here's what I have:
>>>>>
>>>>> $ qemu-system-arm --version
>>>>> QEMU emulator version 5.1.0 (Debian 1:5.1+dfsg-4+b1)
>>>>>
>>>>
>>>> I used qemu 5.0 which - up to now - worked fine. Let me try with
>>>> 5.1 and 5.2. Sorry, I should have tried first before bothering you.
>>>
>>> No bother at all. If this works for you on more recent versions of
>>> QEMU, that'd be an interesting data point. I'm also interested in
>>> the result of the patch either way.
>>>
>>
>> It doesn't work for me with qemu 5.1, nor with qemu 5.2. My userspace
>> is generated with buildroot, busybox-based, and very basic.
> 
> OK, so something is definitely different between our setups.
> Mind pointing me to your config and your QEMU invocation?
> 
>>
>> Your patch fixes the problem for me, though, so feel free to add
>>
>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>>
>> if/when you submit it.
> 
> Thanks for that.
> 

Any news on this? I now see the problem in mainline.

Thanks,
Guenter

