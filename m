Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7712B3603
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 17:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgKOQF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 11:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgKOQF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 11:05:58 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74841C0613D1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 08:05:58 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d3so6890124plo.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 08:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=mbozwE9sISskjeBERM9vaf72sNbzg+5qdk+yMKq7mvM=;
        b=h1HEDBfeBelB6qTBaesJ3a8rdojpBL3JAjCllR84o02xDjGAHeUini3SY4y81FOZ0a
         g/ucLRaKq9IzPlvQ/z0YJe4zTZCqXeYou16/1auyNZ86CWWolARlc125buxCtt9PwE8I
         +wFtQbDWgxLsCa5e/W19hTut3HjNxhjNSei58HYeQb9TBs4QqCRoW4LqL4ODm3fyavym
         HPQEW2mcvZSCeZOUHJ4+Al1iVUkfhV9ZmMQUnILpl7RVtEc6Prv1J4AUfQTlMcALvDUr
         CgV/pUStwfmVAPNXyknysnEvLDM5vNGhy3uuvTm5Af8CGo2CedKXurrw4BZs50H5r83z
         7C5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=mbozwE9sISskjeBERM9vaf72sNbzg+5qdk+yMKq7mvM=;
        b=EWU7XrFTcpDxZpeCN3gYBzlCRTie9j600f8oJfb/CvRrWvvyK5EG7kbhBgptdOrWxC
         LfvoTscxK4SuUdQtdLlln7cYhvaifQkSji2BPWIGCtnlUHNvnumPbEaxR2SNNK1H8kQM
         r9wvrcKfQIRcTSSeXfaMQaVnC1U9sZbzWjOlWS/K09OK6Sk7w2I/KgTmy7kkdIxBD5y+
         bPia5vdvVmQNVGXx9wUvMEzG9HaBTaQ9SkuaPuMbouldwLyeor9oHIKfn+p+ybHSVgnD
         kdW2wPJAnnqZTIt+kvBoCy8rXxXOXdc8l46pMzn3Thudi3rwpSfzkKEvZJbwd6iYID7F
         Q+JQ==
X-Gm-Message-State: AOAM532sdM1zz9UjX4Z0eHC7vaqewczhUJTnkWxY6QOnpGCZT3VC8w4n
        tAROWUm5zXJj7bHI2zUiPz3kwb7ZaiS9MXpW
X-Google-Smtp-Source: ABdhPJzYRyz/tP+GybI6ijUjWwKPcHople18Hm/s8dzwymESDxdhWu+uDHhjrsdtRIwf7zHgT1vMOA==
X-Received: by 2002:a17:902:167:b029:d8:cfe5:bdee with SMTP id 94-20020a1709020167b02900d8cfe5bdeemr9917664plb.11.1605456356856;
        Sun, 15 Nov 2020 08:05:56 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:a4e1:4011:d190:bd04? ([2601:646:c200:1ef2:a4e1:4011:d190:bd04])
        by smtp.gmail.com with ESMTPSA id u197sm16209955pfc.127.2020.11.15.08.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2020 08:05:56 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: WARNING: can't access registers at asm_common_interrupt
Date:   Sun, 15 Nov 2020 08:05:55 -0800
Message-Id: <53DCD372-A847-4B74-A034-330E372B4EB5@amacapital.net>
References: <01c2234c-39a3-2227-25b9-854144c6eb27@suse.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        X86 ML <x86@kernel.org>
In-Reply-To: <01c2234c-39a3-2227-25b9-854144c6eb27@suse.com>
To:     =?utf-8?Q?J=C3=BCrgen_Gro=C3=9F?= <jgross@suse.com>
X-Mailer: iPhone Mail (18B92)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 14, 2020, at 10:33 PM, J=C3=BCrgen Gro=C3=9F <jgross@suse.com> wrot=
e:
>=20
> =EF=BB=BFOn 14.11.20 19:10, Andy Lutomirski wrote:
>>> On Sat, Nov 14, 2020 at 1:16 AM J=C3=BCrgen Gro=C3=9F <jgross@suse.com> w=
rote:
>>>=20
>>> On 13.11.20 18:34, Andy Lutomirski wrote:
>>>> On Wed, Nov 11, 2020 at 12:25 PM Andrew Cooper
>>>> <andrew.cooper3@citrix.com> wrote:
>>>>=20
>>>> So I think there is at most one of these that wants anything more
>>>> complicated than a plain ALTERNATIVE.  Any volunteers to make it so?
>>>> Juergen, if you do all of them except USERGS_SYSRET64, I hereby
>>>> volunteer to do that one.
>>>=20
>>> Why is a plain alternative (either swapgs; sysretq or a jmp xen_sysret64=

>>> depending on X86_FEATURE_XENPV) no option?
>>>=20
>>> Its not as if this code would run before alternative patching.
>> ALTERNATIVE would "work" in the sense that it would function and be
>> just about as nonsensical as the current code.  Fundamentally, Xen
>> PV's sysret feature is not a drop-in replacement for SYSRET64, and
>> pretending that it is seems unlikely to work well.  I suspect that the
>> current code is some combination of exceedingly slow, non-functional,
>> and incorrect in subtle ways.
>> We should just have a separate Xen PV exit path the same way we have a
>> separate entry path in recent kernels.  *This* is what I'm
>> volunteering to do.
>=20
> I don't think there is much work needed. Xen PV does basically a return
> to user mode via IRET. I think it might work just to use
> swapgs_restore_regs_and_return_to_usermode() unconditionally for Xen PV.
>=20

I=E2=80=99m quite confident that will work, but I was hoping to get it to wo=
rk quickly too :)

>=20
> Juergen
> <OpenPGP_0xB0DE9DD628BF132F.asc>
