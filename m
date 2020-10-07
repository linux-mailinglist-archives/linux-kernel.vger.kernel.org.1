Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28F52865FE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 19:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgJGRcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 13:32:43 -0400
Received: from mail-41103.protonmail.ch ([185.70.41.103]:52462 "EHLO
        mail-41103.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgJGRcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 13:32:43 -0400
Received: from mail-03.mail-europe.com (mail-03.mail-europe.com [91.134.188.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 45799200042A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 17:32:41 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="jrhtjpse"
Date:   Wed, 07 Oct 2020 17:32:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1602091958;
        bh=BYNQ4Z6yjIk9IsDDEPdgqxZjFtVaEs6dDvEa2sPxVHU=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=jrhtjpseKScEpsPLIawRw8MFlSoZ15XPouDy0s+f5ZIwiIm779cBL/V1PU3UOuWeL
         8MRqR9h4NgJltJUK5iVk6K/kOmwxwGbODuD39Obj28d2hdkjnldnPGkeYW5hQfk2/F
         0hmWC377xsa0HeNF18spfhqHwEFpaw4qZUjwKxjo=
To:     Hans de Goede <hdegoede@redhat.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Elia Devito <eliadevito@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v2] platform/x86: hp-wmi: add support for thermal policy
Message-ID: <k8GF7y7_mFT5nk-CGsZKHT32w0-qC_nlvitYD6jfCHWTb38gJZh83XcuyNX4vuySFFwF9o-_hFvgVL68Gr_L0bLPAjo3AT5bt-NREiSpMFw=@protonmail.com>
In-Reply-To: <37a0a8b8-6792-8ed7-2e66-da0fa1d6302a@redhat.com>
References: <20200917214957.GD29136@mtg-dev.jf.intel.com> <20201004211305.11628-1-eliadevito@gmail.com> <CAHp75VfbK226a-SsNj=Bnpfc3wWyT9K_D4XzAMOu9of1_g+8-A@mail.gmail.com> <5d60709b-e3cb-685f-2b3e-07381b9855e5@redhat.com> <zm1oBveg0S9L-MagzWnleGj5ZfQg8cV95Ugbzz6WZbnv-nzpF8_9Fghwj8P8V-ZAmVF6kRBWF-blVcOFirhSN3xxmE_8cOUycONWZMJP5xE=@protonmail.com> <37a0a8b8-6792-8ed7-2e66-da0fa1d6302a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

2020. okt=C3=B3ber 7., szerda 19:30 keltez=C3=A9ssel, Hans de Goede =C3=
=ADrta:
> [...]
> Since I'm just getting up2speed in my new role today, I have never pushed
> that branch out yet, hence the error.
>
> I've pushed it out now, the mirrors which actually serve
> the http interface can lag a bit, so give it 10 minutes and
> then it should be there.
> [...]


I see, thanks!


Regards,
Barnab=C3=A1s P=C5=91cze
