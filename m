Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438632F1756
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388232AbhAKOE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388275AbhAKOEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:04:53 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A931CC061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v/HbyBeVP3vzhsHV3kOkOVfJbOTtBbqnmlMmoz2Pur0=; b=PY4uKRFggb7iM+Xq1unBrxI7Cl
        fKWR5iaAVFLHSKHxxCs6QpSav05GkQX7zGsiCYcDfbvEe4RE8wXab0GObH8qmn8co51DwHXDRd1vo
        Zp0o0d/5l0QZQvpFnpOxzPOI8wGVSSxpEKezAfTwbHzKhJMplPTkN12X2bQECAhaxQfrydC6E/H7S
        usUjMmEK51OvR2z9vs5EOZYlCp3tK4Ght/H4o/c+uDBQ+zlQLUMl8TbhCTEyM/nobWFGAxrlLljUn
        fT+0wmVHEXObtTgzjPco+/jKMrip3DFvnRJ6DU6ZZmeTXy61nbXWEB23b1QqrtKYsyyZEUajGCv4S
        b8ly/74w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kyxnj-00071Z-4Q; Mon, 11 Jan 2021 14:04:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 397393010C8;
        Mon, 11 Jan 2021 15:04:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1AD2320167A86; Mon, 11 Jan 2021 15:04:05 +0100 (CET)
Date:   Mon, 11 Jan 2021 15:04:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        vincent.donnefort@arm.com, mingo@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com
Subject: Re: [PATCH v2] sched/debug: Add new tracepoint to track cpu_capacity
Message-ID: <X/xa1WBqu8ZOl5QD@hirez.programming.kicks-ass.net>
References: <1598605249-72651-1-git-send-email-vincent.donnefort@arm.com>
 <20200828102724.wmng7p6je2pkc33n@e107158-lin.cambridge.arm.com>
 <1e806d48-fd54-fd86-5b3a-372d9876f360@arm.com>
 <20200828172658.dxygk7j672gho4ax@e107158-lin.cambridge.arm.com>
 <58f5d2e8-493b-7ce1-6abd-57705e5ab437@arm.com>
 <20200902135423.GB93959@lorien.usersys.redhat.com>
 <20200907110223.gtdgqod2iv2w7xmg@e107158-lin.cambridge.arm.com>
 <20200908131954.GA147026@lorien.usersys.redhat.com>
 <20210104182642.xglderapsfrop6pi@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104182642.xglderapsfrop6pi@e107158-lin>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 06:26:42PM +0000, Qais Yousef wrote:

> So I have a proper patch for that now, that actually turned out to be really
> tiny once you untangle exactly what is missing.
> 
> Peter, bpf programs aren't considered ABIs AFAIK, do you have concerns about
> that?

In order to use these you need to rely on BTF to get anything useful
done right? And anything that relies on BTF cannot be ABI.
