Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C53256A79
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 23:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgH2VjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 17:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgH2VjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 17:39:13 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3188AC061575
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 14:39:13 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id p11so2469168pfn.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 14:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=1Xkw7SsTluwGLX1WFengI1q4lftidu3MJxTjNHik2H0=;
        b=hMbO3tOle/Wmiud+C3raW+sqkQs9r44niz9Z7e4xn8V6HR5QhM+kqGaGqq0s82og7F
         voJSh1miXiYFZD6eoMwd2LDU2k0wJJzOlo2zI/Z+5x/BUBgy3vxjrltkitJUqqyIic/J
         BDoHDDGttgwoELTcH9Gf6VVlNDVSceNWy/VPZsEILA8VYdLnYhOuoJP9djFFXZszCi9Q
         xNxP9GYg+d3iuUynUktGHqU0QpezdqeqRuc86NBG+mJbAEz2ashjEXRC2ZHq7dpS8NET
         WMuR0hlYHmfQcfIOFaJ60xcIiHj78ntEVpgSbZYHpEDmOzDd1u/0TdKDWr8oSTjQW7FS
         4cCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=1Xkw7SsTluwGLX1WFengI1q4lftidu3MJxTjNHik2H0=;
        b=XDeLGaeEwZcG2BSvvAf2VvBtaGPUdNS6T+pyfoZLsIyGXdsfNoaJZQgScAFGR47i9a
         NfCcV5GvSXhKKi0NW+pMRa8G2hnW5qZvwxdAMrS0b0WyJsTBYMsYbgAawujaDbIocPRd
         61QDDx1gCs20sl0Vm4qIyhOxFJeEPpg9NloxwknYi9VBgg96ygShTImahdHc4Zn8vHim
         RMCzR3R4hmKaUR5VRUW7pbIsIUaNsZaXzegrUoTZj6HIbVhJoiu/xX5gVL/ahcJw5VnE
         VFqvu27TQ4aMrlJd1mxKs7R5vh0zOkfnCZh8K4YipI+ZS6SHQ6Ly9eBa9NOY5//oU3rO
         6How==
X-Gm-Message-State: AOAM533pTcex3i8yJ9f4uv46XJuwKa7SGpRgfVmEHnhjdNU73CHFwNmw
        en5K08bVaIle1RaoFpdErVLP7Xn17AejRw==
X-Google-Smtp-Source: ABdhPJw34xsOfawWVhCBneMxURpAKERGDRRVZ2alS63AyRaicgNl3k8EQvpe9DGDskaKVzz63aC0Pw==
X-Received: by 2002:a63:fc18:: with SMTP id j24mr1398594pgi.452.1598737152275;
        Sat, 29 Aug 2020 14:39:12 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id z66sm3457517pfb.53.2020.08.29.14.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 14:39:11 -0700 (PDT)
Date:   Sat, 29 Aug 2020 14:39:11 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] ia64: fix min_low_pfn/max_low_pfn build errors
In-Reply-To: <20200829000126.2463-1-rdunlap@infradead.org>
Message-ID: <alpine.DEB.2.23.453.2008291439020.3955211@chino.kir.corp.google.com>
References: <20200829000126.2463-1-rdunlap@infradead.org>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020, Randy Dunlap wrote:

> Fix min_low_pfn/max_low_pfn build errors for arch/ia64/: (e.g.)
> 
>  ERROR: "max_low_pfn" [drivers/rpmsg/virtio_rpmsg_bus.ko] undefined!
>  ERROR: "min_low_pfn" [drivers/rpmsg/virtio_rpmsg_bus.ko] undefined!
>  ERROR: "min_low_pfn" [drivers/hwtracing/intel_th/intel_th_msu.ko] undefined!
>  ERROR: "max_low_pfn" [drivers/hwtracing/intel_th/intel_th_msu.ko] undefined!
>  ERROR: "min_low_pfn" [drivers/crypto/cavium/nitrox/n5pf.ko] undefined!
>  ERROR: "max_low_pfn" [drivers/crypto/cavium/nitrox/n5pf.ko] undefined!
>  ERROR: "max_low_pfn" [drivers/md/dm-integrity.ko] undefined!
>  ERROR: "min_low_pfn" [drivers/md/dm-integrity.ko] undefined!
>  ERROR: "max_low_pfn" [crypto/tcrypt.ko] undefined!
>  ERROR: "min_low_pfn" [crypto/tcrypt.ko] undefined!
>  ERROR: "min_low_pfn" [security/keys/encrypted-keys/encrypted-keys.ko] undefined!
>  ERROR: "max_low_pfn" [security/keys/encrypted-keys/encrypted-keys.ko] undefined!
>  ERROR: "min_low_pfn" [arch/ia64/kernel/mca_recovery.ko] undefined!
>  ERROR: "max_low_pfn" [arch/ia64/kernel/mca_recovery.ko] undefined!
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
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: linux-ia64@vger.kernel.org

Acked-by: David Rientjes <rientjes@google.com>

Thanks Randy!
