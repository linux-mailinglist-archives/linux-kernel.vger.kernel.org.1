Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53EE2F74DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 10:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbhAOJEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 04:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbhAOJE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 04:04:26 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212C3C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 01:03:46 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y8so4371613plp.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 01:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=W+TNB9GTBNA7O8ikQR0rbGOukl06/A5MmG42j1bpCcU=;
        b=kNJAO2ob/XlszHX7qLdCin/8KILOI6W2LIxyEiI066kE3TRoEVEc8fFdTdd62iz3wj
         SQ8NLV+HqLTve4R+IbfUA28lWgXkBrFGRE2qA3uVY+IoJGDWUqvNX4eWxKDJ9EHHq36B
         zDUTO0InHpo15vfXXClRnq7sfLJC83qRXGwXt7ZftP4M9w53sbo3TZMxP1nE6Bu2fYjO
         FupBg2424UBkzBkJv/MckZz6AmXNpWL/EifBm7LtWK4nkkHGbNGH5dDgCsuooT4tmCRw
         SE4Z6ns9BxpGXa99219ymGjY/QHPNgCk9DsMZdt8yZIgNdMKBIrLVuIde9Fj9Fv0tJuU
         zzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=W+TNB9GTBNA7O8ikQR0rbGOukl06/A5MmG42j1bpCcU=;
        b=g4XPBqnE3WN0ZjwG0ZRlH0xuXPmIagmqoR0ftFrmRfVekKGRlu2Xc0ur/Jhu9WuBQz
         NuMmTKCC+cXU/3/H2ytW3JTmtVoJoCMJbQ8AbLuazCCuRmXkOOqmJjjT/iHq9/5q46Iv
         eya1Lfe2ErMd5zMLwGr4WRXq5N6BSCezv9UWvXhc5harwdOcY9p06zqugmEr27e6vt6t
         nhfk+ql6yzzepfnsv8TwR60Y9yrw7wbDek6+KiOweGSnYu+zw9lIod4TXb3uQ4zTCOBg
         StDGd1Vd48nPU4hz4NyZ70TNiV+iByCRR8Lrvv2KWIr6MhoZU/gcWS5D3PyjMXnvDPS7
         /R8Q==
X-Gm-Message-State: AOAM53249eNFLJMMG7E1U0EavCFYval/Wlaltz4JZB+y9wOQtPImpgFT
        96fWoDAr2ysDk7WtDRpsFbqTQw==
X-Google-Smtp-Source: ABdhPJyCRJ2CkjMe9vhGQFu0PoBupIJQDPGXftwzsicTs87Hyz1VipbWDITlUz1qdcCA7Z3vVsb3LA==
X-Received: by 2002:a17:90b:305:: with SMTP id ay5mr9810511pjb.4.1610701425545;
        Fri, 15 Jan 2021 01:03:45 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id g202sm6984866pfb.196.2021.01.15.01.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 01:03:44 -0800 (PST)
Date:   Fri, 15 Jan 2021 01:03:43 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Christoph Lameter <cl@linux.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] MAINTAINERS: add myself as slab allocators maintainer
In-Reply-To: <7e0356e7-6152-a51c-3d3e-4b1906e694ed@suse.cz>
Message-ID: <91c1ee2-1dff-a68-bfe2-dee9e482b6c@google.com>
References: <20210108110353.19971-1-vbabka@suse.cz> <alpine.DEB.2.22.394.2101081845130.19092@www.lameter.com> <7e0356e7-6152-a51c-3d3e-4b1906e694ed@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021, Vlastimil Babka wrote:

> On 1/8/21 7:46 PM, Christoph Lameter wrote:
> > I am ok with you as a slab maintainer. I have seen some good work from
> > you.
> > 
> > Acked-by: Christoph Lameter <cl@linux.com>
> 
> Thanks!
> 

Acked-by: David Rientjes <rientjes@google.com>

Great addition!
