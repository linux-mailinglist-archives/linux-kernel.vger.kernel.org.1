Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C495272081
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgIUKWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbgIUKWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:22:22 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802B5C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:22:22 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g4so12121830wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6/5e5GIbNLVs+7zeQ40pItj2YrLdEE3aDEThbURa9vE=;
        b=H/y3aciGu3m5pALUe0sDyC/OoKORo7Ja9jeXnhjBkh94ImVQcn3BFlOn1zoRpcoy3a
         7souYeF49jJMEr0yp3KMkAAfgjP3scmYfi0NY4rztBMd55Z/lpPq1QXEY29DDxvFB1BZ
         wmZWhIprq/USYFEGGCgxgq9C+M1SfP9G4dqpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6/5e5GIbNLVs+7zeQ40pItj2YrLdEE3aDEThbURa9vE=;
        b=rwJcKDYBR2KbIBgb7Ap/BFOEPCUR9fVsPa8vLvHuLguZ1rdN5wlNg4chKy0APbquSx
         V6GfuaBoTaWpyFJu3iMjqe1SsPhL0JUci7E6oIc2uUyF7U0Gltg8i4CU0LaB1zI0t2Rn
         PgvvP92M689hhwNJtV9zFW6uJggvqk7k1Q3BWBvcW8GjiOdzzUX/UKSXcOPgiuX8kkXE
         BPwa749MGI5m3dy+9Wa3bApvuqP9Vd0GP4S7C63Iyg/7AOsjLtpPaGnCI/2dCaP4l8bx
         wciZ8cJju81JiQL3fdSLxOSQndVp0p9dry4HZDJkMLuYvArp3Kq/5w0E0u1nMcucraxv
         Dy3A==
X-Gm-Message-State: AOAM533jxBktJIg5azkHmqBrho0FjZCLRAjT/t+pjlOtkCCrqLFuqiXa
        jN4dUPyh3r8OI8CQ/pqChcirzw==
X-Google-Smtp-Source: ABdhPJw2kIDdiZ1vVe4s8pKie703yiMJqDye9z0s9PFSWT2r28gsdLV4zqB5ScXcujJbclrnXL+5qw==
X-Received: by 2002:adf:df87:: with SMTP id z7mr53117028wrl.239.1600683741137;
        Mon, 21 Sep 2020 03:22:21 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 189sm19013751wmb.3.2020.09.21.03.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 03:22:20 -0700 (PDT)
Subject: Re: WARNING in ex_handler_uaccess
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>
Cc:     syzbot <syzbot+ea3a78a71705faf41d77@syzkaller.appspotmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>
References: <000000000000762dee05af9ccd01@google.com>
 <CALCETrVL=VGNXbWK1BB1LnsxaKOGRbEfCGUEx4jaCW9cF-54Ag@mail.gmail.com>
 <20200918235528.GB3421308@ZenIV.linux.org.uk>
 <CALCETrVi=quLyPXzt-0ou-FF_OYMa7pE5N8_NchRaWtwLg3kNg@mail.gmail.com>
 <20200919001714.GC3421308@ZenIV.linux.org.uk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <bc5d889c-17f0-dcb8-d174-f21b321cf85b@rasmusvillemoes.dk>
Date:   Mon, 21 Sep 2020 12:22:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200919001714.GC3421308@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2020 02.17, Al Viro wrote:
> On Fri, Sep 18, 2020 at 05:07:43PM -0700, Andy Lutomirski wrote:
>> On Fri, Sep 18, 2020 at 4:55 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>>
>>> On Fri, Sep 18, 2020 at 04:31:33PM -0700, Andy Lutomirski wrote:
>>>
>>>> check_zeroed_user() looks buggy.  It does:
>>>>
>>>>        if (!user_access_begin(from, size))
>>>>                return -EFAULT;
>>>>
>>>>        unsafe_get_user(val, (unsigned long __user *) from, err_fault);
>>>>
>>>> This is wrong if size < sizeof(unsigned long) -- you read outside the
>>>> area you verified using user_access_begin().
>>>
>>> Read the code immediately prior to that.  from will be word-aligned,
>>> and size will be extended accordingly.  If the area acceptable for
>>> user_access_begin() ends *NOT* on a word boundary, you have a problem
>>> and I would strongly recommend to seek professional help.
>>>
>>> All reads in that thing are word-aligned and word-sized.  So I very
>>> much doubt that your analysis is correct.
>>
>> Maybe -ETOOTIRED, but I seriously question the math in here.  Suppose
>> from == (unsigned long *)1 and size == 1.  Then align is 1, and we do:
>>
>> from -= align;
>> size += align;
>>
>> So now from = 0 and size = 2.  Now we do user_access_begin(0, 2) and
>> then immediately read 4 or 8 bytes.  No good.
> 
> Could you explain what kind of insane hardware manages to do #PF-related
> checks (including SMAP, whatever) with *sub*WORD* granularity?
> 
> If it's OK with 16bit read from word-aligned address, but barfs on 64bit
> one...  I want to know what the hell had its authors been smoking.
> 

So, not sure how the above got triggered, but I notice there might be an
edge case in check_zeroed_user():

	from -= align;
	size += align;

	if (!user_read_access_begin(from, size))
		return -EFAULT;

	unsafe_get_user(val, (unsigned long __user *) from, err_fault);


Suppose size is (size_t)-3 and align is 3. What's the convention for
access_ok(whatever, 0)? Is that equivalent to access_ok(whatever, 1), or
is it always true (or $ARCH-dependent)?

But, AFAICT, no current caller of check_zeroed_user can end up passing
in a size that can overflow to 0. E.g. for the case at hand, size cannot
be more than SIZE_MAX-24.

Rasmus
