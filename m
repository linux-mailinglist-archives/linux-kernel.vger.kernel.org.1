Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36042604D6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 20:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgIGSuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 14:50:16 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:48236 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729298AbgIGSuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:50:15 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kFMDQ-00DfRS-HP; Mon, 07 Sep 2020 20:50:08 +0200
Date:   Mon, 7 Sep 2020 20:50:08 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Andre Heider <a.heider@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Add ethernet switch
 aliases
Message-ID: <20200907185008.GE3254313@lunn.ch>
References: <20200907112718.5994-1-pali@kernel.org>
 <3ec54259-4bfe-8462-e8d5-083fc009707a@gmail.com>
 <20200907172303.GA3254313@lunn.ch>
 <20200907173534.aoupftjkxgcftfqo@pali>
 <f8cce9af-372b-f2bc-ea09-e1516367cb90@gmail.com>
 <20200907174705.clknw4375smvt47o@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907174705.clknw4375smvt47o@pali>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> As a result of this cleanup should be binary DTB file for V7 with same
> structure as DTB file without such cleanup patch, right?

Should be. If need be, you can decompile the DTB back to a DTS and
make sure it looks correct.

     Andrew
