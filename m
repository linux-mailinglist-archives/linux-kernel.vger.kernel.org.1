Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8915430179D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 19:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbhAWS0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 13:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbhAWS0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 13:26:24 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1A8C061786
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 10:25:43 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id n7so6128258pgg.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 10:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IgsmJxNhjM6n7JOSepgWyLYU2D0ed5MSeP1SAOXnnP8=;
        b=E0Be+SNKLKxeZp1olAA15doSY0b2e6N3oQCN5iJ07sOIZUCGohvOwrfj2LzAaW5TUD
         WMOU1Gtfis9fTfYMQfkfZeMj1mU3lvMm1CDGovVBg642EssNONQDGhRYbRwtUSr8hnJy
         uZhOlnHfgrmXZfcskPREbKzLoy9W8HleVFErPyFeWevSefoxdbzg/bLSBArWwWYjeVkm
         V1rXAZOmnxEcpds3ctdGtm/WJHqLvSMJoVZvBUS7CIY8W9/2kk7rdvqeFVKYz8F6RwEJ
         l5MbdKJXV3ZVoxZu2721vqNn0I19lJjGTecavBfLTvnKwVKt2VBBhDJKKgW3WlyC936Y
         HRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IgsmJxNhjM6n7JOSepgWyLYU2D0ed5MSeP1SAOXnnP8=;
        b=WEwjoWJ8g31y8DZ84/yoW/oRnNzxG4aeBCF3eXVkR2M2i5Jsg5DOBx/GZWZFNqVZbW
         RtEjJ3hFfcg1ZayhmN4sd0e2H5eHEYx2mO0+V+a21qVriCd8vtV94zriU05vhecDVA6w
         MjRRBGnCq9ak7sySynOISj5tpSheCnGUTwoecLUTzyl9QN1yZ8VWDS1JSIoRgw75s+9V
         bdXs5A3XZ5+TigKwFmT92ux4XtA8rLbjP0TyX/Chj5R0YFTgaJ+O5SSwoKc7k/4xPnRs
         G3mtuJs9RPgw5dZ363hDdbtFGk5wtcLi5x3I4Wi104KE8EToob3geSuFuxZ7SYNwcASF
         35IA==
X-Gm-Message-State: AOAM531ZZuO/yv4iZu1KJioF2DC8TrF1krJ3HtCqeyCibI1/I7hdhwuV
        vM2oj/QzoMg7zt7k26zDTfg=
X-Google-Smtp-Source: ABdhPJxYZHAMZK8r1avLZqQyT+NhvO35Mi3DXrBP+wvlmArlvV7owuYyb2TVHHOzbKA3bEkXakVO1A==
X-Received: by 2002:a65:458d:: with SMTP id o13mr10574362pgq.450.1611426342838;
        Sat, 23 Jan 2021 10:25:42 -0800 (PST)
Received: from [192.168.29.245] ([49.36.171.181])
        by smtp.gmail.com with ESMTPSA id a22sm8777677pjh.5.2021.01.23.10.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jan 2021 10:25:42 -0800 (PST)
Subject: Re: [PATCH v2] checkpatch: add warning for avoiding .L prefix symbols
 in assembly files
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com,
        broonie@kernel.org, ndesaulniers@google.com, jpoimboe@redhat.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        clang-built-linux@googlegroups.com
References: <bd560a8e-7949-933a-e4a9-508cb42c2570@gmail.com>
 <20210123151405.26267-1-yashsri421@gmail.com>
 <d5eacb78bd354d26725c34d887a75bf1e8f27a04.camel@perches.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <f23f4003-0017-d52a-39b9-2737e60182bb@gmail.com>
Date:   Sat, 23 Jan 2021 23:53:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d5eacb78bd354d26725c34d887a75bf1e8f27a04.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/1/21 10:51 pm, Joe Perches wrote:
> On Sat, 2021-01-23 at 20:44 +0530, Aditya Srivastava wrote:
>> objtool requires that all code must be contained in an ELF symbol.
>> Symbol names that have a '.L' prefix do not emit symbol table entries, as
>> they have special meaning for the assembler.
>>
>> '.L' prefixed symbols can be used within a code region, but should be
>> avoided for denoting a range of code via 'SYM_*_START/END' annotations.
>>
>> Add a new check to emit a warning on finding the usage of '.L' symbols
>> for '.S' files in arch/x86/entry/* and arch/x86/lib/*, if it denotes
>> range of code via SYM_*_START/END annotation pair.
>>
>> Suggested-by: Mark Brown <broonie@kernel.org>
>> Link: https://groups.google.com/g/clang-built-linux/c/-drkmLgu-cU/m/4staOlf-CgAJ
> 
> Please do not use groups.google.com links, or if you must, please
> use links that are readable.
> 
> For instance, this is a better link as it shows the context without
> struggling with the poor interface:
> 
> https://groups.google.com/g/clang-built-linux/c/E-naBMt_1SM
> 

Okay, Got it.. I'll use lkml link for the best.

>> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
>> ---
>> * Applies perfectly on next-20210122
>>
>> Changes in v2:
>> - Reduce the check to only SYM_*_START/END lines
>> - Reduce the check for only .S files in arch/x86/entry/* and arch/x86/lib/* as suggested by Josh and Nick
> 
> I think that's unnecessary.
> 
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -3590,6 +3590,13 @@ sub process {
>>  			}
>>  		}
>>  
>>
>> +# check for .L prefix local symbols in .S files
>> +		if ($realfile =~ m@^arch/x86/(?:entry|lib)/.*\.S$@ &&
> 
> Using /.S$/ should be enough
> 
>> +		    $line =~ /^\+\s*SYM_[A-Z]+_(?:START|END)(?:_[A-Z_]+)?\s*\(\s*\.L/) {
> 
> This might need to be
> 
> +		    $line =~ /^\+\s*(?:[A-Z]+_)?SYM_[A-Z]+_(?:START|END)(?:_[A-Z_]+)?\s*\(\s*\.L/) {
> 

Okay.. Thanks. I'll modify the patch accordingly.

Thanks
Aditya
>> +			WARN("AVOID_L_PREFIX",
>> +			     "Avoid using '.L' prefixed local symbol names for denoting a range of code via 'SYM_*_START/END' annotations; see Documentation/asm-annotations.rst\n" . $herecurr);
>> +		}
>> +
> 
> 

