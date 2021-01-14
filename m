Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5A82F5A18
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 06:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbhANE6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 23:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbhANE63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 23:58:29 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4861FC061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 20:57:51 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id g15so2951664pgu.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 20:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ZmdvymZ2qR4M/qVQyd7uYkLb/p5vBHQAHMPmoaJ6QXk=;
        b=rkJ6uQ+C605Q6EPuu9YPwJJbBYW0XB14gDEmJLZz2PUOcvKxzjE0qwMHHpIWYaCZBJ
         Wha8QlgLwnkBgsVTSNoe5Xbo5t3a54xVmtuq+9og4XRPpTDgqgdsMo47uyOp1xJWURsi
         S69zWlGNMYZbLbdRCOvAq79H3RBMoLMK4A4udGIDJW3gugzdBlsNIVncy+/D/y3g4Xpe
         RYNlWEz4oSs45/ZfROjOYdj0eLzsm4OpK//cgFNqhjDk/Uel8ElpeMjsGcm9rAOQHXns
         o9uUEkOb2lCDrDPrdDSNYZdf4gGC4296AcejCEsRCd6NHEemI4KxKrYXbC/WNXpwQdlt
         /zNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ZmdvymZ2qR4M/qVQyd7uYkLb/p5vBHQAHMPmoaJ6QXk=;
        b=IyQVyFqeYNrunS4HmA27wyafkT6A7F/Op7EpGc2lujHcQQFguNj1gn0FeZveL0I2kV
         Rh00k6cMhboCjazj8pvmJPSFme1+HlZmAqKrLuAqf67l1us7ehD3NHrg391o+uZqANWf
         8PL2qstmZbw93bmDJNSC6XP2z7i8X6ewYxMG+jgaPhYkKLDw7o5yxoGN7eL6HtWPj/mB
         E47kf01/7RnAy+MIZqLJkYQXjs3DPQKvXxFqrUii1StVuRuSjPydr7Cb4axSuFDic3PJ
         Rm9QNFtYmoDiu+zNVMdwM2RHu6H3/HpF1knc395aUzRwSh00QTqPUOjXkXxyNpHYx84a
         dbEQ==
X-Gm-Message-State: AOAM530DEvXH0KMZa9XxAV0WWF1wwBLtGGiCeqm5OCmJ6IselUF3GB6J
        EGdEy1vKN2wvBU4QYuL/9sUDER7swuyeKQ==
X-Google-Smtp-Source: ABdhPJwqxSUQbNmucEQI6rjh19q1MtCjegKcrUNeFbM4I++9kN2AKCbutTS+6rDJuYjrUJLMS5KsYw==
X-Received: by 2002:a63:e40e:: with SMTP id a14mr5586177pgi.345.1610600270765;
        Wed, 13 Jan 2021 20:57:50 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id az6sm3857596pjb.24.2021.01.13.20.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 20:57:49 -0800 (PST)
Date:   Wed, 13 Jan 2021 20:57:49 -0800 (PST)
X-Google-Original-Date: Wed, 13 Jan 2021 20:56:52 PST (-0800)
Subject:     Re: [PATCH 1/1] riscv: Fix KASAN memory mapping.
In-Reply-To: <20210113022410.9057-1-nylon7@andestech.com>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, aou@eecs.berkeley.edu,
        Paul Walmsley <paul.walmsley@sifive.com>, dvyukov@google.com,
        glider@google.com, aryabinin@virtuozzo.com, alankao@andestech.com,
        nickhu@andestech.com, nylon7@andestech.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     nylon7@andestech.com
Message-ID: <mhng-40ebb582-4df3-4189-9521-5446cbe1a9e6@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jan 2021 18:24:10 PST (-0800), nylon7@andestech.com wrote:
> From: Nick Hu <nickhu@andestech.com>
>
> Use virtual address instead of physical address when translating
> the address to shadow memory by kasan_mem_to_shadow().
>
> Signed-off-by: Nick Hu <nickhu@andestech.com>
> Signed-off-by: Nylon Chen <nylon7@andestech.com>
> ---
>  arch/riscv/mm/kasan_init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> index 12ddd1f6bf70..a8a2ffd9114a 100644
> --- a/arch/riscv/mm/kasan_init.c
> +++ b/arch/riscv/mm/kasan_init.c
> @@ -93,8 +93,8 @@ void __init kasan_init(void)
>  								VMALLOC_END));
>
>  	for_each_mem_range(i, &_start, &_end) {
> -		void *start = (void *)_start;
> -		void *end = (void *)_end;
> +		void *start = (void *)__va(_start);
> +		void *end = (void *)__va(_end);
>
>  		if (start >= end)
>  			break;

Thanks, this is on fixes.
