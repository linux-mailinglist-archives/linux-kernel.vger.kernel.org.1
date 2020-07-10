Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8C221BB33
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 18:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgGJQko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 12:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbgGJQko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:40:44 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA85C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5JirCkn89k8MUp/m8kLxMzaZ+LJvaG0MnKjB28N/O94=; b=ot5kVJyl1vabhjzTqsdGWowaoj
        np5/uHrJrIf4kSBsgAaYjWyVAf/d+tchaVuzAtqOEU1oHv8kBCtIKpvZaeFf7T5dXQy+NOh91ATW/
        XBK+C/BygfbealqXa+DibYx3Olo+DXBsfQ713m+rkT4HI+YqFw3OV3R1+xiLMl6MJFeWNpkwDwnre
        7oW9ctN5g1L8GBp9+3eWANV7QTiSVl+qtg9hjxBS/ZENpkg90G02rEK+QvRtW3k8XwyPPtRJYlNHN
        rqSYj6qTwwoLEOOHYhlZVmyxpAan4YxeDk2g+VCAiFkT3CsniYob1xS3VrMpf4TYpMCG4aHdHP2G6
        c/mekBdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtw4n-0004I7-Hf; Fri, 10 Jul 2020 16:40:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BE22B304E03;
        Fri, 10 Jul 2020 18:40:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B2B9D203D2889; Fri, 10 Jul 2020 18:40:37 +0200 (CEST)
Date:   Fri, 10 Jul 2020 18:40:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: user_access_{save,restore}() semantics
Message-ID: <20200710164037.GV597537@hirez.programming.kicks-ass.net>
References: <20200710161527.GA22579@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710161527.GA22579@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 06:15:27PM +0200, Christoph Hellwig wrote:
> Hi Peter,
> 
> can you explain (and maybe document while we're at it) what the
> exact semantics of the user_access_{save,restore} helpers are?
> 
> Reverse engineering from the commit text they seem to be about
> saving the current uaccess state.  But do they also enable/disable
> anything?

user_access_save() is like local_irq_save(), it stores the EFLAGS and
clears AC/IF resp. user_access_restore(), like local_irq_restore(),
simply restores the previously saved EFLAGS.

So for code that had user_access_begin(),
user_access_save()/user_access_restore() will temporarily disable
user-access and allow calling other code.

something like so?

---
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 0a76ddc07d59..c4fadefdb9b2 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -336,7 +336,25 @@ long strnlen_user_nofault(const void __user *unsafe_addr, long count);
 #define unsafe_get_user(x,p,e) unsafe_op_wrap(__get_user(x,p),e)
 #define unsafe_put_user(x,p,e) unsafe_op_wrap(__put_user(x,p),e)
 #define unsafe_copy_to_user(d,s,l,e) unsafe_op_wrap(__copy_to_user(d,s,l),e)
+
+/*
+ * user_access_save(): save current user-access state and disable
+ *
+ * Similar to local_irq_save(), which saves IRQ state and disables
+ * IRQs, exceppt for user-access state.
+ *
+ * Returns a value to be used only by user_access_restore() to
+ * restore the user-access state.
+ */
 static inline unsigned long user_access_save(void) { return 0UL; }
+
+/*
+ * user_access_restore(): restore a previous user-access state
+ * @flags: value obtained from a prevous user_access_save() call
+ *
+ * Similar to local_irq_restore(), which restores a previously saved
+ * IRQ state, except for user-access state.
+ */
 static inline void user_access_restore(unsigned long flags) { }
 #endif
 #ifndef user_write_access_begin
