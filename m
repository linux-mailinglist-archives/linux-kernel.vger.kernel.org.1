Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512AC29EEE1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgJ2Ozg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:55:36 -0400
Received: from verein.lst.de ([213.95.11.211]:49119 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgJ2Ozf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:55:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0E8BE67373; Thu, 29 Oct 2020 15:55:31 +0100 (CET)
Date:   Thu, 29 Oct 2020 15:55:29 +0100
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
Message-ID: <20201029145529.GA19011@lst.de>
References: <20201028091421.GA667673@image-900X5T-900X5U>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028091421.GA667673@image-900X5T-900X5U>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm still worried about this.

If power state based suspend does always work despite a HMB and is
preferred for the specific Google board we should have purely a DMI
based quirk for the board independent of the NVMe controller used with
it.

But if these LiteON devices can't properly handle nvme_dev_disable
calls we have much deeper problems, because it can be called in all
kinds of places, including suspending when not on this specific board.

That being said, I still really do not understand this sentence and thus
the problem at all:

> When NVMe device receive D3hot from host, NVMe firmware will do
> garbage collection. While NVMe device do Garbage collection,
> firmware has chance to going incorrect address.
