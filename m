Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93B421E2DD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 00:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgGMWMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 18:12:15 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:53264 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgGMWMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 18:12:14 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 7B237BC078;
        Mon, 13 Jul 2020 22:12:10 +0000 (UTC)
Subject: Re: [PATCH] CREDITS: Replace HTTP links with HTTPS ones
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     torvalds@linux-foundation.org, f4bug@amsat.org, cyphar@cyphar.com,
        davej@codemonkey.org.uk, geert+renesas@glider.be,
        ribalda@kernel.org, luis.f.correia@gmail.com,
        paulburton@kernel.org, linux-kernel@vger.kernel.org
References: <20200710154630.31521104@lwn.net>
 <20200711055127.92418-1-grandmaster@al2klimov.de>
 <20200713114321.783f0ae6@lwn.net>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <8469428d-39de-7b87-383f-aeb88355540f@al2klimov.de>
Date:   Tue, 14 Jul 2020 00:12:09 +0200
MIME-Version: 1.0
In-Reply-To: <20200713114321.783f0ae6@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spamd-Bar: /
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 13.07.20 um 19:43 schrieb Jonathan Corbet:
> On Sat, 11 Jul 2020 07:51:27 +0200
> "Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:
> 
>>   N: Derrick J. Brashear
>>   E: shadow@dementia.org
>> -W: http://www.dementia.org/~shadow
>> +W: https://www.dementia.org/~shadow
> 
> So while I do understand what you're trying to do, HTTPSifying something
> that has become a spam site doesn't do any good to anybody.  If you
> *really* want to improve this file, dealing with this sort of issue would
> be a much more useful contribution.
> 
> I agree that fixing the links in general is a mildly useful thing to do.
> But this kind of mindless replacement is taking a fair amount of my time,
> and I just can't bring myself to apply patches that do something like
> this.  Please, slow down a bit and think about how to actually improve
> things rather than polishing unseemly items like the above.
I'm sorry. I've just read your complies
https://lore.kernel.org/lkml/20200710154630.31521104@lwn.net/
and thought that's all.

Is that link plus the email I'm responding right now to all?
Normally I'd just submit a v2, but in this case I'd like to be sure first.

> 
> Thanks,
> 
> jon
> 
