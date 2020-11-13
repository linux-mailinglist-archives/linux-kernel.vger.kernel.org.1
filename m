Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A35E2B1720
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 09:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgKMIWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 03:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgKMIWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 03:22:08 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C0AC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 00:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5toluOBo5WZNdPBDdQE5g+sgqR8aYzWFSce6feRDXBQ=; b=1MqbLugtGjsSzotGLVWZBEXySe
        +LMjwK1e/ZmObwC+r0rhZNEV1pLxbULBcH5KgaNhWRDHGOHiaUM8Ugx9nm3J8Ok2NOyzSEv4yG8G+
        jTLSp7F3s1fD8nLaAZlwHprQMqhq4C5OYl8CBv7JjKniBII7YUvqnI6wfixABizrm9vGSKOz6D444
        OM+JJAqZ5EeYkCLuGH8Qa5ku9m1BE86NrU4nXbad/s3DHcwZurtOk8wtYsocGZpzvoDQveTvlBjM9
        CYJBq/FZ2am8xPQlCf4AZk4bpwBlecUXm4H/iHGovPn7fwZ9yb+KNUUWDk67Bpc2HxaF2ipJWTqG6
        0vjbCByQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdULM-0002Kd-B4; Fri, 13 Nov 2020 08:22:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 257D4300238;
        Fri, 13 Nov 2020 09:22:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E809E2C084CB0; Fri, 13 Nov 2020 09:22:02 +0100 (CET)
Date:   Fri, 13 Nov 2020 09:22:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tal Zussman <tz2294@columbia.edu>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Kosina <trivial@kernel.org>
Subject: Re: [PATCH] sched/core: trivial: Fix typos in comments
Message-ID: <20201113082202.GC2628@hirez.programming.kicks-ass.net>
References: <20201113005156.GA8408@charmander>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113005156.GA8408@charmander>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 07:51:56PM -0500, Tal Zussman wrote:

I'm not much for patches like this, but I'll take it.

Thanks!
