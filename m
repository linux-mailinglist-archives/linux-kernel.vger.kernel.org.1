Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A092979F4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 02:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756419AbgJXA1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 20:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756392AbgJXA1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 20:27:41 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458B8C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 17:27:41 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh6so1886040plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 17:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MNY+o3uP+L0Es3K4x/dnh14bBow7VRrfPWTllaXx+PA=;
        b=Cd6U2JgN3lOOxPvb0py3t3q6zO2m7Nf6xFIXUvhXQYGI4kAlNp23nNafG9tjM/9bZ2
         wU1NekEgipkV1Zzd74CPpdtOj13KoZ+eEBPV27FzO2hrSCHY4OaAW0JfNatsi+2+L8CZ
         4ajir9Obu3gMTTK8NA1voaUHnjLaTnPFq3hQOCdBZdWASZMBEQDM0woHq+hF/oYtShV7
         afXvKwRu6A6HIa0VTVw84ou78BYDCHuZ3542oanLkHcQ8u/6ITnTKxmvG3sKPIMH1o0p
         LENrIjrnyYFo+gdT8/XTkYfdRhtCpZ8I/vNlnwovoWltD341VOvtQ3u7Il1TR/JFtcoH
         jH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MNY+o3uP+L0Es3K4x/dnh14bBow7VRrfPWTllaXx+PA=;
        b=hH7f/ruE5YRhB7V32HDyx3sRWOVvZIO/kXTDEgwoS0chQyBCwiuruBm0AqWQPIhX8b
         fuxHdE+xakoy9ygg2e2mPjQFVGPDWwdQ/igqqt93NdFDn4RIqV80lTENTi0nGjtsjCPC
         va7cBdeOvasJ8eaUNFHNd7EVXIzdFBirfBDTcfnGE+pGHOzIfZNrqeCZQR8Xi5vK6s7U
         7VvFpcuir3VxT3xVoUKEI7BZooLSUudNQMptOmNXhtpKGy7JYfV2gl8AO11m2N+peIlu
         1YyPlmeaz/Q5Ky7qsj2ylr0X7903G/33QziAc4zgJSa9DmzOTtUEDUe9QeQ0+widgKVK
         X5PQ==
X-Gm-Message-State: AOAM532aeheIe/dcZpeMmNhD4vLSFwUHNbOkUI7cVoIycxq2Q0lQ7s/2
        qlqTEazSyKr27fj5fh28b1hTtXzoMwOZjCx0
X-Google-Smtp-Source: ABdhPJx7tJD1Wj6ABsAvUNQPfP32A0eRZrn4iaJB6Q9nChiUSC37YUVbAejIPZPVBnbZ1Id402Xpkw==
X-Received: by 2002:a17:902:b107:b029:d2:ab87:c418 with SMTP id q7-20020a170902b107b02900d2ab87c418mr1533331plr.40.1603499260615;
        Fri, 23 Oct 2020 17:27:40 -0700 (PDT)
Received: from ?IPv6:2402:3a80:429:6ba7:30ef:4722:a786:585f? ([2402:3a80:429:6ba7:30ef:4722:a786:585f])
        by smtp.gmail.com with ESMTPSA id d9sm3950188pjx.47.2020.10.23.17.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 17:27:40 -0700 (PDT)
Subject: Re: [PATCH v4] checkpatch: fix false positives in REPEATED_WORD
 warning
To:     joe@perches.com
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com
References: <20201024000830.12871-1-yashsri421@gmail.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <f78dd5a8-f566-c933-2f4d-b003e49847f6@gmail.com>
Date:   Sat, 24 Oct 2020 05:57:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201024000830.12871-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/20 5:38 am, Aditya Srivastava wrote:
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
> consists of hex symbols and skip this warning if it is not among the
> common english words formed using hex letters.
> 
> A quick evaluation on v5.6..v5.8 showed that this fix reduces
> REPEATED_WORD warnings from 2797 to 907.
> 
> A quick manual check found all cases are related to hex output or
> list command outputs in commit messages.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
>  scripts/checkpatch.pl | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7e505688257a..1d42d08d520b 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3049,7 +3049,9 @@ sub process {
>  		}
>  
>  # check for repeated words separated by a single space
> -		if ($rawline =~ /^\+/ || $in_commit_log) {
> +# avoid false positive from list command eg, '-rw-r--r-- 1 root root'
> +		if (($rawline =~ /^\+/ || $in_commit_log) &&
> +                    $rawline !~ /[bcCdDlMnpPs\?-][rwxsStT-]{9}/) {
>  			pos($rawline) = 1 if (!$in_commit_log);
>  			while ($rawline =~ /\b($word_pattern) (?=($word_pattern))/g) {
>  
> @@ -3074,6 +3076,17 @@ sub process {
>  				next if ($start_char =~ /^\S$/);
>  				next if (index(" \t.,;?!", $end_char) == -1);
>  
> +                                # avoid repeating hex occurrences like 'ff ff fe 09 ...'
> +                                my %allow_repeated_words = (
> +                                        add => '',
> +                                        added => '',
> +                                        bad => '',
> +                                        be => '',
> +                                );
> +                                if ($first =~ /\b[0-9a-f]{2,}\b/) {
> +                                        next if (!exists($allow_repeated_words{lc($first)}));
> +                                }
> +
>  				if (WARN("REPEATED_WORD",
>  					 "Possible repeated word: '$first'\n" . $herecurr) &&
>  				    $fix) {
> 

Changes made in v4:
- Fix indentation
- Reduce the dictionary size for allowed words
- Apply changes over Dwaipayan's patch
(https://lore.kernel.org/linux-kernel-mentees/20201017162732.152351-1-dwaipayanray1@gmail.com/)
