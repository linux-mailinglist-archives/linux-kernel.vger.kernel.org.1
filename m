Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440CD2F9F72
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390474AbhARMXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391196AbhARMW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:22:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DC6C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 04:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=icRNAkK0szBBjqq/5Vje/Fh2SCFts7ZENzZRRvbWGz8=; b=tbic5vIrHaPdWR83ygRvHMuxWa
        z0VUx/9IC9FnTQzv0B8OJ9vsmvMWn28fj7RyGYAeAsHr5UYpvbJmwkm21MgzIGrxXhrCUGWJpUaKq
        Aa6Ehl2Z/l2h+r61EHVdetB6eh44sPxCC1705IukbuvbBYgHZBZBKdGbmMgqnPPxyDNDiMfRgTvoq
        OoZVqpRJVOhHDfWWTmZe6Ju9dRN+I4/SKdCEBsTE82KMmxheZCc4GtmA1M6cQPQzC+8iRXAjP26nO
        Gc9moMo4MpUub6s4aCjdK7rcypZS6aAwL092JcI5+wwWPTP0My0lkWQ+z26EdrAw2VAOG3kUJwbs/
        PE5LuESg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l1TXK-00CnRY-L3; Mon, 18 Jan 2021 12:21:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 33C1D30015A;
        Mon, 18 Jan 2021 13:21:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B79220290D25; Mon, 18 Jan 2021 13:21:32 +0100 (CET)
Date:   Mon, 18 Jan 2021 13:21:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/4] x86/fpu: Add kernel_fpu_begin_mask() to selectively
 initialize state
Message-ID: <YAV9TBMZ+Xs9ielC@hirez.programming.kicks-ass.net>
References: <cover.1610950681.git.luto@kernel.org>
 <a9630f17c5bcafbfe297a0828c7b6c78b0f6dcbe.1610950681.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9630f17c5bcafbfe297a0828c7b6c78b0f6dcbe.1610950681.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 10:20:38PM -0800, Andy Lutomirski wrote:

>  - Code that wants MMX doesn't want need MXCSR or FCW initialized.
>    _mmx_memcpy(), for example, can run before CR4.OSFXSR gets set, and
>    initializing MXCSR will fail.

> +#define KFPU_MMX	0		/* nothing gets initialized */

This... why is that correct?
