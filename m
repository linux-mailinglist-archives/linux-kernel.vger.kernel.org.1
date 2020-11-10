Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533722AD614
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 13:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbgKJMVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 07:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730186AbgKJMVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 07:21:15 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0985C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 04:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9QfKBizSdwVq/e1ux0PD/cnEhUP9wW2XpNQEsyGL030=; b=Tz1YHSHwxXV3vgWp4zS8+NHwe8
        DvqHrn8U+FoInOcHUCiIPUEqRdNIy/QysWvYhhj3BhygzOuPA5SCicwyiB8qDeNG4h/P81dPIVQ3h
        4v2DP5fBn1GLUTVTA53LWPt76mVLHmEDZp5kNobQ6MQUn/AJDlQDlAJer9KlQYPqmK1uyu0ch62hK
        SPU16tKP7AMSq1Lczz7klAOqAhKNXbNL3Gaw/xa6Xtxw/d5K91PsUSOUD9lQ94voVddkhTdrGf83H
        lPcIbC3pN+3RO/IZV2/5B9Ve7c5lE0EjL9YMsTk7EswWQnM1E3s1kb/8G1iBgC2YUkuBvBx+CtGlH
        Kc1hvZIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcSe6-0004AG-4o; Tue, 10 Nov 2020 12:21:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9EA73301E02;
        Tue, 10 Nov 2020 13:21:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E3472C29A9E6; Tue, 10 Nov 2020 13:21:08 +0100 (CET)
Date:   Tue, 10 Nov 2020 13:21:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yun Hsiang <hsiang023167@gmail.com>
Cc:     dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        qais.yousef@arm.com, patrick.bellasi@matbug.net,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
Message-ID: <20201110122108.GG2594@hirez.programming.kicks-ass.net>
References: <20201103023756.1012088-1-hsiang023167@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103023756.1012088-1-hsiang023167@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 10:37:56AM +0800, Yun Hsiang wrote:
> If the user wants to stop controlling uclamp and let the task inherit
> the value from the group, we need a method to reset.
> 
> Add SCHED_FLAG_UTIL_CLAMP_RESET flag to allow the user to reset uclamp via
> sched_setattr syscall.
> 
> The policy is
> _CLAMP_RESET                           => reset both min and max
> _CLAMP_RESET | _CLAMP_MIN              => reset min value
> _CLAMP_RESET | _CLAMP_MAX              => reset max value
> _CLAMP_RESET | _CLAMP_MIN | _CLAMP_MAX => reset both min and max
> 

The obvious alternative would be to use a magic value in
sched_util_{min,max} to indicate reset. After all, we strictly enforce
the values are inside [0,1024], which leaves us with many unused values.

Specifically -1 comes to mind. It would allow doing this without an
extra flag, OTOH the explicit flag is well, more explicit.

I don't have a strong preference either way, but I wanted to make sure
it was considered, and perhaps we can record why this isn't as nice a
solution, dunno.
