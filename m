Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88708293649
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 09:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgJTH4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 03:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgJTH4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:56:30 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C26C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 00:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/NecXBjeItf4pRKclRu3K3LlnUd4CLn2RBUj+pJiUCw=; b=M3bKZtd3aL3NmgAY+z2EyVfsX2
        dlJ75pNrhquhpwNaCWWHIIdz3eHI/HWGGTfZh/C8P1VWTtB4gKlfoKxFm74gCwUnjU4AehVAdJc5o
        wtOsyHjdXMJ9lTNAbbjRKgZqWCx3GW/YNTIIDse3kpj1JCubRXTQhQKcxxB1B4PpQ/FrGdB5rjJRW
        sw3a+UHYiSZvn2EFCIfT5+tvGZgnj1AaRPGM9ur7+D/xgf9sdxzSq8+k7WP3NEtEeu07VuN1Vl7af
        vjnHBoLUkKQ/mPSYF0COLlidDZVaElD7pR/6XVrPEqc//gLUFPJAiTTnbbazG3tCFtsQGANjdeux+
        9jyPjPeg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUmVE-0004CG-7I; Tue, 20 Oct 2020 07:56:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 68F513012C3;
        Tue, 20 Oct 2020 09:56:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4EA8A2038FA06; Tue, 20 Oct 2020 09:56:14 +0200 (CEST)
Date:   Tue, 20 Oct 2020 09:56:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tao Zhou <ouwen210@hotmail.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org
Subject: Re: [PATCH v3 10/19] sched: Fix migrate_disable() vs
 set_cpus_allowed_ptr()
Message-ID: <20201020075614.GO2628@hirez.programming.kicks-ass.net>
References: <20201015110532.738127234@infradead.org>
 <20201015110923.910090294@infradead.org>
 <jhjlfg6qqum.mognet@arm.com>
 <BN8PR12MB29784D239007D0D6CA3F4F2A9A010@BN8PR12MB2978.namprd12.prod.outlook.com>
 <jhjimb7r0r5.mognet@arm.com>
 <BN8PR12MB2978F76887133CCA2102B7589A1E0@BN8PR12MB2978.namprd12.prod.outlook.com>
 <jhjblgyqfsf.mognet@arm.com>
 <BN8PR12MB2978D36FF4A81C344DCF37FD9A1F0@BN8PR12MB2978.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR12MB2978D36FF4A81C344DCF37FD9A1F0@BN8PR12MB2978.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


FYI Tao, I shared this with Valentin on IRC yesterday evening (we're
both in Europe):

  https://paste.debian.net/1167885/

I'll be going over it again this morning with a (hopefully) fresh(er) mind.
