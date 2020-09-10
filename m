Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC35264545
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 13:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbgIJLSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 07:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730295AbgIJLNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 07:13:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5738C061757;
        Thu, 10 Sep 2020 04:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s+ol+PXubNrmJOSYnY96WBz+SWC8FNGcvNY7shjniI8=; b=cIB5Z/m36eTnnu3QrGnKe3a0PA
        WRTWVFl1aVcQY+DUURUIB7nMKIML+LXd0yZVK+1A9h4c56740wxJ1uF3EamahmblovoT/8gOBlbUY
        skVQoaV5sjFuWMbzfU7FyXUBNp1XzUGOFXr93zptKZ/XQ2mJcz/17PS2WPVOlJVzpyjz7RgO5T2Vt
        0WjUDtRC+OfNBIXqiGBi8qlhHgSHyFb/VCNjSIjtvP3qJH0T0+GVuhi7ScW3j9XBuUaMADhEj4ntk
        oymZAI65/UXqu5Gzjco69deKaKmE+jqqkHdOFJhvT70jvLnP1R13/gnISnUYrqaikl/7DvbH+eRTr
        T6JV4zCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGKW2-00038W-5P; Thu, 10 Sep 2020 11:13:22 +0000
Date:   Thu, 10 Sep 2020 12:13:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/14] XArray: docs: add missing kernel-doc parameters
 for xas_split_alloc()
Message-ID: <20200910111322.GQ6583@casper.infradead.org>
References: <cover.1599732764.git.mchehab+huawei@kernel.org>
 <17aed0aeb9dad9ad3a1ca97da11bec16a6283f3c.1599732764.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17aed0aeb9dad9ad3a1ca97da11bec16a6283f3c.1599732764.git.mchehab+huawei@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 12:23:56PM +0200, Mauro Carvalho Chehab wrote:
>  /**
> - * Allocate memory for splitting an entry of @order size into the order
> - * stored in the @xas.
> + * xas_split_alloc() - Allocate memory for splitting an entry of
> + *		       @order size into the order stored in the @xas.
> + *
> + * @xas: is the 'xarray operation state'.  It may be either a pointer to
> + * an xa_state, or an xa_state stored on the stack.  This is an unfortunate
> + * ambiguity.
> + * @entry: refers to something stored in a slot in the xarray
> + * @order: size of each entry
> + * @gfp: GFP allocation flags
>   */

No.  I'll do this properly.  Sorry for forgetting to document the arguments.

>  void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
>  		gfp_t gfp)
> -- 
> 2.26.2
> 
