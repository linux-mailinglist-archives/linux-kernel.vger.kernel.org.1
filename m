Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156BB3003FF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbhAVNTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbhAVNTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:19:32 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF22C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:18:51 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id b5so3774203pjl.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2IuYY7Ptttp60mCGRmohDF14eaicEWNySULlVw9pTIE=;
        b=qex1eud/YCF92qwJywdZihwqDlX3vnjuAP2CB4UurkPrU4eO32mUAdJIy6GM2biaVd
         0Ia2yHwucoOxWBzwJLITKb/6ktswnxKEeoUobJB6SVLU4/YBy6PJUGmQeDxQjoqr+C3G
         IPTArAJSgh8uUuv2ml8Ei6uwMKzAGiqiO89FuEWLM7teCgu2ZhTgGYAAol82uiiQmomw
         jUYzm95zyjwrLOxZg7yVcbUW0N6tzcsrLY2gNWE++HtQTfZ+HzqK2miS5wZGzADL1lem
         HcbHGr9HmZPSHE14M+vmGwI3lhYD7pPShrAbpsToGs3I6DIVYeftFy6vEwu8deGNslbP
         6v8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2IuYY7Ptttp60mCGRmohDF14eaicEWNySULlVw9pTIE=;
        b=twHOGHqG/PSnlh/tznE0ZB9AuqgIgSX3gUKm4FBYNTbobB/HXbE5Y6a2V9Qf0/5ueK
         nd+T+L/1YVm8J2K0D7K3J8ICX9hFVFu+QzA8jT83uAuGlel/bd3tik7ILBd/lzWeGVwu
         729rvjEGttxAkiEC4blAafxYvaHtjEJEu0nEK5V0uqSYMPJJDez1KIez471vtz/eBiQn
         mio59qZJzhN3mmPKqZmOrIT73zqtEwjNTqi6Jx4/ZWIB0/a/7u2Ble2HfkuttM0E/x+L
         5gtvRgZz9HREDN5PW05+XTn5mBTdVRycGOo9sMkye8nAnERRuLhxHBiI4HVWOCXj2qvI
         PN1w==
X-Gm-Message-State: AOAM530J9bg4Xt8o/j9hQx1ui98iHcHDVTqbSYiaeFpg2QkDXKcyeFWQ
        rBOfhg2EQGVeUO8FHh1DJvJ+7IUyIJ4PSA==
X-Google-Smtp-Source: ABdhPJxoEW6GFoFDxwtzzlLOAR4hkWxhUM/CRwSMZqHFI3qj4GMAJcLqLhtFhl13ljtuLoMyQAZALA==
X-Received: by 2002:a17:902:e54e:b029:de:8c70:2ed0 with SMTP id n14-20020a170902e54eb02900de8c702ed0mr4946054plf.3.1611321531356;
        Fri, 22 Jan 2021 05:18:51 -0800 (PST)
