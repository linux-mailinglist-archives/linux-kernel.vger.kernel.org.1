Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23242B70F1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 22:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgKQVaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 16:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgKQVaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 16:30:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18B8C0613CF;
        Tue, 17 Nov 2020 13:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a1DZ7Ao9CWAtxHaDMnE+CPVs1ONQ/pJUyinx+DQOyFs=; b=GpATbwiQFpcIukS7Dy4VU7xTwK
        yeUr/iphX1MD/qB+GWdciICVRkjDqLelPa2QabNGfnfXwQouRpryglcwQdMz2Ie+qzSJHVvToCPSL
        teDehXMEnFwDAe9vUaCIrwaXbLBsmrJjz+pQC1YxRQg/OmdKOgIV2LL7iAXyLmEa/8+tTXOfg6449
        v2OL5i/xDI/CxsxYDCpkpC9Def/TBnTVlvZq2TiB7IkxZNNsvXCIt7TQeh1NnVX31xO1DVNpyD9AA
        VnXdzNeyWeiqXuaTikDEclk1kgwNFDv9lChnDEJwCvYMIISJ5a9oKo7DRpSqvm6dykOwXAsACHN1H
        /admJfMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf8Yt-0004tf-Bw; Tue, 17 Nov 2020 21:30:51 +0000
Date:   Tue, 17 Nov 2020 21:30:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Eduardo Habkost <ehabkost@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] kernel-doc: Handle function typedefs without
 asterisks
Message-ID: <20201117213051.GA29991@casper.infradead.org>
References: <20201030144713.201372-1-pbonzini@redhat.com>
 <20201030144713.201372-3-pbonzini@redhat.com>
 <20201113152106.7b4a07ee@lwn.net>
 <20201113223912.GK17076@casper.infradead.org>
 <20201117212452.GM1235237@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117212452.GM1235237@habkost.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 04:24:52PM -0500, Eduardo Habkost wrote:
> On Fri, Nov 13, 2020 at 10:39:12PM +0000, Matthew Wilcox wrote:
> > Better ... can we have a test suite for the regexes and make patches to
> > them include updates to the test suite?  They have clearly passed the
> > point of human understanding ;-)
> 
> Would a simple black box test script like this be desirable?

I think this is fantastic!  Yes please!

Can I add one more test case?

/**
 * radix_tree_lookup_slot - lookup a slot in a radix tree
 * @root:          radix tree root
 * @index:         index key
 *
 * Returns:  the slot corresponding to the position @index in the
 * radix tree @root. This is useful for update-if-exists operations.
 *
 * This function can be called under rcu_read_lock iff the slot is not
 * modified by radix_tree_replace_slot(), otherwise it must be called
 * exclusive from other writers. Any dereference of the slot must be done
 * using radix_tree_deref_slot().
 */
void __rcu **radix_tree_lookup_slot(const struct radix_tree_root *root,
                                unsigned long index)
{ }

(we used to have a problem with multiple '*' in the return type, and
we've also had problems with adornments like __rcu)

