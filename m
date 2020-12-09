Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F8F2D43FD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 15:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732805AbgLIOLh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Dec 2020 09:11:37 -0500
Received: from leonov.paulk.fr ([185.233.101.22]:39046 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbgLIOLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 09:11:36 -0500
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 215F4C013D;
        Wed,  9 Dec 2020 15:10:55 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 7F905C0888; Wed,  9 Dec 2020 15:10:54 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT
        autolearn=disabled version=3.4.2
Received: from aptenodytes (unknown [192.168.1.1])
        by gagarine.paulk.fr (Postfix) with ESMTPSA id 8CD35BFDEB;
        Wed,  9 Dec 2020 15:10:48 +0100 (CET)
Date:   Wed, 9 Dec 2020 15:10:47 +0100
From:   Paul Kocialkowski <contact@paulk.fr>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: irq: sun7i-nmi: Add binding
 documentation for the V3s NMI
Message-ID: <X9Da5xdKlqekPPkz@aptenodytes>
References: <20201206165131.1041983-1-contact@paulk.fr>
 <20201206165131.1041983-2-contact@paulk.fr>
 <20201207182359.GA565631@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201207182359.GA565631@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon 07 Dec 20, 12:23, Rob Herring wrote:
> On Sun, 06 Dec 2020 17:51:27 +0100, Paul Kocialkowski wrote:
> > The V3s NMI controller seems register-compatible with the A80 (sun9i).
> > Add new items for the compatible string, with an entry specific to the V3s
> > and the A80 entry.
> > 
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> >  .../interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml       | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.

Ah sorry, it was indeed intentional as there was a change since this version
uses sun9i-a80 as a base and I also renamed the compatible.

I put that in the cover letter's changelog but maybe it wasn't very explicit.

Cheers,

Paul

-- 
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
