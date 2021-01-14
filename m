Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAD82F5A34
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 06:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbhANFNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 00:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbhANFNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 00:13:16 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980E7C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 21:12:30 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id md11so2463766pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 21:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=EUYdLoxi1ljV+U3fVshJA2BY4WK+sDbT1TUophDzXDM=;
        b=pxOscEIokI8Wd+csd0auxVYDugi0wl44bVu7vJ4pP+1Dch63K+VNmCk9u9vhU05liR
         ddvkaISm5gXnWiYkCKpot19cCUwoXC/pTHhumiC8qF+EZbdQnHVt+IiV+iefPI1d5smw
         K62H99+bVTyil/LXN55pYbP2zSEIxjqfeQ982rNZ+CZGD+bSvlhzM/xRmyzpc47/zBR7
         0LDaSXsKSviGonowKvIAckVz9jXi5PYYGmcKaqu+mfRbevG7K19iX+9qyZGDzriBw4Cg
         VwnwNy2LsCFjMmne4F7v0v53c7LqCyiuPoONRZoYsDMFg3RdHJhVhDxvWDaXrvKzlRNk
         exgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=EUYdLoxi1ljV+U3fVshJA2BY4WK+sDbT1TUophDzXDM=;
        b=YY74YwWMkrVY8Y1aHPI17AplNe0HW2sRD3oafbvNpyqFNhMOLgobBHgHV0oqJI/84Y
         rnqo9FeyA7Zlt/FfdAz5BhulDwmLS+kzS8/mFPxsqywcZldyzBf9w/FgGkR3zIaE4iq1
         qIvUVA2LvLWvIPl3vwbgqE/Sx1AB/a4DKGJvntW0Si/Ul2z2WZFDq7xzwacngoeRNbxE
         Zp928Ja0dALL2kZuS3V8aXBxgdYeYd/oD2wZso2TpJFkDhqALMxZBBeYpCYTqNhoYAIh
         q2Yshf90d2yxqXU6w6zLVArxar4TQi4K9KBLKwq00Iq7RNXvXLOHQ/g6AOHTbGVGNXmV
         iqfw==
X-Gm-Message-State: AOAM532GGHIvyBEI9iri92kMY/tQoKn0OMlaUpDa9ZpD3TWR5tlex7xN
        P8csRuqJG/e33xBp0SL3yHmrGmGgzepgsA==
X-Google-Smtp-Source: ABdhPJyTalN85CBnljYXJhBtVTJsy6/4MR/QTiNj8e6mIzl3l52SlG4+aE124IVjL0Cy4NLwmoCxAQ==
X-Received: by 2002:a17:90a:e7cd:: with SMTP id kb13mr3181606pjb.10.1610601149920;
        Wed, 13 Jan 2021 21:12:29 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v15sm3920184pfn.217.2021.01.13.21.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 21:12:29 -0800 (PST)
Date:   Wed, 13 Jan 2021 21:12:29 -0800 (PST)
X-Google-Original-Date: Wed, 13 Jan 2021 21:12:27 PST (-0800)
Subject:     Re: [PATCH 0/4] Assorted fixes for RV32
In-Reply-To: <mhng-a7496321-17ee-4286-a31c-1474c80d4fce@palmerdabbelt-glaptop>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org,
        Anup Patel <Anup.Patel@wdc.com>, ardb@kernel.org,
        linux-riscv@lists.infradead.org, rppt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, mick@ics.forth.gr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-7d4452e4-0726-41df-96a9-33eae8e5230f@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 21:09:36 PST (-0800), Palmer Dabbelt wrote:
> On Thu, 07 Jan 2021 01:26:48 PST (-0800), Atish Patra wrote:
>> This series fixes various issues observed in latest kernel on RV32.
>> The first two patches fixes an resource tree introduced in 5.11-rc1
>> while the last two fixes the case where 2GB physical memory is used
>> on RV32.
>>
>> There are may be better way to fix the issue pointed out in PATCH 3
>> as it seems a generic kernel issue where kernel pointers can not use
>> last 4k of addressable memory. I am open to other better alternate
>> suggestions.
>>
>> Atish Patra (4):
>> RISC-V: Do not allocate memblock while iterating reserved memblocks
>> RISC-V: Set current memblock limit
>> RISC-V: Fix L1_CACHE_BYTES for RV32
>> RISC-V: Fix maximum allowed phsyical memory for RV32
>>
>> arch/riscv/Kconfig             |  6 ++++--
>> arch/riscv/include/asm/cache.h |  4 ++++
>> arch/riscv/kernel/setup.c      | 24 +++++++++++++-----------
>> arch/riscv/mm/init.c           | 16 ++++++++++++++--
>> 4 files changed, 35 insertions(+), 15 deletions(-)
>
> I took all of them but that L1_CACHE_BYTES one, which I had a comment on.
> Thanks!

Oops, I just saw the v2.  I took those instead, the comment still applies.
