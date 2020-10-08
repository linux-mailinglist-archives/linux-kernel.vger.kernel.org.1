Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81466286C17
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 02:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgJHAcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 20:32:43 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:48954 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbgJHAcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 20:32:43 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kQJrN-000cMt-3I; Thu, 08 Oct 2020 02:32:41 +0200
Date:   Thu, 8 Oct 2020 02:32:41 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vivek Unune <npcomplete13@gmail.com>
Cc:     devicetree@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] ARM: dts: BCM5301X: Linksys EA9500 add port 5 and
 port 7
Message-ID: <20201008003241.GG112961@lunn.ch>
References: <cover.1601655904.git.npcomplete13@gmail.com>
 <cd64e0ccae3e5785c80ad4d73af533a40fc15876.1601655904.git.npcomplete13@gmail.com>
 <20201007210327.GE112961@lunn.ch>
 <20201007220718.GB1972@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007220718.GB1972@ubuntu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This router is currently not enabled in Openwrt

You have to be careful here. Not everything runs OpenWRT. You cannot
break backwards compatibility in mainline, simple as that. You need to
ensure that mainline does not see a change in the CPU port.

    Andrew
