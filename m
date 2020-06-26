Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1590120B08B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 13:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgFZLbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 07:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgFZLbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 07:31:44 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3A2C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 04:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XqpPxaLgj+8G3qgnOsLPntGf7hGD9ApNPwp5v2TWMCw=; b=09dL5Lpym7OYljru2ezzOlhRNJ
        Xir+2tMqnbUO7AwRhu3Jf0rheheOCJ7WklQ3JfCBQt2j5kBBlagCPVvQ1+yG5BNKcIIswc6StQW+x
        Y3G5z/0Tp8gA9FmdYglEkeK+p3qZOLLWcPYW+caJ3WVSb0OhDKTOk7LWdwysS00La156k6O2MJP+O
        BvsaIBsEe4GaNFkR5vXcPdp0WD1A2NQXptgHk8B06JTiwXsaZAGZKDiySjZJy5HLOtlzXLGpT1pno
        2Ay7JJs51WHiAYqLNNLeqNaikjkTbPGCkLQV9+C0CIE7xRQEKdVLbQVksdY+6n/XEpUVszuo62uir
        jL/euvFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jomZX-0004Va-J5; Fri, 26 Jun 2020 11:31:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC1B530280D;
        Fri, 26 Jun 2020 13:31:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CDAD729C4228B; Fri, 26 Jun 2020 13:31:01 +0200 (CEST)
Date:   Fri, 26 Jun 2020 13:31:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] x86/mm: Pre-allocate p4d/pud pages for vmalloc area
Message-ID: <20200626113101.GG4817@hirez.programming.kicks-ass.net>
References: <20200626093450.27741-1-joro@8bytes.org>
 <20200626110731.GC4817@hirez.programming.kicks-ass.net>
 <20200626111711.GO14101@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626111711.GO14101@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 01:17:11PM +0200, Joerg Roedel wrote:
> On Fri, Jun 26, 2020 at 01:07:31PM +0200, Peter Zijlstra wrote:
> > Can't we now remove arch_sync_kernel_mappings() from this same file?
> 
> Only if we panic on allocation failure.

I think we do that in plenty places already, so sure ;-)
