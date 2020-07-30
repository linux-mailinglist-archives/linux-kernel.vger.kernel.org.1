Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC59E233964
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 21:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbgG3T5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 15:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgG3T5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 15:57:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F257C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 12:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/3VtW7SquYEchxQCh33bttrlb5IJlhozRM59vlZwvg0=; b=FEzraYeMg6W36tFFrr6exmwcrN
        CBXWEHS6VzeQD24mfyWNv9nqCaL/fJ6Ft1XQO6/SGSMVwRiCobXoUiH2tOE8dnrSkGO6cM0YgZwxY
        TQH6TxIkHaevjogr/+1CUn7j3HsaeG/pHZ/UeyhqNOgfWRL/uvzs9fP0oSQCfOvmYa2mSsRBx66iv
        3sMWW4t4A99yPFjDNk+zM96aKOY+IZjbEZHgFWQQt0Q1p2iJ6zISXZUCo8geUSvQzYx3uKKU6LpuQ
        bLgQ1IyL+p/hgADLfk/7wR/6DoOI/WXnLfwfNXW+527XEekVOhy99yd08nSl6V/2ZvPnXwEqaLe/L
        oGlrybWA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1Eg6-0005wG-5J; Thu, 30 Jul 2020 19:57:22 +0000
Date:   Thu, 30 Jul 2020 20:57:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH] mm/hugetlb: Fix calculation of
 adjust_range_if_pmd_sharing_possible
Message-ID: <20200730195722.GL23808@casper.infradead.org>
References: <20200730195030.60616-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730195030.60616-1-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 03:50:30PM -0400, Peter Xu wrote:
> +#define MAX(a,b)  (((a)>(b))?(a):(b))
> +#define MIN(a,b)  (((a)<(b))?(a):(b))

What's wrong with max() and min() defined in kernel.h?

