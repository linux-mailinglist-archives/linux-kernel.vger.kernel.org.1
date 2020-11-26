Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF992C5CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 20:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405287AbgKZTpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 14:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbgKZTpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 14:45:06 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CECC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 11:45:05 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id x22so3080154wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 11:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3LDtu7W4N9F3NvmvOTmIFWsV3HqP3LG8thpAXVEnOpk=;
        b=cFCwUBGLCfMXE6aAo81XTkAGIahnGQGpgfuFe3khMueFv8lCF5iR91QcuVKwzjoNe2
         unxt4XhMMirXBme/Avk7jNJXRMGaxM6Y6OQvpBds9wW58vzoCIzug+UW/bUV10seh9Ef
         Zgdx+ERY05kvZG5idV8QkR7RTXIjKjJl5FYMJu39U63MzOl4bzXoBOHIWEinb4+bulOz
         Hw/CFE99M+hC7LkzXYBJ78A6MAZF/ylyiGnQvedvlkpL41BPLerwwUNiZFSPbjnTtIZ6
         Uk5KwYemOVh/JWwVH4cd7rjOXMuz8sx9uXA6+5dW2K9T6PAgMN1qtlYod5GbEch2hXx0
         G1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3LDtu7W4N9F3NvmvOTmIFWsV3HqP3LG8thpAXVEnOpk=;
        b=ErODAg3UZ184iMvZo3I/uGkNaRwulZlVAPTm3InMUQ6igQ0P9jWcop0NH4RO6/QtJ9
         yXG5njKgzmCycwCeMDucd3TNRBvY1ZMZ5kak3q24OTwpuoA2TCi9lS+z1qvDYY7VTbeD
         +iTQ5IIQbRzLGoVeVRVpQFPpGGSf+nVnnBi3OnOZiIDXPh092oJFMtFa+QF8+10Ni9LM
         54WbCEcZAblwwA19Jn2DmLwW+YXXx7f5aeDdPBrUlRxwKB+6MlpaOIHDZVlTP/28611m
         srH1HV3phbg9JfEKTIzZZgFwXx+N3UPLaW0YVCAmrvpplJesE5+gj8pUof/Ar+LAnLOV
         AZ/Q==
X-Gm-Message-State: AOAM532y7WPid7hYtwkw1q+HCHBxnABX47R0fBq0EdvNKDIZyADOG+4s
        ERptWEnpIAD2iPE8DyjcW3qoQA==
X-Google-Smtp-Source: ABdhPJwmwAxw2Ba3u/uOVsYC79fHb/m/mzbXlk14RDuEW1FrtRJfP/jHzqSJZ/Jo9fkCzqfLag65dQ==
X-Received: by 2002:a1c:21c1:: with SMTP id h184mr5145929wmh.106.1606419904337;
        Thu, 26 Nov 2020 11:45:04 -0800 (PST)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id d13sm12048654wrb.39.2020.11.26.11.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 11:45:03 -0800 (PST)
Subject: Re: [PATCH v2 02/19] elf: Move arch_setup_additional_pages() to
 generic elf.h
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
References: <20201124002932.1220517-1-dima@arista.com>
 <20201124002932.1220517-3-dima@arista.com>
 <4e1ade4b-5205-d5e7-a7cd-7f5cb0d024d5@csgroup.eu>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <68bdfbcb-40a8-308f-d4b2-f55af0db45d7@arista.com>
Date:   Thu, 26 Nov 2020 19:45:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <4e1ade4b-5205-d5e7-a7cd-7f5cb0d024d5@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/20 6:12 AM, Christophe Leroy wrote:
[..]
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 6fd7d38a60c8..4221f171d1a9 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -134,6 +134,7 @@ config PPC
>>       select ARCH_HAS_PTE_SPECIAL
>>       select ARCH_HAS_MEMBARRIER_CALLBACKS
>>       select ARCH_HAS_MEMBARRIER_SYNC_CORE
>> +    select ARCH_HAS_SETUP_ADDITIONAL_PAGES
> 
> We try to keep alphabetic order on powerpc, should go after
> ARCH_HAS_SCALED_CPUTIME

Yep, I think I have to learn the alphabet.

Thanks for noticing,
          Dmitry
