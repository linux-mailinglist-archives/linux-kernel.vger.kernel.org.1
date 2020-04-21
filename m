Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B4F1B3117
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 22:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgDUUWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 16:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgDUUWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 16:22:03 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075D7C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 13:22:03 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p8so7304783pgi.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 13:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=uWDtBnrnHZNGBJOZ1uLZhpYXVa58EWkVMTVyh/sHeFo=;
        b=P0iCesRlhwF4dxcTYweoKhkr6tEsMx451LuE6i5dtJgdaOqLEJC7Ut2ULKUb+gwMSS
         PX3tYEcNipS5kHZ+2cUg9iJ+NjEtzqcPSsvgqa9OukJPme68Mc+NtlSe0uFVC77s+vp5
         bTQoylRublbwF+jzM3Z8Vr3emVlAUTVRf5NaODMOSoHqq0As6lu9c7VvHkX0zcJBnZKA
         te9Op/+TS/RUKMoXlPjyLBRPpVu1LlusRlkgO1mCmbakznoRaxlhpNbVybEj9w3sejSo
         zziKkjaBeodPzkOE6RQqarGviorXMfXRrRUPoew4KDtbXjxvEASeWjGIzWbmwyNQIfvg
         oZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=uWDtBnrnHZNGBJOZ1uLZhpYXVa58EWkVMTVyh/sHeFo=;
        b=Z6LirEoTT65IuABfafbOVDQck//R4DUPN0EUaOZSYCh2njn6fx6IKvSDzFAY4z6Ou/
         fITWDw9xpTY1ciVqlF9RTZoaW8oN9ndUYj+aaZyTVHSIKdIHgNEjMg3/QTeoKwAaNAU0
         rJG88EtbYwRx6qhQMJZHf1s3t42lw3CMaVSTq2YKXbuLTuA5q4oIc09YE9BA26Ys6ynV
         E/SzKg4Xglio8ZMC/fx1XPQicp+Z7BwnJDng54Jg+QFyC3x12lA+SVa8XoaK7JP94kcg
         gXu5EQUhk8L70KquIA4cSR1hGjHiaQ4hJympQh4T0WdvZnRukRgQPDrE0/buTUrELYhX
         070w==
X-Gm-Message-State: AGi0PubfyVGfPabhAXo/XmQ+hZQy4Znp1VLHK9E8Ma2XwQ9kLiNTaV1C
        s2FBQxnKFoDzQoXfH/7216NWKA==
X-Google-Smtp-Source: APiQypIMbG8k643bhsXUdoT15BGwG/GR7htXdaFnd0b8giF0dw4V8mXF0zoDCU0QYh6RS+fk37jveA==
X-Received: by 2002:a62:178b:: with SMTP id 133mr23576737pfx.61.1587500522476;
        Tue, 21 Apr 2020 13:22:02 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:2979:437c:2c39:9d85? ([2601:646:c200:1ef2:2979:437c:2c39:9d85])
        by smtp.gmail.com with ESMTPSA id i16sm3394250pfd.108.2020.04.21.13.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 13:22:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v9 00/17] Enable FSGSBASE instructions
Date:   Tue, 21 Apr 2020 13:21:39 -0700
Message-Id: <5957D3CC-B54B-4A1A-998A-0E6F58589CF4@amacapital.net>
References: <20200421195629.GE608746@tassilo.jf.intel.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simark@simark.ca>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20200421195629.GE608746@tassilo.jf.intel.com>
To:     Andi Kleen <ak@linux.intel.com>
X-Mailer: iPhone Mail (17E255)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 21, 2020, at 12:56 PM, Andi Kleen <ak@linux.intel.com> wrote:
>=20
> =EF=BB=BF
>>=20
>> Andi's point is that there is no known user it breaks, and the Intel
>> folks did some digging into potential users who might be affected by
>> this, including 'rr' brought up by Andy, and concluded that there won't
>> be breakage as a result of this patchset:
>>=20
>>    https://mail.mozilla.org/pipermail/rr-dev/2018-March/000616.html
>>=20
>> Sure, if you poke at it you could see a behavior change, but is there
>> an actual user that will be affected by it? I suspect not.
>=20
> Actually we don't know of any behavior changes caused by the kernel
> with selectors.
>=20
> The application can change itself of course, but only if it uses the=20
> new instructions, which no current application does.

If you use ptrace to change the gs selector, the behavior is different on a p=
atched kernel.

Again, I=E2=80=99m not saying that the change is problematic. But I will say=
 that the fact that anyone involved in this series keeps ignoring this fact m=
akes me quite uncomfortable with the patch set.

>=20
> [This was different in the original patch kit long ago which could
> change behavior on context switch for programs with out of sync selectors,=

> but this has been long fixed]

That=E2=80=99s the issue I was referring to.

>=20
> A debugger can also change behavior, but we're not aware of any case
> that it would break.

How hard did you look?

>=20
> For rr or criu we're also not aware of any case that could break.
>=20
> I honestly don't know what else could be done in due diligence.
>=20
> Also just to reiterate merging this would immediately shave off
> hundreds of cycles in most context switches.
>=20
> -Andi
