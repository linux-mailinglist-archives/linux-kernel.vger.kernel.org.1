Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B727329651E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 21:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370010AbgJVTPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 15:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S370000AbgJVTPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 15:15:06 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EE3C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 12:15:06 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id e7so1758356pfn.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 12:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MTOPs1CSneNAIcv0bX2fvvyRnuzty6FLHw/Un0yy0DU=;
        b=dpvUWooZMZxO3OAxNAJlXh0PhQvoFvvAOnv3KzUxOWanOsJIHJtKosY7lX3+S2ggYB
         a8K3w2zCYXj2bKjWxD3yTP7RpMM6MbXp2Z0BwqKHGlc/91ZBI6IBuVBkHxdPCZnbdQrG
         fsRolZDMezc5XqP5rUHBBmd/MG7ru9xnTl+QD5g0dZTOBEgWyMWTVzRnlbmd5dWcKI7L
         o6zxoJICUC04q4gTwj3Dn+GD+acCCxbh35+VqFSskD4gHB1VGSBKSxW+ZMuBUvfgYZoo
         gwT+vI0tExgeGbLD3CF+XQZL289HtQzeDfDzPstAFkqOYEFqFgIedpT8c85wPVwREqQU
         trJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MTOPs1CSneNAIcv0bX2fvvyRnuzty6FLHw/Un0yy0DU=;
        b=MS8b4yrY6RSmr+Itwpq4+bNo/BImjgQbx0G0BE6M5Zc6B+2o+bE7WTiZMQbnT2PKqJ
         yCmdUoEpCK1A2Zx9S4vmkonNMtenrxjfhzAnFPwydwvFNOvwOZdkj3zF2Y3KGaMpEjOM
         hA8gyFF2YNqH5t4pJjAR/MY0QchJhbRZmBOpv7NcFdp54LXbCMSSS00/tfHDEs748HbN
         Fq3ERfg+oqdsTqcgNct7NY+vsyWjZ+IixjaRnMvrwRQ6ZhrFn362+THr/jPYHhbl9OJI
         dEXItv1Vb8YL115kviw9yXb1iYXSm9nrCc0BMPBU4DrMjkrlJG+JMtbH/i4I0W/kwAbB
         zQ0Q==
X-Gm-Message-State: AOAM533+bFcOMFMoCNHnNWy1nZl79TY6NFh9OE9VU9eNJ1qb/KRDv2R8
        LJwbdMqDkN7dmqGaZpdfUzM=
X-Google-Smtp-Source: ABdhPJz9pcCvEF/9HR1/lctA5F5SxcIGH+6rTGs+MVMyRtCMFyMPTLygkwlaa8dobVnCGzx2bPbRTQ==
X-Received: by 2002:a05:6a00:13aa:b029:15d:73e6:2e9f with SMTP id t42-20020a056a0013aab029015d73e62e9fmr4159975pfg.0.1603394105920;
        Thu, 22 Oct 2020 12:15:05 -0700 (PDT)
Received: from ?IPv6:2402:3a80:41a:7419:e1bd:6bc1:d06a:efd1? ([2402:3a80:41a:7419:e1bd:6bc1:d06a:efd1])
        by smtp.gmail.com with ESMTPSA id b3sm3170844pfd.66.2020.10.22.12.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 12:15:05 -0700 (PDT)
Subject: Re: [PATCH v2] checkpatch: fix false positives in REPEATED_WORD
 warning
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com
References: <20201022145021.28211-1-yashsri421@gmail.com>
 <4cbbd8d8b6c4d686f71648af8bc970baa4b0ee9b.camel@perches.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <5121bf7c-a126-6178-62ff-e54f0bb4cb6e@gmail.com>
