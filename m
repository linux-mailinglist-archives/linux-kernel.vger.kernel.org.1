Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7901127AACA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgI1JcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:32:10 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:47816 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726559AbgI1JcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:32:09 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08003213|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.012899-0.00117961-0.985921;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=fuyao@allwinnertech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.IdDp-2p_1601285523;
Received: from localhost(mailfrom:fuyao@allwinnertech.com fp:SMTPD_---.IdDp-2p_1601285523)
          by smtp.aliyun-inc.com(10.147.41.231);
          Mon, 28 Sep 2020 17:32:04 +0800
Date:   Mon, 28 Sep 2020 17:31:58 +0800
From:   fuyao <fuyao@allwinnertech.com>
To:     =?utf-8?B?5YiY6YK15Y2OQlRE?= <liush@allwinnertech.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "paul.walmsley" <paul.walmsley@sifive.com>,
        palmer <palmer@dabbelt.com>, aou <aou@eecs.berkeley.edu>,
        akpm <akpm@linux-foundation.org>, peterx <peterx@redhat.com>,
        walken <walken@google.com>,
        "daniel.m.jordan" <daniel.m.jordan@oracle.com>,
        vbabka <vbabka@suse.cz>, rppt <rppt@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN77yaW1BBVENI?= =?utf-8?Q?=5D?= riscv: fix
 pfn_to_virt err in do_page_fault().
Message-ID: <20200928093158.GC4756@g8Exdroid64>
Mail-Followup-To: =?utf-8?B?5YiY6YK15Y2OQlRE?= <liush@allwinnertech.com>,
        Christoph Hellwig <hch@infradead.org>,
        "paul.walmsley" <paul.walmsley@sifive.com>,
        palmer <palmer@dabbelt.com>, aou <aou@eecs.berkeley.edu>,
        akpm <akpm@linux-foundation.org>, peterx <peterx@redhat.com>,
        walken <walken@google.com>,
        "daniel.m.jordan" <daniel.m.jordan@oracle.com>,
        vbabka <vbabka@suse.cz>, rppt <rppt@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1600327549-3995-1-git-send-email-liush@allwinnertech.com>
 <20200917152518.GA8930@infradead.org>
 <ca550ec0-73f2-485e-84fd-036eacd0bcd9.liush@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca550ec0-73f2-485e-84fd-036eacd0bcd9.liush@allwinnertech.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 03:43:39PM +0800, 刘邵华BTD wrote:
> Hi Christoph,
> > On Thu, Sep 17, 2020 at 03:25:49PM +0800, liush wrote:
> > > The argument to pfn_to_virt() should be pfn not the value of CSR_SATP.
> > > 
> > > Signed-off-by: liush <liush@allwinnertech.com>
> > > ---
> > >  arch/riscv/mm/fault.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> > > index 716d64e..9b4e088 100644
> > > --- a/arch/riscv/mm/fault.c
> > > +++ b/arch/riscv/mm/fault.c
> > > @@ -212,7 +212,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
> > >     * of a task switch.
> > >     */
> > >    index = pgd_index(addr);
> > > -  pgd = (pgd_t *)pfn_to_virt(csr_read(CSR_SATP)) + index;
> > > +  pgd = (pgd_t *)pfn_to_virt(csr_read(CSR_SATP) & SATP_PPN) + index;
> 
> > This adds a crazy long line.  One nice way to clean this up would be to
> > add a local pfn variable, as it would also make the code more readable.
> 
> Thanks, i'll modify it in next revision

Tested-by: fuayo@allwinnertech.com

-- 
<http://www.allwinnertech.com> Allwinnertech Technology


