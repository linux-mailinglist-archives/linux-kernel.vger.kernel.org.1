Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C9B296140
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368305AbgJVO6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368201AbgJVO6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:58:18 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A725C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:18 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w11so1087322pll.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WD0jtBNTjlU9AN49fhz5jjiyP58Uz1jlaJhU9PAdtjM=;
        b=dcCPde1CvGRMz3wM7wYha4dqt3k7ghjEmbmwUrBkqVEzqFi9K4UX/sszrLKlLCEdjt
         OgVgu1x8IXbs6uqlDQzISq8JMv+PuwNHidl27bE/2C66q2NnEhBFdc7eBTcZnJTNeRMA
         1PEgEwX+HGZqDxwypiyGUe+HoF5+41CAq4ZAFAvvDwKs3+kHsqMolsFCXFT+vq+tUyKx
         6X93LSWyzHbcjHZWed9Ub5YRag+TodepPKSMDnE4R3sCfQEu+wsR7IqUiYiv+gnF+COE
         ++F/v85PIHDcu9U3U6jPnHusikRmF+Xe51R1wO3BJdOUShqhNAARaoFT9VhnnRY9dATr
         HY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WD0jtBNTjlU9AN49fhz5jjiyP58Uz1jlaJhU9PAdtjM=;
        b=Vinq/gNGCzBLCbeD8+qSnnL+9/jwly5+Ux3Px+leQy2lllLo9wZZIqzTpXIur7yiQT
         k+0qOTS8GWDkm4vSTx30ng0tMeQxFEALdaWU9q/i4tclqXkIbptD5ws9qglNsMdD8GJ6
         h5+aB++lH1PNiX6y9v5yBJ2VxrqJd8ZzGLqPIJc3AsfqBEB5ti+r8aAIkH5NhaTvYsde
         5YncteANtlYbtjtI1RS8GybG6wK4K8xOLcTC5JIB43LSOfOl/kvlFJ3azdLF1LPS3Tl1
         BeqEW1CL1Iam7P4AIkg4+KWkFcmIqPlSijf7fTKgmzOZ33tKuOz+gs+Gngq1SB0JihDC
         KQJg==
X-Gm-Message-State: AOAM5325x97mSuZc8YVG51kmpqP70Roj3yizhQtA0aEPnnxjTy2KqFwG
        2AMfvBuw3MnAXVBkjxEM0U8=
X-Google-Smtp-Source: ABdhPJwy+XLpMOCBB3opoKCpHFBgZ75ggUWsKgHfEf9nERb3jpZYy8pk+k1tS8TI44/2yJaWLYfkrw==
X-Received: by 2002:a17:902:708a:b029:d4:cf7c:6c59 with SMTP id z10-20020a170902708ab02900d4cf7c6c59mr3103971plk.52.1603378697733;
        Thu, 22 Oct 2020 07:58:17 -0700 (PDT)
Received: from ?IPv6:2402:3a80:41a:7419:e1bd:6bc1:d06a:efd1? ([2402:3a80:41a:7419:e1bd:6bc1:d06a:efd1])
        by smtp.gmail.com with ESMTPSA id b5sm2607693pfo.64.2020.10.22.07.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 07:58:17 -0700 (PDT)
Subject: Re: [PATCH v2] checkpatch: fix false positives in REPEATED_WORD
 warning
