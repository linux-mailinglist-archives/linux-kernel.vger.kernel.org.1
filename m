Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B23C2E42B5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 16:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392528AbgL1P05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 10:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387680AbgL1P0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 10:26:51 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F7AC061795
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 07:26:10 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id o6so9623537iob.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 07:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=UhNcTN3a6kOuyijy6IwTZGopEC0im7Jf6sspgsY6VGY=;
        b=vQ9uMSEZ3cDzg//S3NtwLffPUEo74XFAw6QiyuahY8xOtEwW4XuzGhz7MusofLOJBe
         5TVO1tOc3ZBSjdISvEPdGVIm/VMqUStVGq5uXPrPo7nZrNgRIvEQAqolkKPRLH1PAIeJ
         gohJoC2xuxw9CJnMlhwEGMCPqhQmX1MJEMGLCZserLWznm3xZtS1AbLffD1j7Gu1DDtm
         THflaUnKBdlR5/hKvcrTfDL4ZvQyp1nIA46QqeSbjxobV7Vv3k/IxC/TKYqi/mNn+3Nk
         /bO0OLB5iORxXH82QBKTmsYPZrF1c0FK+jafyc8BK2g27MA/qsXofg+l2xzYJW7Psvw7
         Qoew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=UhNcTN3a6kOuyijy6IwTZGopEC0im7Jf6sspgsY6VGY=;
        b=raTwgq1o9XSqoTLvvUVY+PuWOfJ1RaSHe9wfhWeH0ZQV3aNH+/8D+NBQmeyEsz5WR/
         xjCmXpEfWUVbEz0ykBkElg0H2mmRgb9mkplE9+l05FNIxTldm/u5FxHrKsfbzs2Z0xHP
         SiQzAPHDaNXtQRW5n37X3Qwy9buWlYCf7SJbb7qh1aqtF8f1TcDMTcl1X6cuc/U+0q8I
         KsA4iJOpgvOM5TO+tL1EPNownKVGBrL8Mh39pROUi2y8AZKWEg9KXmkEtAvDfhII325y
         S5SisNZfI46Eja6HOhDWA44tre3K43TJ7DdbM3ON/ix4eldCY0VWnTExzI5y6xXDou/+
         Xm1g==
X-Gm-Message-State: AOAM533SOuq8TkVqcX8EDiDU4LJso7HElk4OTQ1oZut+MQ7TLddEwSls
        wp4iSF6B12yqhPQYsbSMNxV7W1Z+wguMgNz+bqmvvnz1oTo=
X-Google-Smtp-Source: ABdhPJxJbudusJRphyBEUznDC359BFSK/Q3fM12j1KO6Zxss4X+r3x9kGUv/SF3pwUtPjt6Gl2tnyPHmUvWh3i1xQP4=
X-Received: by 2002:a6b:92c4:: with SMTP id u187mr36194706iod.57.1609169169965;
 Mon, 28 Dec 2020 07:26:09 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUUQRKuZzN0ZbaG6vprRWcKPKYVYTryiMFac7q_PRcBvgA@mail.gmail.com>
In-Reply-To: <CA+icZUUQRKuZzN0ZbaG6vprRWcKPKYVYTryiMFac7q_PRcBvgA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 28 Dec 2020 16:25:59 +0100
Message-ID: <CA+icZUXfVF49iBYTvz-g9f=Fo04jkgLhHiYRxoon9NjZtWzGQg@mail.gmail.com>
Subject: Re: Linux 5.11-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please CC me I am not subscribed to LKML and linux-kbuild ML ]

Hi Linus,

I also tested with LLVM toolchain v11.0.1-rc2 together with passing
LLVM=1 and LLVM_IAS=1 to my make line.

I had one ERROR:

error: too few operands for instruction in arch/x86/kvm/svm/sev.c

The issue was reported in ClangBuiltLinux (CBL) issue #1216.
A fix was offered in [2] and fixes the issue on the kernel-side.

I had one WARNING:

drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:
eb_relocate_parse_slow()+0x3d0: stack state mismatch: cfa1=7+120
cfa2=-1+0
drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:
eb_copy_relocations()+0x229: stack state mismatch: cfa1=7+120
cfa2=-1+0

Looks like a similar issue was reported as
"drivers/gpu/drm/i915/gem/i915_gem_execbuffer: objtool warning on
stack state mismatch" in [3].
I CCed Josh in the CBL issue #1192.

Thanks.

Regards,
- Sedat -

[1] https://github.com/ClangBuiltLinux/linux/issues/1216
[2] https://lore.kernel.org/kvm/20201219063711.3526947-1-natechancellor@gmail.com/
[3] https://github.com/ClangBuiltLinux/linux/issues/1192
