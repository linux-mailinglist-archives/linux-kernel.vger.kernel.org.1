Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BAD1A74F2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 09:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406748AbgDNHia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 03:38:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42855 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406729AbgDNHiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 03:38:20 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jOG93-0005W2-1P; Tue, 14 Apr 2020 09:38:09 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id DD9C3100D14; Tue, 14 Apr 2020 09:38:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [patch 0/3] x86/kvm: Basic split lock #AC handling
In-Reply-To: <20200410190243.GH22482@linux.intel.com>
References: <20200410115359.242241855@linutronix.de> <20200410190243.GH22482@linux.intel.com>
Date:   Tue, 14 Apr 2020 09:38:07 +0200
Message-ID: <87v9m2o6u8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean,

Sean Christopherson <sean.j.christopherson@intel.com> writes:
> On Fri, Apr 10, 2020 at 01:53:59PM +0200, Thomas Gleixner wrote:
>> This is a reworked version of the patches posted by Sean:
>> 
>>  https://lore.kernel.org/r/20200402155554.27705-1-sean.j.christopherson@intel.com
>> 
>> The changes vs. this are:
>> 
>>     1) Use a separate function for guest split lock handling
>> 
>>     2) Force SIGBUS when SLD mode fatal
>
> Not that it matters as the code is correct, but I think you meant
> "when SLD mode off" here.

Actually for both fatal and off. The latter should never happen :)

Thanks,

        tglx
