Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9B92C96D9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 06:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgLAFVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 00:21:47 -0500
Received: from atcsqr.andestech.com ([60.248.187.195]:11329 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgLAFVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 00:21:47 -0500
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 0B15LHZx079928;
        Tue, 1 Dec 2020 13:21:17 +0800 (GMT-8)
        (envelope-from tesheng@andestech.com)
Received: from atcfdc88 (10.0.15.120) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.487.0; Tue, 1 Dec 2020 13:20:55 +0800
Date:   Tue, 1 Dec 2020 13:20:49 +0800
From:   Eric Lin <tesheng@andestech.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "walken@google.com" <walken@google.com>,
        "daniel.m.jordan@oracle.com" <daniel.m.jordan@oracle.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "dslin1010@gmail.com" <dslin1010@gmail.com>,
        "Alan Quey-Liang Kao(?????})" <alankao@andestech.com>
Subject: Re: [PATCH] riscv/mm: Prevent kernel module access user-space memory
 without uaccess routines
Message-ID: <20201201052048.GA7647@atcfdc88>
References: <20201130053037.27006-1-tesheng@andestech.com>
 <20201130083015.GA14676@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201130083015.GA14676@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.0.15.120]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 0B15LHZx079928
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 04:30:15PM +0800, Christoph Hellwig wrote:
Hi Christoph,
> > +	if (!user_mode(regs) && addr < TASK_SIZE && unlikely(!(regs->status & SR_SUM)))
> 
> Please avoid the overly long line.
OK, I'll modify it in v2. Thanks for your review.
