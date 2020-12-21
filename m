Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3AAE2DF99C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 08:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgLUHxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 02:53:22 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:34012 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726200AbgLUHxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 02:53:21 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UJFraV9_1608537157;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UJFraV9_1608537157)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Dec 2020 15:52:38 +0800
Subject: Re: [PATCH v2] docs/zh_CN: Improve Cinese transolation quality.
To:     Ran Wang <gxndwr@outlook.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     Harry Wei <harryxiyou@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <AT5PR8401MB096492D31BB7E602E1F45DC9CCCD0@AT5PR8401MB0964.NAMPRD84.PROD.OUTLOOK.COM>
 <20201208080037.40543cdb@lwn.net>
 <AT5PR8401MB096480DF491AAD270CDEDD9CCCC20@AT5PR8401MB0964.NAMPRD84.PROD.OUTLOOK.COM>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <0529bd5e-8305-e5a3-9c85-ec0d1370caf9@linux.alibaba.com>
Date:   Mon, 21 Dec 2020 15:52:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <AT5PR8401MB096480DF491AAD270CDEDD9CCCC20@AT5PR8401MB0964.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/12/19 上午11:42, Ran Wang 写道:
> Hi Jonathan,
>     
> On Tuesday, December 8, 2020 11:00 PM Jonathan Corbet wrote:
>  
>> On Tue,  8 Dec 2020 21:16:04 +0800
>> Ran Wang <gxndwr@outlook.com> wrote:
>>
>>> Signed-off-by: Ran Wang <gxndwr@outlook.com>
>>> ---
>>> Change in v2:
>>>    - For 'cn_development_coding' part, change back to >'是关于编码过程的'
>>>
>>>   .../translations/zh_CN/process/1.Intro.rst    | 61 >++++++++++---------
>>>   1 file changed, 32 insertions(+), 29 deletions(-)
>>
>> Thank you for working to improve the documentation!  >Please, though,
>> include a changelog with your patch; what does "improve >translation
>> quality" mean here?
>>
>> Thanks,
>>
>> jon
> 
> Sorry I missed your mail.
> 
> Actually I feel difficult to list the change log to describe this (after not I am not a language teacher :) ).
> 
> I would say the original translation looks like a little bit more by machine: English word to Chinese word directly without considering particular scenarios (such as software development related terms we used in Chinese, a little bit different to normal usage maybe). So I tried to re-tell the story in a way more kind of 'human' to make everything clearer for Chinese reader.

Hi Ran,

I don't think you describe correctly for your new translation. And you are not 're-tell story'
for a standard community co-work process, which we don't need. Also the original translation is
not by machine, it's by myself.

What you did right is polishing the Chinese words, make it more fluency and fit better for Chinese
custom, although it costs a bit verboseness and a bit precision.


Thanks
Alex

> 
> Anyway, I am willing to provide you such change log if you could provide me an example for reference (this is my first time to post such patch).
> 
> Thanks & Regards,
> Ran
> 
