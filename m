Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6645926034E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 19:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbgIGRrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 13:47:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729396AbgIGRrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 13:47:09 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E90D5206E7;
        Mon,  7 Sep 2020 17:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599500828;
        bh=q8Itn2cHd3ckHrO+heD9TcNKbUw7qQ0g2d+sdj7DcEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oZbdYyHLOdO2oH+pjUHARSetGjw5yfzPVxe60BK2ZuHoCDEbbsxnpPJz5g0DEFUdf
         ISA5KcU14uYZBjNyZ0QOXX/PBJE2czgwveSjk42TV57MEjGHZWvVR0/ID4uNMaAOGQ
         yAUoIKO3mXE8d8HmCyit6ecbkupcZRzDlXVnM9pc=
Received: by pali.im (Postfix)
        id 0819B814; Mon,  7 Sep 2020 19:47:05 +0200 (CEST)
Date:   Mon, 7 Sep 2020 19:47:05 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andre Heider <a.heider@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Add ethernet switch
 aliases
Message-ID: <20200907174705.clknw4375smvt47o@pali>
References: <20200907112718.5994-1-pali@kernel.org>
 <3ec54259-4bfe-8462-e8d5-083fc009707a@gmail.com>
 <20200907172303.GA3254313@lunn.ch>
 <20200907173534.aoupftjkxgcftfqo@pali>
 <f8cce9af-372b-f2bc-ea09-e1516367cb90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8cce9af-372b-f2bc-ea09-e1516367cb90@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 September 2020 19:43:08 Andre Heider wrote:
> On 07/09/2020 19:35, Pali Rohár wrote:
> > On Monday 07 September 2020 19:23:03 Andrew Lunn wrote:
> > > > My dts-foo is a little rusty, but now that you labeled the ports in the
> > > > .dtsi, can this whole "switch0" block reduced to something like:
> > > > 
> > > > &switch0port1 {
> > > > 	label = "lan1";
> > > > };
> > > > 
> > > > &switch0port3 {
> > > > 	label = "wan";
> > > > };
> > > 
> > > Probably yes.
> > > 
> > > But that is definitely too much for stable.
> > 
> > Yes, this suggested change is not for stable, but looks like a nice
> > cleanup. So it could be done in followup patch.
> > 
> > Andre, are you going to prepare and test this followup change?
> 
> I can prep the patch if you like, but the suggested cleanup only affects the
> v7 dts files. I don't have that hardware version to test it, so could only
> send an untested patch.

As a result of this cleanup should be binary DTB file for V7 with same
structure as DTB file without such cleanup patch, right? And this test
(structure / content of compiled file) does not need particular hardware.
