Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BCC1B223E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 11:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgDUJDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 05:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726013AbgDUJDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 05:03:09 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE605C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 02:03:09 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jQonv-0007bH-OJ; Tue, 21 Apr 2020 11:02:56 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id C9C63104099; Tue, 21 Apr 2020 11:02:54 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Singh\, Balbir" <sblbir@amazon.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "keescook\@chromium.org" <keescook@chromium.org>,
        "tony.luck\@intel.com" <tony.luck@intel.com>,
        "benh\@kernel.crashing.org" <benh@kernel.crashing.org>,
        "jpoimboe\@redhat.com" <jpoimboe@redhat.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "dave.hansen\@intel.com" <dave.hansen@intel.com>
Subject: Re:  [PATCH v3 3/5] arch/x86/mm: Refactor cond_ibpb() to support other use cases
In-Reply-To: <9cbabf58e0a6fe3775c268d1fa4517d02ad7e617.camel@amazon.com>
References: <20200408090229.16467-1-sblbir@amazon.com> <20200408090229.16467-4-sblbir@amazon.com> <87sgh2l0q4.fsf@nanos.tec.linutronix.de> <12023cc73a6344ed7499e09492a6934c1dfaf044.camel@amazon.com> <87pnc5xgff.fsf@nanos.tec.linutronix.de> <9cbabf58e0a6fe3775c268d1fa4517d02ad7e617.camel@amazon.com>
Date:   Tue, 21 Apr 2020 11:02:54 +0200
Message-ID: <87wo69us75.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Singh, Balbir" <sblbir@amazon.com> writes:
> On Sat, 2020-04-18 at 11:59 +0200, Thomas Gleixner wrote:
>> 
>> "Singh, Balbir" <sblbir@amazon.com> writes:
>> > On Fri, 2020-04-17 at 15:07 +0200, Thomas Gleixner wrote:
>> > > 
>> > > Balbir Singh <sblbir@amazon.com> writes:
>> > > > 
>> > > >  /*
>> > > > - * Use bit 0 to mangle the TIF_SPEC_IB state into the mm pointer
>> > > > which is
>> > > > - * stored in cpu_tlb_state.last_user_mm_ibpb.
>> > > > + * Bits to mangle the TIF_SPEC_IB state into the mm pointer which is
>> > > > + * stored in cpu_tlb_state.last_user_mm_spec.
>> > > >   */
>> > > >  #define LAST_USER_MM_IBPB    0x1UL
>> > > > +#define LAST_USER_MM_SPEC_MASK       (LAST_USER_MM_IBPB)
>> > > > 
>> > > >       /* Reinitialize tlbstate. */
>> > > > -     this_cpu_write(cpu_tlbstate.last_user_mm_ibpb,
>> > > > LAST_USER_MM_IBPB);
>> > > > +     this_cpu_write(cpu_tlbstate.last_user_mm_spec,
>> > > > LAST_USER_MM_IBPB);
>> > > 
>> > > Shouldn't that be LAST_USER_MM_MASK?
>> > > 
>> > 
>> > No, that crashes the system for SW flushes, because it tries to flush the
>> > L1D
>> > via the software loop and early enough we don't have the l1d_flush_pages
>> > allocated. LAST_USER_MM_MASK has LAST_USER_MM_FLUSH_L1D bit set.
>> 
>> You can trivially prevent this by checking l1d_flush_pages != NULL.
>> 
>
> But why would we want to flush on reinit? It is either coming back from a low
> power state or initialising, is it worth adding a check for != NULL everytime
> we flush to handle this case?

Fair enough. Please add a comment so the same question does not come
back 3 month from now.

Thanks,

        tglx
