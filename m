Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FE62C835D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgK3LjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgK3LjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:39:09 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D077C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 03:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=XFSO9N/pDhVneaE+7E6bKxNkzZ/fFGqF2q0buTjmwH0=; b=sFlWqKgkRzIiaryq2MQ+I6Op/m
        IVaQsEBxsWIp1C10cHwi0155UgMQVRbCvL4p66HJJf9r49c2KYaazCzSyYCQ5PLdrTGKLaXtTmaxZ
        ODc+yQUj2sz+bL/yytBxa/xv4XY9LPJUiE5iJ93JtPf7Jf2NkgFGxycCWgWadmekZ9ga1oPpVj/cu
        zxinQAzbPus++BRR9WAZ7y1fUJT9QmS91OE/zP4DgoM+4SCiA3A/2nmE9vFYteLH3vZhmUeX4rgVe
        QHdc19fDoPrEvwSsvIAfm1dvbY6aM/o5Lo/L5w+kUnhIoR0bLaOiKjJsQU5iz4kBSZRnBjQq/G7Ax
        +owuluHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjhVc-0006CW-GO; Mon, 30 Nov 2020 11:38:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E0F1C301179;
        Mon, 30 Nov 2020 12:38:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CD21A2B84F9C2; Mon, 30 Nov 2020 12:38:17 +0100 (CET)
Message-ID: <20201130112705.900705277@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 30 Nov 2020 12:27:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, peterz@infradead.org
Subject: [RFC][PATCH 0/9] Clean up i386-PAE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

While reviewing some other patches [1], Willy pointed out that lockless
page-table walkers should probably be using the same magic for PMD as we do for
PTE on things like i386-PAE.

These patches are the result of that and apply on top of that earlier series.

[1] https://lkml.kernel.org/r/20201126120114.071913521@infradead.org


