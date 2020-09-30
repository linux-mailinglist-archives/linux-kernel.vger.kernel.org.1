Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701AF27E25C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgI3HML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:12:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727657AbgI3HML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:12:11 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 939922076E;
        Wed, 30 Sep 2020 07:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601449930;
        bh=VUeL5dJxtNCQIqEJ5JCk1LwvGeF5Hdo5GKlpgMiOp/c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YfrqBuAuonZXtO62eiTaf2qTghzXzsnl98KkC/6QTrSlap5SGGUHVuo3CRPv/VDeL
         myh43nOmnp+WIIna2e5Pm8uZ9Zcq+KEvuRGVL04dp+ZKTJaZQTyg3fdXhLNGruZMNX
         FVg0gJjQhIwa2GK1vA6XfDOFbkZnFgu+D4mXs3es=
Received: by mail-ej1-f50.google.com with SMTP id dd13so1265877ejb.5;
        Wed, 30 Sep 2020 00:12:10 -0700 (PDT)
X-Gm-Message-State: AOAM531ae0h/WUtFojb2EUuqS1PTLuOA+Jqi4hbwjLWlW0AmPVxrmInR
        p7/4tw76Yo3Cg/1D7Ha7r3Ci6NyOVYFm/+cRlbk=
X-Google-Smtp-Source: ABdhPJyFS0R7Z+kb+bmnJUwvBv7Vreo7IzgUZoxCPLIZ5IXQoBbjinkmIkcvf9yxQF+aiKJlDOcE4VZOgMlOO6j9YxI=
X-Received: by 2002:a17:906:1984:: with SMTP id g4mr1379084ejd.119.1601449929176;
 Wed, 30 Sep 2020 00:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200926162811.5335-1-krzk@kernel.org> <20200926162811.5335-12-krzk@kernel.org>
 <2a329c9b-8bfc-fbd8-62a3-759f608347d6@denx.de> <686af5e6-d16a-7750-e47f-1ced9cb6c34a@denx.de>
In-Reply-To: <686af5e6-d16a-7750-e47f-1ced9cb6c34a@denx.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 30 Sep 2020 09:11:56 +0200
X-Gmail-Original-Message-ID: <CAJKOXPe7XOQspzTFDRtb=y79mwXEZSGiYiQP3J58JMjCkVRSCQ@mail.gmail.com>
Message-ID: <CAJKOXPe7XOQspzTFDRtb=y79mwXEZSGiYiQP3J58JMjCkVRSCQ@mail.gmail.com>
Subject: Re: [RFC 12/14] dt-bindings: vendor-prefixes: add Aristainetos
To:     hs@denx.de, Rob Herring <robh+dt@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 at 06:16, Heiko Schocher <hs@denx.de> wrote:
>
> Hello Krzysztof,
>
> Am 28.09.2020 um 06:04 schrieb Heiko Schocher:
> > Hello Krzysztof,
> >
> > Am 26.09.2020 um 18:28 schrieb Krzysztof Kozlowski:
> >> Document binding for an unknown entity Aristainetos with few boards
> >> mainlined.
> >>
> >> Cc: Heiko Schocher <hs@denx.de>
> >> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >>
> >> ---
> >>
> >> I tried to Google but except the patches from Heiko Schocher, I could
> >> not find any meaningful data.
> >>
> >> Heiko, you posted this. Do you know what is it?
> >
> > aristainetos is the name of the board, so it is not the vendor name.
> >
> > I just asked the customer if we can add a valid vendor name...
>
> Ok, it is not easy to get an okay from the customer to publish
> his name.
>
> Is there a dummy or unknown entry for vendor?

We could use "denx" as it was done as part of your work or "linux".
Rob, any hints here?

Best regards,
Krzysztof
