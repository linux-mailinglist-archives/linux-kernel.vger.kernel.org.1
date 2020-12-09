Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8492D4436
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 15:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732755AbgLIOZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 09:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732187AbgLIOZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 09:25:32 -0500
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B56EC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 06:24:50 -0800 (PST)
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4CrfS63tbpz8xS6;
        Wed,  9 Dec 2020 15:24:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1607523846; bh=9Pue5Ss/ZHdyKJVLh5pk8LTT9mvftD0LRtbuy6/OEhQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From:To:CC:
         Subject;
        b=WjYihD3LKzWrLa8tex1LfmkHOvjTF2fsaPiovGyzOLGS8bL00JpLBdHsHr+55+6ty
         dxK/GN/MKM/oktj2sGcDsnADNCXrOMcpxgu1ooG1s39zQynxqei1RBfB2GgeEoWpri
         EfQF1s6sf/OW4sG1DHtUVHo0D5B14pBiifI9RYDh+2nWnjxpxpFwgscz+Yftf+U494
         iMyGPGZBK7rDTob+IRsW8KMQJELFJuRXKzCgrFg5QcSPjhGdyrRmE/hOVN/A0BfGRI
         5X4QdbYlJk6DHGK1YlYn6gzrM5s6B9ctVmcQh9D47NewboKEO7lLXIEDLqwMuaZP+q
         vMiUkE2nlCSlQ==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2a02:810d:8080:2d9f::1245
Received: from [IPv6:2a02:810d:8080:2d9f::1245] (unknown [IPv6:2a02:810d:8080:2d9f::1245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1822ugsTGV/zqsMNik/o6fkMiFdY+yZB1Y=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4CrfS36jbKz8shs;
        Wed,  9 Dec 2020 15:24:03 +0100 (CET)
Subject: Re: [RFC PATCH v2] checkpatch: rewrite Kconfig parsing
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     apw@canonical.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de
References: <a07d684c-37ea-b589-c4b1-489e88b5caa5@fau.de>
 <97fb4ba0-68b3-8faf-1d98-e4990b2e63e3@fau.de>
 <776550b7fac3870e65e903f0d8cb917dec58f7c2.camel@perches.com>
From:   Nicolai Fischer <nicolai.fischer@fau.de>
Message-ID: <d97d491e-10fe-5c2e-ebdd-45f437afd257@fau.de>
Date:   Wed, 9 Dec 2020 15:24:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <776550b7fac3870e65e903f0d8cb917dec58f7c2.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/20 7:58 PM, Joe Perches wrote:
> On Tue, 2020-12-08 at 18:18 +0100, Nicolai Fischer wrote:
>> Checkpatch currently only warns if the help text is too short.
>> To determine this the diff gets parsed for keywords starting
>> a new entry, but several kinds of false positives can occur with
>> the current implementation, especially when the config
>> is not well formatted.
>>
>> This patch makes the parsing more robust and includes
>> new warnings if:
>> 1) the help attribute is not specified last
>> 2) there is no blank line or endif before the next keyword
>> 3) the help text is not indented 2 spaces more than
>>    the attribute itself.
>>
>> Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
>> Co-developed-by: Johannes Czekay <johannes.czekay@fau.de>
>> Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
>> ---
>>
>> This patch rewrites most of the Kconfig parsing to address
>> the issues mentioned in the first RFC:
>>
>> 1) search for 'help' instead of '---help---'
>>> I believe all the '---help---' lines have been converted to just 'help'
>>> so the '(?:---)?' bits here could be removed
>>
>> 2) create new warnings:
>>> Perhaps it'd be better to create a new warning when the help text
>>> block is not the last block of the config section.  Maybe warn when
>>> a blank line or endif is not the separator to the next keyword.
>>> Maybe warn when the next line after help is not indented 2 more
>>> spaces than the help line.
>>
>> 3) fix handling of blank lines and rely on keywords for end of help text
>>> This doesn't allow blank lines for multi-paragraph help text either.
>>>
>>> I think keyword parsing is necessary and some false positives are
>>> inevitable as the parsing logic in a line-by-line analyzer will
>>> always be incomplete.
>>
>>
>> It has occurred to us, that kconfig-language.rst does not explicitly
>> specify that the help text should be the last attribute, although
>> this is the defacto convention. Now that checkpatch actively checks
>> for this, we should probably update the documentation accordingly.
> 
> Generally process is either to update documentation along with
> with a checkpatch change or to update documentation first.
> 
> Also checkpatch isn't necessarily the best tool for this.
> 
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> -# check for Kconfig help text having a real description
>> +# Check if Kconfig is well formatted. Warn if help text:
>> +# 1) is shorter than $min_conf_desc_length lines
>> +# 2) is not specified last
>> +# 3) and next keyword are not separated by a blank line or endif
>> +# 4) is not indented correctly
>>  # Only applies when adding the entry originally, after that we do not have
>>  # sufficient context to determine whether it is indeed long enough.
>>  		if ($realfile =~ /Kconfig/ &&
> 
> []
> 
>> +				my $l = $line;
>> +				$l =~ s/^$help_indent//;
>> +				if ($l =~ /^(?:bool|tristate|string|hex|int|prompt|default|
>> +					depends\ on|select|imply|visible\ if|range|option)\b/x) {
> 
> I think this is overly fragile.
> These keywords are not required to be at the same indent as help.
> 
> Also as specified in scripts/kconfig/lexer.h, the kconfig specification
> has more keywords than the list above.
> 
> In general, checkpatch does not have to be the tool of choice for
> verifying everything.
> 
> For instance, checkpatch has a trivial check for MAINTAINERS entry
> ordering, but there is a complete tool called parse-maintainers.pl
> that verifies alphabetic section ordering.
> 
> I think most of what you seem to be attempting should be in a new
> tool that completely understands Kconfig parsing.
> 
> I suggest instead of updating checkpatch, the scripts/kconfig/
> content be updated to do these things.
> 


We understand that checkpatch may not be the ideal place for all of these checks.
However the current implementation has some problems we would like to fix.
Would you be interested in a patch series addressing just the check for the number of lines?
Specifically:
1)
> 
>>
>> I believe all the '---help---' lines have been converted to just 'help'
>> so the '(?:---)?' bits here could be removed.
> 
> Yes.
> 
2) add string, hex and int types to the $is_start regex
3) improve the help message to include the number of present and expected lines
4) Warn if help text is not followed by a blank line or endif







