Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BAF25F3BC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 09:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgIGHQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 03:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgIGHQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:16:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48330C061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 00:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=We0sSC8v6x+i+H5IB1utCVAHV7Fxl84IsWXy46L4uYM=; b=Pbd+9xsTy+ypaF0EJnxn5xkUQI
        Yvh3apado2jso0FhuR30M6SQ4zcmbr72gGJ4DEJVQ0Ul+Hr8xAHblV6jt99emldM+nvwqJ+8NDcic
        Rf+H9ENRjqUsaC42EJVEbjLKwz7t4QsCuAdrbke0d7m9WgZioZBI8sa3asTgdUd/G3f4HHWO00FWe
        8RrfC2kzuN+ST7YxHifWYgkB4K+uMzRMK9NYEjoDZFOAiq0I9rR4xkhD80o9EFME1MVIvS4MKLdPC
        eBsvfA9l9bKSVDkKmqNIlWMafghDJstAf5B8s71F2aIstErhESfdxAjYgpVju5F3FAhRt9oBANIXy
        LP9xlhRw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFBNz-0007Zm-RE; Mon, 07 Sep 2020 07:16:19 +0000
Date:   Mon, 7 Sep 2020 08:16:19 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Bean Huo <huobean@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, beanhuo@micron.com,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH RFC] mm: Let readahead submit larger batches of pages in
 case of ra->ra_pages == 0
Message-ID: <20200907071619.GA28569@infradead.org>
References: <20200904144807.31810-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904144807.31810-1-huobean@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 04:48:07PM +0200, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> Current generic_file_buffered_read() will break up the larger batches of pages
> and read data in single page length in case of ra->ra_pages == 0. This patch is
> to allow it to pass the batches of pages down to the device if the supported
> maximum IO size >= the requested size.

At least ubifs and mtd seem to force ra_pages = 0 to disable read-ahead
entirely, so this seems intentional.
