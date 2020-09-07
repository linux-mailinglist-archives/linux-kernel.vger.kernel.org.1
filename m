Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588152602C9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 19:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbgIGRfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 13:35:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729556AbgIGRfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 13:35:37 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22758206E6;
        Mon,  7 Sep 2020 17:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599500137;
        bh=knLI9PAaOaLWwtvsDxPWo7sMJhQNOsdOp6l9yFu1nkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2VFYVledBQxpBKSHwzHJZYiJM9XJyeHcUYTIcgiIYtk7ejQ2rC9K5xJdKCx/di2y5
         tf1ZogZ5lRmr/rf9Sl1ggNGtw77PQqlIy0YX2pur3271qxnVhUEoiaZ/VROrf5HXX5
         ivK13d1HJ1YSg5KEdX09GMrr8kVokhJqlrJZFf5w=
Received: by pali.im (Postfix)
        id DC0DD814; Mon,  7 Sep 2020 19:35:34 +0200 (CEST)
Date:   Mon, 7 Sep 2020 19:35:34 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>, Andre Heider <a.heider@gmail.com>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Add ethernet switch
 aliases
Message-ID: <20200907173534.aoupftjkxgcftfqo@pali>
References: <20200907112718.5994-1-pali@kernel.org>
 <3ec54259-4bfe-8462-e8d5-083fc009707a@gmail.com>
 <20200907172303.GA3254313@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907172303.GA3254313@lunn.ch>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 September 2020 19:23:03 Andrew Lunn wrote:
> > My dts-foo is a little rusty, but now that you labeled the ports in the
> > .dtsi, can this whole "switch0" block reduced to something like:
> > 
> > &switch0port1 {
> > 	label = "lan1";
> > };
> > 
> > &switch0port3 {
> > 	label = "wan";
> > };
> 
> Probably yes.
> 
> But that is definitely too much for stable.

Yes, this suggested change is not for stable, but looks like a nice
cleanup. So it could be done in followup patch.

Andre, are you going to prepare and test this followup change?
