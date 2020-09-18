Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3312705F2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 22:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgIRUEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 16:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgIRUEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 16:04:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDFBC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qYaEAszQv6v4if8wYRImkPIKWHq2MR9K6P/7rHDEe6w=; b=PMG5G25stfvlOdt8U6PcP8yPtt
        WczUHLk3P6quZDIv6WHLI3s9rizVmKdxM9o/p6dd8YL5BlcdCM8B+aK7hK7cmO7gWjmuAU2pBGOir
        0Q5jvukBXbLbmB1Tv3KaaynOj3Wrj7vj4oc/e1jiMq9vpA1w7NjkUmZFF1YRToPIu7JhZNJK/lMxj
        gMNnwP44jtSN3QG/PkgO54VRDgMomtZroefFIfOoCzHEJ6dv4GeGdGtq5Xzs4/uFf1fakhQ4T4joi
        0XGbaidN1k127sdVT3xnIGyTAvoA3vfCypu7K2sT3Kn04JrROKYUmbGhMdKNbjSZ5DyDt2vNbgFgz
        ilk+WQ4g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJMc6-0003o1-Ol; Fri, 18 Sep 2020 20:04:10 +0000
Date:   Fri, 18 Sep 2020 21:04:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     syzbot <syzbot+3a21fd5ecfc677248e77@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: null-ptr-deref Read in PageHuge
Message-ID: <20200918200410.GI32101@casper.infradead.org>
References: <0000000000000cea4605af946f8c@google.com>
 <3747b978-77d7-93b3-eca4-28010fab5d01@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3747b978-77d7-93b3-eca4-28010fab5d01@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 12:42:24PM -0700, Mike Kravetz wrote:
> On 9/18/20 4:02 AM, syzbot wrote:
> > ==================================================================
> > BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
> > BUG: KASAN: null-ptr-deref in test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
> > BUG: KASAN: null-ptr-deref in PageCompound include/linux/page-flags.h:196 [inline]
> > BUG: KASAN: null-ptr-deref in PageHuge+0x19/0x170 mm/hugetlb.c:1551
> > Read of size 8 at addr 0000000000000000 by task syz-executor410/6864
> > 
> 
> I assume this would also be fixed by 5d1903f712ac
> ("mm-convert-find_get_entry-to-return-the-head-page-fix")

That's a good bet.
