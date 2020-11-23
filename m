Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAC32C09BE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 14:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388207AbgKWNLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 08:11:16 -0500
Received: from relay-us1.mymailcheap.com ([51.81.35.219]:47048 "EHLO
        relay-us1.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbgKWNLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 08:11:12 -0500
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 8094A20E9F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 13:11:10 +0000 (UTC)
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.66.161])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 84E072008F;
        Mon, 23 Nov 2020 13:11:03 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id CC9A43ECDF;
        Mon, 23 Nov 2020 14:11:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id A86D82A510;
        Mon, 23 Nov 2020 14:11:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1606137061;
        bh=n+9CKV1+EcairAIXvhFHe2SDd55at9qkp7mbMG4qEUE=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=PToUS88STuOiSB3rUbm+00QMf+NY8sLoL0QTLTTLsVnetl0m7VYdSZO1LT1elU38G
         b3Xw98T4WD1VWri/qa7eFdClRqMZbZFEHJOs5jadKUqnAqtfA8qdqm2BXKE78ISbO2
         uCH5AmB5QxIfbVTMIF08Hg7122kzbh9G0dpFk4Dw=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m3xVZCFxJ87b; Mon, 23 Nov 2020 14:11:00 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Mon, 23 Nov 2020 14:11:00 +0100 (CET)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 4893641F56;
        Mon, 23 Nov 2020 13:10:59 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="JIoQYmTK";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [172.19.0.1] (unknown [64.225.114.122])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id DFE7441FD3;
        Mon, 23 Nov 2020 13:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1606137051; bh=n+9CKV1+EcairAIXvhFHe2SDd55at9qkp7mbMG4qEUE=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=JIoQYmTKIAhWHINNfIDTPqDZhm0TCq0YLOIGSz9kZwt/pRLqlEQPCmJM2URz7tVH1
         6wZl6cr1Sw0jmHvo0R5M9igTNQGUsiDgcr2WvCuGB2eBnPnXme9ea/bljL/NFqJb/Y
         iV4BfbkUh/vC3y/H//VWY2+j3j0TbTDWYgCQrpMM=
