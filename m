Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43F22F5A31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 06:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbhANFKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 00:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbhANFKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 00:10:15 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E21C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 21:09:35 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id c132so2996293pga.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 21:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=l0SVd2Z6z2wiunvJxS4KRqjbI/ytm6ARhNhbn0IZGIA=;
        b=q8RNlcBRjFP2BNecOlGAIXcVb2tcLxP0m95wws3L5nfz3R/bj6jLK6ZSlQyqecVGBH
         baWhTyopNPQiosVcCHCn5G2V+Cz0RbU9VjcuMuUGuwJRSsmFix4TpJVcBMM6Gl9DJceK
         QZxFMOVhh2CGrfq/kKFRKbyl91TauSsfMJVrrl7NB9lRvt32B9Ev3N3IxOhGKeznjVdH
         ouOAtgS9qv+pwl2EoqItCQgCZn7OBqxrxPImdq8oqFLcPE9qhbgY/IAWQpD4QjbSZ1hP
         cqeple8OV0xEa6wqT5Fd4Oi6OEoElfJuVi5MxdB7XX1rwn6hwD5G9sPAd2XUkLBDQ/Pe
         hrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=l0SVd2Z6z2wiunvJxS4KRqjbI/ytm6ARhNhbn0IZGIA=;
        b=eeO7x+oBzOWV9vCmm6lMGU/VbgJqF4CnrJVaL5QPzF/CVAMbEwtmVsy/+/f5ObVUwN
         WJhU5bZ5R0G5PE8fwPjnSLa60XjwTEpTZNMuenmeKtjZ86MMDvZWqmFof2sbiYwI822R
         d/JupT7RVXl3O6rVjMP1OxBrg4iSZbEUkqQod2FtSVhsZ2uiQYeJPrFuXBE6yQcEdY+7
         9c561WqmdFpiqQNAyzs2Dp7OdJuQunU12UHBPMScbh3wWHgSSppJsKpQikW9EOqLyZ2u
         49LqIUMgI05ta2EczM0r0PMRzXeyzMkMzMPzhBcn378pMxe0NVkjq01CAOuGtPTTGD/Q
         om5Q==
X-Gm-Message-State: AOAM5328AChzIW3HfJfXytkMI7XdftKsyDkirCJIABwkwvIWJH5femiH
        E8MFvUXkh1hNXBqTozLrJ/i+di5YXJQgbg==
X-Google-Smtp-Source: ABdhPJxYDip1RIxxaby45IP3aK2dYVPkxBLmeZ5dufXHqw2Cb/0PSEBpQNl4WBi+G21aOj0gWHPjVA==
X-Received: by 2002:a65:6659:: with SMTP id z25mr5697984pgv.427.1610600975227;
        Wed, 13 Jan 2021 21:09:35 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id p8sm4103108pjo.21.2021.01.13.21.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 21:09:34 -0800 (PST)
Date:   Wed, 13 Jan 2021 21:09:34 -0800 (PST)
X-Google-Original-Date: Wed, 13 Jan 2021 21:08:16 PST (-0800)
Subject:     Re: [PATCH 3/4] RISC-V: Fix L1_CACHE_BYTES for RV32
In-Reply-To: <20210107092652.3438696-4-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org,
        Anup Patel <Anup.Patel@wdc.com>, ardb@kernel.org,
        linux-riscv@lists.infradead.org, rppt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, mick@ics.forth.gr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-1400a3dd-651b-4a78-bb2d-1f10580add75@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Jan 2021 01:26:51 PST (-0800), Atish Patra wrote:
> SMP_CACHE_BYTES/L1_CACHE_BYTES should be defined as 32 instead of
> 64 for RV32. Otherwise, there will be hole of 32 bytes with each memblock
> allocation if it is requested to be aligned with SMP_CACHE_BYTES.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/cache.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
> index 9b58b104559e..c9c669ea2fe6 100644
> --- a/arch/riscv/include/asm/cache.h
> +++ b/arch/riscv/include/asm/cache.h
> @@ -7,7 +7,11 @@
>  #ifndef _ASM_RISCV_CACHE_H
>  #define _ASM_RISCV_CACHE_H
>
> +#ifdef CONFIG_64BIT
>  #define L1_CACHE_SHIFT		6
> +#else
> +#define L1_CACHE_SHIFT		5
> +#endif
>
>  #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)

Should we not instead just

#define SMP_CACHE_BYTES L1_CACHE_BYTES

like a handful of architectures do?

The cache size is sort of fake here, as we don't have any non-coherent
mechanisms, but IIRC we wrote somewhere that it's recommended to have 64-byte
cache lines in RISC-V implementations as software may assume that for
performance reasons.  Not really a strong reason, but I'd prefer to just make
these match.
