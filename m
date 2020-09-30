Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4016227E64E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 12:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgI3KNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 06:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgI3KNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:13:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D683C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 03:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W1wURALxMMUQTe3egz5elA9sPppPaX+TnLqDpjm379E=; b=Cx85e2biBURTkq3433QCZ5DZbt
        Ia+DJlE9d+eEynt8AW/ICxfRnUU6u9CYgrfhZU6EU+G4N3ZG3JAP4FORG2I+7AsxQk1XSctUS9pCE
        MT9UbEmVJjHuZvW9S/vfuVVN3xq9DD+tiD6fG4kSmS880bhcZbU2mGa9byq777FO/uFb8soQYHBtG
        23IRLWj8uOlwwIcscoaq1WZtBnsEfZss/89v07ga4N01y2o48feU3V6LkmEotSOj7/X4qK1fpizEj
        /GqGgyeq2KSapI0EX0IsWB4SR1JqVKF1IyZe+no6wgDiRnnVD+VSouxPA6UHxgWJ6ND1eQhmtkfrB
        pzszJKFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNZ6S-00010w-K6; Wed, 30 Sep 2020 10:12:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8DF63302753;
        Wed, 30 Sep 2020 12:12:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 76B0E203C0AA7; Wed, 30 Sep 2020 12:12:51 +0200 (CEST)
Date:   Wed, 30 Sep 2020 12:12:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] objtool and cross compilation
Message-ID: <20200930101251.GX2628@hirez.programming.kicks-ass.net>
References: <cover.thread-e6a24b.your-ad-here.call-01601459756-ext-4914@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.thread-e6a24b.your-ad-here.call-01601459756-ext-4914@work.hours>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 11:58:24AM +0200, Vasily Gorbik wrote:
> This is based on v5.9-rc7, before "other architectures support" patches
> starting pouring in.

Please base on: tip/objtool/core, as is they no longer apply.
