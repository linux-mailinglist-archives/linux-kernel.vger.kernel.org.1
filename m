Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6CA1A4E64
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Apr 2020 08:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgDKGsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Apr 2020 02:48:10 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:28082 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgDKGsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 02:48:10 -0400
Received: from [192.168.42.210] ([93.22.135.18])
        by mwinf5d37 with ME
        id RJo72200G0Pz5GD03Jo84W; Sat, 11 Apr 2020 08:48:09 +0200
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 Apr 2020 08:48:09 +0200
X-ME-IP: 93.22.135.18
Subject: Re: [PATCH] checkpatch: check for missing \n at the end of logging
 message
To:     Joe Perches <joe@perches.com>, apw@canonical.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.janitors
References: <20200407204908.10420-1-christophe.jaillet@wanadoo.fr>
 <8617a6b94c0644bce1fd4ca77309d67a612e6300.camel@perches.com>
 <6e52383e-100d-b016-32c2-6fb54938b6fe@wanadoo.fr>
 <c9fd4bc75812fed4799c2fb87b452b809a7e9a7a.camel@perches.com>
 <db2730700ab3eb7008413a1e7bba94ca7c49a031.camel@perches.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <215f2a43-6677-04cd-f376-bd7cd051b626@wanadoo.fr>
Date:   Sat, 11 Apr 2020 08:48:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <db2730700ab3eb7008413a1e7bba94ca7c49a031.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 10/04/2020 à 21:53, Joe Perches a écrit :
> On Fri, 2020-04-10 at 12:46 -0700, Joe Perches wrote:
>> On Fri, 2020-04-10 at 19:35 +0200, Christophe JAILLET wrote:
>>> Le 08/04/2020 à 04:14, Joe Perches a écrit :
>>>> This works rather better:
>>>> Perhaps you could test?
>> []
>>> I'm looking at some modification done in the last month that could have
>>> been spotted by the above script.
>>>
>>>       ./scripts/checkpatch.pl -f drivers/usb/phy/phy-jz4770.c
>>>
>>> correctly spots the 3 first cases, but the 3 last (line 202, 210 and
>>> 217) are missed.
>>> I don't understand why.
>> It has to do with checkpatch's single statement parsing.
>>
>> This case:
>>
>> 	if (foo)
>> 		dev_warn(...);
>>
>> is parsed as a single statement but
>>
>> 	if (foo) {
>> 		dev_warn(...);
>> 	};
>>
>> is parsed as multiple statements so for the
>> second case
>>
>> 		dev_warn(...);
>>
>> is analyzed as a separate statement.
>>
>> The regex match for this missing newline test expects
>> that each printk is a separate statement so the first
>> case doesn't match.
>>
>> Clearly the regex can be improved here.
> So on top of the original patch:
> ---
>   scripts/checkpatch.pl | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index f00a6c8..54eaa7 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5675,8 +5675,8 @@ sub process {
>   
>   # check for possible missing newlines at the end of common logging functions
>   		if (defined($stat) &&
> -		    $stat =~ /^\+\s*($logFunctions)\s*\((?:\s*$FuncArg\s*,\s*){0,3}\s*$String/ &&
> -		    $1 !~ /_cont$/ && $1 =~ /^(?:pr|dev|netdev|netif|wiphy)_/) {
> +		    $stat =~ /^\+\s*(?:if\s*$balanced_parens\s*)?($logFunctions)\s*\((?:\s*$FuncArg\s*,\s*){0,3}\s*$String/ &&
> +		    $2 !~ /_cont$/ && $2 =~ /^(?:pr|dev|netdev|netif|wiphy)_/) {
>   			my $cnt = statement_rawlines($stat);
>   			my $extracted_string = "";
>   			for (my $i = 0; $i < $cnt; $i++) {

Hi Joe,

This fixes the use case for  drivers/usb/phy/phy-jz4770.c

     ./scripts/checkpatch.pl -f drivers/usb/gadget/udc/tegra-xudc.c

is missing line 691.

CJ

