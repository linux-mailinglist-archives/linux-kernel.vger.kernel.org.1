Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A95278F2D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgIYQzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbgIYQzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:55:13 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E18B521D42
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601052913;
        bh=ib/7oEhvLrcpwHngtLoUjyPRrDSFjMvIeWnVdOB6HYQ=;
        h=From:Date:Subject:To:From;
        b=o9L/ESS0k1EjMroqQl7fhssfLDDCl3cqdvToi9QYL8UHFUI+9IxLYLQGUmrdWq9fl
         tpMiZ0x5vtJ3Y90LYShzhGyi7Jm1aBhmit6oU7VoIVbr/0uKP9GB9CYygsCa0tdyZF
         LU6qrjwB7mLTyFCS0JS2XhgUCSXK7grYeEew/fU8=
Received: by mail-wr1-f45.google.com with SMTP id s12so4325628wrw.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:55:12 -0700 (PDT)
X-Gm-Message-State: AOAM530AxINxjg1zZlVN93WK29FZTjMFMIYYy5QRuvh47AlCzSbERwFw
        oOMaL9BYZldFtFlAHMg/aIIbjwDQ7stkeYp1MZirDw==
X-Google-Smtp-Source: ABdhPJwXw+eHAI6wMejfBWtSHlRBMBC4HwQDkprqd3e2XKDhVDjUKoAUvyj0Ko4VDkU56vOtRcQkQMasg6Q0XR3K8Vc=
X-Received: by 2002:a05:6000:11c5:: with SMTP id i5mr5561345wrx.18.1601052911367;
 Fri, 25 Sep 2020 09:55:11 -0700 (PDT)
MIME-Version: 1.0
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 25 Sep 2020 09:55:00 -0700
X-Gmail-Original-Message-ID: <CALCETrUhQjQQa-BqNHPgdDfD9GDJZXJWSQ_M0tDF_ri5RfyTsw@mail.gmail.com>
Message-ID: <CALCETrUhQjQQa-BqNHPgdDfD9GDJZXJWSQ_M0tDF_ri5RfyTsw@mail.gmail.com>
Subject: Can we credibly make vdso_sgx_enter_enclave() pleasant to use?
To:     Borislav Petkov <bp@alien8.de>,
        Jethro Beekman <jethro@fortanix.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vdso_sgx_enter_enclave() sucks. I don't think anyone seriously likes
it, but maybe it's the best we can do.

I'm wondering if it's worth trying to do better.  Here's what I'd like
if I could wave a magic wand:

struct sgx_enclave_run {
       __u64 tcs;
       __u32 flags;
       __u32 exit_reason;

    /*
     * These values are exposed to the enclave on entry, and the values
     * left behind by the enclave are returned here.
     * Some enclaves might write to memory pointed to by rsp.
     */
       __u64 rsp, rbp, r8, r9, r10, r11, r12, r13, r14, r15;
       /* Maybe other regs too? */

       union {
               struct sgx_enclave_exception exception;

               /* Pad the entire struct to 256 bytes. */
               __u8 pad[256 - 32];
       };
};

long vdso_sgx_enter_enclave(unsigned int leaf, struct sgx_enclave_run *r);

No callback, no asm wrapper needed, no nastiness from the perspective
of the caller.

So here are my questions.  First, do people agree with me that this
would be better?  Second, could this be implemented in a way that
doesn't utterly suck?  The best I've come up with so far is abusing
WRFSBASE to shove a little data structure containing the real user RSP
or RBP along with the old FSBASE into FSBASE, do EENTER, and then undo
the FSBASE dance.  We'd also need some additional exception fixup
magic to prevent a signal or ptrace() from observing the intermediate
states and getting extremely confused.

--Andy
