Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E3E1ACA39
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 17:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410514AbgDPPch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 11:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2410465AbgDPPc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:32:26 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D7EC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cxO05dwwYyFWwu+Hjn5nmvuxzYZOEhq4dvVTeZURZr4=; b=wYtN3PzQ7GgPwToOvgM9/4hK/R
        Z8HkRKuRdSqdOi7AT6JMqdGX15fKOb7s2Lc9UYQAcmr3E+BKt+XQw+R+z7p2+DgpIuazcYd9QXT3x
        VxTnE8LG5+3T5uG5xwVp2R3eSL238wUg99IHUpaIMlSd0+pxOVFbDqyA5atwM4VLpJrEDc/ipXKMP
        p0kS5h02C4jMaD7nb2tep9Zq55UAxKHfOmqRS1HtPehAtIBIOQ9FusbDpQCwHmv3ytzEPce/fDmHM
        F0QFebRgPvB1UycdQK85sfdaL7mT54E43I+QpfDNlQsQ7UorSdbjV1D0SwLhGWxRXVzD9uOolpJqa
        vmiZAONA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP6Un-0004ut-No; Thu, 16 Apr 2020 15:32:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 73E9730477A;
        Thu, 16 Apr 2020 17:32:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E0382B0DED29; Thu, 16 Apr 2020 17:32:04 +0200 (CEST)
Date:   Thu, 16 Apr 2020 17:32:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: [RFC][PATCH 0/7] objtool vs retpoline
Message-ID: <20200416153204.GR20730@hirez.programming.kicks-ass.net>
References: <20200416150752.569029800@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416150752.569029800@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 05:07:52PM +0200, Peter Zijlstra wrote:
> Hi!
> 
> Based on Alexandre's patches, here's a few patches that apply on top of my
> other series:
> 
>   https://lkml.kernel.org/r/20200416114706.625340212@infradead.org
> 
> which seems to build a clean defconfig without ANNOTATE_NOSPEC_ALTERNATIVE on.
> 
> I've not tried to boot the thing, I'll leave that to the robots.

Find a slightly cleaner, and more actually working, version here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git core/objtool-retpoline
