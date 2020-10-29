Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF82629F173
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgJ2Q34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgJ2Q3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:29:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C17BC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Pqpzp+rAUbWwfm4GZsejAc6K3Z1qWXiGS6GOVhGb5i4=; b=dNqoHHX9r15FzDcGMe0yI1pAyx
        WMafbHtZNoFAZtNDWGQnSJEV8yCQ40dl9iH0Fy4SHFqD3mWwHPrHeb8CVKPNL1i8YeA3ByTivMBFI
        ugkCsREqTCdV+z98HJVk1CSgNFJKHiblCKPNS0TXo0Wprme+xnMmsAbt8EcC4Wv6z+YkmCiJEIEuI
        oUpEfJCg7tVPnAf4mqWBe/5OPDtVCJdfa1Kscmf7VHapO/TguKI/43BWTGUGGv2QXdY/1uoOpgi1b
        EMTWO8Px4rL3FzNDaCzgmXfDhWkVgdwJnIw3mid4y5RTLptHYqsIFXjisSsPKhXRrx6tYeAPJ6i+s
        22T0lBug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYAo7-00040k-DO; Thu, 29 Oct 2020 16:29:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F19B2300446;
        Thu, 29 Oct 2020 17:29:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DCEE12107F307; Thu, 29 Oct 2020 17:29:46 +0100 (CET)
Message-ID: <20201029162719.519685265@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 29 Oct 2020 17:27:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, eranian@google.com,
        ak@linux.intel.com, peterz@infradead.org
Subject: [PATCH v2 0/4] perf: Fix perf_event_attr::exclusive rotation
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andi recently added exclusive event group support to tools/perf:

  https://lkml.kernel.org/r/20201014144255.22699-1-andi@firstfloor.org

and promptly found that they didn't work as specified.

(sorry for the resend, I forgot LKML the first time)

