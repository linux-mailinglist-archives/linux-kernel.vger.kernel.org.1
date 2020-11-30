Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1A22C7FF1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 09:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgK3IbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 03:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgK3IbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 03:31:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C826CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 00:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dlMIUuk5t9/HdJR9i9suY7in0Y/IA8FpeIUXUx4PpM0=; b=vUaYt+r8+5w20rf9SjYeqKN1AH
        qohY38w7m3qq76ehoimsy2DMTIcug4MWY3Q3ntLAYH9v0rmwLIVZK2kZEHrEcF6rOhvNrj5gd+93D
        YrsgO8punGkfvok3EZUBJqSK7/qr8Sbh3yniklPO4T4Yo+eee8jouNzbiXQBjlW07WdEsM7PvBTFj
        Yk7kSKkI/Wj1mJkhdOZZONHarMDxfrYe+nrE8OLuS2wHs5pnmjL2SR6VuzinFR8AyVfRq48cEiwHJ
        ITcQSRWzlOFfbcviQ92SIJ7NPmgotwLX4eER8NQC6iFNEwZTO/1d1yzapVYOye7Xo/ZTc4IFljsCY
        QGQGEeVg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjeZb-0003xv-SA; Mon, 30 Nov 2020 08:30:15 +0000
Date:   Mon, 30 Nov 2020 08:30:15 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Lin <tesheng@andestech.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        walken@google.com, daniel.m.jordan@oracle.com, peterx@redhat.com,
        akpm@linux-foundation.org, penberg@kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, dslin1010@gmail.com,
        Alan Kao <alankao@andestech.com>
Subject: Re: [PATCH] riscv/mm: Prevent kernel module access user-space memory
 without uaccess routines
Message-ID: <20201130083015.GA14676@infradead.org>
References: <20201130053037.27006-1-tesheng@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130053037.27006-1-tesheng@andestech.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (!user_mode(regs) && addr < TASK_SIZE && unlikely(!(regs->status & SR_SUM)))

Please avoid the overly long line.
