Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA9719E088
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 23:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgDCVuA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Apr 2020 17:50:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41071 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgDCVuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 17:50:00 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jKUC0-0004hE-F0; Fri, 03 Apr 2020 23:49:36 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id BEA49103A01; Fri,  3 Apr 2020 23:49:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jannh@google.com, keescook@chromium.org, vbox-dev@virtualbox.org
Subject: Re: [patch 1/2] x86,module: Detect VMX modules and disable Split-Lock-Detect
In-Reply-To: <737F6739-9B8B-4C73-91D3-B873D5780F5E@amacapital.net>
References: <87o8s8l7t3.fsf@nanos.tec.linutronix.de> <737F6739-9B8B-4C73-91D3-B873D5780F5E@amacapital.net>
Date:   Fri, 03 Apr 2020 23:49:35 +0200
Message-ID: <87a73skzo0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@amacapital.net> writes:
>> On Apr 3, 2020, at 11:54 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> ﻿Peter Zijlstra <peterz@infradead.org> writes:
>> Enough vented, but that still does not solve the SLD problem in any
>> sensible way.
>
> Could we unexport set_memory_x perhaps?  And maybe try to make
> virtualbox break in as many ways as possible?

set_memory_x() is not exported anymore, but they found new ways of
circumvention. set_memory_x() is only used on really old kernels.

Thanks,

        tglx
