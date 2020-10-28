Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB80E29D7DF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733299AbgJ1W1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:27:33 -0400
Received: from verein.lst.de ([213.95.11.211]:45305 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733282AbgJ1W13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:27:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0DC5D6736F; Wed, 28 Oct 2020 18:17:26 +0100 (CET)
Date:   Wed, 28 Oct 2020 18:17:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jongpil Jung <jongpuls@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        gloria.tsai@ssstc.com, jongpil19.jung@samsung.com,
        jongheony.kim@samsung.com, dj54.sohn@samsung.com
Subject: Re: [PATCH V3 1/1] nvme: Add quirk for LiteON CL1 devices running
 FW 220TQ,22001
Message-ID: <20201028171726.GA9897@lst.de>
References: <20201028091421.GA667673@image-900X5T-900X5U>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028091421.GA667673@image-900X5T-900X5U>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 06:14:21PM +0900, Jongpil Jung wrote:
> LiteON(SSSTC) CL1 device running FW 220TQ,22001 has bugs with simple
> suspend.
> 
> When NVMe device receive D3hot from host, NVMe firmware will do
> garbage collection. While NVMe device do Garbage collection,
> firmware has chance to going incorrect address.

I'm still lost on what this means.  The device doesn't receive 'D3hot'
from the host, it receives a shutdown request.  And we don't just do
that when hibernating, but also when doing an actual shutdown, a suspend
to disk, unbinding the driver, etc.  So if the device has a problem
with shutdowns we really are in trouble.
