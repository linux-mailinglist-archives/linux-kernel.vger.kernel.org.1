Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9E12AFE83
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgKLFil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbgKLE4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 23:56:18 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF72C0613D1;
        Wed, 11 Nov 2020 20:56:18 -0800 (PST)
Received: from ip4d145e30.dynamic.kabel-deutschland.de ([77.20.94.48] helo=[192.168.66.101]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1kd4eb-0001hT-HT; Thu, 12 Nov 2020 05:56:13 +0100
To:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601541165.git.linux@leemhuis.info>
 <dc293f6d4f71ea827c861c64e88dfa0316f1d934.1601541165.git.linux@leemhuis.info>
 <8f3fce56-fdc4-c248-05ec-4fda1ee6fc54@infradead.org>
 <2b87f58f-ca74-6c73-fb7a-853cca2751bb@leemhuis.info>
 <6a8ffd01-ff1c-284b-42ac-23cd164e0873@leemhuis.info>
 <7eb95400-5ff1-ef14-d03f-b4d0f7482ac5@infradead.org>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v1 02/26] docs: reporting-bugs: Create a TLDR how to
 report issues
Message-ID: <6f1fcb33-86d6-7573-22b5-8f713a2857e3@leemhuis.info>
Date:   Thu, 12 Nov 2020 05:56:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <7eb95400-5ff1-ef14-d03f-b4d0f7482ac5@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1605156978;8dfc29d4;
X-HE-SMSGID: 1kd4eb-0001hT-HT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12.11.20 um 04:33 schrieb Randy Dunlap:
> On 11/11/20 7:24 AM, Thorsten Leemhuis wrote:
>> Am 03.10.20 um 09:27 schrieb Thorsten Leemhuis:
>>> Am 02.10.20 um 04:32 schrieb Randy Dunlap:
>>>> On 10/1/20 1:39 AM, Thorsten Leemhuis wrote: […]
 > […]

Sorry for the mail with those overly long lines, seems Thunderbird does 
not behave as it used to (or I did something stupid) :-/

>> I'm preparing to send v2 and was a bit unhappy with this and
>> another section when seeing it again after weeks. In the end I
>> reshuffled and rewrote significant parts of it, see below.
>> 
>> […]
>> If you can not reproduce the issue with the mainline kernel,
>> consider sticking with it; if you'd like to use an older version
>> line and want to see it fixed there, first make sure it's still
>> supported. Install its latest release as vanilla kernel. If you
>> cannot reproduce the issue there, try to find the commit that fixed
>> it in mainline or any discussion preceding it: those will often
>> mention if backporting is planed or considered impassable. If
>> backporting was not discussed, ask if it's in the cards. In case
>> you don't find
> impossible.  ??

Hmmm, I didn't won't to use "impossible" as it often is possible, but 
considered to hard/to much work. But I guess my dict sent me the wrong way.

I'll guess I'll switch to "considered too complex"

>> any commits or a preceding discussion, see the Linux-stable mailing
>> list archives for existing reports, as it might be a regression
>> specific to the version line. If it is, it round about needs to be
>> reported like a problem in mainline (including the bisection).
> maybe:  it still needs to be reported like

Went with:

If it is, report it like you would report a problem in mainline 
(including the bisection).

>> If you reached this point without a solution, ask for advice one
>> the subsystem's mailing list. ```
> Otherwise it looks good to me.

Many thanks for looking at it, much appreciated!

Ciao, Thorsten
