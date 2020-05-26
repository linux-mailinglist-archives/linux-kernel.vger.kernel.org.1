Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDB1C19D934
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 16:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403850AbgDCOfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 10:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390784AbgDCOfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:35:06 -0400
Received: from linux-8ccs (p3EE2C7AC.dip0.t-ipconnect.de [62.226.199.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39BB72073B;
        Fri,  3 Apr 2020 14:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585924505;
        bh=l0EiIHchinDWyCf43w0lhXunhiG167jMxs4uH8nFBj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yt5CYCfaNNG0hTQtdc+FclL0cgpS2x3v05p14lXgVFdsM3ZGhhpIKU2WPLClo3GRQ
         LqLpVFyhPoXtzNQGl/X9dsg4kXFTPn+hKDqhZtYCelZa0eTaXajtavVptm/Q954UHW
         30Q4UjZ2n5e8/iKwGBIqUXYQlTAD+LuLtC3CT+aw=
Date:   Fri, 3 Apr 2020 16:35:00 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
Message-ID: <20200403143459.GA30424@linux-8ccs>
References: <20200402123258.895628824@linutronix.de>
 <20200402124205.242674296@linutronix.de>
 <bc9a0c9a-7bd0-c85d-4795-ae0b4faa5e84@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bc9a0c9a-7bd0-c85d-4795-ae0b4faa5e84@prevas.dk>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Rasmus Villemoes [03/04/20 01:42 +0200]:
>On 02/04/2020 14.32, Thomas Gleixner wrote:
>> From: Peter Zijlstra <peterz@infradead.org>
>>
>> It turns out that with Split-Lock-Detect enabled (default) any VMX
>> hypervisor needs at least a little modification in order to not blindly
>> inject the #AC into the guest without the guest being ready for it.
>>
>> Since there is no telling which module implements a hypervisor, scan the
>> module text and look for the VMLAUNCH instruction. If found, the module is
>> assumed to be a hypervisor of some sort and SLD is disabled.
>
>How long does that scan take/add to module load time? Would it make
>sense to exempt in-tree modules?
>
>Rasmus

I second Rasmus's question. It seems rather unfortunate that we have
to do this text scan for every module load on x86, when it doesn't
apply to the majority of them, and only to a handful of out-of-tree
hypervisor modules (assuming kvm is taken care of already).

I wonder if it would make sense then to limit the text scans to just
out-of-tree modules (i.e., missing the intree modinfo flag)?

Jessica
