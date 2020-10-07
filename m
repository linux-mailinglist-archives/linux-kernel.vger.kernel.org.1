Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A36E2869CC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 23:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgJGVDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 17:03:30 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:48736 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgJGVD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 17:03:29 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kQGat-000bCh-V5; Wed, 07 Oct 2020 23:03:27 +0200
Date:   Wed, 7 Oct 2020 23:03:27 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vivek Unune <npcomplete13@gmail.com>
Cc:     devicetree@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] ARM: dts: BCM5301X: Linksys EA9500 add port 5 and
 port 7
Message-ID: <20201007210327.GE112961@lunn.ch>
References: <cover.1601655904.git.npcomplete13@gmail.com>
 <cd64e0ccae3e5785c80ad4d73af533a40fc15876.1601655904.git.npcomplete13@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd64e0ccae3e5785c80ad4d73af533a40fc15876.1601655904.git.npcomplete13@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 03:01:51PM -0400, Vivek Unune wrote:
> Add port 5 and port 7 which are connected to gmac0 & 1 respectively
> DSA driver will use port 5 as cpu port and this works as well.

What port was used before this was added? The CPU port cannot be
changed because it can break user space, the code which is configuring
the master interface up.

    Andrew
