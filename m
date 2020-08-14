Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9558A2442C8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 03:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHNBoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 21:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgHNBoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 21:44:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493DEC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 18:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9iILY5y1o8sySmM5jW1ocYlCz9cV5k1VWj6M394hPzY=; b=chRbBMNE3S+gAyKkHqVo802ERf
        JRJUzKQpBYv1LlDyK1YjXUNC8TizkJtZ6frMOfHhz4GltFUa1OPhjbc0VvM/FYDSn8YlL361v9Yo+
        98hGjM184iXjjDz+SFBtomElAuD1P7GhabTpNX/5SLITEjPMVsoVhS3WTO6qCiNHKraJPNAZl/7Lk
        tdTq3Ckv4RadQiBqbhYKJf0E2T8TKXlag1QUc/ZyosWRETetIAVmwCg3dpGDPgT2FBbuYxlCxPOAw
        Rf+aI333+Nu8ZX+jgLKTrpQaWYgs4mOUEtAzitkl44bcuAp335/siqm2CaJz5NQBi2K9qNFEQ7HoF
        EuJP1SSg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6Ol9-0008JE-BB; Fri, 14 Aug 2020 01:43:55 +0000
Date:   Fri, 14 Aug 2020 02:43:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Roman Gushchin <klamm@yandex-team.ru>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm : update ra->ra_pages if it's NOT equal to
 bdi->ra_pages
Message-ID: <20200814014355.GS17456@casper.infradead.org>
References: <1597368611-7631-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597368611-7631-1-git-send-email-zhaoyang.huang@unisoc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 09:30:11AM +0800, Zhaoyang Huang wrote:
> file->f_ra->ra_pages will remain the initialized value since it opend, which may
> be NOT equal to bdi->ra_pages as the latter one is updated somehow(etc,
> echo xxx > /sys/block/dm/queue/read_ahead_kb).So sync ra->ra_pages to the
> updated value when sync read.

It still ignores the work done by shrink_readahead_size_eio()
and fadvise(POSIX_FADV_SEQUENTIAL).
