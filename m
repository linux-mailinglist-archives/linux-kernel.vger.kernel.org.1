Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B992A84F9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbgKEReC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731648AbgKEReB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:34:01 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B959C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 09:34:00 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id p4so1123021plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 09:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=bXK3jEO2zIpAnRvRC4dY7e8rL0kXVixnI/E7VIB9j4U=;
        b=y7P19SKn2el77vCjC8Zi5jhTeHuNO1vf+R4w/I4lIr1Fcr1RnLf/J5JMJlJOwxEc05
         S+2KbUj8SV5wmt3fbRwbo4gG3rp9Uk2PVM8BFH8sLzuRymXpEf4+zsZZey+Z6RRLqpyG
         NzkCyZakbpyOB48Yk37enTbuRnQeF8wi2a7kFkGczVEBJBpybxqiqRHxp7RDKtQ66bcY
         GwOB0wfZxuo/0ivYLgc1wdb6ABpFy0q6G2/DyCI1OwEB45Fuek32V9GFSphmS+/kJQaH
         HIZZApZ1DoHrqZDnty2ZxUe62tu66CfFjQ0p3qX7q+drFTmj14c7NPYdHGVUSwML6pLH
         +FzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=bXK3jEO2zIpAnRvRC4dY7e8rL0kXVixnI/E7VIB9j4U=;
        b=oMDw8gxzITgPnmHqFh3uQKKIp97zipEvXLqAdUgJbUXJPTeoQ1qfmoMbn1Q1o0kkAv
         n5ZwsbfM2BdP3B+yrCIZWuU1CW7j4+TGrgF74a9QdW5MOr1bkf+72y2BKY/ojzq6of5Z
         LedSBKKGCoXR1vSJpsXiVXVzysgvkJtxiURHdhgRLQgN62wMiPW58sEOq5o0q9lbxZO6
         JiCZobaCyq/+9awaRWuJk8lXym8iCnmeXv6Wzmqz40PtTxDA2X67YW5XUwUOm8uTBaCJ
         M//z++KzCgx+fu5TKIlot3nPzg5hp+YCRCyKYUDdpOeHEONyx//EmfRdpftW1e64AzFC
         n2rA==
X-Gm-Message-State: AOAM5338uJzcXkGiiWt1ld6WbQe/ZIHkrbHG4XeztiXgjPXNzKLpYZ/o
        FP/Jx7FsRUWlBW1/xF6bSYE1Rg==
X-Google-Smtp-Source: ABdhPJzHOvTRbzaRy9XAdwgGhXwcAkSxq3p3MAxWFwaFCnmoGFFYGFWOpx4CbhYVVGhTPaItUenZkg==
X-Received: by 2002:a17:90b:1942:: with SMTP id nk2mr3445495pjb.168.1604597639530;
        Thu, 05 Nov 2020 09:33:59 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 192sm3407429pfz.200.2020.11.05.09.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 09:33:58 -0800 (PST)
Date:   Thu, 05 Nov 2020 09:33:58 -0800 (PST)
X-Google-Original-Date: Wed, 04 Nov 2020 13:29:05 PST (-0800)
Subject:     Re: [PATCH] risc-v: kernel: ftrace: Fixes improper SPDX comment style
In-Reply-To: <20201011030351.4619-1-ryanpkosta@gmail.com>
CC:     rostedt@goodmis.org, mingo@redhat.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, ryanpkosta@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ryanpkosta@gmail.com
Message-ID: <mhng-f7c021fe-0eab-497f-8eb5-7daf0f3b7799@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Oct 2020 20:03:51 PDT (-0700), ryanpkosta@gmail.com wrote:
> Signed-off-by: Ryan Kosta <ryanpkosta@gmail.com>
> ---
>  arch/riscv/kernel/ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 99e12faa549..765b62434f3 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) 2013 Linaro Limited
>   * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>

Thanks, this is on fixes.
