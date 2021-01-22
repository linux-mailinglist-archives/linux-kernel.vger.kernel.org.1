Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5B5300A95
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 19:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbhAVSDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 13:03:40 -0500
Received: from verein.lst.de ([213.95.11.211]:37638 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbhAVRvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:51:16 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 99C3A68B05; Fri, 22 Jan 2021 18:50:29 +0100 (CET)
Date:   Fri, 22 Jan 2021 18:50:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-multipath: Early exit if no path is available
Message-ID: <20210122175029.GA21127@lst.de>
References: <20210122174125.145734-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122174125.145734-1-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 06:41:25PM +0100, Daniel Wagner wrote:
> nvme_round_robin_path() should test if the return ns pointer is
> valid. nvme_next_ns() will return a NULL pointer if there is no path
> left.

How can that happen once we're in the loop?
