Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4902C7090
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 19:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbgK1SBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 13:01:19 -0500
Received: from relay-us1.mymailcheap.com ([51.81.35.219]:50994 "EHLO
        relay-us1.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgK1R7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 12:59:13 -0500
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 13EFA20E58;
        Sat, 28 Nov 2020 11:59:35 +0000 (UTC)
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.156])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id D1276200FE;
        Sat, 28 Nov 2020 11:59:32 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id AF5BF3F1CF;
        Sat, 28 Nov 2020 12:59:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 7BED82A7DE;
        Sat, 28 Nov 2020 12:59:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1606564771;
        bh=qo4SLIZUrwY607yZrNGoWgTABuLweaoRjsorAWJWYK0=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=WrlOZhfCFe6awdoHTmhSt9pRWb88JZdpYCk8WGVWNLDQtKzheQ5emwezwR1naukIP
         IuyH5HRmloWVaDxcoEOk/5p7oOOikpdDclkgWEgge9MbzrCoTpFPT/zHWSMDi+ScXa
         lr1nwhHaSiRhnCup8qP9fZB/P9OLBlyciBmQCRhI=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QqF36XvoeO0o; Sat, 28 Nov 2020 12:59:30 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Sat, 28 Nov 2020 12:59:30 +0100 (CET)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 9452741EAD;
        Sat, 28 Nov 2020 11:59:29 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="ORvT/NQO";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [172.19.0.1] (unknown [64.225.114.122])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 8D0AC41EAD;
        Sat, 28 Nov 2020 11:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1606564765; bh=qo4SLIZUrwY607yZrNGoWgTABuLweaoRjsorAWJWYK0=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=ORvT/NQO4+ANb6ekfq8QHmKcGHWGXzkkDE/31UbQgcFEXkv5N7IpQGe2Tih82zKEm
         1gH41zIHXn91PB+w3vgXqUWjAaTA+4/s4w7yqtbz/s2I6SqGFNoHwY5YnoiuZtqUAk
         B8gueg+ThLVHJ+5M7Di4kUf4APcVXxyy+hNCqcoM=
Date:   Sat, 28 Nov 2020 19:59:17 +0800
User-Agent: K-9 Mail for Android
In-Reply-To: <CAJiuCcfEcM+Dksm4uoRPCiRepDSnEmp7pr8Qk5EsFSH_zEOTYA@mail.gmail.com>
References: <6175E674-E8BC-4199-8BE8-A983065C32D5@aosc.io> <20201116155508.364dg6ycklwylswe@gilmour.lan> <8FFC1A6C-9CA4-4F94-91C4-F111A7519979@aosc.io> <20201120155939.3ajmbny2pka2vsnf@gilmour> <A8E91BA0-22FD-47F4-A5B2-A80A38FE9A0E@aosc.io> <38ee5feb-e35d-801f-99a1-65e23618e73b@sholland.org> <20201123111512.y7lbwsipbkcpuleb@gilmour> <97E2037C-3C3C-4B0B-8462-39B9E38CB3BB@aosc.io> <20201123125332.2p5z3ew7svszvyfs@gilmour> <009A22D9-AF20-45C4-9674-13334B3EFFBA@aosc.io> <20201128103827.d6sfc2eumli2betx@gilmour> <1666a61f6ea3e7d573795f9000a0b096c7b7dee0.camel@aosc.io> <CAJiuCcfEcM+Dksm4uoRPCiRepDSnEmp7pr8Qk5EsFSH_zEOTYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [linux-sunxi] Re: [PATCH 3/3] arm64: allwinner: dts: a64: add DT for PineTab developer sample
To:     =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
CC:     Maxime Ripard <maxime@cerno.tech>,
        Samuel Holland <samuel@sholland.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <C8F86F90-14BF-4857-9DB8-7968A34E4656@aosc.io>
