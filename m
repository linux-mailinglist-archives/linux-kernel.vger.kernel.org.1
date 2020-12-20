Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BC62DF293
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 02:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgLTBTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 20:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgLTBTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 20:19:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EC6C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 17:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nTty+Jb7NFfcXZE4+MmMpQCASKTBw2ev6K5BlwoCsxM=; b=tfnJmYiq7rvKVwzvOGc0xjJ7L7
        glDSJWXNHGD8nBPb1x09mxZ6pJeoLDMIs3IMqjvczp136k4RrLHJYwgwKGsMOIDIXYR3Bg3MlTuFM
        HBj4MZeRtt6KDfjKo84f6m6M0hocmod82cjYGgA4H1it4HxjvhhPLp/qWrNuD+mLfreHozYTFQ3lu
        kJn4vaoaFcPgp393aaKOlVor+SyK55zEwqY4g6BkAGS90nv8tS3pheNvt8S9tZYF8dv0ffx0/sE3O
        dYa6jO/fdHkc0MsKOo+2GywcRRt8IrI02CbvyVGhnkrtnA6GYVyQ4+nvI8r27DXqPYcByCthM2M3z
        Hiz1op4g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kqnMp-0001Wz-5k; Sun, 20 Dec 2020 01:18:35 +0000
Date:   Sun, 20 Dec 2020 01:18:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Minchan Kim <minchan@kernel.org>,
        NitinGupta <ngupta@vflare.org>
Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
Message-ID: <20201220011835.GU15600@casper.infradead.org>
References: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
 <20201220002228.38697-1-vitaly.wool@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201220002228.38697-1-vitaly.wool@konsulko.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 20, 2020 at 02:22:28AM +0200, Vitaly Wool wrote:
> zsmalloc takes bit spinlock in its _map() callback and releases it
> only in unmap() which is unsafe and leads to zswap complaining
> about scheduling in atomic context.
> 
> To fix that and to improve RT properties of zsmalloc, remove that
> bit spinlock completely and use a bit flag instead.

Isn't this just "I open coded bit spinlock to make the lockdep
warnings go away"?
