Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6686B27488F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 20:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgIVStP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 14:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgIVStP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 14:49:15 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9993C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 11:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=bXCprHXJBlm7ATmV5LwzCeuOoM7fLlfLlA/R7WtLeV4=; b=wkmMsamsgLxTuF8Zky11YWQ8Xj
        R/YlmMt11KdJWhuUnFGazpgZr74YYcHK0c8D6/ClSgh6TznP8KVsFDykxLGQV0IbbIhdmSKlPCEay
        76gIgZJCtWR2uO2RsOgQGBDu82WGG2LXtOIIfC5HTmRSeRB91u7oTvW+mZVAF5rg1kImUTeoFpyXc
        tf9Nw/P0ubHaKux/n0bEPHByXvFvI/VM/d9R1JpB5GxsmptJYL0pTzwuKsy/ct+VGqA9Dy4saO90Y
        AN+YJ5rf7qLrdKHK7uiYyMjjkpXOSWRvTSI1H7p/P8yvDi3IK7xVwKnMWW27ld3pP3J70iro9r8Nd
        jHM5Bpvw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKnLf-0006nP-Uh; Tue, 22 Sep 2020 18:49:08 +0000
Subject: Re: [PATCH] scripts: increase error-prone spell checking
To:     Joe Perches <joe@perches.com>, Wang Qing <wangqing@vivo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        David Hildenbrand <david@redhat.com>,
        SeongJae Park <sjpark@amazon.de>, Xiong <xndchn@gmail.com>,
        linux-kernel@vger.kernel.org
References: <1600773524-3158-1-git-send-email-wangqing@vivo.com>
 <ff5dbd13-86c1-89f6-2741-19dd49fdadcf@infradead.org>
 <5c108605003d8ee48665ce616ec31c599c7f0c39.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9e872477-4fb2-bf37-df76-bc6fd3f2972b@infradead.org>
Date:   Tue, 22 Sep 2020 11:49:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <5c108605003d8ee48665ce616ec31c599c7f0c39.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/20 9:00 AM, Joe Perches wrote:
> On Tue, 2020-09-22 at 07:37 -0700, Randy Dunlap wrote:
>> On 9/22/20 4:18 AM, Wang Qing wrote:
>>> Increase direcly,ununsed,manger spelling error check
>>>
>>> Signed-off-by: Wang Qing <wangqing@vivo.com>
>>> ---
>>>  scripts/spelling.txt | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/scripts/spelling.txt b/scripts/spelling.txt
>>> index f253681..91ab82b
>>> --- a/scripts/spelling.txt
>>> +++ b/scripts/spelling.txt
>>> @@ -1534,3 +1534,6 @@ writting||writing
>>>  wtih||with
>>>  zombe||zombie
>>>  zomebie||zombie
>>> +direcly||directly
>>> +ununsed||unused
>>> +manger||manager
>>> \ No newline at end of file
>>>
>>
>> Uh, that file was in alphabetical order. Please try to keep it that way.
> 
> More or less, but not completely.
> It's somewhat grouped by desired correction,
> but it's also somewhat random.

OK. Thanks for that.

> Here's a sorted diff:
> ---
>  scripts/spelling.txt | 204 +++++++++++++++++++++++++--------------------------
>  1 file changed, 102 insertions(+), 102 deletions(-)


-- 
~Randy

