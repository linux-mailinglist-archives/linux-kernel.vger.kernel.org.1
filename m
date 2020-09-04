Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A6125D4B7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 11:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbgIDJ0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 05:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgIDJ0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:26:06 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B33EC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 02:26:06 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5C9749CE; Fri,  4 Sep 2020 11:26:04 +0200 (CEST)
Date:   Fri, 4 Sep 2020 11:26:03 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        iommu@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 0/2] r8a7742 SoC add IPMMU support
Message-ID: <20200904092602.GK6714@8bytes.org>
References: <20200825141805.27105-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825141805.27105-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 03:18:03PM +0100, Lad Prabhakar wrote:
> Hi All,
> 
> This patch series adds IPMMU support to R8A7742 (RZ/G1H)
> SoC dtsi.
> 
> Cheers,
> Prabhakar
> 
> Lad Prabhakar (2):
>   dt-bindings: iommu: renesas,ipmmu-vmsa: Add r8a7742 support
>   ARM: dts: r8a7742: Add IPMMU DT nodes

Applied, thanks.
