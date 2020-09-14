Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D4126895C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 12:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgINKdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 06:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgINKdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 06:33:31 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D8CC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 03:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TU5zZhB8fC42cKDJtk6qME9CpbP+U36jT8Vx/ygRImA=; b=c6FCZBFf9bSk5qpIPRLLRLbtIn
        xMEnduPrvKln+UHp+1ejW/kTvqy6I4NGkbTbMW6AbRJ4zIw7n6oVTWDDLR9ieK1V2fao+ec9py9mH
        WB0o9X0uLp3EVZguHnK2csqLtCOYm5+tDeFwpeKY97SEaY1rHwWBtutMf8oEoZImTQPdBfml7lpbK
        FkMK1/0VZtDH48zO7LmzJxmTo66yNN5d4fLuiEi8oVbfgIZTnapuKqzZL3WFy0p5zvNFdu4LC8Hkm
        c0856BolDMR+TyNm9ojdreUivM3L8c8VjoC3auLluzXiwfCFqCe1wyF7RN+Oj81KBfnVO1vNWIkmP
        EB1ZiEig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHlnV-0007Yt-8N; Mon, 14 Sep 2020 10:33:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 36F463050F0;
        Mon, 14 Sep 2020 12:33:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B49B2C47815F; Mon, 14 Sep 2020 12:33:19 +0200 (CEST)
Date:   Mon, 14 Sep 2020 12:33:19 +0200
From:   peterz@infradead.org
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, hpa@zytor.com, bp@alien8.de,
        rric@kernel.org, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 1/6] x86: events: Avoid TIF_IA32 when checking 64bit mode
Message-ID: <20200914103319.GO1362448@hirez.programming.kicks-ass.net>
References: <20200912070553.330622-1-krisman@collabora.com>
 <20200912070553.330622-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912070553.330622-2-krisman@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 12, 2020 at 03:05:48AM -0400, Gabriel Krisman Bertazi wrote:
> In preparation to remove TIF_IA32, stop using it in perf events code.
> 
> Tested by running perf on 32-bit, 64-bit and x32 applications.
> 
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
