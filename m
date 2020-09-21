Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6C72718E6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 03:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgIUBGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 21:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgIUBGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 21:06:35 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33DDC061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 18:06:35 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 7so7492891pgm.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 18:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=zZgBorpNax91lby+vpZTjfIdIdV95yUbQDPIKzAxf/U=;
        b=F8IRQi5dM9ku6ZUBen/r43ZOufuBgzZ51DJS3OFfY4fa3JSjt6vWclgZLY/pPZgRaL
         Y8NFGIpiTRbq6dWBYr2LiXrf8j/rsKgd1yj9bYGm69G36de7b4kxasr5b053YFVF1X6A
         t11ujGZNUK/Z9jylgJ/Qk8x8q1lU09mJVfsSKORkLn0AVv7WDqkRB1nhPSYw5YIFrMMD
         roRat/A4OPnU81xjAvYhjuw/b1FOS38aLiDdhAAtaAa6dIkWAaO99IUMRWadxRniVzqE
         SycURC/hE0A4ekIZsiroBjxF8wEnOBajmaLBgfT6fB4KI5Ynii0VQAWuFa/VtwwtvhWO
         O2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zZgBorpNax91lby+vpZTjfIdIdV95yUbQDPIKzAxf/U=;
        b=tmRLvUktAT37U0aiTfIrHFZ5kCajLgJdHG3petO+oQ74A2phLZ+Q//WS0Vyp5c9Tb1
         9krmHAJH4Cm8PFvASFGfB/RENynyE0T9xOY3KrXrgjLd1cDyta+H2tWp3CEUbhKEOXTD
         C5YwHL1Ke+sUf9Oy2orjfxFSnB+OFYu8gGcZgdIqmzEwEhLSn3AbXC5EGvZna3mnGPr4
         +R820OG7+zsAU1vV+j2P1LTaZK5zWmo1lg1+rW5Et/EE5vIlC0QPYanTlFCFm6XZLj25
         MDem2F5CSAdOlIK/oZsUwDm+dQ5Q7cfxoPZifcrnmmevEOoaDn6htOt4btSYUMHNGws8
         0V9A==
X-Gm-Message-State: AOAM533pSfhB6IEuBR04bpnQNE7rbeiEihpEB7aseakpJQtrFLvsKPFv
        2yILe/bGyQoytP8TDMG8CnvalzZLBAQ=
X-Google-Smtp-Source: ABdhPJzZ8Ivld7WnCias1zQzCDy+QxtkP3SkdA94h7t/Se/JRBnfBnQM3D7lGpQBgp7ZZpNtZv6HlA==
X-Received: by 2002:a17:902:bf4b:b029:d1:cc21:985b with SMTP id u11-20020a170902bf4bb02900d1cc21985bmr31810463pls.32.1600650395245;
        Sun, 20 Sep 2020 18:06:35 -0700 (PDT)
Received: from [10.203.4.217] ([209.58.129.104])
        by smtp.googlemail.com with ESMTPSA id l2sm8619034pjy.3.2020.09.20.18.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 18:06:34 -0700 (PDT)
Subject: Re: Linux 5.9-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wjSWKpiNbcMpzQ9fBUA5s11sU-STLztzQkHhCHtYvLP5A@mail.gmail.com>
From:   Robert Gadsdon <rhgadsdon@gmail.com>
Message-ID: <bb41f8a8-3388-ddec-cb53-e801e5efb8d0@gmail.com>
Date:   Sun, 20 Sep 2020 18:06:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjSWKpiNbcMpzQ9fBUA5s11sU-STLztzQkHhCHtYvLP5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/20 4:55 PM, Linus Torvalds wrote:
>
> Holler if you see anything odd,
>
>                    Linus
>
> ---
>
> Adrian Huang (1):
>        dax: Fix stack overflow when mounting fsdax pmem device
>
CALL    scripts/checksyscalls.sh
   CALL    scripts/atomic/check-atomics.sh
   DESCEND  objtool
   CHK     include/generated/compile.h
   CC      drivers/dax/super.o
drivers/dax/super.c:325:6: error: redefinition of ‘dax_supported’
   325 | bool dax_supported(struct dax_device *dax_dev, struct 
block_device *bdev,
       |      ^~~~~~~~~~~~~
In file included from drivers/dax/super.c:16:
./include/linux/dax.h:162:20: note: previous definition of 
‘dax_supported’ was here
   162 | static inline bool dax_supported(struct dax_device *dax_dev,
       |                    ^~~~~~~~~~~~~
make[2]: *** [scripts/Makefile.build:283: drivers/dax/super.o] Error 1
make[1]: *** [scripts/Makefile.build:500: drivers/dax] Error 2
make: *** [Makefile:1784: drivers] Error 2

# gcc --version
gcc (GCC) 10.2.1 20200826 (Red Hat 10.2.1-3)

RG.


