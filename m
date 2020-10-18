Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52402917DC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 16:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgJROZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 10:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgJROZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 10:25:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DCFC061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 07:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iyUXgLDRMr3vwQo92a8pwTwL+g8y/sgJT1e4TYXDgiU=; b=cwKCt4fLPMzqz3ptSnye/nAMPq
        d/lDE7hvPO8lXT1ZeoI85Bm02XYaST6Plsh6sTBdL4geu+7ytQGJvO99RmXEKIxkyQ0+dL3WQbak0
        Ax6ppsjAu+mg25Bye5KMgpKrjJ3DaZ9mvBHCdYxDC4vrt8KesW9ZJ9pjWdclAtm+y9LpjK1jwwdtr
        SPgIa73LStoYF9xW3T9Do7qGIqyUm5s53aRTjRWWBBpyPRDQCZtGq0qWSaa1xtJhrAOlLFmV4mWzp
        gRqkTWSqv1fLLnVWcV1Kv2ND4e9JPAtLQSz9/0KSf866C9zGZX68BQhIiVenAuiMpSi4HsO25FSEx
        x2rq9cQA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kU9cS-00044P-5I; Sun, 18 Oct 2020 14:25:08 +0000
Date:   Sun, 18 Oct 2020 15:25:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/test_free_pages: Add basic progress indicators
Message-ID: <20201018142508.GJ20115@casper.infradead.org>
References: <20201018140445.20972-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201018140445.20972-1-geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 18, 2020 at 04:04:45PM +0200, Geert Uytterhoeven wrote:
> The test module to check that free_pages() does not leak memory does not
> provide any feedback whatsoever its state or progress, but may take some
> time on slow machines.  Add the printing of messages upon starting each
> phase of the test, and upon completion.

It's not supposed to take a long time.  Can you crank down that 1000 *
1000 to something more appropriate?

