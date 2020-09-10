Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A115A264BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 19:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgIJRxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 13:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgIJQPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:15:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBA2C061757
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 09:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FxWosVolwnMfdv5ZVUcxwHEUfhyRl2xLq4dMuRxI3V4=; b=KtsQglLraazFNT7GAvMGkp/5D5
        9IuQF2tdaROc4TQT1ZFZG6jJCH5WL9q1BFHGpIvwPNh900WEupxsuH4F1qoVxynv9TbIKSQxmx7Dd
        tZTEcLcRqmdTcdacmG6Jw7QZ/8wFVUrRiuP5APwOtfMDRd8rIGUiF7QlEyc2to5MxYuRDjEMfUpVi
        x6VzUal2DGTwxI5dU8SFL9r9LxKtDM7eHc/Dn8uL3qbGcvc0CMWKHRNS/ICvTO8vVlFrjXQmkjNco
        uyZxPl8zqPVBXoE3ypyntLHoSwPiOGD+HFb0OGrMbwSsF50uu8TkaOyl2m3J38yfj/8Qd5pQLPtWK
        aZrOujZw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGPEh-0004Vc-3v; Thu, 10 Sep 2020 16:15:47 +0000
Date:   Thu, 10 Sep 2020 17:15:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pintu Kumar <pintu@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@linux.com,
        pintu.ping@gmail.com
Subject: Re: [PATCH] mm/slab.h: Fix duplicate include file kmemleak.h
Message-ID: <20200910161547.GT6583@casper.infradead.org>
References: <0101017478cb7f12-16ae9fdb-ef30-4277-ab57-e31e12598466-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0101017478cb7f12-16ae9fdb-ef30-4277-ab57-e31e12598466-000000@us-west-2.amazonses.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 04:13:56PM +0000, Pintu Kumar wrote:
> As I was browsing through this code, I found that linux/kmemleak.h
> was declared twice.
> 
> When I run ./scripts/checkincludes.pl it reported the same:
> mm/slab.h: linux/kmemleak.h is included more than once.

Already reported yesterday and also on August 18th.
