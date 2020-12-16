Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0B32DC326
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 16:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgLPPcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 10:32:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40254 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPPcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 10:32:36 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608132714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ChNTurnnTAzgM4+R7TN7VwtIAo0L2Mr35zSMQtctJ4Q=;
        b=NJxqKF1E/6M32C42A4nshPJPwPbj2RpFrDfTQt4gtHVwsSFL1yucZUylXQixljel67H9RO
        woTXjww4Wl6ZfZ5oI4kzt6llMsiKIvxC4+qDi/l2gkxsiuRIGQalAPGKy9sifCjNEnx1Sc
        vzGQXYekG2psqL3aQLb+P7KaaVDbFNBiALase+7hXJvmu99iF1d59A694mzgsv5U38DNLX
        cnATLn+DrdGTVIh9KLktUhCOSGWquOkCtdWTGM6velpaCTJ4tMbwBAcyBS8iiar4mKW3Yv
        I5r3jghjm5+hFpoeDOC6Nwnr5g1XkuK+3Q+9Z7N/KfjUSJtUwLZ+b+ahr39KZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608132714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ChNTurnnTAzgM4+R7TN7VwtIAo0L2Mr35zSMQtctJ4Q=;
        b=WUCJfLCa3Uj4NHg6Y1K4bCOtZDkxJcRKqIpca2qapyutIiwhEFCqZxYeSmQcWINHLQm/Ol
        A8dMVdi//SfYa+Cw==
To:     "shenkai \(D\)" <shenkai8@huawei.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        hewenliang4@huawei.com, hushiyuan@huawei.com,
        luolongjun@huawei.com, hejingxian@huawei.com
Subject: Re: [PATCH] use x86 cpu park to speedup smp_init in kexec situation
In-Reply-To: <06977da1-d148-0079-0e85-32d657d1a1de@huawei.com>
References: <87eejqu5q5.fsf@nanos.tec.linutronix.de> <f2a4d172-fa17-9f98-ad8f-d69f84ad0df5@huawei.com> <87v9d2rrdq.fsf@nanos.tec.linutronix.de> <06977da1-d148-0079-0e85-32d657d1a1de@huawei.com>
Date:   Wed, 16 Dec 2020 16:31:53 +0100
Message-ID: <87im91sr6e.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kai,

On Wed, Dec 16 2020 at 22:18, shenkai wrote:
> After some tests, the conclusion that time cost is from deep C-state=20
> turns out to be wrong
>
> Sorry for that.

No problem.

> In kexec case, first let APs spinwait like what I did=C2=A0 in that patch,
> but wake APs up by sending apic INIT and SIPI=C2=A0 interrupts as normal
> procedure instead of writing to some address and there is no
> acceleration (time cost is still 210ms).

Ok.

> So can we say that the main time cost is from apic INIT and SIPI
> interrupts and the handling of them instead of deep C-state?

That's a fair conclusion.

> I didn't test with play_dead() because in kexec case, one new kernel
> will be started and APs can't be waken up by normal interrupts like in
> hibernate case for the irq vectors are gone with the old kernel.
>
> Or maybe I didn't get the point correctly?

Not exactly, but your experiment answered the question already.

My point was that the regular kexec unplugs the APs which then end up in
play_dead() and trying to use the deepest C-state via mwait(). So if the
overhead would be related to getting them out of a deep C-state then
forcing that play_dead() to use the HLT instruction or the most shallow
C-state with mwait() would have brought an improvement, right?

But obviously the C-state in which the APs are waiting is not really
relevant, as you demonstrated that the cost is due to INIT/SIPI even
with spinwait, which is what I suspected.

OTOH, the advantage of INIT/SIPI is that the AP comes up in a well known
state.

Thanks,

        tglx


