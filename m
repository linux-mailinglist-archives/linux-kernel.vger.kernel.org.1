Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4A42C003E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 07:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgKWGru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 01:47:50 -0500
Received: from gecko.sbs.de ([194.138.37.40]:37383 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727393AbgKWGru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 01:47:50 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 0AN6lT0g030330
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Nov 2020 07:47:29 +0100
Received: from [167.87.38.29] ([167.87.38.29])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0AN6lSOL014252;
        Mon, 23 Nov 2020 07:47:29 +0100
Subject: Re: About regression caused by commit aea6cb99703e ("regulator:
 resolve supply after creating regulator")
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Qu Wenruo <wqu@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        broonie@kernel.org
References: <c13f1683-97c9-40b4-f740-73eaceb7c98f@suse.com>
 <20201108171811.GB10914@qmqm.qmqm.pl>
 <858790f6-8b22-4fe7-bb74-56904ad203bd@suse.com>
 <cea48473-eeb1-db60-cc0d-ebf9a26aaf0c@siemens.com>
 <20201122163534.GA16669@qmqm.qmqm.pl>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <85cc66a3-2625-acd5-ca28-6ef0abaadd21@siemens.com>
Date:   Mon, 23 Nov 2020 07:47:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201122163534.GA16669@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.11.20 17:35, Michał Mirosław wrote:
> On Sun, Nov 22, 2020 at 03:43:33PM +0100, Jan Kiszka wrote:
>> On 09.11.20 00:28, Qu Wenruo wrote:
>>> On 2020/11/9 上午1:18, Michał Mirosław wrote:
>>>> On Sun, Nov 08, 2020 at 03:35:33PM +0800, Qu Wenruo wrote:
> [...]
>>>>> It turns out that, commit aea6cb99703e ("regulator: resolve supply after
>>>>> creating regulator") seems to be the cause.
> [...]
>> We are still missing some magic fix for stable trees: On the STM32MP15x,
>> things are broken since 5.4.73 now. And 5.9.y is not booting as well on
>> that board. Reverting the original commit make it boot again.
>>
>> Linus master is fine, though, but I'm tired of bisecting. Any
>> suggestions? Or is there something queued up already?
> 
> You might want to look at `git log --grep=aea6cb99703e` if you can't
> wait for a stable backport.
> 

Good. Is that flagged and tested for 5.9/5.4 (and whatever is also
affected) already?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
