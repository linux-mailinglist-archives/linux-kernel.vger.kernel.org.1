Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A17250C93
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 01:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHXXxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 19:53:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60013 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgHXXxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 19:53:12 -0400
Received: from carbon-x1.hos.anvin.org ([IPv6:2601:646:8600:3280:1098:42a1:36db:233c])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 07ONqLRP2464825
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 24 Aug 2020 16:52:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 07ONqLRP2464825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020072401; t=1598313144;
        bh=JM6qo6j85EsiFGJo5bpjdiQ4d9EYsiab14JL4DBBCQI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=i0hzNdiE6BrFVawkgDXaHtoE+pTY37EXLlolpCHpcfbYjtMFclVq8ndCg9cj0Cjkn
         5+R+2V/liasUhKg0uyO2epUJTZ5/u2g2vIPOVSGfRVX7eiAS+VJEivjdDmpo5krBcI
         T3/Ij8ID1Q8qWH57wS0xs3qnI3Tx4fl1bv4QgAJ0Nz42AvwvRqnwMFeIRoabG0rcg7
         HumzkNZs2Rs9zuNy8i8Pdue31bd1zZaJhQKUhtlvG81pckGCniRzoIFwVrVVDiUtNg
         kvhXqiIpHroklTtMUELFOj+A/0SawIg6FU4x9ibV+AH7qfQZKp1Hg9gD6YBjPrWhex
         VGM/zfAhYCXBA==
Subject: Re: [REGRESSION] x86/cpu fsgsbase breaks TLS in 32 bit rr tracees on
 a 64 bit system
To:     Andy Lutomirski <luto@kernel.org>,
        "Robert O'Callahan" <robert@ocallahan.org>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Kyle Huey <me@kylehuey.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
References: <CAOp6jLYrwMqV=7hmxgdZUdDZ2aeUB27TTHm=j6cQT7C10Muhww@mail.gmail.com>
 <7DF88F22-0310-40C9-9DA6-5EBCB4877933@amacapital.net>
 <CALCETrUrvrQNw6dPau_rtHjA_YuCVdCTWYd4dsdcvcGsOaspmg@mail.gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <b0813ec5-b163-cc11-bfc9-e9d08c9c4ff2@zytor.com>
Date:   Mon, 24 Aug 2020 16:52:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUrvrQNw6dPau_rtHjA_YuCVdCTWYd4dsdcvcGsOaspmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-24 14:10, Andy Lutomirski wrote:
> 
> PTRACE_READ_SEGMENT_DESCRIPTOR to read a segment descriptor.
> 
> PTRACE_SET_FS / PTRACE_SET_GS: Sets FS or GS and updates the base accordingly.
> 
> PTRACE_READ_SEGMENT_BASE: pass in a segment selector, get a base out.
> You would use this to populate the base fields.
> 
> or perhaps a ptrace SETREGS variant that tries to preserve the old
> base semantics and magically sets the bases to match the selectors if
> the selectors are nonzero.
> 
> Do any of these choices sound preferable to any of you?
> 

My suggestion would be to export the GDT and LDT as a (readonly or mostly
readonly) regset(s) rather than adding entirely new operations. We could allow
the LDT and the per-thread GDT entries to be written, subject to the same
limitations as the corresponding system calls.

	-hpa

