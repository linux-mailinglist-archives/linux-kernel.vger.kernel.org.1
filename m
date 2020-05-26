Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8F7519C754
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 18:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389925AbgDBQqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 12:46:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38637 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388316AbgDBQqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:46:50 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jK2yy-00087o-5S; Thu, 02 Apr 2020 18:46:20 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 72A84100D52; Thu,  2 Apr 2020 18:46:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Kenneth R. Crudup" <kenny@panix.com>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 1/2] x86,module: Detect VMX modules and disable Split-Lock-Detect
In-Reply-To: <alpine.DEB.2.21.2004020801210.10453@xps-7390>
References: <A3312A4A-96A6-46A3-8C37-5AF5312FDF29@amacapital.net> <alpine.DEB.2.21.2004020801210.10453@xps-7390>
Date:   Thu, 02 Apr 2020 18:46:19 +0200
Message-ID: <871rp5omxw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Kenneth R. Crudup" <kenny@panix.com> writes:
> On Thu, 2 Apr 2020, Andy Lutomirski wrote:
>> This seems like much more of a fixup than we would usually do ....
>
> TBH, I was kinda surprised to see that patchset myself.
>
> 	-Kenny, guessing Linus hasn't read this far yet :)

The much we hate it, we simply have users depending on these things for
various reasons.

That said, I'm perfectly fine with changing it to 'refuse module load'.

Thanks,

        tglx
