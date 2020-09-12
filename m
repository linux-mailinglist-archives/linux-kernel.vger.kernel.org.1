Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDA2267948
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 11:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgILJtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 05:49:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgILJtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 05:49:21 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A120214D8;
        Sat, 12 Sep 2020 09:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599904160;
        bh=oNheghBTMGf20w2jhhK9s/ksfsN7xnyd7oIDFq5CbBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QFLfSjoAuAjG/LccnLPi94ijxxhgGL4A9K6lBEHWAJGH3YtCknJykEXLonywG/SHP
         eGe9+KTYvAcqDEefc4DJa3JmUC8wGOu0amfrLzaB3ZVPcLZXyo/9Pe4k2wvmD6xuBG
         ZlKKbfZzIQSthP6DiiTUfxBKKv7XeQXVSOanWBpc=
Date:   Sat, 12 Sep 2020 17:49:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: Re: [PATCH 2/2] arm64: dts: lx2160a: add device tree for lx2162aqds
 board
Message-ID: <20200912094913.GB25109@dragon>
References: <1599059610-7570-1-git-send-email-meenakshi.aggarwal@nxp.com>
 <1599059610-7570-2-git-send-email-meenakshi.aggarwal@nxp.com>
 <20200905075419.GN9261@dragon>
 <AM7PR04MB688571606382A8992C71E8E38E260@AM7PR04MB6885.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM7PR04MB688571606382A8992C71E8E38E260@AM7PR04MB6885.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 07:10:12AM +0000, Meenakshi Aggarwal wrote:
> > > +	sb_3v3: regulator-sb3v3 {
> > > +		compatible = "regulator-fixed";
> > > +		regulator-name = "MC34717-3.3VSB";
> > > +		regulator-min-microvolt = <3300000>;
> > > +		regulator-max-microvolt = <3300000>;
> > > +		regulator-boot-on;
> > > +		regulator-always-on;
> > 
> > I do not see any point to have regulator-boot-on or regulator-always-on for a
> > regulator that doesn't have on/off control.
> [Meenakshi Aggarwal] Properties are added to specify that platform firmware's out of reset configuration enabled the regulator and 
> regulator should never be disabled or change its operative status.

What I was wondering if how this regulator is enabled by firmware, by
some GPIO control?  In that case, 'gpio' property should be there to
describe the GPIO control.

> 
> Can you help in understanding why these optional properties cannot be used together

It's totally fine to use these properties together.  But if the
regulator doesn't have on/off control, neither of them makes sense.

Shawn
