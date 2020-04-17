Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9051AE6F5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 22:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgDQUsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 16:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgDQUsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 16:48:39 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D389AC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 13:48:38 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jPXuc-0006z8-UC; Fri, 17 Apr 2020 22:48:35 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 6090C100C47; Fri, 17 Apr 2020 22:48:34 +0200 (CEST)
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
In-Reply-To: <20200417195601.GA22640@agluck-desk2.amr.corp.intel.com>
References: <20200416205754.21177-1-tony.luck@intel.com> <20200416205754.21177-3-tony.luck@intel.com> <878siumnrf.fsf@nanos.tec.linutronix.de> <20200417170607.GA18267@agluck-desk2.amr.corp.intel.com> <87ftd1zzau.fsf@nanos.tec.linutronix.de> <20200417195601.GA22640@agluck-desk2.amr.corp.intel.com>
Date:   Fri, 17 Apr 2020 22:48:34 +0200
Message-ID: <877dydzvml.fsf@nanos.tec.linutronix.de>
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

> On Fri, Apr 17, 2020 at 09:29:13PM +0200, Thomas Gleixner wrote:
>> "Luck, Tony" <tony.luck@intel.com> writes:
>> > On Fri, Apr 17, 2020 at 12:04:36PM +0200, Thomas Gleixner wrote:
>> > +	if (!m->driver_data)
>> > +		goto setup;
>> > +	if (!cpu_has(c, X86_FEATURE_CORE_CAPABILITIES))
>> > +		return;
>> > +	rdmsrl(MSR_IA32_CORE_CAPS, ia32_core_caps);
>> > +	if (!(ia32_core_caps & MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT))
>> > +		return;
>> > +setup:
>> > +	split_lock_setup();
>> 
>> Which looks nicer w/o the goto:
>> 
>> 	if (m->driver_data) {
>> 		if (!cpu_has(c, X86_FEATURE_CORE_CAPABILITIES))
>> 			return;
>> 		rdmsrl(MSR_IA32_CORE_CAPS, ia32_core_caps);
>> 		if (!(ia32_core_caps & MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT))
>> 			return;
>> 	}
>> 
>> Hmm?
>
> Swings and roundabouts ... getting rid of the goto makes for
> deeper indentation. But if you really want to get rid of the
> goto, then your version is fine with me.
>
> Do you want me to spin it into v3?

Nah. I tweak it myself.
