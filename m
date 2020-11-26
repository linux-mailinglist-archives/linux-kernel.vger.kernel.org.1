Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C583D2C5CB6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 20:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405309AbgKZTtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 14:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404770AbgKZTtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 14:49:04 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96D4C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 11:49:02 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k14so3374061wrn.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 11:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xkFFh0GUNJJSRmyHoJBEh6NYTxVMd+BPzgblv0h9iWg=;
        b=gvFkTu+BmsqcskQm5dhrwxvh/MxnLKFzQ4v3CfSP7cWJGPM+tWYVyiWYHNBXTetkD1
         uvksHWyglzfxqvqFQm1L6EA4nfslbvSo3WO+M6GRu1O+s8nXzsUPKLjeyn41cu/teZZ8
         /aggr8H93J2NnJNHNLrrYdaCwVW48EI06KcP+NdSGHdo1PAdYCR6iSoyUaxPsUznd/Pp
         55QnIbWJccBVyHKfy1mUVkPPiz+9Ynr9c7PrBB+MSiFUCtJZzKOUOPL774Kc3zHYMReM
         tlA20Rf6QRwKTpt/MlUJdn2ycbtjDxTdkJFxECxf6IUz2EnjKpihFCTM2SU2TwRUCSF8
         GCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xkFFh0GUNJJSRmyHoJBEh6NYTxVMd+BPzgblv0h9iWg=;
        b=Vh4u1WGdRK2DUHrszqpvDStRPdnWRu+S16tpIOLrw2jHVPgPR/W3IsDgNQYi5mi6om
         /c0z5g1YtOD1Fnl66Mx3G0lhufKevM94PTUIxLD6Bka9kp0r1MshiMwEXZgJbBCR4DN2
         goya21xSx3/WAQgNJIHeC0boAv4lBpPlWrKoE0GLx9S3bT157Hyx5GJtcmN8SpGesFdz
         Nb9r1TqCdvvKgMNNz9pxl1SVOze3U9aQZRzkUl53YzOI4gESjZMBIzV7VOxo81rOuNss
         s+73zCdW3NTCZ1UOqPTZCIgeurfrLAvLigwlvxukDiGe36wEX3EAnjW2BfDE+ad3UabD
         M42Q==
X-Gm-Message-State: AOAM533DQORmCIFov3bpiBg/OMbLyB7pU/Miq4/W5FwusF0BL2rVvFp3
        Vrpz/pDuvf/EadF7UFDhRh9ITg==
X-Google-Smtp-Source: ABdhPJzMmhNkOe3v3JnfdKd0vR79l3c1PaAffucjhXvn9SObghkG3yh/Q8Ig1e+8TRp4D0VFg9GM7g==
X-Received: by 2002:adf:ee41:: with SMTP id w1mr5964897wro.382.1606420141398;
        Thu, 26 Nov 2020 11:49:01 -0800 (PST)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id q1sm10654974wrj.8.2020.11.26.11.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 11:49:00 -0800 (PST)
Subject: Re: [PATCH v2 08/19] arm/vdso: Remove vdso pointer from mm->context
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
 <20201124002932.1220517-9-dima@arista.com>
 <a6877fff-b066-cffb-cede-011601f8a410@csgroup.eu>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <630b084d-7d61-3126-955e-070e268a1a00@arista.com>
Date:   Thu, 26 Nov 2020 19:48:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <a6877fff-b066-cffb-cede-011601f8a410@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/20 6:22 AM, Christophe Leroy wrote:
> 
> 
> Le 24/11/2020 à 01:29, Dmitry Safonov a écrit :
>> Not used any more.
> 
> But what about mremap() ? Maybe you should explain why you can remove it ?

Yep, it was only to keep track of context->vdso position.
I'll add it to the description.

Thanks,
          Dmitry
