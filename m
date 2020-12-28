Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F85C2E351A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 09:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgL1IfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 03:35:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:55498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbgL1IfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 03:35:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66C7422582;
        Mon, 28 Dec 2020 08:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609144469;
        bh=5G1n56C71j9pJKhwGAx7IkLxlpCqLn9XwcLEY9aCJiw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XCJ4F3quy8czwg3PgpCPumaVqfvn4NqeG0UWe+gNHoLUwB3S4O/vril6+rIed6W3v
         Wdlc4Rjq+502oN0LSOeKd+In1Ta2l2xJNAhprmwbhjSbyB8xVd4ooQMNBnHyhorYP6
         R3v2qMRaLohD/ADiL79RPo4vJR6XyFTEh9lSQA7hEQVyNvw9bRKCEMmsMWHg2oTDX0
         2WFuIvmvGUuGZDeVisRlll1Sqgm6SQRUQ77ctlfSkBQ+/VeaL4zBZmmeMzizbMfrwK
         Yo0eoQ9cry3ZZnx2y8UpxYHI1o91uQQ0NZblU4AyBtrZntlC7uPbpDswvPXN7n1UR2
         kupP3mLCIkaeg==
Received: by mail-ed1-f50.google.com with SMTP id c7so9074112edv.6;
        Mon, 28 Dec 2020 00:34:29 -0800 (PST)
X-Gm-Message-State: AOAM532FIlrWLHwJQnMw6dlRqU5KQvx5DUci/G+C0ZhiZXp1qYOBUQz9
        Gf1BLybSmkrypbQOpSATJlj2fuAT7GyNEbUGBGw=
X-Google-Smtp-Source: ABdhPJxen+9UAJDztAzg+fITSQGg9bxnmZAhYyOn8CI9mcfodTpkQviRZmkAQUxK8JsyVC27u+Zj7qo2zPf3lEoIiS4=
X-Received: by 2002:aa7:d593:: with SMTP id r19mr41858975edq.246.1609144467956;
 Mon, 28 Dec 2020 00:34:27 -0800 (PST)
MIME-Version: 1.0
References: <20201223110343.126638-1-jagan@amarulasolutions.com>
 <20201223110343.126638-5-jagan@amarulasolutions.com> <20201223115933.GC21091@kozik-lap>
 <CAMty3ZA0zrHS_wVKm8gdqU1q5ONokoT7aG_MBcWtXTJK59Bozg@mail.gmail.com>
 <CAJKOXPfNP+6uv6PXmyTCimRd1hrQUbosnY--55yUQh4G4jfZWw@mail.gmail.com>
 <CAMty3ZBWteW2OZMNwFT5hSRegy-AARqqkR7SAz53fDoM3j5Ong@mail.gmail.com>
 <CAJKOXPey8+k7_uT4LLTwo8-UY51+TwUgWhtkPDRW3AD-BCi1Bw@mail.gmail.com> <CAMty3ZAo+9L4rtkJgBkimJu4SPv=gycVUFaUYtL_RSAhs7yGWw@mail.gmail.com>
In-Reply-To: <CAMty3ZAo+9L4rtkJgBkimJu4SPv=gycVUFaUYtL_RSAhs7yGWw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 28 Dec 2020 09:34:16 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdwHGmi+2-w4ymCN6D6RbBrfwk0imiHwXHTQ6nXR=x5yA@mail.gmail.com>
Message-ID: <CAJKOXPdwHGmi+2-w4ymCN6D6RbBrfwk0imiHwXHTQ6nXR=x5yA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini
 C.TOUCH 2.0
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matteo Lisi <matteo.lisi@engicam.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Dec 2020 at 09:21, Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > #include "imx8mm.dtsi"
> > > #include "imx8mm-beacon-som.dtsi"
> > > #include "imx8mm-beacon-baseboard.dtsi"
> > >
> > > (SoC dtsi, SoM dtsi, Carrier board dtsi)
> > >
> > > > design which makes any sense. We do not create empty DTS files which
> > > > only include one more DTSI. The contents of
> > > > imx8mm-engicam-ctouch2.dtsi should be directly in
> > > > imx8mm-icore-mx8mm-ctouch2.dts. That's the same problem as with v1 -
> > > > you overcomplicate simple stuff. It really looks like you ignored the
> > > > comments from v1 in multiple places.
> > >
> > > As explained above, the design is pretty much the same as the existing SoM's.
> > >
> > > imx8mm-engicam-ctouch2.dtsi is not just a dtsi file where nodes are
> > > enabled. It has nodes enabled for Carrier board, so keeping nodes
> > > separately will
> >
> > The files represent real devices or their components. So you have a
> > SOM - a DTSI file. You have a carrier board - a DTS file. That's
> > simple design which is mostly followed, unless something over
> > complicated passes the review.
> >
> > > 1. More verbose for which IP's are available in the carrier board
> >
> > No difference when carrier DTSI is the DTS. Exactly the same.
> >
> > > 2. Easy to extend if someone can create another SoM with a similar Carrier.
> >
> > Not really, if they include carrier DTSI they need to override a lot.
> > So usually (including practice - I did it) they *copy* the carrier to
> > create their own design.
>
> But what if the new board has slite change to use exiting carrier like
> what ctouch2 10" OF. Can we add ctouch2 dtsi as a separate file for
> this case?

If you submit another DTS using the imx8mm-engicam-ctouch2.dtsi - with
its own differences of course (not copying other DTS...) - then having
a DTSI makes sense. In current form, still NAK for all the reasons I
explained more than once.

Best regards,
Krzysztof
