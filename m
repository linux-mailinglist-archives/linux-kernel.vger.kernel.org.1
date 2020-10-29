Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F393529E2B4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391326AbgJ2CeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:34:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729364AbgJ2CdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 22:33:13 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [129.253.182.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D24C020757;
        Thu, 29 Oct 2020 02:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603938792;
        bh=9f9PlnuvS1IHJQjG2sFLlwjyU00BqP9FiUVPACo2Dk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GmzJY7bHlo2JIksPOwEDI5L+MEGfuHaHUfjzIdbi1zBrValR9FlwPEMVs7YpebxEH
         cUpRX0qXopBZTWKh4XlWBv3W4CqJJ5PgGzzRgXpM9axdbbzpNyHWGjaqhd4C0MzsJD
         CMvK2ggvjrscaFKgNDtRR2WEM8PRpt4173vKp/NU=
Date:   Thu, 29 Oct 2020 11:33:06 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Gloria Tsai <Gloria.Tsai@ssstc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jongpil Jung <jongpuls@gmail.com>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jongpil19.jung@samsung.com" <jongpil19.jung@samsung.com>,
        "jongheony.kim@samsung.com" <jongheony.kim@samsung.com>,
        "dj54.sohn@samsung.com" <dj54.sohn@samsung.com>
Subject: Re: [PATCH V3 1/1] nvme: Add quirk for LiteON CL1 devices running FW
 220TQ,22001
Message-ID: <20201029023306.GB20928@redsun51.ssa.fujisawa.hgst.com>
References: <20201028091421.GA667673@image-900X5T-900X5U>
 <20201028171726.GA9897@lst.de>
 <HK2PR02MB4004EC30D14A16B59FD22A44EE140@HK2PR02MB4004.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK2PR02MB4004EC30D14A16B59FD22A44EE140@HK2PR02MB4004.apcprd02.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 02:20:27AM +0000, Gloria Tsai wrote:
> Corrected the description of this bug that SSD will not do GC after receiving shutdown cmd.
> Do GC before shutdown -> delete IO Q -> shutdown from host -> breakup GC -> D3hot -> enter PS4 -> have a chance swap block -> use wrong pointer on device SRAM -> over program

What do you mean by "wrong pointer"? At the place in the sequence you're
referring to, the PCI BME is disabled: you can't access *any* host RAM,
so there's no "correct" pointer either.