X-Rspamd-Queue-Id: 9452741EAD
X-Spamd-Result: default: False [1.40 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         ML_SERVERS(-3.10)[148.251.23.173];
         TO_DN_ALL(0.00)[];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[10];
         FREEMAIL_TO(0.00)[gmail.com];
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



=E4=BA=8E 2020=E5=B9=B411=E6=9C=8828=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
7:54:04, "Cl=C3=A9ment P=C3=A9ron" <peron=2Eclem@gmail=2Ecom> =E5=86=99=E5=
=88=B0:
>Hi Icenowy,
>
>On Sat, 28 Nov 2020 at 12:28, Icenowy Zheng <icenowy@aosc=2Eio> wrote:
>>
>> =E5=9C=A8 2020-11-28=E6=98=9F=E6=9C=9F=E5=85=AD=E7=9A=84 11:38 +0100=EF=
=BC=8CMaxime Ripard=E5=86=99=E9=81=93=EF=BC=9A
>> > On Mon, Nov 23, 2020 at 09:10:38PM +0800, Icenowy Zheng wrote:
>> > > > > > > > Okay=2E But I'm not satisfied with a non-public sample
>> > > > > > > > occupies
>> > > > > > > > the pinetab name=2E Is rename it to pinetab-dev and add a
>> > > > > > > > pinetab-retail okay?
>> > > > > > >
>> > > > > > > To me, naming the production version anything but
>"pinetab"
>> > > > > > > isn't
>> > > > > > > satisfying either=2E
>> > > > > >
>> > > > > > I understand where you're coming from, but the point I was
>> > > > > > making my
>> > > > > > previous mail is precisely that it's not really possible=2E
>> > > > > >
>> > > > > > You want to name the early adopter version _the_ production
>> > > > > > version=2E Let's assume the hardware changes again between
>the
>> > > > > > early
>> > > > > > adopter and mass-production version=2E Which one will be
>_the_
>> > > > > > production version? The early-adopter or the mass-produced
>> > > > > > one?
>> > > > > >
>> > > > > > There's really no good answer here, and both would suck in
>> > > > > > their
>> > > > > > own way=2E The only way to deal with this is to simply avoid
>> > > > > > defining one version as the one true board, and just
>loading
>> > > > > > the
>> > > > > > proper DT in u-boot based on whatever clue we have of the
>> > > > > > hardware
>> > > > > > revision=2E
>> > > > > Then will it be okay to rename current pinetab DT to
>> > > > > pinetab-sample and then introduce new DTs all with suffixes?
>> > > >
>> > > > No=2E From my previous mail:
>> > >
>> > > It can be seen as dropping the PineTab DT and introduce new DTs
>> > > with
>> > > suffix=2E
>> > >
>> > > Do we have rule that we cannot drop boards?
>> >
>> > Are you really arguing that removing a DT and then adding an
>> > identical
>> > one under a different name is not renaming it?
>>
>> Then we can just keep confusing name?
>
>Sorry maybe I missed some information
>But why don't you do like pinephone?

They're the same board revision with different LCD panels=2E

And the major problem is that the DT for samples is already submitted
under the name "PineTab"=2E

>sun50i-a64-pinetab-1=2E0=2Edts
>sun50i-a64-pinetab-1=2E1=2Edts
>
>-dev is also a confusing name I think, as the board has been already
>shipped=2E
>
>Regards,
>Clement
>
>
>>
>> If we do so, how can we mark the new DT as "the user should use this
>> one"?
>>
>> --
>> You received this message because you are subscribed to the Google
>Groups "linux-sunxi" group=2E
>> To unsubscribe from this group and stop receiving emails from it,
>send an email to linux-sunxi+unsubscribe@googlegroups=2Ecom=2E
>> To view this discussion on the web, visit
>https://groups=2Egoogle=2Ecom/d/msgid/linux-sunxi/1666a61f6ea3e7d573795f9=
000a0b096c7b7dee0=2Ecamel%40aosc=2Eio=2E
