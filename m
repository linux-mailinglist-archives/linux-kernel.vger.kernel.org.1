Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC541A8474
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391345AbgDNQQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390547AbgDNQQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:16:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD65C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r8fDQKggXKxqP/PULk16XmyAUlc/RU4HQ2YTQKZ3Wuw=; b=lWJKpyVsLnE+APPi6xA1HuX0CI
        fteOch0wMZnrqVUoewWwfdpujygcw0fietYLplQN55DLyduy4e2MXF2swkeuhXKbZAwzqg3Z1WWEm
        SXAI96rSiBoXD/hWJmgsbnjyryUAGnFBz867ne/k+zQWKGwcysZRP1RbVeIFMKHgZTuRmRDhdNZBS
        65IJLFhqaAthdcQTjuyTQsazgumm4poc4VI1OL9KpRpFe3rudyAWWp8mgbo/+sdItYfllVhfdKF2r
        g9kyfhO3TjjUaAlxJYiAs7MBA9gPZuiU2uY3msY1cYRZHtM5bkYuFFne+2mSAzIcyN2TxlnkZWGO9
        3QwHmefA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOOEp-0000my-OM; Tue, 14 Apr 2020 16:16:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E534F304D58;
        Tue, 14 Apr 2020 18:16:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D47E72B22FBEF; Tue, 14 Apr 2020 18:16:36 +0200 (CEST)
Date:   Tue, 14 Apr 2020 18:16:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH V3 5/9] objtool: Add return address unwind hints
Message-ID: <20200414161636.GP20713@hirez.programming.kicks-ass.net>
References: <20200414103618.12657-1-alexandre.chartre@oracle.com>
 <20200414103618.12657-6-alexandre.chartre@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414103618.12657-6-alexandre.chartre@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 12:36:14PM +0200, Alexandre Chartre wrote:
> Add the UNWIND_HINT_RADDR_DELETE and UNWIND_HINT_RADDR_ALTER unwind
> hint macros to flag instructions which remove or modify return
> addresses.

I'm confused by this thing; why? AFAICT the rest of the patches are
actually simpler without this one.
