Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEEC2603CA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 19:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbgIGRyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 13:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbgIGLWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:22:31 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDABC061383
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 04:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t6L7mc8LY6HcIK4hTeMOoR+t0IgXAjOkRlYlITQe43E=; b=YTUoJOoOvspRe3TUUiTUlvfdsr
        FgQbqoTaKbARdHlULynxlhFtt0g40eGclv8PCYn3kNsvM4aZ7Z8L509+iH3WpUmj+FIP0ts4KlWkh
        mk4KCWTv5noK1r2Y9NQWECqD60MbVBY+Pqon3SXww2yVuVzsOj3Hb1FvU/A9TJB54JditSJyeRvGp
        kzjD/lBp3G2IHA90Msnd3EWv8ySa33V2k2HBbJXlE6757gxqlejjpZarqYmuIIRBC/9yWmypbMG7n
        RS5ieIEnUsZcnJ/fsWgLo0QZATtTdWpQNbEGZGFJ1wdSuW50XnbQo6bCbPr0yIRxGO1WaJ2WUWI0q
        lVSGRgXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFF5O-0004ov-Sy; Mon, 07 Sep 2020 11:13:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6151E301179;
        Mon,  7 Sep 2020 13:13:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 438FC20177D0A; Mon,  7 Sep 2020 13:13:20 +0200 (CEST)
Date:   Mon, 7 Sep 2020 13:13:20 +0200
From:   peterz@infradead.org
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        vincent.donnefort@arm.com, mingo@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2] sched/debug: Add new tracepoint to track cpu_capacity
Message-ID: <20200907111320.GP2674@hirez.programming.kicks-ass.net>
References: <1598605249-72651-1-git-send-email-vincent.donnefort@arm.com>
 <20200828102724.wmng7p6je2pkc33n@e107158-lin.cambridge.arm.com>
 <1e806d48-fd54-fd86-5b3a-372d9876f360@arm.com>
 <20200828172658.dxygk7j672gho4ax@e107158-lin.cambridge.arm.com>
 <58f5d2e8-493b-7ce1-6abd-57705e5ab437@arm.com>
 <20200907104845.6rust2lf2o3d5gmq@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907104845.6rust2lf2o3d5gmq@e107158-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 11:48:45AM +0100, Qais Yousef wrote:
> IMHO the above is a hack. Out-of-tree modules should rely on public headers and
> exported functions only. What you propose means that people who want to use
> these tracepoints in meaningful way must have a prebuilt kernel handy. Which is
> maybe true for us who work in the embedded world. But users who run normal
> distro kernels (desktop/servers) will fail to build against

But this isn't really aimed at regular users. We're aiming this at
developers (IIUC) so I dont really see this as a problem.

> FWIW, I did raise this concern with Peter in 2019 OSPM and he was okay with the
> exports as it's still not a contract and they can disappear anytime we want.
> Migrating to using BTF is the right way forward IMO. I don't think what we have
> here is out-of-control yet. Though I agree they're annoying.

Right, we're hiding behind the explicit lack of ABI for modules.

Anyway, CTF/BTF/random other crap that isn't DWARFs should work fine to
replace all this muck. Just no idea what the state of any of that is.
