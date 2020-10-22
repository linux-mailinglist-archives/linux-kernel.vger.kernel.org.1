Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1E5295CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 12:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896584AbgJVKj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 06:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896572AbgJVKj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 06:39:28 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B41C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 03:39:27 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id x16so1400804ljh.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 03:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7zNbQ3ooEkkM2/rbEW8hAn7HIFAFXPXWCeuQ4EPmCkU=;
        b=XZcL8dldG9nDeRLhfQmiwfN0powq5j58BBhbVMsJhQZjm3UHs/c78Qhg5c3V8pZeId
         uw1o3zMrLsmUUNujkeKySR6kk77wQpaKl28FfcTGHEiwmHuhF8ChE3KnX4ostKziyCD6
         G6zh0N8Pxk3KLhRNujANfVD9htGPgisuTgBWw5sOpwUk1wqCJUgDAviIU7MVXPC82ujt
         USnVCNqyvFgC/1m9SnI/Ca3RN24zGVjfEcORFeVqCEIFtqGme71U3nqX72mRVYrFKV8B
         6rkhU843IOvP3VYc3avmFj8YwruBkirspx341R7MfHNj32syIEQaAR0gN0XWHUvh3ur2
         stAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7zNbQ3ooEkkM2/rbEW8hAn7HIFAFXPXWCeuQ4EPmCkU=;
        b=sc3dYj47EV0D4dtZytFxBRqNGmZaYfdiqXXsn+0IpLMAa5lKfhrhNh/6O16nflW+8V
         hpFXIpsl4OrwPEYgkBY32B2NM1LhENrTTGcfJixPXmVmHv8Qu9mRj9O4ZJB2p+co53mj
         32Gg9oQT0RaoMAi2tP96JN5umolne3QGsiuqs9L38sBNKwT7+BzIXD/QEkpVbvvuhQNK
         TFio9HeRnY4wjVtk/JPROLExC/ypL2fEPMKR0RczY6om0oSRQMoSMh5pdqgSbzb+qefy
         qOws63ourYTTFqaZJjkJvBwDXaQuPAJRXvVy7LjyFAkPwD/YqAoGLSmSLXQ5AbtDBzba
         xJ/Q==
X-Gm-Message-State: AOAM530MyXwLX1qwpNB4/8LRaYAppIKfYTYU+prmfGto18CRlA+szR8f
        64zfr3kTfSANrMKyABuQ6Q0=
X-Google-Smtp-Source: ABdhPJw6kKNDTOJNJiGp85+W/aXRj0sqQ4Yma5mJXrnCZkQnA5NAle6/aehyn3/d+Svn++m4ilTMJA==
X-Received: by 2002:a2e:592:: with SMTP id 140mr663959ljf.381.1603363166231;
        Thu, 22 Oct 2020 03:39:26 -0700 (PDT)
Received: from [192.168.1.112] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id m13sm206105lfl.269.2020.10.22.03.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 03:39:25 -0700 (PDT)
Subject: Re: BTI interaction between seccomp filters in systemd and glibc
 mprotect calls, causing service failures
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, libc-alpha@sourceware.org,
        systemd-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Dave Martin <dave.martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
 <20201022075447.GO3819@arm.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <78464155-f459-773f-d0ee-c5bdbeb39e5d@gmail.com>
Date:   Thu, 22 Oct 2020 13:39:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201022075447.GO3819@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.2020 10.54, Szabolcs Nagy wrote:
> The 10/21/2020 22:44, Jeremy Linton wrote:
>> There is a problem with glibc+systemd on BTI enabled systems. Systemd
>> has a service flag "MemoryDenyWriteExecute" which uses seccomp to deny
>> PROT_EXEC changes. Glibc enables BTI only on segments which are marked as
>> being BTI compatible by calling mprotect PROT_EXEC|PROT_BTI. That call is
>> caught by the seccomp filter, resulting in service failures.
>>
>> So, at the moment one has to pick either denying PROT_EXEC changes, or BTI.
>> This is obviously not desirable.
>>
>> Various changes have been suggested, replacing the mprotect with mmap calls
>> having PROT_BTI set on the original mapping, re-mmapping the segments,
>> implying PROT_EXEC on mprotect PROT_BTI calls when VM_EXEC is already set,
>> and various modification to seccomp to allow particular mprotect cases to
>> bypass the filters. In each case there seems to be an undesirable attribute
>> to the solution.
>>
>> So, whats the best solution?
> 
> the easy fix in glibc is to ignore mprotect(PROT_BTI|PROT_EXEC)
> failures, so programs work with seccomp filters, but bti gets
> disabled (it's unreasonable to expect bti protection if mprotect
> is filtered). it will be a nasty silent failure though.

Some may also want to use seccomp filters so that they will immediately 
kill the process and in this case they couldn't do it.

> and i'm also considering a fix that re-mmaps the executable
> segment with PROT_BTI instead of mprotect since that is not
> filtered. unfortunately the main exe is mmaped by the kernel
> without PROT_BTI and the libc does not have the fd to re-mmap.
> (bti can be left off for the main exe if mprotect fails and
> later we can teach the kernel to add bti there.) currently
> this is not a complete fix so i'm a bit hesitant about it.
> 
> as for a kernel side fix: if there is a way to only filter
> PROT_EXEC mprotect on mappings that are not yet PROT_EXEC
> that would solve this problem (but likely needs new syscall
> or seccomp capability).

Problem with seccomp MDWX is that it's still possible for malicious 
programs to circumvent the filter by using memfd_create(), fill the 
memory with desired content and then use mmap(,,PROT_EXEC) to make it 
executable without triggering seccomp. This can be mitigated by 
filtering also memfd_create(), but then some programs want to use it. 
Also the protection can be bypassed if the program can write to a file 
system which isn't mounted with "noexec". This can be mitigated with 
private mount namespaces and global mount options, but again some 
programs are written to expect W & X.

But I think SELinux has a more complete solution (execmem) which can 
track the pages better than is possible with seccomp solution which has 
a very narrow field of view. Maybe this facility could be made available 
to non-SELinux systems, for example with prctl()? Then the in-kernel 
MDWX could allow mprotect(PROT_EXEC | PROT_BTI) in case the backing file 
hasn't been modified, the source filesystem isn't writable for the 
calling process and the file descriptor isn't created with memfd_create().

-Topi
