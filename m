Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC252C1C98
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 05:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgKXEOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 23:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbgKXEOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 23:14:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA05CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 20:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mlMktLVfsrdjf/T64LkGt1vFmYlTMbYcYYynjTprjGg=; b=BLh3OA8MiW6zkUwz+TIcgFV6P2
        O9jjur8ymrJWnNUBlW9hJRl3DbQK+1nW01rnwzHiiiv3TmqqUJP2/FN6JtCNPn+IA4JESNQ8V6cRm
        54F+8q7BDJ4NQSDPTKcHgAAC4cyzVV/xjLed+h3pIpWptKC5j4Je7hR9gvNwy9kOsH8SyWO+fyGGU
        ZjlhG79fbCSTehFHs24lvX5LnWd2N6dsjN67btTTvPtRVjyLS4jAG3aQerUcTsTTJEdypnwzi3ec2
        E6ZVbyb/WKOrk5d1l8jDXJ0Bxbs6tHhOw12SlRl8UD/0XWKRO49Du1IIOxoZlScLW9Yd1+L1fG9Nz
        0MzZoMWQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khPib-0007UO-RQ; Tue, 24 Nov 2020 04:14:17 +0000
Date:   Tue, 24 Nov 2020 04:14:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+dcb847a3e1e0ecd191ab@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: kernel BUG at include/linux/highmem.h:LINE!
Message-ID: <20201124041417.GX4327@casper.infradead.org>
References: <000000000000f6914405b49d9c9d@google.com>
 <20201123194230.f59c93eba3cf356c632eb1c0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123194230.f59c93eba3cf356c632eb1c0@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 07:42:30PM -0800, Andrew Morton wrote:
> Matthew's series "Overhaul multi-page lookups for THP" chnages the
> shmem code quite a bit, and in the area of truncate.  Matthew, could
> you please fire up that reproducer?

Almost certainly my fault.  I was trying to get the shmem truncate code
in better shape before posting my series of fixes.  I'll send you a batch
of four which fix problems noticed by Hugh.  There's at least one more
to come.
