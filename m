Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9A82DBE71
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 11:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgLPKNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 05:13:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38790 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLPKNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 05:13:31 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608113570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8l/k1NyC4y+S+vQeMziqtqXyO59IG2+OXfCkYnccytg=;
        b=KONxMJ/oL1ggPZgiGfFkH4qLif28wMXzurVyV25tCXX2ElE9IkyTt8XzTNDDnR9ZuFpTAQ
        Vq75GqlsLREuX0FzfvpkXW+4losXBUJWL0PQtBX+E2A5mAGoDB/xJJEiqnLbvpLaFlLb4G
        z2gv9rMcLOl11BRdE9RG8A3Q9C1gmR1/Mn33bsIJqTaej6nhW+x383I16FYI9p2ynUKMgC
        CaV8luNEq69NhPjHxApNCwSvPHmhPTmt3aLWch0VY2pESBICldJRBqlroFReTaiWgD/dK6
        YkpxYQVGrm3A7dRakgQpgkl+AE+I5LO7qATsNRQ6xH0BJj35LDAdEzKGu2nG4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608113570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8l/k1NyC4y+S+vQeMziqtqXyO59IG2+OXfCkYnccytg=;
        b=SntMte3IJ+VAsa+CoVr+t7JbxGXjlO8ZITirmd8xUrEA58CadtTua4bWa6eghoKq4gR0qa
        asi2FUy9cWHfzOCQ==
To:     "shenkai \(D\)" <shenkai8@huawei.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        hewenliang4@huawei.com, hushiyuan@huawei.com,
        luolongjun@huawei.com, hejingxian@huawei.com
Subject: Re: [PATCH] use x86 cpu park to speedup smp_init in kexec situation
In-Reply-To: <f2a4d172-fa17-9f98-ad8f-d69f84ad0df5@huawei.com>
References: <87eejqu5q5.fsf@nanos.tec.linutronix.de> <f2a4d172-fa17-9f98-ad8f-d69f84ad0df5@huawei.com>
Date:   Wed, 16 Dec 2020 11:12:49 +0100
Message-ID: <87v9d2rrdq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kai,

On Wed, Dec 16 2020 at 16:45, shenkai wrote:
> =E5=9C=A8 2020/12/16 5:20, Thomas Gleixner =E5=86=99=E9=81=93:
>>
>>
> Thanks for your and Andy's precious comments. I would like to take a try =
on
>
> reconstructing this patch to make it more decent and generic.

>> It would be interesting to see the numbers just with play_dead() using
>> hlt() or mwait(eax=3D0, 0) for the kexec case and no other change at all.

Can you please as a first step look into this and check if the time
changes?

Thanks,

        tglx
