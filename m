Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB0C2CA5E9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391631AbgLAOkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:40:00 -0500
Received: from mail.efficios.com ([167.114.26.124]:49162 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389462AbgLAOj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:39:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E8AF724A203;
        Tue,  1 Dec 2020 09:39:18 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fiOIHKj3Q1ju; Tue,  1 Dec 2020 09:39:18 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9CF5E249FE7;
        Tue,  1 Dec 2020 09:39:18 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9CF5E249FE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1606833558;
        bh=jQeiv0iNOrHBNjsFdgWBlUQqBIRtEj0NVZFIKRGxHwE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=AyDat0Cu20v5G+96ucQyTP3ZKx3VFDimRSA15HUoMB9/wwdj1UiJC7SPzsNYLzpHz
         ErWDGcNMkNDaRTBV5b0d/7oLGm96Q7GNVwkrOu9dC5gxuK2YnAdNm4HRlbnd43Nddb
         4q9rAX859A1sd6ZmGr4aZLzYzLKTtZbEKX0cpabOPgFVWJO1oOzJq4WP4FJxNZVbO3
         kFacZ5LPj7oTQmA4QOCMUCjn16PAmq5sFq0bb3AxmDKDAzXfuP1IBH76/KHlMghmho
         hJHFscFVIi/job3M8T8Hr7yERdIBGAYZM2KvxZH99yhjFVQfmTB2cytSu+kwxEm08h
         l+30RsAq5wcLA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PgweP0lwY3-5; Tue,  1 Dec 2020 09:39:18 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 918C5249FE6;
        Tue,  1 Dec 2020 09:39:18 -0500 (EST)
Date:   Tue, 1 Dec 2020 09:39:18 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anton Blanchard <anton@ozlabs.org>
Message-ID: <1261102549.69322.1606833558510.JavaMail.zimbra@efficios.com>
In-Reply-To: <9b8ecd9a017960c9e56ef3f3e733f32aa1194366.1606758530.git.luto@kernel.org>
References: <cover.1606758530.git.luto@kernel.org> <9b8ecd9a017960c9e56ef3f3e733f32aa1194366.1606758530.git.luto@kernel.org>
Subject: Re: [PATCH 1/3] x86/membarrier: Get rid of a dubious optimization
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3975 (ZimbraWebClient - FF83 (Linux)/8.8.15_GA_3975)
Thread-Topic: x86/membarrier: Get rid of a dubious optimization
Thread-Index: wAGaXecJPCqZ4duYmAECrI9Dg3cfkg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Nov 30, 2020, at 12:50 PM, Andy Lutomirski luto@kernel.org wrote:
[...]
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 11666ba19b62..dabe683ab076 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -474,8 +474,10 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct
> mm_struct *next,
> 	/*
> 	 * The membarrier system call requires a full memory barrier and
> 	 * core serialization before returning to user-space, after
> -	 * storing to rq->curr. Writing to CR3 provides that full
> -	 * memory barrier and core serializing instruction.
> +	 * storing to rq->curr, when changing mm.  This is because membarrier()
> +	 * sends IPIs to all CPUs that are in the target mm, but another
> +	 * CPU switch to the target mm in the mean time.

The sentence "This is because membarrier() sends IPIs to all CPUs that are in
the target mm, but another CPU switch to the target mm in the mean time." seems
rather unclear. Could be clarified with e.g.:

"This is because membarrier() sends IPIs to all CPUs that are in the target mm
to make them issue memory barriers. However, if another CPU switches to/from the
target mm concurrently with membarrier(), it can cause that CPU not to receive the
IPI when it really should issue a memory barrier."

For the rest of this patch:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
