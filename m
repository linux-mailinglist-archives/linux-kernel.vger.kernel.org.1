Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB001E2246
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 14:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388789AbgEZMxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 08:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgEZMxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 08:53:30 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AB7C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 05:53:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49WYmR1NcJz9sSk;
        Tue, 26 May 2020 22:53:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1590497607;
        bh=EtQztu5NmCVqCIZyOPV1ACDAhtqa29TG/2fKZ5rLLpM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JI1at74GbvNS0bVZEFf4OJViTkUOEyGb9fPhmr2DTYm5O7v0GBZG/v95TXx6OEi/3
         TJvX6neupQJbZFN5DwEeJCflq/AdfjG4KX2SVWUFJGqapba3Qhl9Th4l/pmHEIetbk
         WPgw4N5388UQGaJPyZ2DAM+ns5FY1MpNoEA/+N4r3AWzP3n6gh1s58vWvPV4giPXQs
         U6A98J/W8N/M0+FtXA/bEWw785sz4tDDsyqxXmwwC2Rj/dzm/CKtM5rvxXsM/W6xNj
         Dxj+d3NsG23J/wrpteipjywiqGmjwQcXbj2l+RDakBFQju9YkcBSK8UFtWDvzB5a21
         3gPpFoBMjaWCQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 07/45] powerpc/ptdump: Limit size of flags text to 1/2 chars on PPC32
In-Reply-To: <e505c554-21b1-3d02-1ea5-c2a214b80ebb@csgroup.eu>
References: <cover.1589866984.git.christophe.leroy@csgroup.eu> <83a7a0cfca6198e63caf7a16839bd18454961f52.1589866984.git.christophe.leroy@csgroup.eu> <87h7w4fvcy.fsf@mpe.ellerman.id.au> <e505c554-21b1-3d02-1ea5-c2a214b80ebb@csgroup.eu>
Date:   Tue, 26 May 2020 22:53:50 +1000
Message-ID: <87zh9ueu1t.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 25/05/2020 =C3=A0 07:15, Michael Ellerman a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>> In order to have all flags fit on a 80 chars wide screen,
>>> reduce the flags to 1 char (2 where ambiguous).
>>=20
>> I don't love this, the output is less readable. Is fitting on an 80 char
>> screen a real issue for you? I just make my terminal window bigger.
>
> I don't have strong opinion about that, and the terminal can be made bigg=
er.
> I just don't like how messy it is, some flags are so big that they hide=20
> other ones and getting it more ordered and more compact helped me during=
=20
> all the verifications I did with this series, but we can leave it as is=20
> if you prefer.

I think I do.

> Would you like a v5 without patches 7 and 8 ? Or I can just resend the=20
> patches that will be impacted, that is 9 and 38 ?

I dropped 7 and 8 and then fixed up 9 and 38, it was easy enough.

I used "coherent" and "huge".

> With the change I get.
>
> ---[ Start of kernel VM ]---
> 0xc0000000-0xc0ffffff  0x00000000        16M   h  r   x  p        sh     a
> 0xc1000000-0xc7ffffff  0x01000000       112M   h  rw     p        sh  d  a
> ---[ vmalloc() Area ]---
> 0xc9000000-0xc9003fff  0x050e4000        16K      rw     p        sh  d  a
> 0xc9008000-0xc900bfff  0x050ec000        16K      rw     p        sh  d  a
> 0xc9010000-0xc9013fff  0xd0000000        16K      rw     p  i  g  sh  d  a
> 0xc9018000-0xc901bfff  0x050f0000        16K      rw     p        sh  d  a

It's definitely more compact :)

But I worry no one other than you will be able to decipher it, without
constantly referring back to the source code.

cheers
