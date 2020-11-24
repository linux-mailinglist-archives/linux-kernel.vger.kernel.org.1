Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F042C26C7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387838AbgKXNGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387739AbgKXNGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:06:12 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B7CC0613D6;
        Tue, 24 Nov 2020 05:06:12 -0800 (PST)
Received: from ip4d149f6e.dynamic.kabel-deutschland.de ([77.20.159.110] helo=[192.168.66.101]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1khY1E-0004Nd-P2; Tue, 24 Nov 2020 14:06:05 +0100
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
References: <cover.1606137108.git.linux@leemhuis.info>
 <c07e51e153f453c83c77a75513ad3d5ec70ef1be.1606137108.git.linux@leemhuis.info>
 <20201124091852.GB11695@lst.de>
 <04eae024-811d-d11e-b8bd-52f0dd0e225f@leemhuis.info>
 <20201124093658.GA13174@lst.de>
 <e424e24f-08d3-0b83-3d5b-ac500c753792@leemhuis.info>
 <20201124121109.GY4327@casper.infradead.org>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v3 1/3] LICENSES: Add the CC-BY-4.0 license
Message-ID: <7d6c3ce6-a635-8066-924b-3ee41ee34353@leemhuis.info>
Date:   Tue, 24 Nov 2020 14:06:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201124121109.GY4327@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GH
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1606223172;6529df00;
X-HE-SMSGID: 1khY1E-0004Nd-P2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.11.20 um 13:11 schrieb Matthew Wilcox:
> On Tue, Nov 24, 2020 at 11:07:41AM +0100, Thorsten Leemhuis wrote:
>> There is nothing special with this text, it's just that GPL is known to not
>> be really ideal for documentation. That makes it hard for people to reuse
>> parts of the docs outside of the kernel context, say in books or on
>> websites. But it IMHO would be good for us if others could simply use this
>> text as a base in such places. Otherwise they'd often face a situation where
>> they had to write something completely new themselves, which afsics often
>> leads to texts that can be incomplete, inaccurate or actually missleading.
>> That can lead to bad bug reports, which is annoying both for reporters and
>> kernel developers.
>>
>> That's why I came up with the thought "make the text available under more
>> liberal license in addition to the GPLv2 is a good idea here". I considered
>> MIT, but from what I see CC-BY 4.0 is a way better choice for documentation
>> that is more known to authors.
>>
>> And I hope others pick up the idea when they write new documentation for the
>> kernel, so maybe sooner or later it's not unusual anymore.
> 
> It's really tricky to make this work when, eg, including kernel-doc from
> files which are unambiguously licensed under the GPL.

Yeah, I'm aware of that and see the risk. But the text I proposed does 
not include anything from other files (apart from titles), so is this 
risk a problem for this case? Or just something you fear might become a 
problem when other texts in the documentation start to use CC-BY without 
thinking it through?

And the processed text at no point mentions its license, so people can't 
redistribute it anyway. Only the source file mentions it, where nothing 
is included.

>  I'd be happy to
> sign up to licensing the files I control under GPL-with-CC-BY-SA-exception
> that said something like "any documentation extracted from this file may
> be distributed under the BY-SA license", but I'm not sure everybody would.

I tend to say discussing steps like that is better left for a point of 
time when somebody actually wants to use BY-SA for the documentation and 
include kernel-doc from source files at the same time.

Ciao, Thorsten
