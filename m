Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67322C1C25
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 04:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgKXDf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 22:35:57 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:36801 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726000AbgKXDf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 22:35:56 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 2DCFE11A8;
        Mon, 23 Nov 2020 22:35:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 23 Nov 2020 22:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=R
        i7M0RpLp7s82VQj5tEZ6vDOqJqVAViTcMsgsc2jrSY=; b=TipzpapQV1rH4epBq
        n7zK8q4GHPyeEFaS3J18vWxfPKAZdinjBI74wS2hHPfUOHpJ6E6h5kztJ1plg45J
        prH9pxIJfMiT1HMb4JgO0wpJg4CuX6uiEaQfS8ezOIlLGOzFCK2Szw6QyZj9GU9V
        AR9Za231Bgkz96HgJTGZ/Hcg9amt25pUWyHE17iEAhrmA2vmjcRyI7uYkB0icojl
        4kvQcE0XAMbVqFYE1t8H/EtDHW8uwsI2HzmseG3iz+/w0XNWNnmrI2eN7PzTsCXP
        dBHC1uZo9CfkWR7b0fmSxai95t3NN7NGMfS2CTIJnti58j8eG3DaGI+B1e8rijs7
        0Yu7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=Ri7M0RpLp7s82VQj5tEZ6vDOqJqVAViTcMsgsc2jr
        SY=; b=gCfpM8LlHPUCUY+XE9mJN5A3JiuIz2e2Lkgh4P+KGuz9VpufY3pcKEx64
        pYsfK3o5tl2DMr3FUCR9AlYKkNMzRPfUz9706/r/OJpJz5AmPxQcchohwKZv7kms
        Fv/GKlzdNquz0eLzAwlpTA0/JKnU4KoXAtYDcluxhT1cFN9Nu13XuEAVZJ1owg+V
        d7hFBo8kULmQJBoEKOhafFUJ94jpupqZDCpZBXqNR9EqPcTyOD0M1P7mwIzY6okZ
        a7FpxNpMg3V74cXk9PWxG1yJ64c/oCBaGDMfxpAbu/QwNtbi3EaP3ElqhqRsCvmO
        7i15iqGsmqS78GA46LcC0GRqeXgkQ==
X-ME-Sender: <xms:mX-8X1IO-y1yTkFbt39P4qu7H-ufH5JleAU_gyYsSlXR4knZOedMSw>
    <xme:mX-8XxLhULqwuWJsElTa57KiEsJ-SZcUtJcHpUqQRbJiHo4a0rZR653JbAKXWrOp3
    J5krBP3HPGsT-tU7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegjedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfhfhffukffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepuefhffegteegkeejudegkeeifffgjeffffejleettdeuvdeggfeh
    leehjeevveeinecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepjedtrddufe
    ehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:mX-8X9tYng61NHRM8kjnA_NkM6AyIP9_RcjGn1F_VmWSjKQyFagFbQ>
    <xmx:mX-8X2YDCJbX56-Y_ks6XPA1L8OvpqhqP7xDmqX7dzQ51h8IqWkjBA>
    <xmx:mX-8X8bawuZbc9FAyzDa-6FLDBKSv74xX3Sja-uDYxWRIvRcXbmDjA>
    <xmx:mn-8XxOscIvwmfSf_3RTPWAJB6EztLme4LZvuBjy9b2aC5QB7hU3HA>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id EF1D53064AAE;
        Mon, 23 Nov 2020 22:35:52 -0500 (EST)
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
References: <cover.1605693132.git.wilken.gottwalt@posteo.net>
 <149526a0ba8d18ebb68baa24e95d946ede90b4c0.1605693132.git.wilken.gottwalt@posteo.net>
 <20201118153733.jgiokn6jkwu6rv6c@gilmour.lan>
 <20201118203624.7221ba8b@monster.powergraphx.local>
 <20201119071523.5cbpgy2cpo5cmuev@gilmour.lan>
 <20201119111343.74956eae@monster.powergraphx.local>
 <20201120164231.nmzxe5scwnfoyy3o@gilmour> <20201121122255.GB22987@debian>
 <20201121164418.hxrxzgob7whgzkpj@gilmour>
 <20201123193206.0b2d1b6d@monster.powergraphx.local>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 2/2] hwspinlock: add sunxi hardware spinlock support