To:     joe@perches.com
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com
References: <20201022145021.28211-1-yashsri421@gmail.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <1de93783-1faf-95b9-c8bd-2f2bb2f8a010@gmail.com>
Date:   Thu, 22 Oct 2020 20:28:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201022145021.28211-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/20 8:20 pm, Aditya Srivastava wrote:
> Presence of hexadecimal address or symbol results in false warning
> message by checkpatch.pl.
> 
> For example, running checkpatch on commit b8ad540dd4e4 ("mptcp: fix
> memory leak in mptcp_subflow_create_socket()") results in warning:
> 
> WARNING:REPEATED_WORD: Possible repeated word: 'ff'
>     00 00 00 00 00 00 00 00 00 2f 30 0a 81 88 ff ff  ........./0.....
> 
> Similarly, the presence of list command output in commit results in
> an unnecessary warning.
> 
> For example, running checkpatch on commit 899e5ffbf246 ("perf record:
> Introduce --switch-output-event") gives:
> 
> WARNING:REPEATED_WORD: Possible repeated word: 'root'
>   dr-xr-x---. 12 root root    4096 Apr 27 17:46 ..
> 
> Here, it reports 'ff' and 'root to be repeated, but it is in fact part
> of some address or code, where it has to be repeated.
> 
> In these cases, the intent of the warning to find stylistic issues in
> commit messages is not met and the warning is just completely wrong in
> this case.
> 
> To avoid these warnings, add additional regex check for the
> directory permission pattern and avoid checking the line for this
> class of warning. Similarly, to avoid hex pattern, check if the word
> consists of hex symbols and skip this warning if, it forms a pattern
> of repeating sequence or contains more special character after pattern
> than non hex characters.
> 
> A quick evaluation on v5.6..v5.8 showed that this fix reduces
> REPEATED_WORD warnings from 2797 to 907.
> 
> A quick manual check found all cases are related to hex output or
> list command outputs in commit messages.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
>  scripts/checkpatch.pl | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 9b9ffd876e8a..0f57e99ed670 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3051,7 +3051,10 @@ sub process {
>  		}
>  
>  # check for repeated words separated by a single space
> -		if ($rawline =~ /^\+/ || $in_commit_log) {
> +# avoid false positive from list command eg, '-rw-r--r-- 1 root root'
> +		if (($rawline =~ /^\+/ || $in_commit_log) &&
> +		$rawline !~ /[bcCdDlMnpPs\?-][rwxsStT-]{9}/) {
> +			my @hex_seq = $rawline =~ /\b[0-9a-f]{2,} \b/g;
>  			while ($rawline =~ /\b($word_pattern) (?=($word_pattern))/g) {
>  
>  				my $first = $1;
> @@ -3065,6 +3068,34 @@ sub process {
>  				next if ($first ne $second);
>  				next if ($first eq 'long');
>  
> +				# avoid repeating hex occurrences like 'ff ff fe 09 ...'
> +				if ($first =~ /\b[0-9a-f]{2,}/) {
> +					# if such sequence occurs more than 4, it is most probably part of some of code
> +					next if ((scalar @hex_seq)>4);
> +
> +					# for hex occurrences which are less than 4
> +					# get first hex word in the line
> +					if ($rawline =~ /\b[0-9a-f]{2,} /) {
> +						my $post_hex_seq = $';
> +
> +						# set suffieciently high default values to avoid ignoring or counting in absence of another
> +						my $non_hex_char_pos = 1000;
> +						my $special_chars_pos = 500;
> +
> +						if ($post_hex_seq =~ /[g-z]+/) {
> +							# first non hex character in post_hex_seq
> +							$non_hex_char_pos = $-[0];
> +						}
> +						if($post_hex_seq =~ /[^a-zA-Z0-9]{2,}/) {
> +							# first occurrence of 2 or more special chars
> +							$special_chars_pos = $-[0];
> +						}
> +
> +						# as such occurrences are not common, it is more likely to be a part of some code
> +						next if ($special_chars_pos<$non_hex_char_pos);
> +					}
> +				}
> +
>  				if (WARN("REPEATED_WORD",
>  					 "Possible repeated word: '$first'\n" . $herecurr) &&
>  				    $fix) {
> 

I have also generated some reports showing impact caused by the changes:

Hex variations causing warning previously:
https://github.com/AdityaSrivast/kernel-tasks/blob/master/Task3/hex_variations.txt

Change in warnings and errors:
https://github.com/AdityaSrivast/kernel-tasks/blob/master/Task3/relative_summary/summary_relative.txt

Warnings which are dropped:
https://github.com/AdityaSrivast/kernel-tasks/blob/master/Task3/relative_summary/dropped_warnings/summary.txt

Thanks
Aditya
