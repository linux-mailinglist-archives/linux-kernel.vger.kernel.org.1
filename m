Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A5328DD14
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgJNJWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731150AbgJNJVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:21:52 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CB1C0F26E0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 19:55:44 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t18so1026346plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 19:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/CF7sGkvM8qigMWqyh3wqQ7xb/wKWDNOqvJPjBYV0xs=;
        b=UJb6xowePTVjk6UH2lufE76prWIyq5Do5ZM5ObFfyFWbipyEUpXPgFPMnPcsS0vE4X
         3iGuQIiX+1/7TSmFZ4/KCaHCGZYEbiGAlpmYcvXj5bj1bKvWJKqzFVA1iY/13RzovpEM
         UFjaKMz2rgZvfVQkHikUVfYFlDVNz4eqeL6Xk00LpjKexIXSoYzbTEuroe3C2sHVh3rd
         QLMIBgdLzNq/HcFVVwtpdrPz/cZ/ZaFJx3HXN3UDSgb2WVFITpqNcHumC3zTkidqFXjv
         VF/Upr+IzLJI6+SYTaNq5A2/TMg+In31R2llt1A7BF/L0SyW19gmKU2S687sIRWKPaFY
         KeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/CF7sGkvM8qigMWqyh3wqQ7xb/wKWDNOqvJPjBYV0xs=;
        b=jHWNZMg9rWXcG5GKrzqEMaFlkgxkspvjkWtyBfH8xezeoQXd0XEQINIdAd3qSH4PG7
         8LsQmFybThfjo5bNKQL2XKNThoisVmRqgW8jbSWYfHjdYA87gKhK8iJL1mZsKPrLXDCZ
         BSfWzHLqOsciXaCBjsXfjxbpK/l2kyhbKDNU+DLdr9i8F3XjdCBadu98Nkd5jq1V3AB2
         mUrvppMB4razPOJGC3YozphbEYq9MnltQ+BvO/9OjYLFlaHIuYmD1rwGq8smvY0bu6cY
         BUMSwlmvQdZhuqf3A5sf++ZHj2f8X7zMmW3p2P+X1hJdT9hykczTyJBGpxUISG/9Y7+H
         27rQ==
X-Gm-Message-State: AOAM532bTQgxmsH4xn2ei6qNPngdgUfByhFUnJp0FCwY5Ko3EcH/FwdN
        wkSG4gI0a6GJJLhOM9VCiPKYVp5pOrKv3GLi
X-Google-Smtp-Source: ABdhPJxcYq+w36c3Hv9a7AbAwXFf6fXw12Qi+PKp0U/QWWghuBuByTInn9mZjVujERP6vR7lPO/qRg==
X-Received: by 2002:a17:90b:1a90:: with SMTP id ng16mr1379169pjb.172.1602644143206;
        Tue, 13 Oct 2020 19:55:43 -0700 (PDT)
Received: from [192.168.10.88] (124-171-83-152.dyn.iinet.net.au. [124.171.83.152])
        by smtp.gmail.com with UTF8SMTPSA id ne16sm692271pjb.11.2020.10.13.19.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 19:55:40 -0700 (PDT)
Subject: Re: [PATCH v2] powerpc/pci: unmap legacy INTx interrupts when a PHB
 is removed
To:     =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        Qian Cai <cai@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200807101854.844619-1-clg@kaod.org>
 <9c5eca863c63e360662fae7597213e8927c2a885.camel@redhat.com>
 <fce8ffe1-521c-8344-c7ad-53550e408cdc@kaod.org>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <89726af2-00ca-9d47-f417-4bea8d5b8b1f@ozlabs.ru>
Date:   Wed, 14 Oct 2020 13:55:35 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <fce8ffe1-521c-8344-c7ad-53550e408cdc@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/09/2020 17:06, Cédric Le Goater wrote:
> On 9/23/20 2:33 AM, Qian Cai wrote:
>> On Fri, 2020-08-07 at 12:18 +0200, Cédric Le Goater wrote:
>>> When a passthrough IO adapter is removed from a pseries machine using
>>> hash MMU and the XIVE interrupt mode, the POWER hypervisor expects the
>>> guest OS to clear all page table entries related to the adapter. If
>>> some are still present, the RTAS call which isolates the PCI slot
>>> returns error 9001 "valid outstanding translations" and the removal of
>>> the IO adapter fails. This is because when the PHBs are scanned, Linux
>>> maps automatically the INTx interrupts in the Linux interrupt number
>>> space but these are never removed.
>>>
>>> To solve this problem, we introduce a PPC platform specific
>>> pcibios_remove_bus() routine which clears all interrupt mappings when
>>> the bus is removed. This also clears the associated page table entries
>>> of the ESB pages when using XIVE.
>>>
>>> For this purpose, we record the logical interrupt numbers of the
>>> mapped interrupt under the PHB structure and let pcibios_remove_bus()
>>> do the clean up.
>>>
>>> Since some PCI adapters, like GPUs, use the "interrupt-map" property
>>> to describe interrupt mappings other than the legacy INTx interrupts,
>>> we can not restrict the size of the mapping array to PCI_NUM_INTX. The
>>> number of interrupt mappings is computed from the "interrupt-map"
>>> property and the mapping array is allocated accordingly.
>>>
>>> Cc: "Oliver O'Halloran" <oohall@gmail.com>
>>> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>
>> Some syscall fuzzing will trigger this on POWER9 NV where the traces pointed to
>> this patch.
>>
>> .config: https://gitlab.com/cailca/linux-mm/-/blob/master/powerpc.config
> 
> OK. The patch is missing a NULL assignement after kfree() and that
> might be the issue.
> 
> I did try PHB removal under PowerNV, so I would like to understand
> how we managed to remove twice the PCI bus and possibly reproduce.
> Any chance we could grab what the syscall fuzzer (syzkaller) did ?


How do you remove PHBs exactly? There is no such thing in the powernv 
platform, I thought someone added this and you are fixing it but no. 
PHBs on powernv are created at the boot time and there is no way to 
remove them, you can only try removing all the bridges.

So what exactly are you doing?


-- 
Alexey
