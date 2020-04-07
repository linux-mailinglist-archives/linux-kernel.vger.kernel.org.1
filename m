Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6861A18CB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 01:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgDGXtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 19:49:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48679 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgDGXtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 19:49:50 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jLxyO-00074q-SG; Wed, 08 Apr 2020 01:49:41 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 1032010069D; Wed,  8 Apr 2020 01:49:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Singh\, Balbir" <sblbir@amazon.com>,
        "keescook\@chromium.org" <keescook@chromium.org>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck\@intel.com" <tony.luck@intel.com>,
        "benh\@kernel.crashing.org" <benh@kernel.crashing.org>,
        "jpoimboe\@redhat.com" <jpoimboe@redhat.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "dave.hansen\@intel.com" <dave.hansen@intel.com>
Subject: Re: [PATCH v2 3/4] arch/x86: Optionally flush L1D on context switch
In-Reply-To: <728ba30fdc269d4b24c4fb16832e0151e8270cba.camel@amazon.com>
References: <20200406031946.11815-1-sblbir@amazon.com> <20200406031946.11815-4-sblbir@amazon.com> <202004071125.605F665@keescook> <728ba30fdc269d4b24c4fb16832e0151e8270cba.camel@amazon.com>
Date:   Wed, 08 Apr 2020 01:49:40 +0200
Message-ID: <87y2r6j1pn.fsf@nanos.tec.linutronix.de>
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
> On Tue, 2020-04-07 at 11:26 -0700, Kees Cook wrote:
>> On Mon, Apr 06, 2020 at 01:19:45PM +1000, Balbir Singh wrote:
>> > Add arch specific prctl()'s to opt-in to the L1D cache on context switch
>> > out, the existing mechanisms of tracking prev_mm via cpu_tlbstate is
>> > reused. cond_ibpb() is refactored and renamed into cond_mitigation().
>> 
>> I still think this should be a generic prctl(). If there is a strong
>> reason not to do this, can it be described in the commit log here?
>
> I can move to prctl() if that is what you prefer, the prctl() can then do arch
> specific things. I thought in my question around would other arch's like to do
> this, I did not hear anything specific, but I am happy to convert the
> interface over.

Yes, please. It's just a matter of time that other architectures find
this useful. L1D attacks are not restricted to x86 AFAICT.

Thanks,

        tglx
