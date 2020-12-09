Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F282D417E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbgLIL4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:56:11 -0500
Received: from mail-03.mail-europe.com ([91.134.188.129]:59114 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730891AbgLIL4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:56:00 -0500
Date:   Wed, 09 Dec 2020 11:54:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1607514873;
        bh=Am0wfylruDvvobV80Pi9fvVjNOBPb92unpvDC6wBAgE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=RCaqQUBsKJwS4CA4BlHNqA4xQR6PyhGBqvJzlWDyhD/eQDEIUyCkmZ6jCwY1C2ozU
         dDGPmzpXGorWwYNcVmfCTHoc2CekOLqyXZRogVAnmrlzm4y5xVZjdqpruCqasIm2W4
         ThdJtDEK/wkDj9Ra/4LJ9ex/XU5Cej/Su275dFF0=
To:     Vladimir Oltean <olteanv@gmail.com>
From:   Aswin C <realc@protonmail.com>
Cc:     Aswin C <aswinraman2013@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>
Reply-To: Aswin C <realc@protonmail.com>
Subject: Re: [PATCH] net: dsa: sja1105: Remove an unprofessional word from the code comments
Message-ID: <-gMuTlvCAcfhIMqI1V4ylxBXKdWffUwznP_0cODJaam4l3hyfEFTLkZUZMLQV23BCeO8S6vTh1OfN0yOi7M5PhfX0rOX8SkL9JknVM2nKOA=@protonmail.com>
In-Reply-To: <20201208123515.wb72g6zwtxlawp34@skbuf>
References: <20201208103332.5095-1-realc@protonmail.com> <20201208123515.wb72g6zwtxlawp34@skbuf>
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

Hello. Thank you very much for the reply.

Firstly, yes, it's my first contribution and apologies for making some mist=
akes and I'd like to thank you for being kind and pointing it out.

I came to know about this driver in a casual discussion among my peers when=
 one of them pointed out the presence of this particular word on the driver=
. I just thought that I'd try to help and get rid of that, if possible. Not=
hing more.

As you mentioned, I ran my eyes over drivers/net/dsa/sja1105/sja1105_tas.c =
and the other files. Other than a very minor spelling error, I didn't come =
across wording conventions like the one we are discussing about.

And yes, as you mentioned, "poorly organized" sounds perfect, too.

I believe that not signing off and not sending it to all maintainers is all=
, in the things I did wrong. So, I hope I can fix them and send the patch a=
s a reply to this thread.

Thank you.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Tuesday, December 8, 2020 6:05 PM, Vladimir Oltean <olteanv@gmail.com> w=
rote:

&gt; Hi Aswin,
&gt;
&gt; On Tue, Dec 08, 2020 at 04:03:32PM +0530, Aswin C wrote:
&gt;
&gt; &gt; Remove the word 'retarded' from the code comments with a more pro=
fessional word
&gt; &gt; 'erroneous' to make it less profane.
&gt; &gt;
&gt; &gt; -----------------------------------------------------------------=
----------------------------------------------------
&gt; &gt;
&gt; &gt; drivers/net/dsa/sja1105/sja1105_dynamic_config.c | 2 +-
&gt; &gt; 1 file changed, 1 insertion(+), 1 deletion(-)
&gt; &gt; diff --git a/drivers/net/dsa/sja1105/sja1105_dynamic_config.c b/d=
rivers/net/dsa/sja1105/sja1105_dynamic_config.c
&gt; &gt; index b777d3f37..7a76180f3 100644
&gt; &gt; --- a/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
&gt; &gt; +++ b/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
&gt; &gt; @@ -250,7 +250,7 @@ sja1105pqrs_l2_lookup_cmd_packing(void *buf, =
struct sja1105_dyn_cmd *cmd,
&gt; &gt; SJA1105PQRS_SIZE_L2_LOOKUP_ENTRY, op);
&gt; &gt; }
&gt; &gt; -/* The switch is so retarded that it makes our command/entry abs=
traction
&gt; &gt; +/* The switch is so erroneous that it makes our command/entry ab=
straction
&gt; &gt;
&gt; &gt; -   crumble apart.
&gt; &gt; -
&gt; &gt; -   On P/Q/R/S, the switch tries to say whether a FDB entry
&gt; &gt;     --
&gt; &gt;     2.29.2
&gt; &gt;
&gt;
&gt; Thank you for the patch and for what looks like your first contributio=
n
&gt; to the kernel. First of all, when you submit a patch, you should follo=
w
&gt; the development process at:
&gt; https://www.kernel.org/doc/html/latest/process/submitting-patches.html
&gt; https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.rst
&gt;
&gt; You should use ./scripts/get_maintainer.pl and send the email to all
&gt; maintainers that get listed there, plus the mailing list.
&gt;
&gt; I don't feel that "erroneous" is the right replacement. Maybe "poorly =
organized".
&gt;
&gt; Although I am not sure that "professional" is something that I was goi=
ng
&gt; for when I wrote this driver.
&gt;
&gt; This makes me curious what exactly motivated you to make the change? D=
o
&gt; you feel offended by the use of profanity when used to describe hardwa=
re?
&gt; How did you even pick the sja1105 driver. I can think of two possibili=
ties:
&gt;
&gt; -   You are working with it. But in this case, I do wonder how you fee=
l by
&gt;     the larger amount of profanity in drivers/net/dsa/sja1105/sja1105_=
tas.c.
&gt;     Are you planning further patches for that?
&gt;
&gt; -   You just searched the kernel sources for profanity, or, putting it
&gt;     differently, you were actively trying to be offended.
&gt;

</olteanv@gmail.com>
