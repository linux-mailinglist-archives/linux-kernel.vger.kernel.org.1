Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80651273CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 10:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgIVIDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 04:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgIVIDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 04:03:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD8FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 01:03:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600761783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iybo119V7hksuiu9tgyEL3G49tpMXK/9TX07phpzOfA=;
        b=wnyCK0L8+pUUB2kfe2UCXb5f3ZQkNcbV77UUZRQaVogdwOTyumzcTrMVOvJSGgsSPJ9a8X
        yE9H6Bew/VIeLDUHeTOUPo8OJEpoz05a6zLhEkRgxFNJkEH5XAYK8YxESEmmItr2S+9qzt
        PCrLOIp582MKZj8wi79W5RRLoaVu10QUTXljaiokiG4OhiY2W2fnMzWzVeXocz5BeAnTrK
        bS1w9Dz9/HJdZsG7SUmm8EC0sJuCbaycIOr7ziSt48+jyMT6z0sk27IxB0tB0txWG9wnqF
        rbFT9e3Z5sIJ3vCvfiTSHdB9NHlVRaLY8KY53HWHZZxJ2sBz9Mg/HPM8NwQsOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600761783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iybo119V7hksuiu9tgyEL3G49tpMXK/9TX07phpzOfA=;
        b=DCFQA+/4UdhjcxqHuTLAOT/U7AVQawJgtwCrDpHMZwfd9T58+kPSME51SNwicLRLQlJlMa
        MBeG3wYaeJOyieAw==
To:     Borislav Petkov <bp@alien8.de>, x86-ml <x86@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] Use feature bit names in clearcpuid=
In-Reply-To: <20200920154228.GB7473@zn.tnic>
References: <20200920154228.GB7473@zn.tnic>
Date:   Tue, 22 Sep 2020 10:03:03 +0200
Message-ID: <87mu1ib5mw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20 2020 at 17:42, Borislav Petkov wrote:
> Hi,
>
> so tglx hates this clearcpuid= interface where you have to give the
> X86_FEATURE array indices in order to disable a feature bit for testing.
> Below is a first attempt (lightly tested in a VM only) to accept the bit
> names from /proc/cpuinfo too.
>
> I say "too" because not all feature bits have names and we would still
> have to support the numbers. Yeah, yuck.
>
> An exemplary cmdline would then be something like:
>
> clearcpuid=de,440,smca,succory,bmi1,3dnow ("succory" is wrong on
> purpose).
>
> and it says:
>
> [    0.000000] Clearing CPUID bits: de 13:24 smca bmi1 3dnow
>
> Also, I'm thinking we should taint the kernel when this option is used.
>
> Thoughts?

Yes, instead of making it differently horrible, can we finally remove that
nonsense which should have never been there in the first place?

Thanks,

        tglx
