Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D96C300EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 22:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbhAVV3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 16:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731081AbhAVUOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:14:07 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B9AC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:13:25 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id j12so4540848pfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P9tYxUwkT1diagUtKn01/sYWnChBZ13cYDuFtjNNJ6E=;
        b=RqFQHT/cm0iQdmZST9Af5cM0lNKHS3FPYNpey9Rusbswe4Eejn7P9J/PJDFYk/sOf5
         6L+h0hTGGx/vMVX0WCGGwzZRGR8wfUMM9QaHDJHglbJ2Nf6pHt4jHnITtqc687r+Jn9w
         AKRiIcQLAEbYBRSXAikrBuJv9FUjVwT7S6FuDBOTz63bh/g2CgFTobIwko8nrBRa/TLe
         ljMD50xpn5V9gvMtAjnYGF4uq68WPtm/vq0l4JbJYVD+whlYA+Q8ufEmTXrkPGZNfQsI
         GXzqFlKycnXMUHSblx+4TL70ee4oZsiml/Pb+kR5P1TGA1IasGGGjYP/AgSiMBmRDa3S
         pLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P9tYxUwkT1diagUtKn01/sYWnChBZ13cYDuFtjNNJ6E=;
        b=Sl6p3qbeeQ0PiQkOckcHrtawtmSNw2ZPWQ37RmvXyAtuWF9T8tPrQYZw1g+RqB1+4b
         pCRj6LznNWYH8hgCcB86Mjw+Cl/GN6s34aoqbsVosoQR6is6caBI80L/RGiLiYnSelKm
         PrVcfgmh35uGHJTjJ5Zc+iuFmK0fpkkgjAGovRsqzYCIRCj5IQRfU1rFRXQTMtRy0b3K
         hQfA6TN9cfhLPdFm3gKUJMew7o6tglEm3jP+KHBzhcq1+aN2qwAVbDiwFTTgNs/J75bt
         d9oEnRPpIp9Pj5833sA0AS7f9xmCzQUQW31+nBPnJRmVSuh0gzgh5UXJtES1dSnDxg22
         c+eA==
X-Gm-Message-State: AOAM532zdPjOlemX+MGfz3e2rEJNOTsuj3EpfrjR4FnSaXL1DKNoO5/N
        UsixD53dV7btxQc/65pDPvQ=
X-Google-Smtp-Source: ABdhPJzYbDnJqvneR1TTA42JC4Jy5xe6d5Fir/gFzfPWl+44ER4KNbtUbUh8p4gVanrenaI8p3YbZw==
X-Received: by 2002:a65:5b47:: with SMTP id y7mr6136443pgr.221.1611346405325;
        Fri, 22 Jan 2021 12:13:25 -0800 (PST)
Received: from ?IPv6:2405:201:600d:a089:5548:7837:8dcd:a8? ([2405:201:600d:a089:5548:7837:8dcd:a8])
        by smtp.gmail.com with ESMTPSA id n1sm9689327pjv.47.2021.01.22.12.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 12:13:24 -0800 (PST)
Subject: Re: [PATCH] checkpatch: add warning for avoiding .L prefix symbols in
 assembly files
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com,
        broonie@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        clang-built-linux@googlegroups.com
References: <20210120072547.10221-1-yashsri421@gmail.com>
 <e5c5f8495fbdd063f4272f02a259bbf28b199bdd.camel@perches.com>
 <14707ab9-1872-4f8c-3ed8-e77b663c3adb@gmail.com>
 <fb1b511d71761c99a9bece803f508b674fce9962.camel@perches.com>
 <98d40817-1f80-c772-eb9e-a6c3c04625b3@gmail.com>
 <27366417ad75e0300d4647f776ca61bb1b132507.camel@perches.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <bd560a8e-7949-933a-e4a9-508cb42c2570@gmail.com>
Date:   Sat, 23 Jan 2021 01:43:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <27366417ad75e0300d4647f776ca61bb1b132507.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/1/21 12:40 am, Joe Perches wrote:
> On Fri, 2021-01-22 at 18:48 +0530, Aditya wrote:
>> On 21/1/21 12:13 am, Joe Perches wrote:
>>> I believe the test should be:
>>>
>>> 	if ($realfile =~ /\.S$/ &&
>>> 	    $line =~ /^\+\s*SYM_[A-Z]+_(?:START|END)(?:_[A-Z_]+)?\s*\(\s*\.L/) {
>>
>> Joe, with this regex, we won't be able to match
>> "jmp  .L_restore
>> SYM_FUNC_END(\name)"
> 
> I think that's not an issue.
> 
>> which was replaced in this patch in the discussion:
>> https://groups.google.com/g/clang-built-linux/c/-drkmLgu-cU/m/phKe-Tb6CgAJ
>>
>> Here, "jmp  .L_restore" was also replaced to fix the error.
> 
> Notice that this line was also replaced in the same patch:
> 
>  #ifdef CONFIG_PREEMPTION
> -SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
> +SYM_CODE_START_LOCAL_NOALIGN(__thunk_restore)
> 
> 
>> However, if this
>> regex(/^\+\s*SYM_[A-Z]+_(?:START|END)(?:_[A-Z_]+)?\s*\(\s*\.L/) is
>> correct, maybe we don't need to check for $file as we are now checking
>> for just one line.
>>
>> What do you think?
> 
> The test I wrote was complete, did not use $file and emits a
> warning on the use of CODE_SYM_START_LOCAL_NOALIGN(.L_restore)
> 
> I think it's sufficient.
> 

Okay, Thanks.. I will send the modified patch :)

Thanks
Aditya
