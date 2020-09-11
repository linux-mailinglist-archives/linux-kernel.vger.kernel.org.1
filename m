Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4E7265CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 11:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgIKJrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 05:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgIKJrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:47:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD122C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 02:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L3X8xRwkx+bS9wefHd4PLR1ppf5H6eLchw4L2TMwyQA=; b=EJGNAKBUZsRB1/eNTBiS6GHF89
        i7d/sB0L79tFvN/qw1F20qwktKYNnfU3hAJtUz3hHMKDbmrCIZnDK6xfh80ZXOipJSNQwiXAAczsZ
        ytlLq5W+TYJALVw7PtSccUiZ1czYzviuuWz7CmFm3NyQg+EPpanzeiUvsNLQA0l11Y9LCHsM8qtjK
        IRhyI8ipp96ycmM1jtWFtTnvp7HpN4IsFB/XpuBTrN9kYwX7l6anEFi4+YpWxnlw0uVs2s5AxP5HO
        533SKecBTDOr8kE88HCxX8bWCeNN5wqkMi1g3+lvCQjFXvKwHhK26B8wPNuIy5xSO2WNA1H01o0P3
        ByLJ3qUg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGfe9-0003yx-2r; Fri, 11 Sep 2020 09:47:09 +0000
Date:   Fri, 11 Sep 2020 10:47:09 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Bean Huo <huobean@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, beanhuo@micron.com,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH RFC] mm: Let readahead submit larger batches of pages in
 case of ra->ra_pages == 0
Message-ID: <20200911094709.GB14158@infradead.org>
References: <20200904144807.31810-1-huobean@gmail.com>
 <20200904110938.d9a2cb53a58e67a15c960f47@linux-foundation.org>
 <ef82be594709a8f954f4933968bd96888e589df3.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef82be594709a8f954f4933968bd96888e589df3.camel@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 10:15:24AM +0200, Bean Huo wrote:
> > What is special about ->ra_pages==0?  Wouldn't this optimization
> > still
> > be valid if ->ra_pages==2?
> > 
> > Doesn't this defeat the purpose of having ->ra_pages==0?
> 
> 
> Hi Andrew
> Sorry, I am still not quite understanding your above three questions. 
> 
> Based on my shallow understanding, ra_pages is associated with
> read_ahead_kb. Seems ra_pages controls the maximum read-ahead window
> size, but it doesn't work when the requested size exceeds ra_pages. 
> 
> If I set the read_ahead_kb to 0, also, as Christoph mentioned, MTD
> forcibly sets ra_pages to 0.  I think the intention is that only wants
> to disable read-ahead, however, doesn't want
> generic_file_buffered_read() to split the request and read data with
> 4KB chunk size separately.

They way I understood Richard this is intentional.
