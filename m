Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A582FE856
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbhAULFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:05:46 -0500
Received: from mout.gmx.net ([212.227.15.18]:59393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730194AbhAULD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611226897;
        bh=eYAy1J2NKCY+RyTEa0EWRFh3SqSrlZL9klmVxa9DBP0=;
        h=X-UI-Sender-Class:Subject:From:In-Reply-To:Date:Cc:References:To;
        b=KsNcBfRlO4MSYxzNTo+lKweEPmFbUpKuAC3FzA6e08+GmeL6/8h2jidgKh8PiWoG0
         8qIlEtt5D06Sroy3Ib2b2pFvL2N3q6f1ioziwFYIBysqEW18OwhkCfjlrrEWfBTL9j
         bs9GO8CAGR5gBgJdgkS6Kd3JP8vamgludLOcKXpU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from rainbow.home ([83.204.192.78]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mnpns-1lnQzr34Ru-00pPgR; Thu, 21
 Jan 2021 12:01:37 +0100
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.5\))
Subject: Re: [RFC PATCH 2/7] arm64: kernel: Add a WFI hook.
From:   Mohamed Mediouni <mohamed.mediouni@caramail.com>
In-Reply-To: <CAK8P3a20XRHaErO5445ds6tf0omSKLMZ_NAWdS=9nBbLb7rdvg@mail.gmail.com>
Date:   Thu, 21 Jan 2021 12:01:35 +0100
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Stan Skowronek <stan@corellium.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5403A355-A4FA-442B-8F8B-5629FCECC006@caramail.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-3-mohamed.mediouni@caramail.com>
 <CAK8P3a20XRHaErO5445ds6tf0omSKLMZ_NAWdS=9nBbLb7rdvg@mail.gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.5)
X-Provags-ID: V03:K1:I2JAzLKjoXvPuwdCtfo/qK44jRV3D6+4JtEipYPBpKJkz3GnCCr
 LkAhBQ12Y/bZRdq6BmPN2YLEwma0r31aHHK7kwT7bIMwdPIZ5iWubXqFKJbKB0PcXx6BKkr
 f+yaEblViJDEjLfdBxyfPEQADVDCrode8YonnEWKA6/D0AihKSKe3K0dzui7TNXtsxceBa6
 Y7inpx4RMktYGHpRQPArA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MlMw1I/SbqU=:0SX2+4xrMQRL/VGj2YF9JI
 4zQSFzEI/qsJ/dnqlx9IfJe4WYjfhx8/rgF62KUOiVBliOhvsVXK3yLX6tS9hc4TS+b88UrJk
 //V96TeDHPX8DblX4BM/15Ya93JMcOrRZMmCa+5xz1hIpBNZPTVEGpd2WukHHgo/whwl7fahh
 v5FSKiY1Hp90CrS6GiwhD5/jnZo3LrEIlISODE9MKWhlXWbQOvpLsYq+7O6TU2W6j4l6prwKP
 NSQN4Mq9+qmeDAXtmph+ZmwQcwndLRZFEQdKrSrgbfBH9ngz6Vs4rpY2y/t8RFJl9rQ9j4Smh
 W+ZwYdco2OfQh+3PpSypaSRurv0+fCXt0l/6fQZnED/UovKevCyrz09rCq/GdNd8rrvHMdnOq
 BQfPiR9DC14J8QNtoOmrmIJdYijPp+Y+KCUX9x+CyZpW3sqmZ1RLROjsAIieIxT7wUatsL7ys
 I2GLh8fNUNOrcGHqqAJH2QB1GdLNSt6m8PiCZCLtQ76rGs+5oDYZ0K5JWtdMtGn3YhOr2/X1t
 ygdK5DWYcmDbqT9xgY5Faeip41FlhEPc6CfHtYg5Wkvr5use1scmV6KRwTLCO42xFkRyhDE7w
 D3gJul9AANgOJzn0RxgtC700I78IETIRm9dk/uLx3IvK7EZTlC9cUZIB/VJ3JFlLoHtefEP+B
 9fQXtiN/KDi1LGLAVyN2ESlWiJ4sH2qUc6K1nLLCpF2dU6mjQATo6urFSZvArOUgVjvlforFZ
 cGu8+axz5WXFp6jpBFGi7MMI2tRyQw+WjUbQ1jOta9VUNnMNeAAjtrgj3auavUblnb0auOTbo
 ywu/JLrmMBFRW53bkykqm0kfoY0EQPQffjw3NolNExLzSi25LzgAjxdZmnHMvXdZD5YOnwDX9
 jjSWuzlt7wn/LrVN8eCCas86PLjU5+PAeshTgxfts=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 21 Jan 2021, at 11:52, Arnd Bergmann <arnd@kernel.org> wrote:
>=20
> On Wed, Jan 20, 2021 at 2:27 PM Mohamed Mediouni
> <mohamed.mediouni@caramail.com> wrote:
>> --- a/arch/arm64/kernel/cpu_ops.c
>> +++ b/arch/arm64/kernel/cpu_ops.c
>=20
>> #if defined(CONFIG_STACKPROTECTOR) && =
!defined(CONFIG_STACKPROTECTOR_PER_TASK)
>> #include <linux/stackprotector.h>
>> @@ -74,8 +75,14 @@ void (*arm_pm_restart)(enum reboot_mode =
reboot_mode, const char *cmd);
>>=20
>> static void noinstr __cpu_do_idle(void)
>> {
>> -       dsb(sy);
>> -       wfi();
>> +       const struct cpu_operations *ops =3D =
get_cpu_ops(task_cpu(current));
>> +
>> +       if (ops->cpu_wfi) {
>> +               ops->cpu_wfi();
>> +       } else {
>> +               dsb(sy);
>> +               wfi();
>> +       }
>> }
>=20
> I think the correct place to put this would be a platform specific =
driver
> in drivers/cpuidle/ instead of an added low-level callback in the
> default idle function and a custom cpu_operations structure.
Can we make sure that wfi never gets called even on early
boot when using a cpuidle driver?

Thank you,
>=20
>       Arnd

