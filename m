Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D0A2B5D55
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgKQKy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727759AbgKQKyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:54:54 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6C0C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:54:54 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id 81so7482004pgf.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sm8n6UYqLjDm8/GBzKE/gX4i+7HfB6mILkhsvWxWLqg=;
        b=WBgtMyM7CFOtzC8nJ/CIHW8uxmrJ8plkQhu0ARjiEDQmxbWteTqZrbkLvND4oyhtrH
         IADsrma/PToPGL1ka/L7bT/AdTGiL1SE/egg6+37vMJTK5zqp+nP7VO+6LZm9SbEGQMR
         XdyqtQcdu6ADZILekb/BeJqT3wBxPbvJcAawdYK17rW0kmQ3I1wNmHI2YRlDzsQxv7mV
         t+e4h9TZHSuy4wpeHIhP1AgpTHGUTQtPhms4d9PuIDxxURdqJ0ADwGn2bSjBLu5SZbae
         LKqG+v1lpWUz1bVMp9KLQCEsm9J3RwqEAGV4VLgli8RPuV69AvsFZx2p/dYYOvaiCOt0
         eY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sm8n6UYqLjDm8/GBzKE/gX4i+7HfB6mILkhsvWxWLqg=;
        b=ubDEQQmVZgNdyWNL8Kz68Yc3rQSJnuBRcChWwICJ83kcPvPJkk+CAv2eNr9ef9+JKz
         SKCJbs9tNZSnlCbGEILNScx1BcxGN+bdWCJmHhN1CoqOpAlyjlNl7VIjxJeGt+vbadfQ
         JubCXBaslrmNeQuLJe2iGp19WVDSo4rB+dyGHS3dREFJKm2CkiK2v2oH+cBdpl/jhT9U
         rNVj5uy2bpoPM3IN2gzbDf62iW6vYdqhNvQwO3+kgLUGL9+FwY8+m03cwDJPX+GJlcke
         YHT4MK+27+AJEScq81KRjvb+buTlG4BMqXBqrJ4zhZorV2VwI8YBZFQxrxfVBJfiSNHW
         r3Hw==
X-Gm-Message-State: AOAM531TN2M0ZbDkj9vIY+DI89VmBpTjbv0d+rNvpjTZ1LrdITFAn23m
        6pbh1ZLtPlehKkluEXbhyVBLaR8yIdh4HQ==
X-Google-Smtp-Source: ABdhPJxTYI2atV+F/z+ssLv6UCtAIPcR3CHHHGLuEuUBD6kPWx1vMXmTjDpJ+AjkCxcS3z44F811Aw==
X-Received: by 2002:a62:790f:0:b029:18a:ae57:353f with SMTP id u15-20020a62790f0000b029018aae57353fmr18013533pfc.78.1605610493977;
        Tue, 17 Nov 2020 02:54:53 -0800 (PST)
Received: from ?IPv6:2402:3a80:425:6282:bc1b:1de0:7718:e8a1? ([2402:3a80:425:6282:bc1b:1de0:7718:e8a1])
        by smtp.gmail.com with ESMTPSA id n10sm8828366pgb.45.2020.11.17.02.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 02:54:53 -0800 (PST)
Subject: Re: [PATCH v3] checkpatch: add fix option for MAINTAINERS_STYLE
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201117040501.21914-1-yashsri421@gmail.com>
 <1b9c5353c6318cc7a4e013886012739e6627d82d.camel@perches.com>
 <791b3213aaabd5ecccc9d3f6dd0e8ee420611dbd.camel@perches.com>
 <CAKXUXMxGbL8myAJwobCNEimxmwKTyF41WUNkLU45HTqSKKAPRw@mail.gmail.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <a9e4543f-3020-8626-ac42-8c912b28a21d@gmail.com>
Date:   Tue, 17 Nov 2020 16:24:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKXUXMxGbL8myAJwobCNEimxmwKTyF41WUNkLU45HTqSKKAPRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/20 3:51 pm, Lukas Bulwahn wrote:
> On Tue, Nov 17, 2020 at 5:29 AM Joe Perches <joe@perches.com> wrote:
>>
>> On Mon, 2020-11-16 at 20:26 -0800, Joe Perches wrote:
>>> On Tue, 2020-11-17 at 09:35 +0530, Aditya Srivastava wrote:
>>>> Checkpatch expects entries in MAINTAINERS file in a specific order and
>>>> warns if the changes made do not follow the specified order.
>>>>
>>>> E.g., running checkpatch on commit b33bc2b878e0 ("nexthop: Add entry to
>>>> MAINTAINERS") reports this warning:
>>>>
>>>> WARNING: Misordered MAINTAINERS entry - list file patterns in
>>>> alphabetic order
>>>> +F: include/uapi/linux/nexthop.h
>>>> +F: include/net/netns/nexthop.h
>>>>
>>>> Provide a simple fix by swapping the unordered lines, if both the lines
>>>> are additions (start with '+')
>>>
>>> On second thought, nak.
>>>
>>> This fails when there are 3 consecutive misordered lines.
>>>
>>> SECTION
>>> F:    c
>>> F:    b
>>> F:    a
>>>
>>
>> btw:
>>
>> scripts/parse-maintainers.pl already does this reordering properly so
>> this particular --fix addition isn't all that useful.
>>
> 
> I think the real fix is to provide some more documentation on
> scripts/parse-maintainers.pl that explains how to run this script when
> an author hits the warning type in checkpatch.pl.
> 
> I see these follow-up patches:
> 
>   - some documentation on scripts/parse-maintainers.pl
>   - a patch to checkpatch.pl that points out this documentation when
> this warning occurs.
>   - maybe: improve of scripts/parse-maintainers.pl to handle exactly
> this use case of a patch author (assuming that the patch was just
> created with git format-patch -1) and how to get the corrected diff
> for this patch.
>   - maybe: a patch to checkpatch.pl that can create the command for
> scripts/parse-maintainers.pl for a specific patch and which then can
> be added with git commit --amend or git commit && git rebase and
> squashing that in.
> 
> I think once that is done and better understood, you can much better
> judge if there is really a need for a fix in checkpatch.pl.
> 

Okay thanks. Will check these out.

Thanks
Aditya

> Lukas
>
