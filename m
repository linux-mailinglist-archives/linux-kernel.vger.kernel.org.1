Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA762E0D73
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 17:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgLVQh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 11:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbgLVQh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 11:37:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D45C0613D3;
        Tue, 22 Dec 2020 08:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=K6TY+2C87Nj2Uq8Izy+0y+KXHauQffDaMdJAxzjoZ6s=; b=bwf62DIJfsUfHKXIpyhlGNotni
        yYIhhi671lt8p9+fgbrNYgf3RDFH77C8bRHsERXVzi93yh6SpB0DmGHVugS7T+R1SnyR+tqhRIVh/
        0HpJ+8KwjiUYEVfLnJFGOQ3gnDOBVB4LUl3XKYT7XInI0IaCBHYvVxT9Jh8oeaTiHORK5qAhn+MIy
        G14RomDlNZ2rhfPFKpLxPP5biI4uOCdbuWoUHoY0kHq0OzTE0bItCTvPGJAZHVDc9x+71Ij2/SIhd
        ZWUsSXb+S0DTG3bkkB6xO/XsRYgrI3BWdpYJnCmD6/vWS9JxLhBectNEyvrK75eVGiWoMVEqlcGN7
        tMkaFgrQ==;
Received: from [2601:1c0:6280:3f0::64ea]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krkeQ-0005jc-Ve; Tue, 22 Dec 2020 16:36:43 +0000
Subject: Re: [PATCH v2] Documentation: process: Correct numbering
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Milan Lakhani <milan.lakhani@codethink.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-safety@lists.elisa.tech,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Christoph Hellwig <hch@lst.de>
References: <1608064956-5512-1-git-send-email-milan.lakhani@codethink.co.uk>
 <20201221095209.4dd4233e@lwn.net>
 <CAKXUXMwR9i5bJx+_rXkv4SK0yU1cHpGexH9RjsN7UFqJ-Ozsew@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7a6ab1d3-a5f5-d4ae-61e2-0a52419732f6@infradead.org>
Date:   Tue, 22 Dec 2020 08:36:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAKXUXMwR9i5bJx+_rXkv4SK0yU1cHpGexH9RjsN7UFqJ-Ozsew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/20 8:23 AM, Lukas Bulwahn wrote:
> On Mon, Dec 21, 2020 at 5:52 PM Jonathan Corbet <corbet@lwn.net> wrote:
>>
>> On Tue, 15 Dec 2020 20:42:36 +0000
>> Milan Lakhani <milan.lakhani@codethink.co.uk> wrote:
>>
>>> Renumber the steps in submit-checklist.rst as some numbers were skipped.
>>>
>>> Fixes: 72deb455b5ec ("block: remove CONFIG_LBDAF")
>>> Signed-off-by: Milan Lakhani <milan.lakhani@codethink.co.uk>
>>> ---
>>>  Documentation/process/submit-checklist.rst | 24 ++++++++++++------------
>>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/Documentation/process/submit-checklist.rst b/Documentation/process/submit-checklist.rst
>>> index 1879f88..230ee42 100644
>>> --- a/Documentation/process/submit-checklist.rst
>>> +++ b/Documentation/process/submit-checklist.rst
>>> @@ -75,44 +75,44 @@ and elsewhere regarding submitting Linux kernel patches.
>>>  13) Has been build- and runtime tested with and without ``CONFIG_SMP`` and
>>>      ``CONFIG_PREEMPT.``
>>>
>>> -16) All codepaths have been exercised with all lockdep features enabled.
>>> +14) All codepaths have been exercised with all lockdep features enabled.
>>>
>>> -17) All new ``/proc`` entries are documented under ``Documentation/``
>>> +15) All new ``/proc`` entries are documented under ``Documentation/``
>> [...]
>>
>> I've applied this, but, if you're going to stick a "Fixes" tag onto a
>> patch, it's probably only polite to copy the original author.  I'm not
>> fully convinced that the tag is warranted in this case.
>>
>> This document seems out of date in a number of ways; it could really use a
>> rather more thorough updating than this.
>>
> 
> Jon, I completely agree on your out-of-date comment. That is why we
> pointed Milan to that checklist to start with some small basic changes
> and continue with increasingly more challenging and complex updates.
> 
> Milan, next update for you to consider: what does "make headers_check"
> do nowadays? (spoiler alert: it does nothing) Adjust the documentation
> for that.
> 
> Then, a more general improvement: think about structuring the
> checklist to follow the structure of the other submission guidelines.
> So, reorder the current checklist and check if the step is mentioned
> in submitting-patches and where and make the checklist much more
> aligned to submitting-patches.

Please do not move item #1. It is #1 for a reason.


-- 
~Randy

