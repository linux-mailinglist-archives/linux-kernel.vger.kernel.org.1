Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A8B224DC9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 22:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgGRUSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 16:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgGRUSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 16:18:10 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7918C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 13:18:09 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w27so10233304qtb.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 13:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Wzy+cAnfVWyCNBRsbp4f96uaFuyezcnGy3p//wWBWlc=;
        b=IwWw+pOP8iz9mglvw1oqstQ6ZxJyWkhps+nXR1W7C87271q704wKNliO3g40NlXtYX
         FEdEP8H3UzLAiUjh7/U6V57lgeSPBgXJlgqoWmm5bZcj13guYXTbt1Ozrp2kuxt/U43T
         SvA7YfgeZqrhMZDtgktMzQKvnW0QuTblDl0Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wzy+cAnfVWyCNBRsbp4f96uaFuyezcnGy3p//wWBWlc=;
        b=anesM7daDHY1DJpioNBSt+Pi5APTKlI/iz6wG0IgWjId0UTNshUHcmFyvlxzLv3v5b
         v3NZonBfbEVqijdVRHVnph7RaVleoOjdif/CY2xpaSpDOnjytjMPQ5qRsJSOQPtF0xtv
         6evj3Qc1J6Dnu/uKrz5WuHhow8TxL5hyxrB9f3bO9NcQhwwmbolphKfjE98p5zJF7d0w
         sQ6USNidGK1htLm2sw+pL9eBNpc7P/qCQqZZgNnj/T4WA8F01mTtZWIQ28d+DWmNDucp
         JH3Y3MGv5djuE1TQmAw55f2mM0yBfLYbiwz4pGqEGfVTztFj+C+cYEBcMeNSA8Q0bXS9
         VPJQ==
X-Gm-Message-State: AOAM531sgnQc4mFbNWEzAHNppH+ShVJGkRMaPxw0CG2GSu/3X2fIV/Si
        cfiRXOUcCOsw5kpZcGdZlq/8jQ==
X-Google-Smtp-Source: ABdhPJyssU1ufVTgBHVnmx0gim5lL4wHfPYijT9LtU6LhysR/mZAHBckC38fdgAQFzGckorO1LGo+g==
X-Received: by 2002:aed:2723:: with SMTP id n32mr16929892qtd.109.1595103488923;
        Sat, 18 Jul 2020 13:18:08 -0700 (PDT)
Received: from pepe.local (71-142-124-255.lightspeed.rlghnc.sbcglobal.net. [71.142.124.255])
        by smtp.gmail.com with ESMTPSA id p36sm15125718qte.90.2020.07.18.13.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jul 2020 13:18:08 -0700 (PDT)
Subject: Re: Linux FSGSBASE testing
To:     Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Stas Sergeev <stsp@list.ru>, linux-sgx@vger.kernel.org
References: <CALCETrU_O4AxcJeBO77uXt2j8woYVtjZd18-YV0BuCKRAu00eA@mail.gmail.com>
From:   Don Porter <porter@cs.unc.edu>
Message-ID: <6e3d25fc-9a67-8655-a00a-b3afbc360ff0@cs.unc.edu>
Date:   Sat, 18 Jul 2020 16:18:06 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALCETrU_O4AxcJeBO77uXt2j8woYVtjZd18-YV0BuCKRAu00eA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/20 11:59 AM, Andy Lutomirski wrote:
> Hi Stas-
> 
> FSGSBASE support is queued up for Linux 5.9.  Since you're one of the
> more exotic users of segmentation on Linux, is there any chance you
> could test it?  The code is here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=x86/fsgsbase
> 
> There are two interesting cases to test:
> 
> 1. FSGSBASE on.  This is the default if you boot this kernel on Ivy
> Bridge or newer hardware.
> 
> 2. FSGSBASE off on a patched kernel.  Boot the same kernel as in #1
> but either pass nofsgsbase on the kernel command line or use pre-Ivy
> Bridge hardware.  You will *
> 
> You can tell you have FSGSBASE enabled for test #1 by running
> tools/testing/selftests/x86/fsgsbase_64 -- the first line of output
> will be :FSGSBASE instructions are enabled".  You can build it by
> cd-ing to tools/testing/selftests/x86 and running make.
> 
> If anything is broken for you, I'd like to know before this makes it
> into a released kernel!
> 
> Thanks,
> Andy
> 

FWIW, we tested this patch using Graphene under Case 1, both in our 
standard CI pipelines, and with hand testing.  Everything looks good on 
our end - no suspicious dmesg, no application-level issues.

I also reran the stress test Andy suggested on a separate thread, which 
also looks good:
* Graphene running nginx pinned to core 0
* infinite loop on core 0
* perf top running
* Exercised with non-SGX apache bench several times (~10 minutes of 
testing time) also from core 0

All the best,
Don
