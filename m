Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991892D6AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 23:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393609AbgLJWcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 17:32:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:60636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405148AbgLJW30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 17:29:26 -0500
X-Gm-Message-State: AOAM533pa8O5OGQA9TqMJx1dXIrvQDPQ89RZQTni8wj97lPCR2JN9l/f
        r8QLt9BjN9gDpHAxYA62eJeEI6p/reiLW+t6dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607639325;
        bh=AwBm1sOylDA4igz4WzY+pw8TKG6j23bjsUanh6pfDgM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZK4U0HCtIlYNCren07U1WyHUPbbOLWxNSzqhA2PgBVceYqIFuqxMMi3fT71+YwiU4
         RESEQ6zmrqoAzaOOhw3HCysNQKc4g54uVf6tOkhiC6RHOWRz+nD7tJcJgfw9W9H+/S
         jlsIEXcIbQq/4ueeW/RxchpkSs/3O3n5xOmDzd0EC7DEInzPEUe+5XRiyVK5154Ipd
         dN7cQDJw0ojVgS3t/QwTTJ0t6CA9lxHvCQFSXhUlU5/P13tCaMHW+xMk/hD5FMN0qH
         ecFGlWglipuga4Tbx/45JvkfUcMj76Vtp3j43sEkc373Qh/P7LmuX0o2nGImqJfRA8
         +jR889VTq9FNw==
X-Google-Smtp-Source: ABdhPJyymUnSALTcy47VYVv5649A6u3+OHeY86YqbeEIaIsYhG09Q5br4FWLGjTGAMJ3p6Rti61dhsS8yjOSzje5knw=
X-Received: by 2002:a50:f404:: with SMTP id r4mr9019649edm.62.1607639323771;
 Thu, 10 Dec 2020 14:28:43 -0800 (PST)
MIME-Version: 1.0
References: <20201206165131.1041983-1-contact@paulk.fr> <20201206165131.1041983-2-contact@paulk.fr>
 <20201207182359.GA565631@robh.at.kernel.org> <X9Da5xdKlqekPPkz@aptenodytes>
In-Reply-To: <X9Da5xdKlqekPPkz@aptenodytes>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 10 Dec 2020 16:28:31 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+XE+-uGK9kv5+8_mK57zC1Hw+SkOuiBkDyti3s4F896w@mail.gmail.com>
Message-ID: <CAL_Jsq+XE+-uGK9kv5+8_mK57zC1Hw+SkOuiBkDyti3s4F896w@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: irq: sun7i-nmi: Add binding
 documentation for the V3s NMI
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 8:11 AM Paul Kocialkowski <contact@paulk.fr> wrote:
>
> Hi,
>
> On Mon 07 Dec 20, 12:23, Rob Herring wrote:
> > On Sun, 06 Dec 2020 17:51:27 +0100, Paul Kocialkowski wrote:
> > > The V3s NMI controller seems register-compatible with the A80 (sun9i).
> > > Add new items for the compatible string, with an entry specific to the V3s
> > > and the A80 entry.
> > >
> > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > > ---
> > >  .../interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml       | 3 +++
> > >  1 file changed, 3 insertions(+)
> >
> > Please add Acked-by/Reviewed-by tags when posting new versions. However,
> > there's no need to repost patches *only* to add the tags. The upstream
> > maintainer will do that for acks received on the version they apply.
> >
> > If a tag was not added on purpose, please state why and what changed.
>
> Ah sorry, it was indeed intentional as there was a change since this version
> uses sun9i-a80 as a base and I also renamed the compatible.
>
> I put that in the cover letter's changelog but maybe it wasn't very explicit.

Okay.

Reviewed-by: Rob Herring <robh@kernel.org>
