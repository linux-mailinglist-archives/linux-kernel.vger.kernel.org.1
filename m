Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D152529E5A0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 09:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgJ2ICh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 04:02:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgJ2ICY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 04:02:24 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [129.253.182.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4145320791;
        Thu, 29 Oct 2020 03:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603941329;
        bh=C4kjXqI7ewtdQmVp492Kw8rJuNeRKJNHLGIoAabBliE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vV477CxOyIFDZhPvYZTMh02IiC9MZGr9eDWUaT0QqMjMbv3ElclNmWeBg+AUpC1eY
         TfrIs0LTHkwbKJK1nSrfdrbx7cuVrWA6ReS8mJESNofzaZyPsqf203DQeXWenTDzqg
         5rTIAvIbALEeJBg5h7HzLVW6Ij+iRIEjAQY3VXZ0=
Date:   Thu, 29 Oct 2020 12:15:21 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Gloria Tsai <Gloria.Tsai@ssstc.com>
Cc:     Jongpil Jung <jongpuls@gmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Jens Axboe <axboe@fb.com>,
        "dj54.sohn@samsung.com" <dj54.sohn@samsung.com>,
        "jongpil19.jung@samsung.com" <jongpil19.jung@samsung.com>,
        "jongheony.kim@samsung.com" <jongheony.kim@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 1/1] nvme: Add quirk for LiteON CL1 devices running FW
 220TQ,22001
Message-ID: <20201029031521.GC20928@redsun51.ssa.fujisawa.hgst.com>
References: <20201028091421.GA667673@image-900X5T-900X5U>
 <20201028171726.GA9897@lst.de>
 <HK2PR02MB4004EC30D14A16B59FD22A44EE140@HK2PR02MB4004.apcprd02.prod.outlook.com>
 <20201029023306.GB20928@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029023306.GB20928@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 11:33:06AM +0900, Keith Busch wrote:
> On Thu, Oct 29, 2020 at 02:20:27AM +0000, Gloria Tsai wrote:
> > Corrected the description of this bug that SSD will not do GC after receiving shutdown cmd.
> > Do GC before shutdown -> delete IO Q -> shutdown from host -> breakup GC -> D3hot -> enter PS4 -> have a chance swap block -> use wrong pointer on device SRAM -> over program
> 
> What do you mean by "wrong pointer"? At the place in the sequence you're
> referring to, the PCI BME is disabled: you can't access *any* host RAM,
> so there's no "correct" pointer either.

Re-reading your message, I do see you said "device" rather than "host",
so my response may not be relevant.
