Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E48B296115
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901009AbgJVOol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2507757AbgJVOol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:44:41 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B77DE24171;
        Thu, 22 Oct 2020 14:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603377880;
        bh=eLWR5wVhG0u6XZ1oBjauTolKfqHlzUUNVOYEjVUg57M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h+mWLKBeFVPBRt6YHCW5BBfpgWNSpp5H+oYSPGLZSd/VSyRVlbPpd0pt3H9l6I2Zf
         xK/r0d+cZyJqtChRwVg+8bU6O4VFkztZttHymgCpXN3nyxwgBUpwpDNmKIEX/ZHWDh
         nXhkDUOAn5u5OLVAOJSRJsncaA3Ue6KQBtgfffBM=
Received: by pali.im (Postfix)
        id 2E2D7BFC; Thu, 22 Oct 2020 16:44:38 +0200 (CEST)
Date:   Thu, 22 Oct 2020 16:44:38 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andre Heider <a.heider@gmail.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Reducing number of Espressobin DTS files
Message-ID: <20201022144438.gxsd4mtt6lktnhi2@pali>
References: <20201022140007.hppmeyt34lubotbc@pali>
 <20201022142900.GX139700@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022142900.GX139700@lunn.ch>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 October 2020 16:29:00 Andrew Lunn wrote:
> > For example, Turris MOX board which is also A3720 based has optional
> > SDIO module which can be plugged / unplugged, standard variant is sold
> > without it and in DTS file is this node always enabled:
> 
> I think the Turris has quite a sophisticated bootloader which
> manipulates the DT to fit the hardware. I've no idea if eMMC is part
> of this...

Turris MOX has uSD card and SDIO module, not eMMC. But sdhci0 and sdhci1
DT nodes are not disabled in U-Boot.
