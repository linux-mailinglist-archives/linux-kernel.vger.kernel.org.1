Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FAE28CEA8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgJMMsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgJMMsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:48:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F62C0613D0;
        Tue, 13 Oct 2020 05:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FboJ3+G/kicVc0kZbCg71uoSul79uUzxGmsY06A9ZF8=; b=VU2bYrqtScjK3juIRJuHzhC4af
        bAJs7sTEhYbDQ06iBgnOKHEKGTCPozaC1DQJGSA6kJDodNP1vpgFS5KMl5GeIHBIhDugLtWZO2HOr
        rkHH8ab7EYYfWn+f8v95DPiCxiFXkK6Ees35xhtMwQ7MgYFLfj2rdPxl3v4nwvsvK7S1alCNvvl87
        eGD125vm+60kraunyKcuUt5kTd9O0UadTdFZH3OdXbcZGpKObnV69aabnbACstuLgTE4sXs6OFfMi
        7eK9gi0x1/dawl7A8QeV3sG8poIhf1wQ2fUFLDBw+htJ7LdsQcaG0EEz7+NXbBfItvNLkmE3UX8jU
        ZbxF1D4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSJih-0007V1-Hg; Tue, 13 Oct 2020 12:48:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D13D3304E03;
        Tue, 13 Oct 2020 14:47:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C51AC2B62B1A7; Tue, 13 Oct 2020 14:47:56 +0200 (CEST)
Date:   Tue, 13 Oct 2020 14:47:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 66/80] locking/refcount: document the new "oldp"
 pointer value
Message-ID: <20201013124756.GT2611@hirez.programming.kicks-ass.net>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
 <b233b8d610fae376472d0ef4e43b256efb69bdfa.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b233b8d610fae376472d0ef4e43b256efb69bdfa.1602589096.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 01:54:21PM +0200, Mauro Carvalho Chehab wrote:
> Changeset a435b9a14356 ("locking/refcount: Provide __refcount API to obtain the old value")
> added a new parameter to most refcount functions, but didn't update
> the kernel-doc markups.

Mindless warning begets mindless patch :/ Please turn on brain while
operating the computer.

> Add a description for it on all touched functions.

It's actively wrong now, the function in the comment is the variant with
__ and they do not have the extra parameter.

> Fixes: a435b9a14356 ("locking/refcount: Provide __refcount API to obtain the old value")

Breaks actual sanity.
