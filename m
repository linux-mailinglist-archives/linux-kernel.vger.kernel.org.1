Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336B12AB8C3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 13:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgKIM42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 07:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbgKIMzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 07:55:54 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFBEC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 04:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=80LG2Un0XQkskYIudlhzfeVR0TmYr6k+xJT8vPMRVNo=; b=i4SulT2hvpLGIYq2AhaqVntpH8
        DzHOGuiBk4MtztgVlWy6r+4uuXsECSdMfEc498zwdz+deQIhsamNvW8OqD7W78YlyQecb87FE+fGd
        Rm6bnv1DXayckQwuE/o/xudxrk8oz/G43w+AqjJxggdG7iNn1WdmpbR5Rg8OIVbYs1HHfwVA/4lss
        buzMAjNDWGD7DsQaGIKuLf2jB0MCfKV9CqQ7n1cLR0ubvCBhCQq4/vQqgWaZAjD9tOygsP05Vdy3K
        qRCBiUGQ16lu4CStS8s+n81GM5pnFNUFxDAFsYN3M6CRhvEY9kxHwEld3d8wOtBq6cKIuD5p8XGjR
        vCxo0gyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kc6i1-0006K5-1J; Mon, 09 Nov 2020 12:55:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2EE2C304D58;
        Mon,  9 Nov 2020 13:55:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10C5B2BDD057E; Mon,  9 Nov 2020 13:55:43 +0100 (CET)
Date:   Mon, 9 Nov 2020 13:55:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     paul.gortmaker@windriver.com, paulmck@kernel.org,
        akpm@linux-foundation.org, abelits@marvell.com, pjt@google.com,
        jinyuqi@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cpumask: use false and true for bool variables
Message-ID: <20201109125543.GJ2611@hirez.programming.kicks-ass.net>
References: <1604923190-70981-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604923190-70981-1-git-send-email-zou_wei@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 07:59:50PM +0800, Zou Wei wrote:
> Fix coccicheck warnings:
> 
> ./lib/cpumask.c:342:6-13: WARNING: Comparison of 0/1 to bool variable
> ./lib/cpumask.c:351:33-40: WARNING: Comparison of 0/1 to bool variable
> ./lib/cpumask.c:406:3-11: WARNING: Assignment of 0/1 to bool variable

None of that is a problem, please, apply:

  https://lkml.kernel.org/r/20201109113912.GH2594@hirez.programming.kicks-ass.net

and go do something useful.
