Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B882C5CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 20:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405291AbgKZTqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 14:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404430AbgKZTqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 14:46:03 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A000AC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 11:46:01 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id p8so3337212wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 11:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GKkyJodLEeeNbPye6V7AiF19XM8ebf++RaZMHvZXzts=;
        b=kENLa3OzB6IAi48pL35dakngyclFRpWhXkdSWvd5Jbd9T+ufxyPNKqcDPOsonnkUsx
         OlQyPsQzwUkA0JiTqu0rRKitxSOG4ylsSRL/jNwXk5gCO1uG7+bFVowGcyy0QN5NBEfF
         u4/erPlMAG0UlEzrjNoaF2QGIkGKBU1io6ud8mOF75hC5vUxb6L+rk2neFRiqF/RXDHN
         i7my+MkjV4bfVxg7+AAMU3c19OMpOuH4wnDeUJEBylzTh83dFPG5fWKZmnBLM39rZs/E
         8cFSsyZjuYDUwMrw/pW0AZQr1TOLhJal5v+3OHeCozGKLtNXqLLdg4LTam4ANYDz1cl7
         dlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GKkyJodLEeeNbPye6V7AiF19XM8ebf++RaZMHvZXzts=;
        b=oe0exgSOS4m9gT0Ik1/nhd3mYfNmQBQkEOeFhTHPopQIa1wehjF6AlvakfxRcxjFiE
         J3PSLTcLZ1BvFK2zk5oQM4m69B/rdRXN4Ompam6w7aFW7wcBSBXLKncQA1d7+0lJYEm3
         nS/yjrFmB+EoQaoc6OPSZA4jvpgWy1PdXmfv34ETPyGlzoxh+xE0wSJ3aPVAUtWqEjwR
         /q9FkQdX5bVT16DVW+uZbmDQmC4mkWlVoHEdb6/KHl8crlLua6knRndlzwqteWjlLznp
         6efOsJsJlJnTpvKzEY4PEcb4RNCseZQs7RifvxTHsyE0xmhLIyEgdsni4uegz1EItvxU
         aPEA==
X-Gm-Message-State: AOAM530EMXxhLkhQFV7txiL17X5GoYezWBkyQUoqRyhBHt/hooxNm5cg
        M2L1fg97ibW5ftW+4+NanPGVFA==
X-Google-Smtp-Source: ABdhPJxHwJMqOL8OFlViCsvtV3ZXC/jH0BZABj/IJumNOPCW19X1g67VbLYenkzSu40SiBqAefzeDw==
X-Received: by 2002:adf:fec5:: with SMTP id q5mr5884512wrs.245.1606419960348;
        Thu, 26 Nov 2020 11:46:00 -0800 (PST)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l8sm9360046wro.46.2020.11.26.11.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 11:45:59 -0800 (PST)
Subject: Re: [PATCH v2 05/19] elf: Remove compat_arch_setup_additional_pages()
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
 <20201124002932.1220517-6-dima@arista.com>
 <77b23c00-13a2-a8bb-6b9e-72980c5d6fca@csgroup.eu>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <9ba031b6-e399-a425-bebc-aa807e3dbb1c@arista.com>
Date:   Thu, 26 Nov 2020 19:45:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <77b23c00-13a2-a8bb-6b9e-72980c5d6fca@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/20 6:13 AM, Christophe Leroy wrote:
> 
> 
> Le 24/11/2020 à 01:29, Dmitry Safonov a écrit :
>> Now that all users rely on detecting bitness of new-born task checking
>> personality, remove compat_arch_setup_additional_pages() macro,
>> simplifying the code.
> 
> I understand from cover that you wanted to reword "new-born" ?

Yes. I have reread the messages, not sure how I've missed it,

Thanks,
          Dmitry