Date:   Mon, 23 Nov 2020 21:10:38 +0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20201123125332.2p5z3ew7svszvyfs@gilmour>
References: <20201107125332.2223197-1-icenowy@aosc.io> <20201110103925.rbej5ueo2fefbmlp@gilmour.lan> <6175E674-E8BC-4199-8BE8-A983065C32D5@aosc.io> <20201116155508.364dg6ycklwylswe@gilmour.lan> <8FFC1A6C-9CA4-4F94-91C4-F111A7519979@aosc.io> <20201120155939.3ajmbny2pka2vsnf@gilmour> <A8E91BA0-22FD-47F4-A5B2-A80A38FE9A0E@aosc.io> <38ee5feb-e35d-801f-99a1-65e23618e73b@sholland.org> <20201123111512.y7lbwsipbkcpuleb@gilmour> <97E2037C-3C3C-4B0B-8462-39B9E38CB3BB@aosc.io> <20201123125332.2p5z3ew7svszvyfs@gilmour>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [linux-sunxi] Re: [PATCH 3/3] arm64: allwinner: dts: a64: add DT for PineTab developer sample
To:     maxime@cerno.tech, Maxime Ripard <maxime@cerno.tech>
CC:     Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <009A22D9-AF20-45C4-9674-13334B3EFFBA@aosc.io>
X-Rspamd-Queue-Id: 4893641F56
X-Spamd-Result: default: False [1.40 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[10];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2020=E5=B9=B411=E6=9C=8823=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
8:53:32, Maxime Ripard <maxime@cerno=2Etech> =E5=86=99=E5=88=B0:
>On Mon, Nov 23, 2020 at 07:25:47PM +0800, Icenowy Zheng wrote:
>>=20
>>=20
>> =E4=BA=8E 2020=E5=B9=B411=E6=9C=8823=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=887:15:12, Maxime Ripard <maxime@cerno=2Etech>
>=E5=86=99=E5=88=B0:
>> >Hi!
>> >
>> >On Fri, Nov 20, 2020 at 08:51:48PM -0600, Samuel Holland wrote:
>> >> On 11/20/20 5:30 PM, Icenowy Zheng wrote:
>> >> >>>>>>> +/ {
>> >> >>>>>>> +	model =3D "PineTab Developer Sample";
>> >> >>>>>>> +	compatible =3D "pine64,pinetab-dev",
>"allwinner,sun50i-a64";
>> >> >>>>>>> +};
>> >> >>>>>>
>> >> >>>>>> Changing the DT and the compatible half-way through it
>isn't
>> >ok=2E Please
>> >> >>>>>> add a new DT with the newer revision like we did for the
>> >pinephone
>> >> >>>>>
>> >> >>>>> We did this on Pine H64=2E
>> >> >>>>
>> >> >>>> What are you referring to? I couldn't find a commit where we
>did
>> >what
>> >> >>>> you suggested in that patch to the pine H64=2E
>> >> >>>
>> >> >>> Oh the situation is complex=2E On Pine H64, we didn't specify
>> >anything at
>> >> >>> start (which is the same here), the DT is originally
>> >version-neutral
>> >> >>> but then transitioned to model B, then reverted to model A=2E
>Here
>> >the DT is always
>> >> >>> for the sample=2E
>> >> >>>
>> >> >>> However, for Pine H64 there's model A/B names, but for PineTab
>> >there's no
>> >> >>> any samples that are sold, thus except who got the samples,
>all
>> >PineTab
>> >> >>> owners simply owns a "PineTab", not a "PineTab xxx version"=2E
>> >> >>
>> >> >> It's fairly simple really, we can't really predict the future,
>so
>> >any DT
>> >> >> submitted is for the current version of whatever board there
>is=2E
>> >This is
>> >>=20
>> >> I don't think that was the intention at all=2E The DT was submitted
>for
>> >a
>> >> future product, whatever that future product ends up being at the
>> >time
>> >> of its release=2E Since there are necessarily no users until the
>> >product
>> >> ships, there is no chance of breaking users by modifying the DT=2E
>> >
>> >There was no indication of that in the commit though
>> >
>> >> >> what we (somewhat messily) did for the PineH64, for the
>pinephone,
>> >or
>> >> >> really any other board that has several revisions
>> >>=20
>> >> Surely a non-public prototype doesn't count as a separate
>revision!
>> >This
>> >> sort of policy strongly discourages ever shipping a board with
>> >> out-of-the-box mainline Linux support=2E Because if there any
>hardware
>> >> bugs fixed between initial upstreaming and production, the
>> >manufacture
>> >> must come up with a new DT name=2E
>> >>=20
>> >> This is hostile to the users as well, because the "canonical" DT
>name
>> >no
>> >> longer matches the "canonical" (read: the only one ever available)
>> >> version of the hardware=2E
>> >>=20
>> >> Do you want manufacturers to submit their initial board DT as
>> >> "$BOARD-prototype=2Edts", just in case they have to make a change
>> >before
>> >> production? And only after the board is shipped (with out-of-tree
>> >> patches, of course, to use $BOARD=2Edts, since the shipped board is
>> >*not*
>> >> the prototype) submit a "$BOARD=2Edts" to mainline?
>> >>=20
>> >> Maxime, can you clarify specifically what the line is where a
>device
>> >> tree is "locked down" and further changes to the hardware require
>a
>> >new
>> >> name? First sample leaves the factory? $NUMBER units produced?
>First
>> >> sold to the public for money?
>> >
>> >The first board that is shipped to a user=2E From the wiki, the
>version
>> >supported here (I guess?) has been shipped to around 100 people, so
>it
>> >doesn't really qualify for the "non-public prototype"=2E We still have
>to
>> >support these users, whether we like it or not=2E
>> >
>> >> Without some guidance, or a change in policy, this problem is
>going
>> >to
>> >> keep coming up again and again=2E
>> >
>> >There's a few things that are interleaved here=2E First, there's two
>hard
>> >rules: never change the DT name and never change the compatible of a
>> >board=2E
>> >
>> >The former would break any build system, boot script or
>documentation,
>> >and the latter would break the DT compatibility=2E
>> >
>> >Aside from this, things get a bit blurrier since it's mostly about
>the
>> >intent=2E I'm fine with having a DT for a non-public prototype if it's
>> >clear from day one that it is=2E In this particular case, the DT just
>> >stated that support for the pinetab was added=2E I guess anyone would
>> >make
>> >the assumption without any context that this would be for the (or a)
>> >final design=2E
>> >
>> >Finally, I'd also advise against submitting the parts that are still
>> >not
>> >finalized though, because this is also fairly bad for the users=2E
>Let's
>> >take the current situation as the example: from what I understand,
>the
>> >screen changed half-way through the process, and the first one was
>> >upstreamed=2E This means that any user that would use a kernel with
>that
>> >bugfix would have the display working, while rolling back to 5=2E9
>would
>> >break the display, even though everyone claimed it was supported
>> >out-of-the-box in mainline=2E This is a worse situation than not
>> >supporting the display in the first place here=2E
>> >
>> >> You'll note that so far it has mostly affected Pine devices, and I
>> >don't
>> >> think that's because they make more board revisions than other
>> >> manufacturers=2E
>> >
>> >Yes definitely=2E Pine devices may be worse though because of their
>> >policy
>> >of making their prototypes public=2E I guess most of the issues we had
>> >also were due to poor communication: context on what were the Pine
>> >intentions were missing, and thus we couldn't catch things that
>turned
>> >out to be bad later on during review=2E
>> >
>> >> It's because they're actively involved in getting their
>> >> boards supported upstream=2E For other manufacturers, it's some user
>> >> sending in a device tree months after the hardware ships to the
>> >public
>> >> -- of course the hardware is more stable at that point=2E
>> >
>> >I mean, it's not black and white either=2E One could very well send
>the
>> >DT
>> >once the final design is done and that would still be upstreamed way
>> >before reaching the first user=2E
>> >
>> >> I think Pine's behavior is something we want to encourage, not
>> >> penalize=2E
>> >
>> >For the DT in particular, yes
>> >
>> >> > Okay=2E But I'm not satisfied with a non-public sample occupies
>> >> > the pinetab name=2E Is rename it to pinetab-dev and add a
>> >> > pinetab-retail okay?
>> >>
>> >> To me, naming the production version anything but "pinetab" isn't
>> >> satisfying either=2E
>> >
>> >I understand where you're coming from, but the point I was making my
>> >previous mail is precisely that it's not really possible=2E
>> >
>> >You want to name the early adopter version _the_ production version=2E
>> >Let's assume the hardware changes again between the early adopter
>and
>> >mass-production version=2E Which one will be _the_ production version?
>> >The
>> >early-adopter or the mass-produced one?
>> >
>> >There's really no good answer here, and both would suck in their own
>> >way=2E The only way to deal with this is to simply avoid defining one
>> >version as the one true board, and just loading the proper DT in
>u-boot
>> >based on whatever clue we have of the hardware revision=2E
>>=20
>> Then will it be okay to rename current pinetab DT to pinetab-sample
>and
>> then introduce new DTs all with suffixes?
>
>No=2E From my previous mail:

It can be seen as dropping the PineTab DT and introduce new DTs with suffi=
x=2E

Do we have rule that we cannot drop boards?

>
>> > there's two hard rules: never change the DT name and never change
>> > the compatible of a board=2E
>> >
>> > The former would break any build system, boot script or
>> > documentation, and the latter would break the DT compatibility=2E
>
>Maxime
