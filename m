Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F96D2CD11B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 09:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388295AbgLCIRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 03:17:49 -0500
Received: from atcsqr.andestech.com ([60.248.187.195]:18521 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729887AbgLCIRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 03:17:49 -0500
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 0B38HD2t016615;
        Thu, 3 Dec 2020 16:17:13 +0800 (GMT-8)
        (envelope-from tesheng@andestech.com)
Received: from atcfdc88 (10.0.15.120) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.487.0; Thu, 3 Dec 2020 16:17:00 +0800
Date:   Thu, 3 Dec 2020 16:16:55 +0800
From:   Eric Lin <tesheng@andestech.com>
To:     Pekka Enberg <penberg@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Michel Lespinasse <walken@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 0/2] Let illegal access to user-space memory die
Message-ID: <20201203081655.GB25276@atcfdc88>
References: <20201203064826.30832-1-tesheng@andestech.com>
 <CAOJsxLHo6-6w9M3H1UP1hPX1bnxZ06tqbnc9cwR5_sLQBgA7HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAOJsxLHo6-6w9M3H1UP1hPX1bnxZ06tqbnc9cwR5_sLQBgA7HA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.0.15.120]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 0B38HD2t016615
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 03:29:57PM +0800, Pekka Enberg wrote:

Hi Pekka, 

> Hi Eric,
> 
> On Thu, Dec 3, 2020 at 8:51 AM Eric Lin <tesheng@andestech.com> wrote:
> >
> > Accesses to user-space memory without calling uaccess routine
> > leads to hanging in page fault handler. Like arm64, we let it
> > die earlier in page fault handler.
> >
> > Changes in v2:
> >     -Add a die_kernel_fault() helper
> >     -Split one long line code into two
> 
> Please also make no_context() use the new helper. Other than that:
> 

OK, I'll make no_context() use the new helper in v3.
Thanks for your review.

> Reviewed-by: Pekka Enberg <penberg@kernel.org>
