Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9D82952C2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 21:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437950AbgJUTKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 15:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394975AbgJUTKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 15:10:40 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1CDC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 12:10:40 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f19so2039404pfj.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 12:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sqKrdcb1JW7aapeQZweUM78mpTGqQvC1e1ca9+gRkRk=;
        b=fM/IXSI4xylUS4vB7syq9meRyttA3/TlwkeKmvNJg9JrIOQ9/nmrpE+ATWYsgjhXKl
         o0+g1dFcGFZYezdF2HXjB3Ap+CBApCphI0D9QoZNl7QWGImv6dqfcRlRcfk6GP5wmjZl
         aDQ0QCgN0nLyS7rox3JFKcwf6RtJEw2+ifeEMWZKXuNc4UsYjKbTjYArJiLsHiiwcSs0
         TNj4wJzUP0IdaQl0bwMt0EZpqYdr8kpgidDP+9kvykAuNWpBhVxSTGZfNePiw6vpU0VF
         EyGBtdV7VwjZ9ymhZcPty7hLSWWcW5f3RPAGKY/mwwnLjOHF7zt5AVXZgvb5gNFk6t+3
         qNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sqKrdcb1JW7aapeQZweUM78mpTGqQvC1e1ca9+gRkRk=;
        b=JO7GV23XkgRRTBgkpBmvLiKXUuyytfJV0+hKxwG59S+6fYKtWDh0IZZXq0u18NJx1G
         prq9tmq5p/iSDzCuXJrRF5LGbBR9siHnsIa5+jzZ0EMSa3y6JBwJSOZ/KnC0i3fjrlEV
         r82iau31wFBwmv+fH+/hv9i26nk/X882bUE6WOsUbNsdYzKgYzpylZ1yDdF+jK9gDvbp
         x2PK3TS5MZyONymv1YAHUDeu4uWPnJqwpl6wT5tueOwZ9zhiN8Ypxf3ybNNelL+GgQNg
         QKkQMmYUUlUrk4qnyGu4tQcBprrfI9yrs7bhgwSJ9JTRT7t0izP0+DwmDOqYo4IE+OVs
         uO1Q==
X-Gm-Message-State: AOAM532uTcCwJF4ZQOdrALxFgRPL8qslM9LZZZp73N2+o5iAwh9MaYHW
        rTi6uKBUfBcVkC1XnjHFJ0o=
X-Google-Smtp-Source: ABdhPJyp49QFzlg5V0OUdPSExSsCgmgqLJI4KZwaScPscItQSmsUKPy+x84prqM4Uz5ntJTOg5kbQQ==
X-Received: by 2002:a62:8f81:0:b029:152:6184:6c69 with SMTP id n123-20020a628f810000b029015261846c69mr5033535pfd.75.1603307439452;
        Wed, 21 Oct 2020 12:10:39 -0700 (PDT)
Received: from ?IPv6:2402:3a80:431:7ac0:8cb2:c45f:197:35d9? ([2402:3a80:431:7ac0:8cb2:c45f:197:35d9])
        by smtp.gmail.com with ESMTPSA id f66sm3186429pfa.59.2020.10.21.12.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 12:10:38 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: fix false positive for REPEATED_WORD warning
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com
References: <20201021150120.29920-1-yashsri421@gmail.com>
 <f073750511750336de5f82600600ba6cb3ddbec0.camel@perches.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <0562c42d-f9af-1141-ab77-8abb73bfd31f@gmail.com>
Date:   Thu, 22 Oct 2020 00:40:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f073750511750336de5f82600600ba6cb3ddbec0.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/20 8:48 pm, Joe Perches wrote:
> On Wed, 2020-10-21 at 20:31 +0530, Aditya Srivastava wrote:
>> Presence of hexadecimal address or symbol results in false warning
>> message by checkpatch.pl.
>>
>> For example, running checkpatch on commit b8ad540dd4e4 ("mptcp: fix
>> memory leak in mptcp_subflow_create_socket()") results in warning:
>>
>> WARNING:REPEATED_WORD: Possible repeated word: 'ff'
>>     00 00 00 00 00 00 00 00 00 2f 30 0a 81 88 ff ff  ........./0.....
> 
> Right.
> 
>> To avoid all such reports, add an additional regex check for a repeating
>> pattern of 4 or more 2-lettered words separated by space in a line.
> 
>> A quick evaluation on v5.6..v5.8 showed that this fix reduces
>> REPEATED_WORD warnings from 2797 to 1043.
> 
> Are many of the other 1043 false positives?
> Any pattern to them?
> 

Apart from the changes suggested by Dwaipayan in
https://lore.kernel.org/linux-kernel-mentees/20201017162732.152351-1-dwaipayanray1@gmail.com/

The 'ls -l' output seems to be another common false positive for
REPEATED_WORD (Frequency 106 over v5.6..v5.8). For eg.

WARNING:REPEATED_WORD: Possible repeated word: 'root'
#18:
  drwxr-xr-x. 2 root root    0 Apr 17 10:53 .

WARNING:REPEATED_WORD: Possible repeated word: 'nobody'
#28:
drwxr-xr-x 5 nobody nobody    0 Jan 25 18:08 .

WARNING:REPEATED_WORD: Possible repeated word: 'irogers'
#17:
  -rw-r----- 1 irogers irogers 553 Apr 17 14:31
../../../util/unwind-libdw.h

These can be avoided by using:
@@ -3050,8 +3050,10 @@ sub process {
 			}
 		}

-		if ($rawline =~ /^\+/ || $in_commit_log) {
+		if (($rawline =~ /^\+/ || $in_commit_log) &&
+		$rawline !~ /\b[a-z-]+.* \d{1,3} [a-zA-Z]+ \w+ +\d+ \w{3} \d{1,2}
\d{1,2}:\d{1,2}/) {

Sincerely
Aditya

>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -3050,8 +3050,10 @@ sub process {
>>  			}
>>  		}
>>  
>> -# check for repeated words separated by a single space
>> -		if ($rawline =~ /^\+/ || $in_commit_log) {
>> +# check for repeated words separated by a single space and
>> +# avoid repeating hex occurrences like 'ff ff fe 09 ...'
>> +		if (($rawline =~ /^\+/ || $in_commit_log) &&
>> +		$rawline !~ /(\b[0-9a-f]{2}( )+){4,}/) {
> 
> This might be better as \b$Hex to avoid FF FF
> and FFFFFFFF FFFFFFFF
> 
> I might add that check to the line below where
> the repeated words are checked against long
> ---
>  scripts/checkpatch.pl | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index fab38b493cef..929866999f81 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3062,6 +3062,7 @@ sub process {
>  
>  				next if ($first ne $second);
>  				next if ($first eq 'long');
> +				next if ($first =~ /^$Hex$/;
>  
>  				if (WARN("REPEATED_WORD",
>  					 "Possible repeated word: '$first'\n" . $herecurr) &&
> 
> 

