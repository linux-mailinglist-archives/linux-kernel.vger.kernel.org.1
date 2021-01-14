Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBB82F5A32
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 06:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbhANFKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 00:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbhANFKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 00:10:17 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0E5C061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 21:09:37 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id r4so2308256pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 21:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=KcEA2nbzXx0jru83yIQ190/mImRN9DXek195EgNHMTM=;
        b=ItvMJreq/VrK59JsNEZhxHcD41LpU029J3ATPXNn4VP79v8smYm5CKi6tvsZLZ0IMN
         stLb6jdptaiX2p2VLSOmVluSITFwuKCpP5FEuqVCUWsrzyDAzQaAiyEuUV2piCLv2QlR
         Fm5le6VT20CABM5QMDgNso6BR/g9B1sbWPIG1OHXkQ1RD8NVb22molvVS5maGkslFNKP
         gKXjakFIy2btTOKIedtUM8ufKnw8YbY/bFCKaixINOyWVYxfvnLSg1M0N3B9YeyQRBJ1
         IJvNQ7bCH1ipvvL9LDC7WXNt6eKC+b/tvd/K3Aj5ZXD/pGgOJocHlq4MYdrYdzrDEQTn
         0Www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=KcEA2nbzXx0jru83yIQ190/mImRN9DXek195EgNHMTM=;
        b=h+ZkUyCRdZQG3SUEZZTpkIbuYYLoLZM5Ol2xdxOEiXBhJ2WlJ6U5cRhYO8YYruUJMu
         2ONFBa/hMN1wjkuDhIPQ0roi5H6voR9XVkU3LOQR5PISfm9Dd7lQztdF3dbLljmHj9MD
         zz6WyvElVwLKlSEEJAM7q7W8jhvRBPBF8BRsErE3CIpALwR1+mSqD+M2uqZOnbzcVFJO
         i4uWb2g4nsvhvins0HW52HkghfJS1pDcztT6y2nTxWXFKMXE7xmNWVLEyLIObQ03T3Dl
         OyGd0yDMtkmpszkBQd7DtxnbncoUrs51vmoaJ8zCyHa7+CsZVoeOkPZda/yGxv0njhmC
         vJxQ==
X-Gm-Message-State: AOAM533h+d8+i6Og+3tKW6LqLXgMtVobKLMHZKbh5mfy7a2pxcQ6Ck3+
        OC/XNYXsDA3NSNFT2rCrs2ij2qrbmHoDJQ==
X-Google-Smtp-Source: ABdhPJw5w1qfQyweI0KL/cYR8X7oUo5hoLXAq5yFReqxbhNLHD/d8jUY4iz/0NIR9UIQwenjXQsvMQ==
X-Received: by 2002:a17:902:9a4a:b029:dc:435c:70ad with SMTP id x10-20020a1709029a4ab02900dc435c70admr5884019plv.77.1610600976917;
        Wed, 13 Jan 2021 21:09:36 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id s29sm4277278pgn.65.2021.01.13.21.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 21:09:36 -0800 (PST)
Date:   Wed, 13 Jan 2021 21:09:36 -0800 (PST)
X-Google-Original-Date: Wed, 13 Jan 2021 21:09:24 PST (-0800)
Subject:     Re: [PATCH 0/4] Assorted fixes for RV32
In-Reply-To: <20210107092652.3438696-1-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org,
        Anup Patel <Anup.Patel@wdc.com>, ardb@kernel.org,
        linux-riscv@lists.infradead.org, rppt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, mick@ics.forth.gr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-a7496321-17ee-4286-a31c-1474c80d4fce@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Jan 2021 01:26:48 PST (-0800), Atish Patra wrote:
> This series fixes various issues observed in latest kernel on RV32.
> The first two patches fixes an resource tree introduced in 5.11-rc1
> while the last two fixes the case where 2GB physical memory is used
> on RV32.
>
> There are may be better way to fix the issue pointed out in PATCH 3
> as it seems a generic kernel issue where kernel pointers can not use
> last 4k of addressable memory. I am open to other better alternate
> suggestions.
>
> Atish Patra (4):
> RISC-V: Do not allocate memblock while iterating reserved memblocks
> RISC-V: Set current memblock limit
> RISC-V: Fix L1_CACHE_BYTES for RV32
> RISC-V: Fix maximum allowed phsyical memory for RV32
>
> arch/riscv/Kconfig             |  6 ++++--
> arch/riscv/include/asm/cache.h |  4 ++++
> arch/riscv/kernel/setup.c      | 24 +++++++++++++-----------
> arch/riscv/mm/init.c           | 16 ++++++++++++++--
> 4 files changed, 35 insertions(+), 15 deletions(-)

I took all of them but that L1_CACHE_BYTES one, which I had a comment on.
Thanks!
