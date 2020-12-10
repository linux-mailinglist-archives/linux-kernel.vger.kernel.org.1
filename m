Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460422D5E9A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 15:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391828AbgLJOvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 09:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391675AbgLJOtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:49:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C3EC061794
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 06:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=yn1qH04jjjmkAXAfwbqdVLSx2R9x3N7TiVfDrsMpX+E=; b=Wi5MrpNuNIzVubde2t4JG+MhSL
        G2i9j0pS6csU5+hLILJYOYD/LZUnIilk/5AZbGv6gFiXyncSjcLI+ZmPho2KislHkydYKV8IFPUC6
        YRshqvhRp6xmuoqNARPVYx26LqEWxOpELm19GBdL3953lgG/kvU5MmVHAeYVbT6X/V0EX/vtwCSbX
        w3YvOmQ/qDkcfx0WMipdubRMiDPgT4idwDjynztdOrfSowGikTgGoRgryysrLzk8G4p92Lbbp8otJ
        7Eghbwtw8YBjeywiixFDavNQ5rtGVApszF7nQmnviEDxntY2c8pTVtiOA5AZSSuYQ+JaVdWKS5qhb
        WRFjiyHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knNF5-00044V-4G; Thu, 10 Dec 2020 14:48:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DCE63304D58;
        Thu, 10 Dec 2020 15:48:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C33D72BAB36D0; Thu, 10 Dec 2020 15:48:25 +0100 (CET)
Message-ID: <20201210144254.583402167@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 10 Dec 2020 15:42:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, peterz@infradead.org
Subject: [PATCH 0/6] Fix lockdep vs local_lock_t
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After a few days of confusion, here are patches that (hopefully!) teach lockdep
about local_lock_t.


