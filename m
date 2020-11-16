Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22082B4AA2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbgKPQRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:17:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:50454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730948AbgKPQRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:17:45 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9E4A222B9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 16:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605543465;
        bh=Mv6f7f8506FraoMumz35j4BQyYx1tMmBjlS7DZTMh6s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cO0fEGISnNA7PcgOiATiolTw7tAkS5Zg7T/iuml160lD72+D/c5QQCC6g99NPdiv0
         E+tm/P0YcyWfeksg5V68oPeJbMzzoFz8MOlckQYOvSLN5cL4nnxznKQsmlZxwvR3+9
         21xAGXQROAjxwTtWdTl8e7cPOi/ciZNc1Yiis33Q=
Received: by mail-wm1-f49.google.com with SMTP id p22so24232139wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:17:44 -0800 (PST)
X-Gm-Message-State: AOAM531RHSVEV4xBCIagavKJJzdRvvhaYBFpcIePQaNmF8qbJVtH0LC+
        pdblzbnHGDVQGcA00MCP95evBniZLp1kggwLhmjK5A==
X-Google-Smtp-Source: ABdhPJzo4DLkbb/iKsJTRaDIKTsVLyxyBBgQcLU+k85si7bdNAKlaxr9HCjPF0P3RxTG5pvYnF7uVMxefE2gleeWFnw=
X-Received: by 2002:a1c:7213:: with SMTP id n19mr15820304wmc.36.1605543463407;
 Mon, 16 Nov 2020 08:17:43 -0800 (PST)
MIME-Version: 1.0
References: <20201116152301.24558-1-jgross@suse.com> <20201116152301.24558-4-jgross@suse.com>
In-Reply-To: <20201116152301.24558-4-jgross@suse.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 16 Nov 2020 08:17:29 -0800
X-Gmail-Original-Message-ID: <CALCETrWwnK1AwrGRn8Kuin-23NOG31LrWBO7w=T2QE+EJW=f-w@mail.gmail.com>
Message-ID: <CALCETrWwnK1AwrGRn8Kuin-23NOG31LrWBO7w=T2QE+EJW=f-w@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86/pv: switch SWAPGS to ALTERNATIVE
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel <xen-devel@lists.xenproject.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 7:23 AM Juergen Gross <jgross@suse.com> wrote:
>
> SWAPGS is used only for interrupts coming from user mode or for
> returning to user mode. So there is no reason to use the PARAVIRT
> framework, as it can easily be replaced by an ALTERNATIVE depending
> on X86_FEATURE_XENPV.
>
> There are several instances using the PV-aware SWAPGS macro in paths
> which are never executed in a Xen PV guest. Replace those with the
> plain swapgs instruction. For SWAPGS_UNSAFE_STACK the same applies.

Acked-by: Andy Lutomirski <luto@kernel.org>
