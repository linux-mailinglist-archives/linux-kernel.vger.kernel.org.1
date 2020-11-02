Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5362A3754
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 00:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgKBXwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 18:52:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:36304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgKBXwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 18:52:25 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05712207C4;
        Mon,  2 Nov 2020 23:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604361144;
        bh=f7s3D49TOtYE8QyV/cjeavqKhcKCcZ3+a8aGAtJXWl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UA92Oc8qZHT67MNv/dtw8V952ib+nKyWbMvJ7pP+Y6mpC8m5tVYWYmgUPJ4oBhYDT
         BkVTX0bExp1pifjBSFvywAyE7wZLGG5w3eVDFpaHKKVj7N6o6TvIc4DmrrkSrnumEo
         /NAtSo/fwViV618kSDk9oCdk+opBXJrY8alSsciI=
Date:   Tue, 3 Nov 2020 07:52:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] clk: imx: scu: Fix compile error with module build of
 clk-scu.o
Message-ID: <20201102235218.GY31601@dragon>
References: <208469.1604318525@turing-police>
 <6e5a8fdb-0a02-5eae-ca1f-37df8a454e34@infradead.org>
 <238534.1604350899@turing-police>
 <0b61c4f4-b389-c853-6e09-ee603455e583@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b61c4f4-b389-c853-6e09-ee603455e583@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 01:31:59PM -0800, Randy Dunlap wrote:
> On 11/2/20 1:01 PM, Valdis Klētnieks wrote:
> > On Mon, 02 Nov 2020 09:15:20 -0800, Randy Dunlap said:
> > 
> >> also
> >> Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> However, this driver does not directly use <linux/module.h>.
> > 
> > Just my luck - I looked at 3 or 4 other things that include of_platform.h
> > and they all *did* include module.h.
> > 
> >> platform_device.h #includes <linux/device.h>, which is where the
> >> problem lies:
> >>
> >> <linux/device.h> uses macros that are provided by <linux/module.h>
> >> so <linux/device.h> should #include <linux/module.h>.
> >>
> >> and that fixes this commit:
> >>
> >> commit 4c002c978b7f2f2306d53de051c054504af920a9
> >> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Date:   Mon Dec 9 20:33:03 2019 +0100
> >>
> >>     device.h: move 'struct driver' stuff out to device/driver.h
> > 
> > OK.. who's going to do that? Me, or Randy, or Greg?
> 
> You could go ahead... I began on it yesterday but didn't finish
> testing, although I did see the same build error that the 0day
> bot reported, so I don't know what it's going to take to fix that.

It's a driver problem which is being addressed by Dong's patch[1].

Shawn

[1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20201030153733.30160-1-aisheng.dong@nxp.com/