Received: from ?IPv6:2405:201:600d:a089:5548:7837:8dcd:a8? ([2405:201:600d:a089:5548:7837:8dcd:a8])
        by smtp.gmail.com with ESMTPSA id b206sm8608751pfb.73.2021.01.22.05.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 05:18:50 -0800 (PST)
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
From:   Aditya <yashsri421@gmail.com>
Message-ID: <98d40817-1f80-c772-eb9e-a6c3c04625b3@gmail.com>
Date:   Fri, 22 Jan 2021 18:48:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fb1b511d71761c99a9bece803f508b674fce9962.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/1/21 12:13 am, Joe Perches wrote:
> On Wed, 2021-01-20 at 18:23 +0530, Aditya wrote:
>> On 20/1/21 2:51 pm, Joe Perches wrote:
>>> On Wed, 2021-01-20 at 12:55 +0530, Aditya Srivastava wrote:
>>>> Local symbols prefixed with '.L' do not emit symbol table entries, as
>>>> they have special meaning for the assembler.
>>>>
>>>> '.L' prefixed symbols can be used within a code region, but should be
>>>> avoided for denoting a range of code via 'SYM_*_START/END' annotations.
>>>>
>>>> Add a new check to emit a warning on finding the usage of '.L' symbols
>>>> in '.S' files, if it lies within SYM_*_START/END annotation pair.
>>>
>>> I believe this needs a test for $file as it won't work well on
>>> patches as the SYM_*_START/END may not be in the patch context.
>>>
>> Okay.
>>
>>> Also, is this supposed to work for local labels like '.L<foo>:'?
>>> I don't think a warning should be generated for those.
>>>
>> Yes, currently it will generate warning for all symbols which start
>> with .L and have non- white character symbol following it, if it is
>> lying within SYM_*_START/END annotation pair.
>>
>> Should I reduce the check to \.L_\S+ instead? (please note "_"
>> following ".L")
> 
> Use grep first.  That would still match several existing labels.
> 
>> Pardon me, I'm not good with assembly :/
> 
> Spending time reading docs can help with that.
> 
> Mark?  Can you please comment about the below?
> 
> I believe the test should be:
> 
> 	if ($realfile =~ /\.S$/ &&
> 	    $line =~ /^\+\s*SYM_[A-Z]+_(?:START|END)(?:_[A-Z_]+)?\s*\(\s*\.L/) {

Joe, with this regex, we won't be able to match
"jmp  .L_restore
SYM_FUNC_END(\name)"

which was replaced in this patch in the discussion:
https://groups.google.com/g/clang-built-linux/c/-drkmLgu-cU/m/phKe-Tb6CgAJ

Here, "jmp  .L_restore" was also replaced to fix the error.

However, if this
regex(/^\+\s*SYM_[A-Z]+_(?:START|END)(?:_[A-Z_]+)?\s*\(\s*\.L/) is
correct, maybe we don't need to check for $file as we are now checking
for just one line.

What do you think?

Thanks
Aditya

> 		WARN(...);
> 	}
> 
> so that only this code currently matches:
> 
> $ git grep -P '^\s*SYM_[A-Z]+_(?:START|END)(?:_[A-Z_]+)?\s*\(\s*\.L' -- '*.S'
> arch/x86/boot/compressed/head_32.S:SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
> arch/x86/boot/compressed/head_32.S:SYM_FUNC_END(.Lrelocated)
> arch/x86/boot/compressed/head_64.S:SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
> arch/x86/boot/compressed/head_64.S:SYM_FUNC_END(.Lrelocated)
> arch/x86/boot/compressed/head_64.S:SYM_FUNC_START_LOCAL_NOALIGN(.Lpaging_enabled)
> arch/x86/boot/compressed/head_64.S:SYM_FUNC_END(.Lpaging_enabled)
> arch/x86/boot/compressed/head_64.S:SYM_FUNC_START_LOCAL_NOALIGN(.Lno_longmode)
> arch/x86/boot/compressed/head_64.S:SYM_FUNC_END(.Lno_longmode)
> arch/x86/boot/pmjump.S:SYM_FUNC_START_LOCAL_NOALIGN(.Lin_pm32)
> arch/x86/boot/pmjump.S:SYM_FUNC_END(.Lin_pm32)
> arch/x86/entry/entry_64.S:SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
> arch/x86/entry/entry_64.S:SYM_CODE_END(.Lbad_gs)
> arch/x86/lib/copy_user_64.S:SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
> arch/x86/lib/copy_user_64.S:SYM_CODE_END(.Lcopy_user_handle_tail)
> arch/x86/lib/getuser.S:SYM_CODE_START_LOCAL(.Lbad_get_user_clac)
> arch/x86/lib/getuser.S:SYM_CODE_END(.Lbad_get_user_clac)
> arch/x86/lib/getuser.S:SYM_CODE_START_LOCAL(.Lbad_get_user_8_clac)
> arch/x86/lib/getuser.S:SYM_CODE_END(.Lbad_get_user_8_clac)
> arch/x86/lib/putuser.S:SYM_CODE_START_LOCAL(.Lbad_put_user_clac)
> arch/x86/lib/putuser.S:SYM_CODE_END(.Lbad_put_user_clac)
> arch/x86/realmode/rm/wakeup_asm.S:SYM_DATA_START_LOCAL(.Lwakeup_idt)
> arch/x86/realmode/rm/wakeup_asm.S:SYM_DATA_END(.Lwakeup_idt)
> 
> 

