Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5068B1F9FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 21:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbgFOTJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 15:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgFOTJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 15:09:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD42C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 12:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fqlg5vRi2+I+nrKU5A1wOWFzOs9FiP4c5PxmnzSYwA0=; b=gXa24hOmL3f4ENeQJul7Im5dEd
        w7ctb4wDsGweOpZvIkVt8UvddTn4QcOA8/Sq//DDvayT1tkNGm6cF7n7/TzqHktPh2J0tgKLu6mOZ
        sbQbVBqNpdagwsYXsG2pjFVVtclpy2gMGNcJJJ5UPhfC8hXm5fNDDQZG+4AvT3DidPZhREqrSPGJd
        FBGtX6NRwXmzIsq8pBkneXn34UhoJgnkgjV5aFRDKULI0jwRw6c8AxD24ev/a3M0W9v15SJdQqRu4
        gpAeiRnnH8kpDrKovMLILqON2rdxli7WzLoqN7h8KA+3tq6fotpaiNU8ucXkXoItZyFtOwFOuv7hd
        P4sIex2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkuU7-0003Gj-L4; Mon, 15 Jun 2020 19:09:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E7166301A32;
        Mon, 15 Jun 2020 21:09:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D1EA4201CB844; Mon, 15 Jun 2020 21:09:28 +0200 (CEST)
Date:   Mon, 15 Jun 2020 21:09:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org,
        amd-gfx <amd-gfx@lists.freedesktop.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Message-ID: <20200615190928.GJ2531@hirez.programming.kicks-ass.net>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-13-git-send-email-fenghua.yu@intel.com>
 <20200615075649.GK2497@hirez.programming.kicks-ass.net>
 <20200615154854.GB13792@romley-ivt3.sc.intel.com>
 <20200615160357.GA2531@hirez.programming.kicks-ass.net>
 <20200615181259.GC13792@romley-ivt3.sc.intel.com>
 <20200615183116.GD2531@hirez.programming.kicks-ass.net>
 <20200615185529.GD13792@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615185529.GD13792@romley-ivt3.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 11:55:29AM -0700, Fenghua Yu wrote:

> Or do you suggest to add a random new flag in struct thread_info instead
> of a TIF flag?

Why thread_info? What's wrong with something simple like the below. It
takes a bit from the 'strictly current' flags word.


diff --git a/include/linux/sched.h b/include/linux/sched.h
index b62e6aaf28f0..fca830b97055 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -801,6 +801,9 @@ struct task_struct {
 	/* Stalled due to lack of memory */
 	unsigned			in_memstall:1;
 #endif
+#ifdef CONFIG_PCI_PASID
+	unsigned			has_valid_pasid:1;
+#endif
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 142b23645d82..10b3891be99e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -955,6 +955,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->use_memdelay = 0;
 #endif
 
+#ifdef CONFIG_PCI_PASID
+	tsk->has_valid_pasid = 0;
+#endif
+
 #ifdef CONFIG_MEMCG
 	tsk->active_memcg = NULL;
 #endif
