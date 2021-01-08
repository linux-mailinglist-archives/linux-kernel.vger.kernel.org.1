Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AA22EEAFA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 02:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbhAHBhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 20:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbhAHBhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 20:37:00 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89F4C0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 17:36:19 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id b8so4857417plx.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 17:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Y1J3DUdWcOQx0bVUfuDnHN7QMPqvsEtCtXv4CCI/gFU=;
        b=We21GKe5c5ppvnQ5+V38BX7N59HJaXyZsmnSGyVb9vsePRAy0GYDEpFLfzJV2P/64U
         G1LQ4IfjlcpaNkahgKsq/VBl8dJvlvTT9W55gtIhXSDT1SlLL6ULEs/6Xb9ifjQVfmZ3
         W+XsaM+OCL/DBmLRMvmvn8hJSLGSZj4fi9b91Q6CHepgQn+dpF98gLfBykCvZNA5aByP
         lhDkvbNxaYcTQgnBJdE3HHi2jHDSdXnYfR9mNdTfIKBHwSI3ypZFvvtFFzK0k/XDsq9r
         V+auQg9QfQtpGJ4Rb5m2mMZFWFDMVqaPUgerlEf7WLVzZ3NUTIVkrgCc1CayrVy/lpVJ
         fcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Y1J3DUdWcOQx0bVUfuDnHN7QMPqvsEtCtXv4CCI/gFU=;
        b=nd981OhqLZnZe2A9DpuJ9PtwmZ+ST561+hT+Y1AsEAZSJRZe/hV+8fHZvjK1rcsXV2
         Y7PWAFXhvwtLP/sIa82DfCmoAn+DnsEzIQcOJ3gXgNQg5FHAylp0uNzuU8fe/5YvJIN5
         0h2WJUlmYDy7FGYG8ZTNvzVqwOS86WVaL+rQydUqD92ntwn15AF3UjWi1MotJ14vS/KL
         hhYOW2attqL4Rz+459n3qV8LahRvFQD0W6UdsKneekhrBUro/lVDNQJdgyzE9qM4nqIB
         zlnlSyFo9RonQF5fLIe7pY8lyelWTb9cxfxHKJ0+lvnvSyV4ipXQ73yVrVwSVjs/GE4J
         HPRQ==
X-Gm-Message-State: AOAM531d6Taw9fLjDfBzu3brmKsCIPGg4JS2iX8h/iCSLxp0QVbnF1+Q
        a6jB/Bfr3yhKw1q5wVC8c0DvBMVjfunukw==
X-Google-Smtp-Source: ABdhPJwTQMFJXBOd42SE6blUoubNT5H3NxGBzcRFMuHBbDHQRNAJzbKlAUEqkL9CnagoK8T0LCnxRA==
X-Received: by 2002:a17:90a:5793:: with SMTP id g19mr1274178pji.32.1610069779086;
        Thu, 07 Jan 2021 17:36:19 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id c18sm6735984pfj.200.2021.01.07.17.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 17:36:18 -0800 (PST)
Date:   Thu, 07 Jan 2021 17:36:18 -0800 (PST)
X-Google-Original-Date: Thu, 07 Jan 2021 17:28:44 PST (-0800)
Subject:     Re: [PATCH v3 0/2] riscv: sifive_l2_cache: Add support for SiFive FU740 SoC
In-Reply-To: <1607596083-81480-1-git-send-email-yash.shah@sifive.com>
CC:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, bp@suse.de, anup@brainfault.org,
        Jonathan.Cameron@huawei.com, wsa@kernel.org, sam@ravnborg.org,
        aou@eecs.berkeley.edu, Paul Walmsley <paul.walmsley@sifive.com>,
        robh+dt@kernel.org, sagar.kadam@sifive.com,
        sachin.ghadi@sifive.com, yash.shah@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     yash.shah@sifive.com
Message-ID: <mhng-18249e76-3632-4347-b9f1-73e1cc39683a@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Dec 2020 02:28:01 PST (-0800), yash.shah@sifive.com wrote:
> Add support for additional interrupt present in SiFive FU740 chip.
>
> Changes:
> v3:
> - Rename the subject line of dt-binding patch
> - Add the additional interrupt "DirFail" as the last entry so as to keep
>   the order of all previous index same.
>
> v2:
> - Changes as per Rob Herring's request on v1
>
> Yash Shah (2):
>   dt-bindings: riscv: Update l2 cache DT documentation to add support
>     for SiFive FU740
>   RISC-V: sifive_l2_cache: Update L2 cache driver to support SiFive
>     FU740
>
>  .../devicetree/bindings/riscv/sifive-l2-cache.yaml | 34 +++++++++++++++++++---
>  drivers/soc/sifive/sifive_l2_cache.c               | 27 +++++++++++++++--
>  2 files changed, 54 insertions(+), 7 deletions(-)

Thanks, these are on for-next.
