Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586A4256A77
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 23:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgH2Vhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 17:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgH2Vhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 17:37:39 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F77C061573
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 14:37:39 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id c15so1270169plq.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 14:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=t7Z/WihbZx/nUDMqaKBMgaERszAkUDmuZLwW/hs7E6o=;
        b=ClxR1NpBtDBvFkdx0n5KKmbc5L2lE3c7Ld+RDyUG8Hy5D9yPm/fFL2BDrZgAbgq4g0
         I8HYP3DYyT3ZPCI2GnOgG8IDMnBDcWq/XG8neCdqTO63AnKfolSp8kAkWTSseG3B+VLM
         fN8xgsat7mOa8VqD9HYlXA2/aAULRN2K/Vgf+zrJoujVc3ui82b8uHvunYbSlKOHoh9M
         f5lj8WiUmrAbOdfi6MhcGVI0Rdbve7ctn5KzVKWoNfm3BebgjEMDNSXNSeXYVhKn+Kik
         6dg27wKrRxmDMeD3C9lkoBVn7kQ5r0sPN/fblFRVIeLDxmNo7Qsvo7cYmJcmvtqTtCH1
         JcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=t7Z/WihbZx/nUDMqaKBMgaERszAkUDmuZLwW/hs7E6o=;
        b=MGG2kWUaooHvaXBLcwAU1H9+z5hebSpIeudwXx86qrC6cMwA8h6JWWaEymfguOhNbi
         U5zA36oHCuML1bepbU1OYoZNNGo4wvn89HpZuTnc/rCzNto9czSy+gQQNw7PNuVTiKnk
         rt3nW++Mli5IspoHvRyu9ak4vcosHRpPJaC4OOtlJeBvo4WYDq1o4jGr1v9emidkJeyC
         /xaNiTfd7QLGLBAtqNTKTjEays1u6NmerzYNo92B3UdrWnU3LjODaZN/k/IVJcvYIk52
         s5qLMLZAA7ibpcNoDd7lAofGynKuwi6KNuZ8EhLMh9Rv3TfluPiNrIAaZyGDTQy5Np9Y
         BzfA==
X-Gm-Message-State: AOAM530/UzjWKkqV48n3Lriurn04RRRNuu1Gi+eBHxfEs7oXf0AGjNAQ
        q2N7gm0a0zgxLmZi+kA7g1B+qQPK0m+JKw==
X-Google-Smtp-Source: ABdhPJz6U+6iEBYqzcJ6tQmtB1+MimNlUA/izv/zo0BDVwDFk6affwwQ4wVDVG6ATI56qy7nL8L8YQ==
X-Received: by 2002:a17:90a:dac5:: with SMTP id g5mr4208360pjx.5.1598737058711;
        Sat, 29 Aug 2020 14:37:38 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id v18sm3416251pfu.15.2020.08.29.14.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 14:37:38 -0700 (PDT)
Date:   Sat, 29 Aug 2020 14:37:37 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Simek <monstr@monstr.eu>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] microblaze: fix min_low_pfn/max_low_pfn build errors
In-Reply-To: <20200829000110.2408-1-rdunlap@infradead.org>
Message-ID: <alpine.DEB.2.23.453.2008291437170.3955211@chino.kir.corp.google.com>
References: <20200829000110.2408-1-rdunlap@infradead.org>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020, Randy Dunlap wrote:

> Fix min_low_pfn/max_low_pfn build errors for arch/microblaze/: (e.g.)
> 
>   ERROR: "min_low_pfn" [drivers/rpmsg/virtio_rpmsg_bus.ko] undefined!
>   ERROR: "min_low_pfn" [drivers/hwtracing/intel_th/intel_th_msu_sink.ko] undefined!
>   ERROR: "min_low_pfn" [drivers/hwtracing/intel_th/intel_th_msu.ko] undefined!
>   ERROR: "min_low_pfn" [drivers/mmc/core/mmc_core.ko] undefined!
>   ERROR: "min_low_pfn" [drivers/md/dm-crypt.ko] undefined!
>   ERROR: "min_low_pfn" [drivers/net/wireless/ath/ath6kl/ath6kl_sdio.ko] undefined!
>   ERROR: "min_low_pfn" [crypto/tcrypt.ko] undefined!
>   ERROR: "min_low_pfn" [crypto/asymmetric_keys/asym_tpm.ko] undefined!
> 
> Mike had/has an alternate patch for Microblaze:
> https://lore.kernel.org/lkml/20200630111519.GA1951986@linux.ibm.com/
> 
> David suggested just exporting min_low_pfn & max_low_pfn in
> mm/memblock.c:
> https://lore.kernel.org/lkml/alpine.DEB.2.22.394.2006291911220.1118534@chino.kir.corp.google.com/
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-mm@kvack.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Michal Simek <michal.simek@xilinx.com>

Acked-by: David Rientjes <rientjes@google.com>

Thanks Randy!
