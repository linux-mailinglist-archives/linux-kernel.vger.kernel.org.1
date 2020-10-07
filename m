Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEC12869CA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 23:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgJGVBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 17:01:38 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:48716 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgJGVBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 17:01:37 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kQGZ4-000bBm-A7; Wed, 07 Oct 2020 23:01:34 +0200
Date:   Wed, 7 Oct 2020 23:01:34 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vivek Unune <npcomplete13@gmail.com>
Cc:     devicetree@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] ARM: dts: BCM5301X: Linksys EA9500 make use of
 pinctrl
Message-ID: <20201007210134.GD112961@lunn.ch>
References: <cover.1601655904.git.npcomplete13@gmail.com>
 <6687de05226dd055ee362933d4841a12b038792d.1601655904.git.npcomplete13@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6687de05226dd055ee362933d4841a12b038792d.1601655904.git.npcomplete13@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 03:01:50PM -0400, Vivek Unune wrote:
> Forgo the use of mmioreg mdio mux infavor of the pinctrl

Hi Vivek

Could you add some more details please. I don't know this
hardware. I'm assuming there are two MDIO busses, external as talked
about in the comments, and an internal one? And for this hardware you
only need one of them? But i don't see what pinmux has to do with
this?

Thanks
	Andrew
 
