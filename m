Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3128B2AAEB2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 02:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgKIBW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 20:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgKIBW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 20:22:57 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEE1C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 17:22:56 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id w24so3993123wmi.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 17:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zL1+G1iCtCAQiwcai2Rra7oPinx86zF4HN9ctuWZLWU=;
        b=vZ6ks+2xpg4RjXFG2VeAW7Z0xyUsrT4AgpI7V2Fm5e0HQHh8uOZnTF7a0VL5z7q4pt
         Ue3i+brw65rQZn/Y9kozEJLyxE8szFdbZjQuCbnqAxJ2BEsiSJe9Scpta62Iwhl6miG/
         rMOSbhvvGDTSaJfFLSfaAqG9TkRS4MbuLAzxtTxTf5IgjrkmHaeVBCN8q2CWir5POxDK
         Fc0lhiaQEhr5Yb9VTVM6uDFMq6uUlYCEZtFLdy3dc+eCa24VrDzuS0nLEExiskVkGnTP
         IqK0li9VmzyPJRwzCEoYnu5QYtdwa+BXv7fGE7jdKi9E6S2265EFqhnD7WGJUbC1q3Cu
         smPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zL1+G1iCtCAQiwcai2Rra7oPinx86zF4HN9ctuWZLWU=;
        b=Ouha8LBFsI3qzPecPRmNOeBv74aQNipbzOI+ppcSCh3jM84++wCB3mLMyFc95nawIS
         neXa+0byWvSQhiX6okeZRPgu7/UbzPrS3L+cywFK01vYUs04fW26Wv1vh7bEcvT1EiZn
         FLxYl33mhOnxC+OAGSRPN5LOuBrjAcscWaZ1jLyXAcMZvdS4/RvtaOR95SWUwbiZnRR5
         uynlfJ+TNYIx5PF+Matc1cobW3syw2vvwftL5zBZxlpKT48SL1sXmn/K3WGF57XdApBS
         LB+mApj/d6ITVZ/mMZHXj7tvPJlrQqeRceRGIGTFTP/wmmyqNWBUGAoPbAONNxSYgnI+
         obrA==
X-Gm-Message-State: AOAM531xRblzLt3JUvbYu6cgFzZ7RDqO2tiCgrja7QbPhd+kVamTFe6d
        NRuz0FLFZhkC6t3VXXeq+fk=
X-Google-Smtp-Source: ABdhPJwYsSVs2+47kPqwZ7S9KJ/xel7YEbym0BuzytptUeXEEIrXhSNOMQwqinZ+9lUxvDI5fQjMBA==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr11939959wmj.149.1604884975502;
        Sun, 08 Nov 2020 17:22:55 -0800 (PST)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id p4sm11335401wrm.51.2020.11.08.17.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2020 17:22:54 -0800 (PST)
Subject: Re: [PATCH 12/19] x86/signal: Land on &frame->retcode when vdso isn't
 mapped
To:     Andy Lutomirski <luto@kernel.org>, Dmitry Safonov <dima@arista.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>
References: <20201108051730.2042693-1-dima@arista.com>
 <20201108051730.2042693-13-dima@arista.com>
 <CALCETrW7zQMRZOJFVN5AsqMAy=F6jnVyj+QL_w3-xEghqT3XJw@mail.gmail.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <6ac99ea6-ccad-2719-5ff2-a0e18e52a500@gmail.com>
Date:   Mon, 9 Nov 2020 01:22:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrW7zQMRZOJFVN5AsqMAy=F6jnVyj+QL_w3-xEghqT3XJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/20 7:06 PM, Andy Lutomirski wrote:
> On Sat, Nov 7, 2020 at 9:17 PM Dmitry Safonov <dima@arista.com> wrote:
>>
>> Since commit 9fbbd4dd17d0 ("x86: Don't require the vDSO for handling
>> a.out signals") after processing 32-bit signal if there is no vdso
>> mapped frame->retcode is used as a landing.
>> Do the same for rt ia32 signals.
> 
> Am I reading correctly that this makes the ia32 compat signals match
> the native ia32 case?

Yes, probably I should have added it to the changelog.

Thanks,
         Dmitry
