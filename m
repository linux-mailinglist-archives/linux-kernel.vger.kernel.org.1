Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18DF2FEC25
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbhAUNix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:38:53 -0500
Received: from mout.gmx.net ([212.227.15.15]:49081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732462AbhAUNgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611236066;
        bh=m1h6cl2uU7OzzlGvliTsG7x9mZ16AXj8EUYGlKHi8i0=;
        h=X-UI-Sender-Class:Subject:From:In-Reply-To:Date:Cc:References:To;
        b=fh/T5V0VhMXsErlNpk0VR6LoXvLRU72OshCEB95Ntn5Y3lx/qa1ixauTMbHzK/UVW
         K+qxBZhvSDjpP1T2M2ZQnr7tHRRNbebd2bamLK7PP6SRUUaiIkBDWsj/HXCWHEY7ug
         5+vGOWYG6Z6p0o7gbLgzJ/k9sfNKFqTwzOzfNTr0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.42.0.78] ([83.204.192.78]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9Wys-1l86Q22R76-005aAI; Thu, 21
 Jan 2021 14:34:26 +0100
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.5\))
Subject: Re: [RFC PATCH 7/7] irqchip/apple-aic: add SMP support to the Apple
 AIC driver.
From:   Mohamed Mediouni <mohamed.mediouni@caramail.com>
In-Reply-To: <71e94b48857cbdd21c5d6bdadf148621@kernel.org>
Date:   Thu, 21 Jan 2021 14:34:24 +0100
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Stan Skowronek <stan@corellium.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2861E21B-32B9-479E-A5F6-528D021183E6@caramail.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-8-mohamed.mediouni@caramail.com>
 <CAK8P3a1qeVxTxZXpfMe70zpPCSBrTOz23ZTR=PHgw0PP9GUvbw@mail.gmail.com>
 <E77005CF-8B2A-4D17-9330-72ECFD7F3C93@caramail.com>
 <71e94b48857cbdd21c5d6bdadf148621@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.5)
X-Provags-ID: V03:K1:glCtxedkl3ixCobh4vvhsEf/Kv5eEfQhHAOFGoOtog+GxG0rUMB
 Przav8dUY2dRpwfzwo1wTFmUo3hTMHfqqdbsU11K8LF61BJt3e1Osft4OmZBpko3mYOV3Rw
 t1O2wJHYrQ47kMFG3rhQPTbrFmZ07CR2aSYWDtVFLX5SgDYboaN9yqiDO7IMLXjW+e0lOhv
 mmW0b3P/lmDrSHY+OkA6w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wsmoz9YM8mQ=:9rI+dhS4aJEQWCGDjQd2/j
 ehOFwema9APHdqwVNwlMDwqtyIsWAqnbh9TyKpHu5GlF5L0yOCoUwudrvS3jHjrMNo9j+cuKp
 X0Al2X5rjeyNR59JPx7I57wMOWB7IjGcWG8nZtBiCd+/cSDnjj9/bs0hA/TSKD4+Go07dqSyx
 FKzp3L0pwR8zamfMVEGHzS0xZSpMAQfQ4m0tba02ZphMz2rmB5arY4G+CukYh9/2ZzBSNLWAE
 Rzx9aP3Fyop9/4CgYLGBn31aGHDF4wIc7t7mERB/jGsLbXhhkEFWKnoWPy3g8I+g1xQiB38+/
 0QUU99RiektQu2ZIq/QpZUgBjKsi5VweFSOsbKoZospq6fkHJwkxkyblWYhisBqcWNuoSQjva
 fiMogrvLkFWOSumdZdATcnYbdkvX8npiSXnrUhbbdCIRgmNA89HDcnAF8zhgVU8RyhvSJp2e5
 TtBU4JlS/GF7y63KpDbWXbyN/cUuUC5Lsh+4quDjYX51zZrGVkJTi5GanUXZU9KEjeFo9kc/n
 n8Pow2BqgbtjxwdQMaBtd439gU7A4T/snq0czzZcIRflMi9QS+kJrZjQIAw79Q1DLBlr7Adw6
 PRRUD4QZyg52P3fjHFpJ3Zr1oQbU5zZUWQA/6LXZioOtaFLqDzrCq+svri0XfNyOtJR57OYcV
 BXeCZ8yOqoMFg6DHnr3zDo6c7bCgn0hJoOR+BU/XdkHKGDMlxAKoufg+LAVQuRLp0MDA6U8DR
 frysKX9M9CPpWM7brA4zgSKjEbNQg/orGpBhO7J8BS3qDVQLEl4U/f8o+CAZBGarr1tuNlJSy
 NnjfcgzeJAtk/q2SNbcc/4b6bswC3JL8sKNPwCAVVeNj4Atu8pzOb2AvdbafNn+vBwm409Uot
 2/mLeaGlCO1uWeK+QABOLrVcvrK3HLk7mFLJ0f9FA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 21 Jan 2021, at 14:22, Marc Zyngier <maz@kernel.org> wrote:
>=20
> On 2021-01-21 12:50, Mohamed Mediouni wrote:
>>> On 21 Jan 2021, at 13:44, Arnd Bergmann <arnd@kernel.org> wrote:
>>> On Wed, Jan 20, 2021 at 2:27 PM Mohamed Mediouni
>=20
> [...]
>=20
>>>> +       aic.fast_ipi =3D of_property_read_bool(node, "fast-ipi");
>>> Where is this property documented, and what decides which one to =
use?
>> It=E2=80=99s getting documented in the next patch set.
>> This property is there to enable support for older iPhone processors
>> later on, some of which do not have fast IPI support.
>> On Apple M1, fast-ipi is always on.
>=20
> Then please focus on a single implementation. Additional features can
> always be merged later once something is up and running.
>=20
> Also, there sysregs can be detected by matching the MIDR, so I don't
> think we need a DT property for that.
>=20
> Thanks,
>=20
Because UART access adapters for the new M1 Macs aren=E2=80=99t =
plentiful
at all, I actually use this for development, with iPhones which have=20
much more easy to buy Lightning-to-UART adapters.

(That=E2=80=99s why the old implementation is there too)

Might be worth splitting the new one to a new commit though...

Thank you,
>        M.
> --=20
> Jazz is not dead. It just smells funny...

