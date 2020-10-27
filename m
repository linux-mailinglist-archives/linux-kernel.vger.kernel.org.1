Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C5B29CA14
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 21:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1831342AbgJ0UXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 16:23:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1831335AbgJ0UXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 16:23:38 -0400
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0172020719;
        Tue, 27 Oct 2020 20:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603830217;
        bh=3emz6UQhpY4UW+3j5aomFK7x1AuiURETZZxGwVy/TZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vKFXJkJMwVpGxzCd/Nc/P9I90wffuBoPzvKvYQdoogX9+xnFsxShG0XBCmxlqGgzA
         BV+vT0OTrLxXtczLxwLEBPeiqOAaudyrmpWonO80WiVQn78QtBCZERXUd+rpTcZ3jW
         +SnauYBe9GDb0iwfCPj8FZ2PPinN/8qkw/BIXKlM=
Date:   Tue, 27 Oct 2020 13:23:34 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Jongpil Jung <jongpuls@gmail.com>
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        jongpil19.jung@samsung.com, gloria.tsai@ssstc.com
Subject: Re: [PATCH 1/1] nvme: Add quirk for LiteON CL1 devices running FW
 220TQ,22001
Message-ID: <20201027202334.GA1942708@dhcp-10-100-145-180.wdc.com>
References: <20201027155438.GA111754@jongpil-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027155438.GA111754@jongpil-desktop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 12:54:38AM +0900, Jongpil Jung wrote:
> suspend.
> 
> When NVMe device receive D3hot from host, NVMe firmware will do
> garbage collection. While NVMe device do Garbage collection,
> firmware has chance to going incorrect address.
> In that case, NVMe storage device goes to no device available state.
> Finally, host can't access the device any more.
> 
> Quirk devices will not use simple suspend even if HMB is enabled.
> In case of poweroff scenario, NVMe receive "PME turn off".
> So garbage collection will not be happening.
> 
> Liteon(SSSTC) will fix the issue, that's why quirk apply on specific
> vendor id and firmware version.

This is a concerning quirk. We use the simple suspend when HMB is
enabled because at least some platforms disable device DMA access in the
runtime suspend state. Many devices continue to access their HMB while
in low power, so we can't let both conditions occur concurrently.
Unless you know for sure this device doesn't access host memory in
low-power, there will be at least some platform combinations where this
quirk will fail.
