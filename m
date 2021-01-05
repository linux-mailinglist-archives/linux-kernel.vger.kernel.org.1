Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633232EAF63
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 16:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbhAEPtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 10:49:46 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:51829 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728552AbhAEPtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 10:49:45 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4D9H3h57vFz1xwK;
        Tue,  5 Jan 2021 16:49:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1609861744; bh=SzSkb+YI+0MEGWompIIpTh635rOo+N38ZgyeyCSpX6Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From:To:CC:
         Subject;
        b=f9sXQTZYHiirDMJxGQd7nhMFtGAUCosJmagFrqyXuXqp6r23cBmGGIR5eIpFgxODR
         Qm9L9bcIQbTuBc9EM/LCDSIh+py7mY7wANxCrYA9Zp1sS1XpxebDTTubHHgLL0HVxy
         1BL0cuDqNpcVGbYDBeHiVnn5PmQ/BV1tNsIq/lpaGJCeuu1QWXLYU9GINwoPhJx3wS
         FLHbHtv0ZfGcPe6UYUSM//K/JtwQu56jm0Y2TOD1ueML/ugutSzwy01L3+gWM0ySvC
         V1tgxsrZes5RtZ+WToWYxBdh8KkJ/+SMUmUdbUd7Pw5YDpOsegGWlj0kaPuMNzlsPv
         Lg4bvHMrGhqHA==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 172.17.10.69
Received: from [10.21.2.135] (rat69.ratnet.stw.uni-erlangen.de [172.17.10.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1/QfEQaj80QvMx6fpdX/07ImsnvYB2nMfg=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4D9H3f3DJrz1xxy;
        Tue,  5 Jan 2021 16:49:02 +0100 (CET)
Subject: Re: [PATCH v3 3/5] checkpatch: kconfig: enforce help text indentation
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     apw@canonical.com, akpm@linux-foundation.org,
        johannes.czekay@fau.de, linux-kernel@i4.cs.fau.de
References: <20201226140511.662368-1-nicolai.fischer@fau.de>
 <20210103075015.23946-1-nicolai.fischer@fau.de>
 <20210103075015.23946-4-nicolai.fischer@fau.de>
 <0e8754d14cb5624704159ba85b18f8a6bb703b27.camel@perches.com>
 <5f01770454d163605406265b1bf316e0452753cf.camel@perches.com>
From:   Nicolai Fischer <nicolai.fischer@fau.de>
Message-ID: <13db326d-0f63-402e-b475-8f3b2ceece13@fau.de>
Date:   Tue, 5 Jan 2021 16:49:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <5f01770454d163605406265b1bf316e0452753cf.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue 05.01.21 09:57, Joe Perches wrote:
> On Mon, 2021-01-04 at 14:09 -0800, Joe Perches wrote:
>> On Sun, 2021-01-03 at 08:50 +0100, Nicolai Fischer wrote:
>>> Adds a new warning in case the indentation level of the
>>> first line of a Kconfig help message is not at least two spaces
>>> higher than the keyword itself.
>>> Blank lines between the message and the help keyword
>>> are ignored.
>>>
>>> Co-developed-by: Johannes Czekay <johannes.czekay@fau.de>
>>> Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
>>> Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
>>> ---
>>>
>>> Now matches indentation of two or more spaces, instead of exactly two.
>>
>> No, this should match exactly 2 and warn on any other use.
> 
> To clarify, only the first line after the help keyword needs to
> have a 2 space indent more than the help keyword and the help
> block may start with Kconfig keywords.
>> Subsequent help block lines may have more than 2 chars.

Okay, thank you for the clarification.

> 
> The help block line count should end when the indent is less than
> the help keyword indent and is a non-blank line.

We could do something like this

  if (defined $help_indent) {
    $lines[$ln - 1] =~ /^\+(\s*)\S+/;
	if (length($1) < length($help_indent)) {
	  is_end = 1; last;
  }

as an extra patch after patch 3.

Please clarify whether we should match for a smaller indent than the help
keyword or the first non-blank line after the keyword.


> 
> This should be valid:
> 
> 	help
> 	  line 1
> 	    -- reason 1
> 	    -- reason 2
> 	       continuation
> 	    -- reason 3
> 
> But this should warn only on line 1:
> 
> 	help
> 	   line 1 has a 3 space indent
> 	   -- reason 1
> 	   -- reason 2
> 	       continuation
> 	   -- reason 3
> 
> 


