Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510A6290D3A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 23:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411290AbgJPVZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 17:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411183AbgJPVXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 17:23:50 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDA5C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 14:23:49 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id hk7so2197010pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 14:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=9r+vjWxac+k+dzN+bY/eqFKYn3xmRfxWz658Py6XIZ4=;
        b=D5CCxnuFqztvqgv5LezTdW+2PS8Ja4DrX2lanfhOVd5jSN3ThLJIJElk0EFgT36K2U
         UB3QMinnbdviljJsiyaTGJ5J7Fceua8uJtlL5bx0bTTHjWsaUghDloNdUYl3QOABbpeJ
         Sy2ZNOQ08+Oiynz6GOtCTpkV1l733nJoTF5bEqpFJ9fXGqdJwxh0MIJI2oZ7yn8LxkJv
         rn6m0BeWff0ofa7OIcJC2xxogXo+A7B+s1jPYxmu+mw91dLo9QNbCcyS+kXnEdKnf7vV
         uxpJbpc0pDTM/9WP/MG/uYfhASjqpfqbComZCQjrn+VCrwHqo8OUaNmsvhiqkBs93SfT
         eGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=9r+vjWxac+k+dzN+bY/eqFKYn3xmRfxWz658Py6XIZ4=;
        b=dkQk/oosT2z+AK522zqnsMcgYzngDYz8hNnzk2nc7PaaVO27lwK5I+u+HHZ1ANuiHf
         6qKNPi2vdeOwiM5NojgJ12aBcqNoxry8/ATVSCxd55igib7c9+1McMGwfWOD+jH4p9NB
         8siK2RE8e7wpCRNp6FkyE5nrvdkdYDs/ZchR7w3r/evXvsZJIqTdvyk5/vTZ4mw+39NB
         f47nK1Jw+kIDkIlY+NK6FV8m0e3qXmFlrdN1mbNZ2hApRSxnkERUENkKgI/YMLJ9d2Hx
         UYw0t7p3UPkHRnkv7xCCeouV1UBOGR3nTgQeo3Fh/GcfbfptQpiMg+/z4njVDto2rZ6X
         5dkw==
X-Gm-Message-State: AOAM531q9zlZEykmoaA2xPK9TTK0kdopg1JzXWmbLIqFWW+nL42AjCbb
        EzbOjXoOIP7nGy+nIg1vZaxI7rbF/aXgg1CW
X-Google-Smtp-Source: ABdhPJzMZ4XrJR5Qf1bPUZVnEA6GaTM+ddjiVMjrnvPyWOIURjGnkTgHJspyx1cPX0qtHpb7y+yeGg==
X-Received: by 2002:a17:902:d904:b029:d3:d2dd:2b36 with SMTP id c4-20020a170902d904b02900d3d2dd2b36mr6276766plz.32.1602883428300;
        Fri, 16 Oct 2020 14:23:48 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id r6sm3983715pfg.85.2020.10.16.14.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 14:23:47 -0700 (PDT)
To:     David Woodhouse <dwmw2@infradead.org>, joro@8bytes.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: dmar compile failure in -git
Message-ID: <d090c378-bfb4-34bc-7091-64e2b83925de@kernel.dk>
Date:   Fri, 16 Oct 2020 15:23:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ran into this one yesterday:

drivers/iommu/intel/dmar.c: In function ‘free_iommu’:
drivers/iommu/intel/dmar.c:1139:41: error: ‘struct iommu_device’ has no member named ‘ops’
 1139 |  if (intel_iommu_enabled && iommu->iommu.ops) {
      |                                         ^
make[3]: *** [scripts/Makefile.build:283: drivers/iommu/intel/dmar.o] Error 1
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:500: drivers/iommu/intel] Error 2
make[1]: *** [scripts/Makefile.build:500: drivers/iommu] Error 2
make: *** [Makefile:1777: drivers] Error 2

which is due to the config I use:

axboe@amd ~/g/linux-block (master)> cat .config | grep IOMMU
# CONFIG_GART_IOMMU is not set
CONFIG_IOMMU_SUPPORT=y
# Generic IOMMU Pagetable Support
# end of Generic IOMMU Pagetable Support
# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_AMD_IOMMU is not set
# CONFIG_INTEL_IOMMU is not set
axboe@amd ~/g/linux-block (master)> cat .config | grep DMAR
CONFIG_DMAR_TABLE=y

-- 
Jens Axboe

