Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE752E23E3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 04:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgLXDFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 22:05:35 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:38748 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728631AbgLXDFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 22:05:34 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UJb.Tkt_1608779089;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UJb.Tkt_1608779089)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Dec 2020 11:04:49 +0800
Subject: Re: [PATCH v2] docs/zh_CN: Improve Cinese transolation quality.
To:     Ran Wang <gxndwr@outlook.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     Harry Wei <harryxiyou@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <AT5PR8401MB096492D31BB7E602E1F45DC9CCCD0@AT5PR8401MB0964.NAMPRD84.PROD.OUTLOOK.COM>
 <20201208080037.40543cdb@lwn.net>
 <AT5PR8401MB096480DF491AAD270CDEDD9CCCC20@AT5PR8401MB0964.NAMPRD84.PROD.OUTLOOK.COM>
 <0529bd5e-8305-e5a3-9c85-ec0d1370caf9@linux.alibaba.com>
 <AT5PR8401MB0964C0D4E2C993755C9DB223CCC00@AT5PR8401MB0964.NAMPRD84.PROD.OUTLOOK.COM>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <8618ce39-c7b8-8ae4-399f-03b0279afb5b@linux.alibaba.com>
Date:   Thu, 24 Dec 2020 11:04:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <AT5PR8401MB0964C0D4E2C993755C9DB223CCC00@AT5PR8401MB0964.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/12/21 下午8:34, Ran Wang 写道:
> Hi Alex,
> 
> 
> On Monday, December 21, 2020 3:52 PM, Alex Shi wrote:
> 
>> 在 2020/12/19 上午11:42, Ran Wang 写道:
>>> Hi Jonathan,
>>>      
>>> On Tuesday, December 8, 2020 11:00 PM Jonathan Corbet wrote:
>>>  
>>>> On Tue,  8 Dec 2020 21:16:04 +0800
>>>> Ran Wang <gxndwr@outlook.com> wrote:
>>>>
>>>>> Signed-off-by: Ran Wang <gxndwr@outlook.com>
>>>>> ---
>>>>> Change in v2:
>>>>>    - For 'cn_development_coding' part, change back to >'是关于编码过程的'
>>>>>
>>>>>   .../translations/zh_CN/process/1.Intro.rst    | 61 >++++++++++---------
>>>>>   1 file changed, 32 insertions(+), 29 deletions(-)
>>>>
>>>> Thank you for working to improve the documentation!  >Please, though,
>>>> include a changelog with your patch; what does "improve >translation
>>>> quality" mean here?
>>>>
>>>> Thanks,
>>>>
>>>> jon
>>>
>>> Sorry I missed your mail.
>>>
>>> Actually I feel difficult to list the change log to describe this (after not I am not a language teacher :) ).
>>>
>>> I would say the original translation looks like a little bit more by machine: English word to Chinese word directly without considering particular scenarios (such as software development related terms we used in Chinese, a little bit different to normal usage maybe). So I tried to re-tell the story in a way more kind of 'human' to make everything clearer for Chinese reader.
>>
>> Hi Ran,
>>
>> I don't think you describe correctly for your new translation. And you are not 're-tell story'
>> for a standard community co-work process, which we don't need. Also the original translation is
>> not by machine, it's by myself.
> 
> Sorry, I didn't mean to offend. You are right.

That's all right. I guess, few my translation is easy to be misunderstood, and I own some explantion:
like 2 places:

1, 'There are a great many "reasons" why kernel code should be merged into the ...'
Here if 'reasons' translated as 'benefits/advantage', that would fits better in Chinese
converstion custom. (I don't strong oppose this). but usually we keep 'reasons' original meaning.

2, 'managing patches with git and reviewing patches "posted" by others.' 
Here the 'posted', I did think a lot on '发布' or '提交', It costed me sometime, But finally I used '发布'
not ‘提交’， since the latter is easy to be confused with git 'commit' in Chinese, while patches we hold
here were posted by email, not 'git'.


> 
>> What you did right is polishing the Chinese words, make it more fluency and fit better for Chinese
>> custom, although it costs a bit verboseness and a bit precision.> 
> The word 'polishing' is the perfect word to describe this, thank you.

We are not professional translators or interpreters (although my wife is one). :)
But there is a standards of the Chinese translation, fidelity, fluency, elegence, let's hang on fidelity,
and try best on fluency or elegence. :)


Thanks
Alex
