Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD177241399
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 01:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgHJXJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 19:09:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbgHJXJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 19:09:00 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E934D2083B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 23:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597100940;
        bh=KN3dKAif49xXoXcIYO2KHMhCVpVKygWXi9GX3lGZE0Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yv2lQ6JaL4P4RZ6DPgVE31ayJe5xrgq8e/gkNH27Ne/wxDKwqPT7kq7bgthZb2324
         lEw+IH7M/ObVNPZdmg3XuvXjJHghj2lvECJhX5M0PTcJY1RU2cHyGjEAvVfdVxynFu
         o179kJE3HAZitPXghelbc7zm8zomnZc/oNMUqjL8=
Received: by mail-wm1-f46.google.com with SMTP id c80so978787wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 16:08:59 -0700 (PDT)
X-Gm-Message-State: AOAM531XMzrIWkVYiT+WL/BKp9sHXUFBb5wkAatXgoR+4S7bedWDl1J4
        xOmk11bpBlBfSxsseGNS7hKmar2TQORR0VFEtcz/SA==
X-Google-Smtp-Source: ABdhPJxmzhiiwwbrIFHZSor9k9o7ub7q4gaPWRP1byqx4GzUeDDloP6QcQE45NlFyBvtRlFrJIX4xrjlnh1EftzntZU=
X-Received: by 2002:a1c:4c17:: with SMTP id z23mr1361940wmf.49.1597100938325;
 Mon, 10 Aug 2020 16:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200716135303.276442-1-jarkko.sakkinen@linux.intel.com>
 <20200716135303.276442-22-jarkko.sakkinen@linux.intel.com> <CAOASepOqRfUafSv_qjUv-jW_6n8G7kZ9yh-2z_Z9sjL_2zqNCg@mail.gmail.com>
In-Reply-To: <CAOASepOqRfUafSv_qjUv-jW_6n8G7kZ9yh-2z_Z9sjL_2zqNCg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 10 Aug 2020 16:08:46 -0700
X-Gmail-Original-Message-ID: <CALCETrVch_XW-oc_-LR8Dbgat9DpSKtCYTV9YZaU7tfu61FHEw@mail.gmail.com>
Message-ID: <CALCETrVch_XW-oc_-LR8Dbgat9DpSKtCYTV9YZaU7tfu61FHEw@mail.gmail.com>
Subject: Re: [PATCH v36 21/24] x86/vdso: Implement a vDSO for Intel SGX
 enclave call
To:     Nathaniel McCallum <npmccallum@redhat.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        X86 ML <x86@kernel.org>, linux-sgx@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Cedric Xing <cedric.xing@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        asapek@google.com, Borislav Petkov <bp@alien8.de>,
        chenalexchen@google.com, Conrad Parker <conradparker@google.com>,
        cyhanish@google.com, Dave Hansen <dave.hansen@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Svahn, Kai" <kai.svahn@intel.com>, Keith Moyer <kmoy@google.com>,
        Christian Ludloff <ludloff@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Neil Horman <nhorman@redhat.com>,
        Patrick Uiterwijk <puiterwijk@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, yaozhangx@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 7:55 AM Nathaniel McCallum <npmccallum@redhat.com> wrote:
>
> In a past revision of this patch, I had requested a void *misc
> parameter that could be passed through vdso_sgx_enter_enclave_t into
> sgx_enclave_exit_handler_t. This request encountered some push back
> and I dropped the issue. However, I'd like to revisit it or something
> similar.

Why do you need an exit handler at all?  IIRC way back when I
suggested that we simply not support it at all.  If you want to
call__vdso_sgx_enter_enclave() in a loop, call it in a loop.  If you
want to wrap it intelligently in Rust, you don't want a callback
anyway -- that forces you have an FFI (or non-Rust, anyway) frame on
the stack, which interacts poorly with panic handling and prevents you
from using await in your Rust callback handler.  If, on the other
hand, you just call __vdso_sg_enter_enclave() in a loop, all these
problems go away and, if you really want, you can pass in a callback
in Rust and call the callback from Rust.

What am I missing?  I still don't really understand why we are
supporting this mechanism at all.  Just the asm code to invoke the
callback seems to be about half of the entire function.
