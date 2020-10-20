Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA02029422F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 20:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437496AbgJTSff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 14:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437458AbgJTSfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 14:35:34 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D50C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 11:35:34 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id k9so2529358qki.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 11:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3bEaFKRFPS/Sh2t/CI7BcAkihd22K7XwWCcLf9zY4qI=;
        b=eDpMzgLFh+ac8jAdLmXWxs6dOFK/N7u2zhExMvQXU8gLIswGz9dNocWqqJLN/Xmuyt
         rBZ11B5sKUn96yasph0hl8x+8p+BefVuTBQ57aVaVezZHGTE+dm7xTQUyZgeXJkWn5W+
         oERWzaHuOUxRgFPRQORIMQtYcxgIHrWVgfWZux9HU6I7iOtcWighiB11uEEK5eshXa4E
         /Kbn72MSSNUyOKG4Q+P0k7AMskR5VssEg83c6RQlKEjv4LmdJawNB7uv3SRRo07tmzSY
         81pzjCbWB2Jcp/mOXq+/LutPBIhoueU67Qr4WAOrQCbjpgCIbW+OKz5ZPM9mgII8Cjd2
         5CHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3bEaFKRFPS/Sh2t/CI7BcAkihd22K7XwWCcLf9zY4qI=;
        b=e9CCfUWMP13q4edjJXwTpnndXuMSUzCp789ko0SufJpeh4R2Zxt+I1JBBwCMMLegDT
         GrBSW3SpKSge1CTQyG2igG7EKVPO2Kw2tRCksdRkPs0bVjiZ9k6DXt2Bdn8Am+4yASdt
         sneNG37dMhn8PbXPjUg9YNybXUH6Hr9dcwWIOMUHMHeE/0v/0ipQ36zIBF0Un69nXKg1
         TpR6tYXyx157cmlbehGwL26OysCSv7Q8XDXxaHJcdDggdfBUF4tkPIclICmtGwSVX8Zd
         okIZXrrZKJuTTZJE7GklINGJUYnBtDFDAJ+OT0aZfjsY6ap6COSwc/fQaYeiYr+g5kRh
         kQZA==
X-Gm-Message-State: AOAM533l6JPniaN0o/kGg73EA5qFjKZMij0WiR2ePWvftsa2HBatCytb
        CDXOn5IwM3PN6dBbn8xbwbzAwBZDhmNDVA==
X-Google-Smtp-Source: ABdhPJx8oRW/tNaZSiG9aS3bionlit1W0IoCBu7VK3t7uOuxJeysus0w6e9BOQuYqJS0NUhYqBefDg==
X-Received: by 2002:a37:a5cd:: with SMTP id o196mr3952603qke.374.1603218933224;
        Tue, 20 Oct 2020 11:35:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:c52c])
        by smtp.gmail.com with ESMTPSA id o2sm1151174qkm.96.2020.10.20.11.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 11:35:32 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:33:55 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-mm <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: mm: Question about the use of 'accessed' flags and pte_young()
 helper
Message-ID: <20201020183355.GB397401@cmpxchg.org>
References: <31ef1305-1fd4-8159-a2ca-e9968a568ff0@csgroup.eu>
 <ed3d1e19-b18b-d10e-2c86-0fb7ce3a431d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed3d1e19-b18b-d10e-2c86-0fb7ce3a431d@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 05:52:07PM +0200, Vlastimil Babka wrote:
> On 10/8/20 11:49 AM, Christophe Leroy wrote:
> > In a 10 years old commit
> > (https://github.com/linuxppc/linux/commit/d069cb4373fe0d451357c4d3769623a7564dfa9f), powerpc 8xx has
> > made the handling of PTE accessed bit conditional to CONFIG_SWAP.
> > Since then, this has been extended to some other powerpc variants.
> > 
> > That commit means that when CONFIG_SWAP is not selected, the accessed bit is not set by SW TLB miss
> > handlers, leading to pte_young() returning garbage, or should I say possibly returning false
> > allthough a page has been accessed since its access flag was reset.
> > 
> > Looking at various mm/ places, pte_young() is used independent of CONFIG_SWAP
> > 
> > Is it still valid the not manage accessed flags when CONFIG_SWAP is not selected ?
> 
> AFAIK it's wrong, reclaim needs it to detect accessed pages on inactive
> list, via page_referenced(), including file pages (page cache) where
> CONFIG_SWAP plays no role. Maybe it was different 10 years ago.

Yes, we require this bit for properly aging mmapped file pages. The
underlying assumption in the referenced commit is incorrect.

> > If yes, should pte_young() always return true in that case ?
> 
> It should best work as intended. If not possible, true is maybe better, as
> false will lead to inactive file list thrashing.

An unconditional true will cause mmapped file pages to be permanently
mlocked / unevictable.

Either way will break some workloads. The only good answer is the
truth :-)
