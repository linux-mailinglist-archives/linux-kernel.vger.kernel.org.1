Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671F62A60FC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 10:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgKDJ4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 04:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgKDJ4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 04:56:05 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F5CC0613D3;
        Wed,  4 Nov 2020 01:56:04 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id 184so26302050lfd.6;
        Wed, 04 Nov 2020 01:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H/Piybnri0KvjBLh2YcL64mPZyCiqFVi1MfXWajtlaM=;
        b=k14IQwEmiajGjP8KfCafHwcRKINn6x7+hcfsBIAlNRUmV7KJZpo6QNY1S5IUTR+pKM
         OVklo7Lt20KN1Dl/2Ehc1OMCTc8fQb2IBKvNJ/tuo+qO/oF/W2XWLxYHggF0hPEJZhje
         IA3rTa65akyo07p9f6lGSxKQXCxApe2YqiYAwu2PDep3F9BPZuX2OHGovc3HEevhWOhm
         Mb5zCPFYy8gu4QwQxVd+0Bl4leKQDwhKF+NIUhLNvYU6IaTaNiOwV51lqTs3OrOmZCYB
         JfbIiD6Dglr58lO/1+61y7cCn7XGDAilwU5ain8WojrJry6fWfvwNNQAt0N3O+JLLcKB
         V47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H/Piybnri0KvjBLh2YcL64mPZyCiqFVi1MfXWajtlaM=;
        b=fssmjUkCNmC4X0gJLDPiy/35lob904Ei0IFkpWQu1Na/gCGn1pqgSUq6Hv1Ux5kCUe
         3mgoL9Mus/yZBD4yarLNlE4pb65cjGhZObX14dzGBL5q8F03KNJyt57D0PYk9io66nII
         7DidQoqWJ/J8Ll/CTK58ASNg7gKRlQPFKMxLGU5qrm4cmtuz2kkQPE7pimlQJoRP3b09
         90qZozwRg3gJp6cK61e5jPEPd6tcvanFOxYHJIbnN89b+1Bmb9ZKP/LrRCrat56mf5Xn
         OLXJOas7IUOTHYip4FkkHRHqCB1yv5InnVt8Pd52/9A1Ix1uxUyGPPFgp0G3NFG/J5K9
         pItA==
X-Gm-Message-State: AOAM532mA4oJdZ/SqLr22fqeuCJdcM8o+ZY3cf7Mdic4tj3asYiEQO7g
        o5E3tcksKlfGXpf2/G8F2WoHWNML4scQ8A==
X-Google-Smtp-Source: ABdhPJwHI2gk6VHp6DNkwO0HXNvbI6lC+cpZGZLfcD7oHjjfjg/Xa9O2Sve3HOQopC4jnzl2cJOhNg==
X-Received: by 2002:a05:6512:547:: with SMTP id h7mr10361849lfl.132.1604483763075;
        Wed, 04 Nov 2020 01:56:03 -0800 (PST)
Received: from [192.168.1.112] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id a9sm469376ljk.23.2020.11.04.01.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 01:56:02 -0800 (PST)
Subject: Re: [PATCH 0/4] aarch64: avoid mprotect(PROT_BTI|PROT_EXEC) [BZ
 #26831]
To:     Florian Weimer <fweimer@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha@sourceware.org, Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
References: <cover.1604393169.git.szabolcs.nagy@arm.com>
 <20201103173438.GD5545@sirena.org.uk>
 <20201104092012.GA6439@willie-the-truck>
 <87h7q54ghy.fsf@oldenburg2.str.redhat.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <d2f51a90-c5d6-99bd-35b8-f4fded073f95@gmail.com>
Date:   Wed, 4 Nov 2020 11:55:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87h7q54ghy.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.11.2020 11.29, Florian Weimer wrote:
> * Will Deacon:
> 
>> Is there real value in this seccomp filter if it only looks at mprotect(),
>> or was it just implemented because it's easy to do and sounds like a good
>> idea?
> 
> It seems bogus to me.  Everyone will just create alias mappings instead,
> just like they did for the similar SELinux feature.  See “Example code
> to avoid execmem violations” in:
> 
>    <https://www.akkadia.org/drepper/selinux-mem.html>

Also note "But this is very dangerous: programs should never use memory 
regions which are writable and executable at the same time. Assuming 
that it is really necessary to generate executable code while the 
program runs the method employed should be reconsidered."

> As you can see, this reference implementation creates a PROT_WRITE
> mapping aliased to a PROT_EXEC mapping, so it actually reduces security
> compared to something that generates the code in an anonymous mapping
> and calls mprotect to make it executable.

Drepper's methods to avoid SELinux protections are indeed the two ways 
(which I'm aware) to also avoid the seccomp filter: by using 
memfd_create() and using a file system which writable and executable to 
the process to create a new executable file. Both methods can be 
eliminated for many system services, memfd_create() with seccomp and 
filesystem W&X with mount namespaces.

If a service legitimately needs executable and writable mappings (due to 
JIT, trampolines etc), it's easy to disable the filter whenever really 
needed with "MemoryDenyWriteExecute=no" (which is the default) in case 
of systemd or a TE rule like "allow type_t self:process { execmem };" 
for SELinux. But this shouldn't be the default case, since there are 
many services which don't need W&X.

I'd also question what is the value of BTI if it can be easily 
circumvented by removing PROT_BTI with mprotect()?

-Topi
