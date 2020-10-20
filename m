Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719972932DE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgJTBvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729517AbgJTBvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:51:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0959C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=deZ6MQ1ACm1OG02gHv7CUcKCaufo+WF1ZYsYaen5WBI=; b=PFH7AH56gGVjlApycfaHmIORAh
        NsK9iwsByIJbd8+2rdz6u8SxeeGAhURUpwEWtvZZtuoJ0Tq5/uquhoVTfNbC/pJ2ScVL5PuFz7gAJ
        Ayud07CO10puOr7MSG+JkMnw0HEctdKN1+JYpW/rOZTT21Cs/UtszqzFpcOmJDZ2ewLqlc80vZM/9
        iOhzmFWPSugUPA9UF4eoPyOGoExe4RwFNTMauIOe34I2sAW3P7HDnjGL67OTVtg9/PySNubyisFSQ
        ZqzG3i1S9AOXVA+hquYNYXmt5Kpryxqj3yfBKqIXTo1hVbOFf8F7ehhp8CtQeycHbDrFRu2pwK3dE
        HtqT2u7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUgnz-0003AP-LQ; Tue, 20 Oct 2020 01:51:15 +0000
Date:   Tue, 20 Oct 2020 02:51:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        anton.ivanov@cambridgegreys.com
Subject: Re: [PATCH] um: Call pgtable_pmd_page_dtor() in __pmd_free_tlb()
Message-ID: <20201020015115.GX20115@casper.infradead.org>
References: <20201019211049.22524-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019211049.22524-1-richard@nod.at>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 11:10:49PM +0200, Richard Weinberger wrote:
> Commit b2b29d6d0119 ("mm: account PMD tables like PTE tables") uncovered
> a bug in uml, we forgot to call the destructor.
> While we are here, give x a sane name.
> 
> Reported-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Co-developed-by: Matthew Wilcox <willy@infradead.org>

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> Signed-off-by: Richard Weinberger <richard@nod.at>

And as a bonus, $ grep PageTables /proc/meminfo 
PageTables:       128720 kB

gets more accurate!
