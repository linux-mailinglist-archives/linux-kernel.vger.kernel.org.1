Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9B91E8C11
	for <lists+linux-kernel@lfdr.de>; Sat, 30 May 2020 01:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgE2X3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 19:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbgE2X3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 19:29:20 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A445DC03E969;
        Fri, 29 May 2020 16:29:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C393312863400;
        Fri, 29 May 2020 16:29:19 -0700 (PDT)
Date:   Fri, 29 May 2020 16:29:17 -0700 (PDT)
Message-Id: <20200529.162917.1970892823680223252.davem@davemloft.net>
To:     peterz@infradead.org
Cc:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        a.darwish@linutronix.de, rostedt@goodmis.org,
        bigeasy@linutronix.de, sparclinux@vger.kernel.org,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [RFC][PATCH v3 1/5] sparc64: Fix asm/percpu.h build error
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200529214203.673108357@infradead.org>
References: <20200529213550.683440625@infradead.org>
        <20200529214203.673108357@infradead.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 29 May 2020 16:29:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 29 May 2020 23:35:51 +0200

> ../arch/sparc/include/asm/percpu_64.h:7:24: warning: call-clobbered register used for global register variable
> register unsigned long __local_per_cpu_offset asm("g5");

The "-ffixed-g5" option on the command line tells gcc that we are
using 'g5' as a fixed register, so some part of your build isn't using
the:

KBUILD_CFLAGS += -ffixed-g4 -ffixed-g5 -fcall-used-g7 -Wno-sign-compare

from arch/sparc/Makefile for some reason.
