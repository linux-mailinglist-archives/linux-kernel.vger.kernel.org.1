Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42022E0126
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 20:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgLUTjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 14:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgLUTjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 14:39:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7EBC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 11:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VVCXpUDKZzGEDshlIyWXlUHpNYdWbBRAq78poeXofdI=; b=r55bTdXZTH/mflDLxLGDJb+Akq
        RVIBwYOVRIn/jX0IkKB03d7pc0hJWequR/Zce6oQnMCWVpZgDqYsrcpDJhkQSWegzWM3CDI2StLxT
        5acwwkkImKnRZlWYjNIcHSDNFFUehQactmtg10HehbMW+yb3lt2ZGvQIkEv456kV96lb/V3iyG0+b
        ZwWmiy5tXDfrwaCaHSMTd1BEUmXzG98xKoubfv6HORCzXzayV/Atib8AnshInmlrMg6SWOXtDFfmW
        /fx9VrpP7miJOBRoruURjbUKA5WWmQGkx2yf0wjoc46uHw68Qm7Rij2jSaTExddYkKvS6XT6YeY7k
        +VaxImhA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krR0f-0005GV-FL; Mon, 21 Dec 2020 19:38:21 +0000
Date:   Mon, 21 Dec 2020 19:38:21 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] mm/hugetlb: change hugetlb_reserve_pages() to type
 bool
Message-ID: <20201221193821.GF874@casper.infradead.org>
References: <20201221192542.15732-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221192542.15732-1-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 11:25:41AM -0800, Mike Kravetz wrote:
> While reviewing a bug in hugetlb_reserve_pages, it was noticed that all
> callers ignore the return value.  Any failure is considered an ENOMEM
> error by the callers.
> 
> Change the function to be of type bool.  The function will return true
> if the reservation was successful, false otherwise.  Callers currently
> assume a zero return code indicates success.  Change the callers to look
> for true to indicate success.  No functional change, only code cleanup.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
