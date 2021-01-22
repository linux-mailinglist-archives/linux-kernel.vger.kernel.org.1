Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D201300AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 19:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbhAVSQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 13:16:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:33600 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730042AbhAVRzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:55:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0631FAC6E;
        Fri, 22 Jan 2021 17:55:09 +0000 (UTC)
Date:   Fri, 22 Jan 2021 18:55:08 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-multipath: Early exit if no path is available
Message-ID: <20210122175508.eiimz2fbx3csrejk@beryllium.lan>
References: <20210122174125.145734-1-dwagner@suse.de>
 <20210122175029.GA21127@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122175029.GA21127@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 06:50:29PM +0100, Christoph Hellwig wrote:
> How can that happen once we're in the loop?

As far I can tell, it's the first nvme_next_ns() call which returns the
NULL pointer and this will pass the test 'ns != old'.
