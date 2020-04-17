Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C0F1AE811
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 00:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgDQWSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 18:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728482AbgDQWST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 18:18:19 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EB7C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 15:18:19 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jPZJJ-00082n-Uy; Sat, 18 Apr 2020 00:18:10 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 4A10B1025DB; Sat, 18 Apr 2020 00:18:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Luck\, Tony" <tony.luck@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 2/3] x86/split_lock: Bits in IA32_CORE_CAPABILITIES are not architectural
In-Reply-To: <20200417211930.GA24777@agluck-desk2.amr.corp.intel.com>
References: <877dydzvml.fsf@nanos.tec.linutronix.de> <873691zuqu.fsf@nanos.tec.linutronix.de> <20200417211930.GA24777@agluck-desk2.amr.corp.intel.com>
Date:   Sat, 18 Apr 2020 00:18:09 +0200
Message-ID: <87zhb9ycwu.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Luck, Tony" <tony.luck@intel.com> writes:
> On Fri, Apr 17, 2020 at 11:07:37PM +0200, Thomas Gleixner wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>> as I fear that the infinite wisdom of HW folks will add yet another
>> variant in the foreseeable future, I used a switch() right away and
>> tweaked the comments a bit.
>> 
>> Can you have a look, please?
>
> Looks like you are all ready for "case 2:" when Intel produces
> a less sucky implementation of split lock detect. Don't hold your
> breath waiting for that :-)

Surely not.

I'm still hoping to see quirkless TSCs and timers, sane IRET semantics
and the demise of non-maskable MSIs before my retirement. Not that I
believe it will happen, it's just because hope dies last.

> Looks good. Should be a useful template for any future
> bits that show up in CORE_CAPABILITIES.

Groan. No!

Thanks,

        tglx
