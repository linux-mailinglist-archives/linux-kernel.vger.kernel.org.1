Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F1F1D31CB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 15:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgENNut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 09:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726067AbgENNut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:50:49 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453F6C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 06:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oUb9XRa4HSf+di+9adEfNnhbqfuLOkGDaR9A8N50SmY=; b=iUT7/JziNjm5u+tScAhcV8xfbC
        1z3ZEoVhzeP2ZkB5SCAzzt+S0GOxdUUKKo7K8EherRQ4kR6Ja2j9KrCLu0BlZ4sMl6JxzPtcq9od3
        +qpg+lO2Lq1reJmnkRfJ6SfoS+GP3YRxhjfWZWbMNpllNCb6j8JrGgijxpVvATOLi+flAsPqY6Qc1
        yWU75AUYlRyh/S5kvLZ7QUeAyCjKc19SIHiKRsZHL0zjwdoY2yrjNsMYaQ+uObMhuEjrCVInyBYtz
        XvqvO8MZOa4O7DGQZmGzS/cAOasvl7Uk2nCBwhAYWVT3trNDe41xQmoLI+ozXwgT5y2QW+eTyL2ak
        o6GY8awA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZEFm-0000C0-Ut; Thu, 14 May 2020 13:50:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A7B46301A66;
        Thu, 14 May 2020 15:50:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 944742B852D66; Thu, 14 May 2020 15:50:25 +0200 (CEST)
Date:   Thu, 14 May 2020 15:50:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200514135025.GZ2978@hirez.programming.kicks-ass.net>
References: <20200513124021.GB20278@willie-the-truck>
 <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
 <20200513165008.GA24836@willie-the-truck>
 <CANpmjNN=n59ue06s0MfmRFvKX=WB2NgLgbP6kG_MYCGy2R6PHg@mail.gmail.com>
 <20200513174747.GB24836@willie-the-truck>
 <CANpmjNNOpJk0tprXKB_deiNAv_UmmORf1-2uajLhnLWQQ1hvoA@mail.gmail.com>
 <20200513212520.GC28594@willie-the-truck>
 <CANpmjNOAi2K6knC9OFUGjpMo-rvtLDzKMb==J=vTRkmaWctFaQ@mail.gmail.com>
 <20200514110537.GC4280@willie-the-truck>
 <CANpmjNMTsY_8241bS7=XAfqvZHFLrVEkv_uM4aDUWE_kh3Rvbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMTsY_8241bS7=XAfqvZHFLrVEkv_uM4aDUWE_kh3Rvbw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 03:35:58PM +0200, Marco Elver wrote:
>   4. __no_kcsan functions should never be spuriously inlined into
> instrumented functions, causing the accesses of the __no_kcsan
> function to be instrumented. [Satisfied by Clang >= 7. All GCC
> versions are broken.]

The current noinstr annotation implies noinline, for a similar issue, we
need the function to be emitted in a specific section. So while yuck,
this is not an immediate issue for us.
