Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA661B5D82
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 16:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgDWOVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 10:21:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbgDWOVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:21:14 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE43B2076C;
        Thu, 23 Apr 2020 14:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587651674;
        bh=bfbxVsKUF/76rdf0Qqm6uc1xcuiU0K9AP+BipX8lGw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tIB63ymyLlCpgjs+FxCNNHjV/qm+B8u3qX0VRpfCGdKn/IN8e8YQGQaLWeOvgK63g
         ZDfVw/Nb/kjXlhac7hLTNPy7faKl8eSxrp9j29Q5ot3Fer+8e5Q7H2J/skPylp0idr
         KkHaV8KN+TOUwUtjfn9IGjbHm1YzltMFKX9kV4wY=
Date:   Thu, 23 Apr 2020 22:21:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Adam Ford <aford173@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: vendor-prefixes: Add Beacon vendor
 prefix
Message-ID: <20200423142102.GA9391@dragon>
References: <20200324144324.21178-1-aford173@gmail.com>
 <20200423031002.GH8571@dragon>
 <CAOMZO5B3OL3_Ow_gy_a4PD=E6xaOWvOAHw-aDDB54E51UajQ4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5B3OL3_Ow_gy_a4PD=E6xaOWvOAHw-aDDB54E51UajQ4w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 12:49:52AM -0300, Fabio Estevam wrote:
> Hi Shawn,
> 
> On Thu, Apr 23, 2020 at 12:10 AM Shawn Guo <shawnguo@kernel.org> wrote:
> 
> > Hi Rob,
> >
> > Are you okay with this?
> 
> Rob has already applied it:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/Documentation/devicetree/bindings/vendor-prefixes.yaml?h=next-20200422&id=f756619f26edf74ad55d2151a6757a260e660fa8

Okay.  Thanks Fabio.

Shawn
