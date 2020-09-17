Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD2F26DF9E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 17:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgIQP1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 11:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgIQPZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:25:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5F1C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0E1nBfTCTThpxoXia4dttriCoGxK8LXuWWVjqYQOOus=; b=wBhVIgTg/IPNFaqOfy71TTH/wK
        jOiMEWMkCZyyEB4flL/P/uVlfcV2/SmaJagZtVHFn/0qsQkL5sX1ov1UQKb3m774i6ACb/yYqt8oX
        +UHYrVIChiGqVfdXP3UAoPkiMS2Qgf7Jd+hDXSSqdbepEk3LT5PAIz0r+yiawj7QZ0DNjNbYmGv3y
        qSkyjnHyd79/21ict28OSCcJ6hSFabDFG80IhzEhE1GnfPiTqs6D7+5hE6c9NEFbuhtrR6+I682PM
        dMD14z/lhfo4YbJqE3/KM5SKXiP6xTvOhypfnfHGoBH7VxyQvBjlU4AvjuyA5FqPtC5FvqfMKHXBP
        bdd7sCxw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIvmg-0002V9-VH; Thu, 17 Sep 2020 15:25:19 +0000
Date:   Thu, 17 Sep 2020 16:25:18 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     liush <liush@allwinnertech.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org,
        peterx@redhat.com, walken@google.com, daniel.m.jordan@oracle.com,
        vbabka@suse.cz, rppt@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: fix pfn_to_virt err in do_page_fault().
Message-ID: <20200917152518.GA8930@infradead.org>
References: <1600327549-3995-1-git-send-email-liush@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600327549-3995-1-git-send-email-liush@allwinnertech.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 03:25:49PM +0800, liush wrote:
> The argument to pfn_to_virt() should be pfn not the value of CSR_SATP.
> 
> Signed-off-by: liush <liush@allwinnertech.com>
> ---
>  arch/riscv/mm/fault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 716d64e..9b4e088 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -212,7 +212,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>  		 * of a task switch.
>  		 */
>  		index = pgd_index(addr);
> -		pgd = (pgd_t *)pfn_to_virt(csr_read(CSR_SATP)) + index;
> +		pgd = (pgd_t *)pfn_to_virt(csr_read(CSR_SATP) & SATP_PPN) + index;

This adds a crazy long line.  One nice way to clean this up would be to
add a local pfn variable, as it would also make the code more readable.
