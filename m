Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A7621A408
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 17:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgGIPuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 11:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgGIPuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:50:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100CAC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 08:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qoHPbGxG9Oimtt6WoWs+2/LdnzOc61VzELk6X25qiTo=; b=KyWLACnetXhzqn1rE6psvcE3ly
        lic9T6JORrpdlmLz6S6ifhyzvX1D6TV0+nYFG9qjvieVNp6mlJyk2EsdHIycrWDbA31U8U1jq6DhQ
        6Ga502jhNLoYNipU9hDazSe0p1u5NLqtCtiqqqwhk8/LAcPSke0ZA6W7T3sk7b/227LdgtsqqUTXy
        d3ZG6OSosVhV+BqKnHvu/N+K12tan0C3I2So6KFIvfM49qfE2WYnFSOoMLc6GGueQKn/otEd35970
        ub2ZjuxaD1ATWXNu5EklO98i/a6wICm6NXfenTll6YHDxgU6HRBRo8D8AQP/J+6Kwa36c6UEgBJEe
        mQESMAtw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtYoE-0006k0-KD; Thu, 09 Jul 2020 15:50:02 +0000
Date:   Thu, 9 Jul 2020 16:50:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: a question of split_huge_page
Message-ID: <20200709155002.GF12769@casper.infradead.org>
References: <df2597f6-af21-5547-d39c-94c02ad17adb@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df2597f6-af21-5547-d39c-94c02ad17adb@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 11:11:11PM +0800, Alex Shi wrote:
> Hi Kirill & Matthew,
> 
> In the func call chain, from split_huge_page() to lru_add_page_tail(),
> Seems tail pages are added to lru list at line 963, but in this scenario
> the head page has no lru bit and isn't set the bit later. Why we do this?
> or do I miss sth?

I don't understand how we get to split_huge_page() with a page that's
not on an LRU list.  Both anonymous and page cache pages should be on
an LRU list.  What am I missing?
