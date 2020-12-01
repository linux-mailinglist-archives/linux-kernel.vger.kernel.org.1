Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0392C98FB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 09:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgLAITs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 03:19:48 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49297 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726120AbgLAITs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 03:19:48 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 036575C01E3;
        Tue,  1 Dec 2020 03:18:42 -0500 (EST)
Received: from imap10 ([10.202.2.60])
  by compute2.internal (MEProxy); Tue, 01 Dec 2020 03:18:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dend.ro; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm1; bh=acxKL
        i+JrFZJ97JaedtJGyTgNs1PsHCPhnTqcGZukNI=; b=hJCNqY7cSFVcUSfrdVgtO
        cIV6TKW+AnZaSwGfNDR9/jhoMnGiERijvR7sMDuHIVQHfViJgTl61Kuk/IieQw2g
        uXZe+yemckUhqVK4BwlBWy562MrMSjttrbrjDwj1as2e8obWscwh9CBW1+GowQ9V
        oaCUP73Hlffnj0IDLIvI9/PoUoOQfkJxxWve5lpm/E7pyINTuGpuNAskwSAqM5sw
        B8ebTByejozaWy5ojmXKq77L0fFmpq5crkjOXiPitoCt7DaIC/KTdt73oLIjQbon
        tH1Fk/PgaNgFAq5ZDtF1x9xYCf6o8peY99yoxmuqP1DIb/zKfHeWYRReO+z6qDNQ
        w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=acxKLi+JrFZJ97JaedtJGyTgNs1PsHCPhnTqcGZuk
        NI=; b=N70Am1MAvOVUvjgAQ1v0K3+g+XQFxaX2L+Q3st35rIEMkECbcEBodaQIZ
        2R4Np2ZBloKrwNjjKFxJOVlTfskpTehPpoaDDnpa+BdOP88ACUcKLRTkzeaA6gsM
        rvH/Kor0yhHQgK9buMospvKhar5XWNTlipwouLcdr4ok8tj9IBYCmR9+1Fjr43Q3
        5yvilX5Xa/86LWDAQQvlkr4xO6bv1LC65RhZ7c54VXw2zUsq/3+BXJdBX7x+PQ7W
        5ZIgIQ+oS35lGa6F75czCsehCef9NoW/JTTDltOlL0WluzkNkoOMECZqkRLXlWrg
        CnjFr6Dvj3mtSSIMudUvOWJ9vamiQ==
X-ME-Sender: <xms:YfzFX4InKdbnDATx65np8GImrfo7lX2uRoUgjoVoJe-jdAnkYTdJJg>
    <xme:YfzFX4K60pgqZqz23i2q6nS9L4iiksaBwNFuPCCqT-OImT3-CY73vOE7uL_OFrjw4
    nZNDPVuDd1YatNQ7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeiuddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepnfgr
    uhhrvghnthhiuhgppfhitgholhgruceolhhnihgtohhlrgesuggvnhgurdhroheqnecugg
    ftrfgrthhtvghrnhepudegffeiffeiieeiieeigefhjedvudfgkefhieethfeglefhgfet
    ueetgfeiieeknecuffhomhgrihhnpehlkhhmlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlnhhitgholhgrseguvghnugdrrhho
X-ME-Proxy: <xmx:YfzFX4uNggjWlA1FWKRxK91iQVsb944qSGLKzgXfuSHeJ-nTa49RkA>
    <xmx:YfzFX1aSyDVG7F_jzyF2DHdyHV8CwaelbY1uGW2Mfl5-MZ6Zmuk0dQ>
    <xmx:YfzFX_ZWa9FGZHNpnfUlTUMrKjWzthXGi4mk17P-XQhRB5dUAvS8vA>
    <xmx:YfzFX-V2aOrgdiRkkNciTYI-1gxdNIOgkZdXCFviuprnX0CxD3TuTQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3D163201BD; Tue,  1 Dec 2020 03:18:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-622-g4a97c0b-fm-20201115.001-g4a97c0b3
Mime-Version: 1.0
Message-Id: <69841ea6-5998-46ca-8e49-3e9ee65fc8b1@www.fastmail.com>
In-Reply-To: <87tut6h10u.fsf@nanos.tec.linutronix.de>
References: <20201126074734.12664-1-lnicola@dend.ro>
 <875z5rk68z.fsf@nanos.tec.linutronix.de>
 <ea40c3e8-0be1-4783-ba1e-86c96cf8e4af@www.fastmail.com>
 <87lfeiiy10.fsf@nanos.tec.linutronix.de>
 <96085c8a-b144-4fd3-b1fb-45763b5b64a4@www.fastmail.com>
 <87tut6h10u.fsf@nanos.tec.linutronix.de>
Date:   Tue, 01 Dec 2020 10:18:21 +0200
From:   =?UTF-8?Q?Lauren=C8=9Biu_Nicola?= <lnicola@dend.ro>
To:     "Thomas Gleixner" <tglx@linutronix.de>
Cc:     mingo@kernel.org, bp@alien8.de, x86@kernel.org, trivial@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Tom Lendacky" <thomas.lendacky@amd.com>
Subject: Re: [PATCH] x86/irq: Lower unhandled irq error severity
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020, at 01:34, Thomas Gleixner wrote:
> The point is that for some cases this can result in a non working
> machine which just hangs and if it's below the usual loglevel cutoff,
> then it's not visible, which is more annoying than a non-quiet boot if=

> you're affected.

For most (desktop) users "errors" will be shown by default, and if anyon=
e is having trouble, they can temporarily remove "quiet" from the kernel=
 command line while debugging it, so it's easy. On the other hand, I don=
't think it's possible to silence the emergency messages (and I'd still =
like to see them for any "something is on fire").

The only other use of `pr_emerg_ratelimited` seems to be an informationa=
l message shown on non-AMD MCEs ("run mcelog --ascii"). `pr_emerg` is us=
ed in more places, but they do sound like critical situations that will =
bring the system down anyway.

>=20
> We are looking into a way to mitigate that AMD wreckage, but so far we=

> don't even know where exactly this comes from. The reason why we are
> pretty sure that it is a BIOS/Firmware issue is that some people
> reported it to be gone after a BIOS update and quite some machines do
> not have this issue at all.

In my case, it's latest BIOS version available. Could be AGESA-related, =
maybe we could install a no-op handler for that IRQ?

>=20
> Just for completeness sake. Can you provide the line in /proc/interrup=
ts
> for irq 7 on that machine?


  55:          0          0          0          0          0          0 =
         0          0          0          0          0          0       =
   0          0          0          0          0          0          0  =
        0          0          0          0          0          0        =
  0          0          0          0          0          0          0  I=
R-PCI-MSI 2625543-edge      xhci_hcd

PS: I now see that this was reported a lot of times, including e.g. http=
s://lkml.org/lkml/2019/3/6/97.

Thanks,
Lauren=C8=9Biu
