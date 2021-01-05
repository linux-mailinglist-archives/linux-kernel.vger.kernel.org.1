Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32D82EA7D6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbhAEJq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:46:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:48894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728143AbhAEJq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:46:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 56758AD29;
        Tue,  5 Jan 2021 09:45:46 +0000 (UTC)
Date:   Tue, 5 Jan 2021 10:45:45 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
        Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: hwmon: fix crash on device teardown
Message-ID: <20210105094545.3tq7c6ev5yn3bhyi@beryllium.lan>
References: <20201209213228.5044-1-ematsumiya@suse.de>
 <4ebb1b8c-4bb0-6ebf-3417-d4aee1bdd3a8@suse.de>
 <20201230143805.2v4izgkzbnisssvr@beryllium.lan>
 <20201230151653.ozlqlwef7f2tarwz@beryllium.lan>
 <20201230153138.4f2jd2yd2vkqndby@beryllium.lan>
 <20210104210610.hliiupywksawgei3@hyori>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104210610.hliiupywksawgei3@hyori>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 06:06:10PM -0300, Enzo Matsumiya wrote:
> @Daniel maybe try tweaking your tests to use a smaller controller
> loss timeout (-l option)? I do this on my tests because the default
> value kicks in about 30min after hot-removal -- i.e. you
> have to actually wait for the timeout to expire to trigger the bug.

As far I can tell, the blktests test I am using will trigger the same
bug. The problem is that the lifetime of hwmon sysfs entry should be
aligned to the lifetime of the nvme sysfs entry. Currently, hwmon's
lifetime is bound to the lifetime of the ctl sysfs entry. When the nvme
entry goes away (and obviously also the underlying device), the hwmon
sysfs entry still references it.
