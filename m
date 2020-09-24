Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F00276EB7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 12:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgIXK2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 06:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbgIXK2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 06:28:35 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BF3C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 03:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aXpwPr11MPhd3XZ7JuIbfl5lJouU8jwcHCIWXQAJv38=; b=MUT67gQA83FMmsdvm/INbwTJbX
        cm+mj+YCfR2XZDuy/kzeKSBzx29zskDlefSCrm0ZZ/XdVXWzSYRGCCCHo78b4LJo9IvXxm/BB3VOW
        ORXE9B2ZFN1VMbTmJX/Y+Yza5feKbjtYLjr0LAfNAdcqy7l6LlTlxN3FOlPQ7eIcZk575gSoGqcMh
        cz5c5X5b+WT4sbXjc7UGFV0EJtLqySAJfy5C1nUikHaz/pN3gYQEhQVBGZXtpFI/uIW+5+iQ579gU
        HW/IN0PcMC8sk9J5Emj85j+6rZAc9dLVGeXkpKQNexDy2WCpl5lXNQ0tqvpW3IleNzzphR2f77ImO
        VtB+ozzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLOUE-0004nj-DT; Thu, 24 Sep 2020 10:28:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A9643007CD;
        Thu, 24 Sep 2020 12:28:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3EBCD202A40A3; Thu, 24 Sep 2020 12:28:22 +0200 (CEST)
Date:   Thu, 24 Sep 2020 12:28:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/irq: Use printk_deferred() on raw_spin_lock()
 protected sections
Message-ID: <20200924102822.GA2628@hirez.programming.kicks-ass.net>
References: <e68888438cec9a1da53aaa1647720ade638d6ad4.1600705105.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e68888438cec9a1da53aaa1647720ade638d6ad4.1600705105.git.bristot@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 06:22:12PM +0200, Daniel Bristot de Oliveira wrote:
> While testing hotplug I got this BUG:

> 
> It was caused by printk() inside a code section protected by a
> raw_spin_lock() that ended up calling a serial console that
> uses a regular spin_lock().
> 
> Use the printk_deferred() to avoid calling the serial console
> in a raw_spin_lock() protected section.

I consider printk_deferred() to be a bug, can't we just wait for the new
printk implementation to land so we don't need all this nonsense?