Date:   Fri, 23 Oct 2020 00:44:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4cbbd8d8b6c4d686f71648af8bc970baa4b0ee9b.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/20 9:40 pm, Joe Perches wrote:
> On Thu, 2020-10-22 at 20:20 +0530, Aditya Srivastava wrote:
>> Presence of hexadecimal address or symbol results in false warning
>> message by checkpatch.pl.
> []
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -3051,7 +3051,10 @@ sub process {
>>  		}
>>  
>>  # check for repeated words separated by a single space
>> -		if ($rawline =~ /^\+/ || $in_commit_log) {
>> +# avoid false positive from list command eg, '-rw-r--r-- 1 root root'
>> +		if (($rawline =~ /^\+/ || $in_commit_log) &&
>> +		$rawline !~ /[bcCdDlMnpPs\?-][rwxsStT-]{9}/) {
> 
> Alignment and use \b before and after the regex please.

If we use \b either before or after or both it does not match patterns
such as:
+   -rw-r--r--. 1 root root 112K Mar 20 12:16
selinux-policy-3.14.4-48.fc31.noarch.rpm

This is happening probably because it is counting '-' for '\b'
I have not observed any negatives of using this though.

> 
> 		if (($rawline =~ /^\+/ || $in_commit_log) &&
> 		    $rawline !~ /\b[bcCdDlMnpPs\?-][rwxsStT-]{9}\b/) {
>> @@ -3065,6 +3068,34 @@ sub process {
>>  				next if ($first ne $second);
>>  				next if ($first eq 'long');
>>  
>> +				# avoid repeating hex occurrences like 'ff ff fe 09 ...'
>> +				if ($first =~ /\b[0-9a-f]{2,}/) {
>> +					# if such sequence occurs more than 4, it is most probably part of some of code
>> +					next if ((scalar @hex_seq)>4);
>> +					# for hex occurrences which are less than 4
>> +					# get first hex word in the line
>> +					if ($rawline =~ /\b[0-9a-f]{2,} /) {
>> +						my $post_hex_seq = $';
>> +
>> +						# set suffieciently high default values to avoid ignoring or counting in absence of another
>> +						my $non_hex_char_pos = 1000;
>> +						my $special_chars_pos = 500;
>> +
>> +						if ($post_hex_seq =~ /[g-z]+/) {
>> +							# first non hex character in post_hex_seq
>> +							$non_hex_char_pos = $-[0];
>> +						}
>> +						if($post_hex_seq =~ /[^a-zA-Z0-9]{2,}/) {
>> +							# first occurrence of 2 or more special chars
>> +							$special_chars_pos = $-[0];
>> +						}
> 
> What does all this code actually avoid?
> 
> 

Sir, there are multiple variations of hex for which this warning is
occurring, for eg:
1) 00 c0 06 16 00 00 ff ff 00 93 1c 18 00 00 ff ff  ................
2) ffffffff ffffffff 00000000 c070058c
3)     f5a:       48 c7 44 24 78 ff ff    movq
$0xffffffffffffffff,0x78(%rsp)
4) +    fe fe
5) +    fe fe   - ? end marker ?
6) Code: ff ff 48 (...)

So I first check if the repeated word matches /\b[0-9a-f]{2,}/ . If it
does and occurs as a sequence of such repetitions more than 4(ie more
than or equal to 5), then it is most probably a part of hexadecimal
code. This is implemented here,

+				if ($first =~ /\b[0-9a-f]{2,}/) {
+					# if such sequence occurs more than 4, it is most probably part
of some of code
+					next if ((scalar @hex_seq)>4);

This addresses our issues for warning similar to example (1),(2) and (3).

But still we haven't detected 4,5,6. One can argue that we can modify:

+					next if ((scalar @hex_seq)>4);

with (scalar @hex_seq)>2 or (scalar @hex_seq)>3

but then, we'll not be able to account for warnings such as:

7) +	 * sets this to -1, the slack value will be calculated to be be
halfway
8) + * @seg: index of packet segment whose raw fields are to be be
extracted
9) The data in destination buffer is expected to be be parsed in big
10) +	 *   1. New session or device can'be be created - session sysfs
files

Here I observed that in hex codes, there are atleast 2 special
characters present before any non-hex character, for eg. in (5). Also
generally such occurrences are very rare in writing english, and it is
also helpful in our case.

This is implemented here:

>> +				# avoid repeating hex occurrences like 'ff ff fe 09 ...'
>> +				if ($first =~ /\b[0-9a-f]{2,}/) {
>> +					# if such sequence occurs more than 4, it is most probably
part of some of code
>> +					next if ((scalar @hex_seq)>4);
>> +					# for hex occurrences which are less than 4
>> +					# get first hex word in the line
>> +					if ($rawline =~ /\b[0-9a-f]{2,} /) {
>> +						my $post_hex_seq = $';
>> +
>> +						# set suffieciently high default values to avoid ignoring or
counting in absence of another
>> +						my $non_hex_char_pos = 1000;
>> +						my $special_chars_pos = 500;
>> +
>> +						if ($post_hex_seq =~ /[g-z]+/) {
>> +							# first non hex character in post_hex_seq
>> +							$non_hex_char_pos = $-[0];
>> +						}
>> +						if($post_hex_seq =~ /[^a-zA-Z0-9]{2,}/) {
>> +							# first occurrence of 2 or more special chars
>> +							$special_chars_pos = $-[0];
>> +						}

I have used these two lines for cases like example(4):
+						my $non_hex_char_pos = 1000;
+						my $special_chars_pos = 500;

Here, non-hex characters are missing, thus the default character helps
us to get desired result.
Also, I have set higher values such that if one of them occurs in a
line, the result remain unaffected, than with lower default values.


Thanks
Aditya
