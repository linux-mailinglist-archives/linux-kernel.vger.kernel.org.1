Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B972E2C04
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 18:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgLYR2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 12:28:09 -0500
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:40369 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725953AbgLYR2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 12:28:08 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4D2YmG1CFjzPklM;
        Fri, 25 Dec 2020 18:27:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1608917246; bh=9GxLPFVs+6iHmpQNuNhuh9AZmgzvsM1OYzNazjRY0u8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From:To:CC:
         Subject;
        b=Iw58+SSjGuFZW3NvKF/H7QzqgS6m73Fw1/WJEOpZGpIj+yswX82xQYMlEy33Pmd0v
         g3vgunzORa+k/lUYQinSpiOngxlmhShOQUOdMe67Cw1M+HjkDX4WUrcuNYoj3xdGlu
         M1gKREY5xhcVwSEfgfZq3TvpTwwURsnLPacplYppdD2ijAIQXITGN5ulNS2qEP6wQc
         QugZ/IyU/SQPsrTJdGndZcv804dy4XfgXymiLrtHyJnz1YBBSoDJIe5RGo2ZFOw0Nw
         4bnNhjX3mRBBUM8F8eRfxd2S0P4VVBEmnK4F53zyNdYmCZshqaq04QujHpC2OXTJ8Z
         1FQAm7A6Y8i3Q==
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2a02:810d:8080:2d9f::1245
Received: from [IPv6:2a02:810d:8080:2d9f::1245] (unknown [IPv6:2a02:810d:8080:2d9f::1245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX19TivKyyZu29UZFzRzquHfqe1ahzWdzvjw=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4D2YmC519ZzPkjv;
        Fri, 25 Dec 2020 18:27:23 +0100 (CET)
Subject: Re: [PATCH 2/2] checkpatch: kconfig: add missing types to regex
To:     Joe Perches <coupons@perches.com>, linux-kernel@vger.kernel.org
Cc:     apw@canonical.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de, akpm@linux-foundation.org
References: <a9797282-84c3-2c8f-73a0-d751a8201541@fau.de>
 <1f3b50a6f343dd252c043b2e5b7d47bca8514ee7.camel@perches.com>
 <5d7cef4f-071d-0504-74df-bd944a11dd70@fau.de>
 <fa637be6bb02336a3df6e3c3fdc800b9b17d079f.camel@perches.com>
From:   Nicolai Fischer <nicolai.fischer@fau.de>
Message-ID: <4899798f-46b9-32ee-4d1e-ab2b5833da08@fau.de>
Date:   Fri, 25 Dec 2020 18:27:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <fa637be6bb02336a3df6e3c3fdc800b9b17d079f.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/21/20 6:17 PM, Joe Perches wrote:
> On Mon, 2020-12-21 at 16:08 +0100, Nicolai Fischer wrote:
>> On Sun, 2020-12-20 at 20:16 +0100, Joe Perches wrote:
>>> On Mon, 2020-12-14 at 11:24 +0100, Nicolai Fischer wrote:
>>>> Kconfig parsing does not recognise all type attributes.
>>>> This adds the missing 'int', 'sting' and 'hex' types.
>>> []
>>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>>> []
>>>> @@ -3321,7 +3321,7 @@ sub process {
>>>>  				next if ($f =~ /^-/);
>>>>  				last if (!$file && $f =~ /^\@\@/);
>>>>  
>>>>
>>>> -				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
>>>> +				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|int|hex|string|prompt)\s*["']/) {
>>>>  					$is_start = 1;
>>>>  				} elsif ($lines[$ln - 1] =~ /^\+\s*help$/) {
>>>>  					$length = -1;
>>>
>>> Another thing that could be done is to enforce the "extra 2 spaces"
>>> indent by capturing the whitespace before the help keyword:
>>>
>>> 				} elsif ($lines[$ln - 1] =~ /^\+\s*help$/) {
>>>
>>> could be
>>>
>>> 				} elsif ($lines[$ln - 1] =~ /^\+(\s*)help\s*$/) {
>>>
>>> with $1 used to validate the extra indent.
>>>
>>>
>>
>>
>> In case the indent does not match, should we display a new warning as in our previous patch?
> 
> Sure, but in a separate patch and ensure blank lines are ignored.
> 
> +                               if ($l !~ /^\ {2}/) {
> +                                       $wrong_indent = 1;
>                                 }
> 
> The message you used:
> +                               WARN("CONFIG_DESCRIPTION",
> +                                       "help text is not indented 2 spaces more than the help keyword\n" . $herecurr);
> 
> is IMO a bit oddly phrased and could/should test only
> the first line after the help keyword and show the help
> line using $hereprev.
> 
> The problem with $herecurr is, that it always contains the first line of the Kconfig option.
The loop which actually determines if the warning is to be displayed, leaves $herecurr and likewise $hereprev unaffected.

So printing $hereprev would unfortunately not be any more helpful than $herecurr.

Because $herecurr and $hereprev also contain the line number, among other things, I am not sure what would be the best way
to address this.
