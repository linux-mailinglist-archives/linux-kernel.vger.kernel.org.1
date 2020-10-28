Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717E129D48A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgJ1VxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:53:02 -0400
Received: from verein.lst.de ([213.95.11.211]:45155 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728331AbgJ1Vw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:52:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 14C0B67373; Wed, 28 Oct 2020 08:46:43 +0100 (CET)
Date:   Wed, 28 Oct 2020 08:46:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jongpil Jung <jongpuls@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        gloria.tsai@ssstc.com, jongpil19.jung@samsung.com,
        jongheony.kim@samsung.com, dj54.sohn@samsung.com
Subject: Re: [PATCH V2 1/1] nvme: Add quirk for LiteON CL1 devices running
 FW 220TQ,22001
Message-ID: <20201028074642.GA16651@lst.de>
References: <20201028074000.GA320668@image-900X5T-900X5U>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028074000.GA320668@image-900X5T-900X5U>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 04:40:00PM +0900, Jongpil Jung wrote:
> When NVMe device receive D3hot from host, NVMe firmware will do
> garbage collection. While NVMe device do Garbage collection,
> firmware has chance to going incorrect address.

What does "going incorrect address" mean?
