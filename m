Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EE730130C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 05:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbhAWE0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 23:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbhAWE0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 23:26:43 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5D4C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 20:25:57 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 30so5200380pgr.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 20:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=HsTH23mTsBXTUCD9PYfUtYW7PMHmRqFx/62RuOOhwWE=;
        b=H6dbeZ4IKz/jHoKDvrRiNfcm29zDT322Qo6oWUxEEYCW69JaisrCzd7yp0BoucfsJ9
         F335oNUhCJqnoOVi7YlS4/Oi7j8PDv8z/66Vor3rN4jGeJfA1U9TY68j0Vhs+8LvwWZn
         7QAeoeY/Ix0tYM+FjfwhN1QzjaO9yT2zezKDVTLKQXtnPDI4e5Cw2S3RfYALs2GvfD0Q
         rfUjRbD/etRvr3wALx9OxzZXJTfwjNNwSLs6fe/CbHQD99TSZyiZnKl5E+Uyz0VHV+yA
         ofwzsjwwtLzuNyfoIHw7wwVo1yv7sQXyRKSW5N7i9aJqMtY/bErm4iJArNCtv2XtUrDN
         Sv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=HsTH23mTsBXTUCD9PYfUtYW7PMHmRqFx/62RuOOhwWE=;
        b=MXYSDO7TwbxnjghaVgQP4rTaVU6Co733YmFEM4Y8LH3foUYWemx2MOxtqHuP6TN3IU
         n1q78iJBzP7DE+scEPakxah+T74UAYcannvjPRf3SZkYZwYdnN8U1fpQvyZ9Awb5X7F6
         u9musNDEsUliT8ZJ87I2q4N/XNTZkaOeLedATPPHhfDHbUjkPVjCwAf1jBeC6DBlPJiF
         i1NFSO8R22jLKmBQOhXk/4s/x3JnERR8dcVW94nOqJ38IDRysNDEFMw0lHXu1Pcl1fg2
         HrsKKknsmdYBJBTcSQkxyOKys1OLse5xQF9/x1QYdgGB01H8qi+pTdcDPz4dQpqGum0d
         GMGA==
X-Gm-Message-State: AOAM5328VqamWeXkSI6cmhcRwgzsEsOSaQl467fCShrieJmx8DRtEzBR
        Wvh+v/xmm5VtR2p9OuAwjfnwwA==
X-Google-Smtp-Source: ABdhPJzGTiXE96kFTsRM8zJTqDWKPdMLEh8GQ+kyr14hxbw338i0lgZa4y87kwM3dSETJtrxDp8LLA==
X-Received: by 2002:a63:e24f:: with SMTP id y15mr7821856pgj.366.1611375956854;
        Fri, 22 Jan 2021 20:25:56 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t2sm10844097pga.45.2021.01.22.20.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 20:25:55 -0800 (PST)
Date:   Fri, 22 Jan 2021 20:25:55 -0800 (PST)
X-Google-Original-Date: Fri, 22 Jan 2021 20:16:14 PST (-0800)
Subject:     Re: [PATCH] arch/riscv:fix typo in a comment in arch/riscv/kernel/image-vars.h
In-Reply-To: <20210121015513.2258-1-tangchunyou@163.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        ardb@kernel.org, anup@brainfault.org,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhangwen@yulong.com, tangchunyou@yulong.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     tangchunyou@163.com
Message-ID: <mhng-11923d80-18d3-4d0a-a0f8-8ca93ee307a1@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 17:55:13 PST (-0800), tangchunyou@163.com wrote:
> From: tangchunyou <tangchunyou@yulong.com>
>
> "kerne" -> "kernel"
>
> Signed-off-by: WenZhang <zhangwen@yulong.com>
> ---
>  arch/riscv/kernel/image-vars.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-vars.h
> index 8c212ef..71a76a6 100644
> --- a/arch/riscv/kernel/image-vars.h
> +++ b/arch/riscv/kernel/image-vars.h
> @@ -3,7 +3,7 @@
>   * Copyright (C) 2020 Western Digital Corporation or its affiliates.
>   * Linker script variables to be set after section resolution, as
>   * ld.lld does not like variables assigned before SECTIONS is processed.
> - * Based on arch/arm64/kerne/image-vars.h
> + * Based on arch/arm64/kernel/image-vars.h
>   */
>  #ifndef __RISCV_KERNEL_IMAGE_VARS_H
>  #define __RISCV_KERNEL_IMAGE_VARS_H

Thanks, this is on for-next.
