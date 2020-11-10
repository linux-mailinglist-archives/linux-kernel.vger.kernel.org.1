Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4EF2ADE65
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbgKJScr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgKJScp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:32:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2316C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s71PQJ0UzgiTWz5YQZpQUhxr7/w5u3caoT/K4RDIPRw=; b=AIuMRPehUeZ/ksaab33AT0JXnz
        9kPsJQcNZl3yNNhnaxyynjksTTm9RVFLMbjMaLfIvSsFjfE6ksS7zexZ7TF68qnilzkW0KiQ3Q3ph
        NV3DSewBJAE/ted1ZMeZHbbynz9hbTuqHItNZ6NyUZ32iEhQXhH74E3K/TejeIXBS7bxSqm/Kr652
        +7MbPyIrDnFV49hbQxErREOwi9A4WEFh1zLI2itBU1+syY+VgM49pJabCOI7lFUOHmGwn6eNM6JsT
        asxGjvtIou0BGnUwvVivMJUtKogEuyRzpaYmlv8thcn21/UJ2rCu+KmZOZ4LeqYkC9EIMHah68j8u
        LA0ftvXQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcYRa-0002Oe-6v; Tue, 10 Nov 2020 18:32:38 +0000
Date:   Tue, 10 Nov 2020 18:32:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm: unexport follow_pte_pmd
Message-ID: <20201110183238.GL17076@casper.infradead.org>
References: <20201029101432.47011-1-hch@lst.de>
 <20201029101432.47011-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029101432.47011-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 11:14:31AM +0100, Christoph Hellwig wrote:
> follow_pte_pmd is only used by the DAX code, which can't be modular.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
