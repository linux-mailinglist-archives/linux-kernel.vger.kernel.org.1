Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399892DFD4F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 16:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgLUPOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 10:14:46 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:59117 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725777AbgLUPOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 10:14:46 -0500
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Dec 2020 10:14:45 EST
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4D02sV09Yzz1yGl;
        Mon, 21 Dec 2020 16:08:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1608563294; bh=NO8bxZJI9FL1Tju/F91axWwmFgX4azH6VlIEJLJCUSs=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From:To:CC:
         Subject;
        b=LpGsOMp7EFcwO165I2jyahkUhlP0NzbwZqevYIHs1ozPDD8f1tZEddUkShLw45DpK
         3m21f+DMFzod6z+EEE30E9zmRbTGiEalQoFs8NIQQs/O8sGZJY8LpX/pl0RAi+CMXu
         5Ckx+hUEK0ULSCfgUfhtbXf/UYj08OsOTcuEQtcUFKw45pgXNuzUiKMhOm/CR9On/u
         uIug+KF/xY6UuGl0F36oV7EZepXdapCYWRqSYVnsn17RZ0QLqNYiDS8+fpwZ4eZr3U
         h2aI8WFLInfM9mmZSnApzct2cmka/LgMzxsJQ1O0gCeQAV8dyAs4JRhZ5LKsjLUu3z
         GXsggQYqaXUig==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 172.17.10.69
Received: from [10.21.2.135] (rat69.ratnet.stw.uni-erlangen.de [172.17.10.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1/irtnTP4xTg1MiW7/pknjO52QovIuGZbs=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4D02sR53bVz1xs2;
        Mon, 21 Dec 2020 16:08:11 +0100 (CET)
Subject: Re: [PATCH 2/2] checkpatch: kconfig: add missing types to regex
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
References: <a9797282-84c3-2c8f-73a0-d751a8201541@fau.de>
 <1f3b50a6f343dd252c043b2e5b7d47bca8514ee7.camel@perches.com>
Cc:     apw@canonical.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de
From:   Nicolai Fischer <nicolai.fischer@fau.de>
Message-ID: <5d7cef4f-071d-0504-74df-bd944a11dd70@fau.de>
Date:   Mon, 21 Dec 2020 16:08:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1f3b50a6f343dd252c043b2e5b7d47bca8514ee7.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 2020-12-20 at 20:16 +0100, Joe Perches wrote:
> On Mon, 2020-12-14 at 11:24 +0100, Nicolai Fischer wrote:
>> Kconfig parsing does not recognise all type attributes.
>> This adds the missing 'int', 'sting' and 'hex' types.
> []
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -3321,7 +3321,7 @@ sub process {
>>  				next if ($f =~ /^-/);
>>  				last if (!$file && $f =~ /^\@\@/);
>>  
>>
>> -				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
>> +				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|int|hex|string|prompt)\s*["']/) {
>>  					$is_start = 1;
>>  				} elsif ($lines[$ln - 1] =~ /^\+\s*help$/) {
>>  					$length = -1;
> 
> Another thing that could be done is to enforce the "extra 2 spaces"
> indent by capturing the whitespace before the help keyword:
> 
> 				} elsif ($lines[$ln - 1] =~ /^\+\s*help$/) {
> 
> could be
> 
> 				} elsif ($lines[$ln - 1] =~ /^\+(\s*)help\s*$/) {
> 
> with $1 used to validate the extra indent.
> 
> 


In case the indent does not match, should we display a new warning as in our previous patch?

On Tue, 2020-12-08 at 14:35 +0100, Nicolai Fischer wrote> +				WARN("CONFIG_DESCRIPTION",
> +					"help text is not indented 2 spaces more than the help keyword\n" . $herecurr);

