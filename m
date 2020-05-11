Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879A01CDA04
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 14:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbgEKMe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 08:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727019AbgEKMe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 08:34:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92356C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:34:57 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jY7dq-0005NH-GU; Mon, 11 May 2020 14:34:42 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id DE8FAFFBF8; Mon, 11 May 2020 14:34:41 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Radoslaw Biernacki <biernacki@google.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     x86@kernel.org, Ross Zwisler <zwisler@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/tsc: Use hard-coded crystal clock for Skylake mobile
In-Reply-To: <CAM4=Rn+7RGHEGa7u33zUA0b-cBehadw4NKN75JtjKjOhxm2Fxg@mail.gmail.com>
References: <20200509113717.9084-1-pmenzel@molgen.mpg.de> <87eerr3ppb.fsf@nanos.tec.linutronix.de> <edc5af47-27e6-753f-c095-bd3087942690@molgen.mpg.de> <CAM4=Rn+7RGHEGa7u33zUA0b-cBehadw4NKN75JtjKjOhxm2Fxg@mail.gmail.com>
Date:   Mon, 11 May 2020 14:34:41 +0200
Message-ID: <87y2py6466.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Radoslaw Biernacki <biernacki@google.com> writes:
> We found that regression only on specific SKU which was used in one
> model of ChromeBook.
> What's interesting is that some other SKU is fine.
>
> The consequences of this are rather not trivial,
> so this was considered a quickfix and temporary till we develop
> something better.
> In contrast to ChromeOs, I know that there is no way of finding if
> there are in fact regressions on generic kernel in the field (this is
> SKU dependent),
> but we also think that this problem should be addressed in a better
> way (if possible).

Fix the BIOS to setup the CPUID/MSRs correctly?

Thanks,

        tglx
