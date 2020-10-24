Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99E6297BA2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 11:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760461AbgJXJ20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 05:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760454AbgJXJ2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 05:28:25 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AC6C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 02:28:25 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x10so24653plm.13
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 02:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1x+p2HDoq+uPS1PcQClHUkWFKa3rEJTmQpkbNK8MKhU=;
        b=g4HLe5iKXuF+Joprfh0tPLgpDu3xwcRGr4QuNKTSN2vjiJDnpxZmJrGxD0VakKsUbp
         ZPX4yt8K9OgLR4EJqbrygFn+3b1Zl5KD87E6l/PKKMGRd32c9pKjVSNvZ/jS3a2pSMly
         E8498Y5Uq+Hs5mhOihubpmRssnIF9uufwm0Hlj+OUcLt5wnT6myT2peHpNrBAE3cQysB
         qvY0lozx+u4ZLPx5shDYto3Wb3x7aonb2+WIjQeIu7HbXXrHbOLhYWTf5VdiBkbY33EG
         E9v01iA/uXEjWXQjc/htJOgFSQMzBjqy5X332ig+ACbrGUn60GeLdgD7v6U3/6Ghz5/l
         kUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1x+p2HDoq+uPS1PcQClHUkWFKa3rEJTmQpkbNK8MKhU=;
        b=QoWweOzjVk5xM/aVlKT1PSPuah84rs0k2Z7OiBgf24vXUh1j59neus9bTSQO9akl3+
         o1hgVPNnOERfySv/XgyIVOTjcsP1V3ksPJNDjKmlwTJLTs4x8EdVacCCPM5WXb9Aw1xM
         Ncb7gYxkjWGAntGSw/xMwS7GT/qF5qPAvPFx/jMCaMoRYBbTv3wuchIS8EStO8Zhsrz+
         SycQYUwRBW4CwQa5EmBFnI/xOSN14+ixZ7pbzjTxsbO90EYwApNpfdagAr/wNjzYhxl0
         FF0ChNK3c/nIt1eu+oHM9PatmPrqyMyNFQEMYnlyjy76+X1+6zhNpZUjmwI7jme0ZD+Z
         ST6g==
X-Gm-Message-State: AOAM532nY6Gtms04001hMYzDtvjJxgObqE2J0iKUzzQW3/r/Q10SRu+F
        U78YHRHLyXLyJlgKC7mYFckFSzsUeAUAlYBn
X-Google-Smtp-Source: ABdhPJxc1DCcHItcrTy6gNBtJHDoq/kqKDnFB5iPsYC1pIC/WzD2f2uxZx28hrjrjLA359L0BTmdpQ==
X-Received: by 2002:a17:902:c24b:b029:d5:f14a:318d with SMTP id 11-20020a170902c24bb02900d5f14a318dmr3707444plg.4.1603531705218;
        Sat, 24 Oct 2020 02:28:25 -0700 (PDT)
Received: from ?IPv6:2402:3a80:40f:9156:55ee:fad5:f15e:347e? ([2402:3a80:40f:9156:55ee:fad5:f15e:347e])
        by smtp.gmail.com with ESMTPSA id 8sm5738229pjk.20.2020.10.24.02.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2020 02:28:24 -0700 (PDT)
Subject: Re: [PATCH v4] checkpatch: fix false positives in REPEATED_WORD
 warning
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com
References: <20201024000830.12871-1-yashsri421@gmail.com>
 <5bc34c6faf989f528c92f5e631607f1774f08d20.camel@perches.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <c4432b0c-3e21-20ec-d439-cdfebc283148@gmail.com>
Date:   Sat, 24 Oct 2020 14:58:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5bc34c6faf989f528c92f5e631607f1774f08d20.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/20 7:07 am, Joe Perches wrote:
> On Sat, 2020-10-24 at 05:38 +0530, Aditya Srivastava wrote: 
>> A quick evaluation on v5.6..v5.8 showed that this fix reduces
>> REPEATED_WORD warnings from 2797 to 907.
> 
> How many of these 907 remaining are still false positive?
>  
>> A quick manual check found all cases are related to hex output or
>> list command outputs in commit messages.
> 
> You mean 1890 of the 2797 are now no longer reported and all 1890
> were false positives yes?
> 

Yes. In v5.6..5.8, there were 2797 warnings for REPEATED_WORD, after
these changes, they are reduced to 907.
However, many among these 907 must have been fixed by Dwaipayan's
patch. I'll replace it with 1890 instead, for the better.

>>  			pos($rawline) = 1 if (!$in_commit_log);
>>  			while ($rawline =~ /\b($word_pattern) (?=($word_pattern))/g) {
>>  
>>
>> @@ -3074,6 +3076,17 @@ sub process {
>>  				next if ($start_char =~ /^\S$/);
>>  				next if (index(" \t.,;?!", $end_char) == -1);
>>  
>>
>> +                                # avoid repeating hex occurrences like 'ff ff fe 09 ...'
>> +                                my %allow_repeated_words = (
>> +                                        add => '',
>> +                                        added => '',
>> +                                        bad => '',
>> +                                        be => '',
>> +                                );
> 
> If perl caches this local hash declaration, fine,
> but I think it better to use 'our %allow_repeated_words'
> and move it so it's only declared using the file scope.
> 

I ran checkpatch over few commits, it was working fine. But I'll move
it to file scope, using 'our'. That should do as well.

>> +                                if ($first =~ /\b[0-9a-f]{2,}\b/) {
> 
> This regex matches only lower case so it wouldn't match "Add".
> 
> I think this regex would be clearer using
> 	/^[0-9a-f]+$/i or /^[A-Fa-f0-9]+$/
> 
> 

Missed it. Will do.

Thanks
Aditya
