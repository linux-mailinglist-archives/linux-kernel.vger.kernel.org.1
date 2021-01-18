Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C813D2FADA4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 00:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390029AbhARXCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 18:02:00 -0500
Received: from mail.cock.li ([37.120.193.124]:41364 "EHLO mail.cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732425AbhARXBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 18:01:54 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firemail.cc; s=mail;
        t=1611010858; bh=UUB9k+abJidGdRhYavEzuDm7f12OLV8kZjqV1ykJqs8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yvyCdtjRDgwGNpe8BeBsKZVOEaJ8pvOL3mvOPYSuf6fZm7ViV44MWSE3QQyEF6key
         qDEKxxl+niOumF1Oxd9O4I5NVE8VoftjMx3PIrxC5yQyhY9OtQBr71Gukdaygf9hSx
         4XQEOb9/c1DnmcOYnxz2vajyybD3fGuMDzWsEZn2BM+Qx5lrIir9RouNdxNhgn0l4f
         BlL93qUJqpa0ohxdSyF/kpNo9V7k8Y+28vPIPFjFPhghtuk0N8ZLKKjzhIxAJ7YxTn
         v6/cjScNr73q2fCVQp0+oEogANxbNk0G03jBozK7t1WkPHNCFcFUl3E6UpK2aapHDS
         /8J3drKlVYHEg==
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 18 Jan 2021 23:01:00 +0000
From:   nipponmail@firemail.cc
To:     linux-kernel@vger.kernel.org
Cc:     rms@gnu.org, bruce@perens.com, esr@thyrsus.com,
        moglen@columbia.edu, blukashev@sempervictus.com,
        tcallawa@redhat.com, editor@lwn.net, skraw.ml@ithnet.com,
        torvalds@osdl.org
Subject: Re: Linksys WRT54G and the GPL - What about GRSECURITY?
In-Reply-To: <CAFUG7Cd8S+sGRkKB3z1PoPz14ReaNN=unE6E7tTuFYGB8LqdBA@mail.gmail.com>
References: <018895af6127043324ce34c8faceac42@firemail.cc>
 <CAFUG7Cd8S+sGRkKB3z1PoPz14ReaNN=unE6E7tTuFYGB8LqdBA@mail.gmail.com>
Message-ID: <f39be467660372afea4c694d7a2aaac8@firemail.cc>
X-Sender: nipponmail@firemail.cc
User-Agent: Roundcube Webmail/1.3.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bradly Spengler continues to violate the GPL, it's fine now tho: he's 
creating his own reality and everyone is accepting it:
https://mobile.twitter.com/spendergrsec/status/1349086946560253952

He "corrects" people saying "grsec isn't gpl anymore", informing them 
he's simply "running a subscription service". This is THE reality now: 
since none of you, except for Bruce Perens, did anything. None of you 
care about free software.

----

Tweet
See new Tweets
Conversation
アルミ
@schrotthaufen
·
Jan 11
I don’t know how many hours I poured into getting my kernel config for 
grsec to work (because pebkac), and then a few years later it ceases to 
be gpl
Loudly crying face
Quote Tweet
DWIZZZZZZZZZZZZLE
@dwizzzleMSFT
  · Jan 11
The biggest impediment to security on Linux is the same as Windows.  Its 
currently much too hard for the average person to deploy hardening 
policies and use hardened kernels.  The tyranny of the kernel conf 
reigns. The reality is a few Linux users will ever touch a conf
Show this thread
Brad Spengler
@spendergrsec
·
Jan 12
Always was GPLv2, always will be.  GPL doesn't mean "I can demand free 
work/support/warranty."  Doesn't mean you have to like decades-old 
subscription policies like Red Hat has, but neither do I like people 
making things up b/c they want something for $0.
The GPL and a Condition on Providing Future Versions or Services » 
Chhabra® Law
Section 6 of the GNU Public License (GPL) version 2 states, in part, 
that “[y]ou may not impose any further restrictions on the recipients’ 
exercise of the rights granted herein.” Naturally, the...
clfip.com
アルミ
@schrotthaufen
·
Jan 12
I may have gotten that wrong. What I meant was: “It’s not free anymore, 
and last time I inquired about licensing to end users the answer was 
‘no’”. I don’t blame you for turning it into a payed only product. If I 
was in your shoes, I’d have done the same given the circumstances.
Brad Spengler
@spendergrsec
·
Jan 12
It's important to be specific about these things though, because people 
will take your words and infer certain things that simply aren't true.  
Same regarding the phrase of "licensing to end users"  -- we don't sell 
a license, we offer a subscription service.
Brad Spengler
@spendergrsec
Replying to
@spendergrsec
  and
@schrotthaufen
Anyone who receives a copy of grsecurity, direct customer of ours or 
not, has a license to it: the GPLv2.  It may seem to be a pedantic 
point, but it's important.
8:12 PM · Jan 12, 2021·Twitter Web App
1
  Retweet
----


On 2021-01-17 21:58, Boris Lukashev wrote:
> Why do you send this stuff to people?
> First off, its no longer even accurate - grsec code _changes_ to Linux
> have been deemed as "never to be adopted" by Linus. Without those
> changes, their GCC plugins can't work properly, and those plugins are
> part of the build-toolchain, not the C source. So even if you gave
> them a billion dollars tomorrow, Linux would still never use the work.
> The whole GPL mess is broken, clearly, and nobody is looking to
> enforce it - industry is waiting it out till Redox and BSDs become
> more viable for production OS.
> So why send these emails? Venting purposes?
> 
> On Sun, Jan 17, 2021 at 1:03 PM <nipponmail@firemail.cc> wrote:
> 
>> Linus etc do not give a FUCK that Grsecurity is BLATANTLY violating
>> the
>> GPL. So why do you fucking retards complain about this?
>>> DURR BECUAUSE WE DON'T HAVE 2 DO ANYTHING, CAN JUST COMMISERATE
>> 
>> (
>> 
> https://perens.com/2017/06/28/warning-grsecurity-potential-contributory-infringement-risk-for-customers/
>> 
>> )
> 
> --
> 
> Boris Lukashev
> Systems Architect
> Semper Victus [1]
> 
> 
> Links:
> ------
> [1] https://www.sempervictus.com
