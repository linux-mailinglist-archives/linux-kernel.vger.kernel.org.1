Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05FB2BAC18
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 15:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgKTOmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 09:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgKTOml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 09:42:41 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A51FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 06:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jVVtcjI2KBzyw6L6PWdDe5VqbWBRupAvsWfUE9BVLRQ=; b=c4dNfBjhdRiFc0MXiW7Q7KwEcp
        Vb1AWraq53XJErBgB5B1BVl/IMPDEptQa88U/6eboiqIMd/+mGXe8DLRdBbeTqN0STFv85sjyKkzz
        Pw7wUyFbbz6H23bwkNoLbxB2i9csNsy3wHy1IYyUV62oRwwK09Sm3RuOUwo4QWeFOk6wGSzSHPVTd
        glHPCArEDg9TIhJE/uQmJNCc9AHykIxIUSOaSifUC4e04oGc08oF7mxlo8VmtUafxBK/Uh4lNOlkv
        yba881xfF6CeqyFI6vWvcQi/DuJ3i+CB4ple9ppR6iWy8h8msc20Tjwo4lgvKY4ET3vDK4KyfMoHj
        ICdeENfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kg7cQ-0005Py-Nj; Fri, 20 Nov 2020 14:42:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 095BF305C16;
        Fri, 20 Nov 2020 15:42:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E9CCC201B4C4C; Fri, 20 Nov 2020 15:42:32 +0100 (CET)
Date:   Fri, 20 Nov 2020 15:42:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH 5/5] locking/rwsem: Remove reader optimistic spinning
Message-ID: <20201120144232.GE3040@hirez.programming.kicks-ass.net>
References: <20201118030429.23017-1-longman@redhat.com>
 <20201118030429.23017-6-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118030429.23017-6-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 10:04:29PM -0500, Waiman Long wrote:
> -static inline bool osq_is_empty(struct rw_semaphore *sem)
> -{
> -	return !osq_is_locked(&sem->osq);

> -static inline bool osq_is_empty(sem)
> -{
> -	return false;
> -}

Oh, it doesn't live...