Message-ID: <39136764-2b58-f66d-68ea-e1c6b4d74edf@sholland.org>
Date:   Mon, 23 Nov 2020 21:35:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201123193206.0b2d1b6d@monster.powergraphx.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/20 12:32 PM, Wilken Gottwalt wrote:
> On Sat, 21 Nov 2020 17:44:18 +0100
> Maxime Ripard <maxime@cerno.tech> wrote:
> 
>> On Sat, Nov 21, 2020 at 08:22:55PM +0800, fuyao wrote:
>>> On Fri, Nov 20, 2020 at 05:42:31PM +0100, Maxime Ripard wrote:
>>>> Hi,
>>>>
>>>> On Thu, Nov 19, 2020 at 11:13:43AM +0100, Wilken Gottwalt wrote:
>>>>> On Thu, 19 Nov 2020 08:15:23 +0100
>>>>> Maxime Ripard <maxime@cerno.tech> wrote:
>>>>>>> can you help me here a bit? I still try to figure out how to do patch sets
>>>>>>> properly. Some kernel submitting documentation says everything goes into the
>>>>>>> coverletter and other documentation only tells how to split the patches. So
>>>>>>> what would be the right way? A quick example based on my patch set would be
>>>>>>> really helpful.
>>>>>>
>>>>>> I mean, the split between your patches and so on is good, you got that right
>>>>>>
>>>>>> The thing I wanted better details on is the commit log itself, so the
>>>>>> message attached to that patch.
>>>>>
>>>>> Ah yes, I think I got it now. So basically add a nice summary of the coverletter
>>>>> there.
>>>>
>>>> Yes, a bit more context as well. Eventually, this should be the
>>>> motivation on why this patch is useful. So what it can be used for, what
>>>> are the challenges, how it was tested, etc.
>>>>
>>>> The cover letter is usually here more to provide some meta-context: what
>>>> you expect from the maintainers / reviewers if it's an RFC, if there's
>>>> any feature missing or that could be added later on, etc.
>>>>
>>>>>>>> Most importantly, this hwspinlock is used to synchronize the ARM cores
>>>>>>>> and the ARISC. How did you test this driver?
>>>>>>>
>>>>>>> Yes, you are right, I should have mentioned this. I have a simple test kernel
>>>>>>> module for this. But I must admit, testing the ARISC is very hard and I have
>>>>>>> no real idea how to do it. Testing the hwspinlocks in general seems to work
>>>>>>> with my test kernel module, but I'm not sure if this is really sufficient. I
>>>>>>> can provide the code for it if you like. What would be the best way? Github?
>>>>>>> Just mailing a patch?
>>>>>>>
>>>>>>> The test module produces these results:
>>>>>>>
>>>>>>> # insmod /lib/modules/5.9.8/kernel/drivers/hwspinlock/sunxi_hwspinlock_test.ko 
>>>>>>> [   45.395672] [init] sunxi hwspinlock test driver start
>>>>>>> [   45.400775] [init] start test locks
>>>>>>> [   45.404263] [run ] testing 32 locks
>>>>>>> [   45.407804] [test] testing lock 0 -----
>>>>>>> [   45.411652] [test] taking lock attempt #0 succeded
>>>>>>> [   45.416438] [test] try taken lock attempt #0
>>>>>>> [   45.420735] [test] unlock/take attempt #0
>>>>>>> [   45.424752] [test] taking lock attempt #1 succeded
>>>>>>> [   45.429556] [test] try taken lock attempt #1
>>>>>>> [   45.433823] [test] unlock/take attempt #1
>>>>>>> [   45.437862] [test] testing lock 1 -----
>>>>>>
>>>>>> That doesn't really test for contention though, and dealing with
>>>>>> contention is mostly what this hardware is about. Could you make a small
>>>>>> test with crust to see if when the arisc has taken the lock, the ARM
>>>>>> cores can't take it?
>>>>>
>>>>> So the best solution would be to write a bare metal program that runs on the
>>>>> arisc and can be triggered from the linux side (the test kernel module) to take
>>>>> a spinlock ... or at least take spinlocks periodically for a while and watch it
>>>>> on the linux side. Okay, I think I can do this. Though, I have to dig through
>>>>> all this new stuff first.
>>>>
>>>> It doesn't have to be super complicated, just a loop that takes a lock,
>>>> sleeps for some time, and releases the lock should be enough to at least
>>>> validate that the lock is actually working
>>>>
>>>
>>> I think the difficulty is the bare metal program in arsic has little
>>> documentation.
>>
>> crust has mostly figured it out:
>> https://github.com/crust-firmware/crust
> 
> I actually have serious trouble to get crust running. It compiles for H2+/H3, but
> I can't figure out if it runs at all. I will switch to a H5 based device which is

Crust does not yet support the H2+/H3 (it is active WIP). H5 should work
well.

> confirmed to work. If I see this correctly crust is doing nothing with spinlocks
> yet, so I may end up also working on crust, adding the spinlocks there too. Don't> know yet how long I will take to understand every detail, but I will
report
> progress.

Correct. There is currently no hwspinlock driver in crust. For testing,
you can poke MMIO from the main loop, near the call to scpi_poll() in
common/system.c. You can use the timeout.h functions for timing.

If you want to write a full driver, I would like to know how you expect
to use the hwspinlocks. Allocating the locks has to be coordinated among
all of the users: Linux, U-Boot, crust, any other ARISC firmware, etc.

> Greetings,
> Wilken

Cheers,
Samuel
