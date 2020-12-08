Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DD12D33AC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbgLHUWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729155AbgLHUWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:22:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C16C0611E4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 12:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W4AcrJtK6ICPNnI9vxGdOXKaQfpdPFgiK/5X2s/GKpg=; b=t9hBCTQ2gC/cRAtFkNGRk31Vi4
        tTprtULfcvVf09Oo09i9f4IhgMb/wi22GAhoV0VzXZE9tDfP4156Jx1modMqflxZ+APrZ/Ki+qg7r
        sId93W28FV0yJZULRzA4UDBCALkDmaY6aLX+CFoUkZNObTGf7wRrqnfict4a60hjoxp9mRn4vpvgR
        Pn3l6oF7aO8gOiyFMsChRZiSMoFsgPdietSQhmoVGucDf6gYaM1paDmhiHOXrrvEPzC4CqzFbkkmS
        seK1fbTbhQp+sCU5BkVoZyssBC6KJR/FlNFXpZrQGrMmfYBhHDUx+D4xJ7Wg3cybQkBW2bwUc6j4G
        Tk9M3cuw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmi94-00029L-8d; Tue, 08 Dec 2020 18:55:30 +0000
Date:   Tue, 8 Dec 2020 18:55:30 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] mm/hugetlb: clear compound_nr before freeing
 gigantic pages
Message-ID: <20201208185530.GJ7338@casper.infradead.org>
References: <20201208182813.66391-1-gerald.schaefer@linux.ibm.com>
 <20201208182813.66391-2-gerald.schaefer@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208182813.66391-2-gerald.schaefer@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 07:28:13PM +0100, Gerald Schaefer wrote:
> This is because only the compound_order is cleared in
> destroy_compound_gigantic_page(), and compound_nr is set to 1U << order == 1
> for order 0 in set_compound_order(page, 0).

I didn't realise there was a separate destroy path for gigantic pages.
Thanks for catching and fixing this.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

