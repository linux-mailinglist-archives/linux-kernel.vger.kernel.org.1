Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30092E79FF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 15:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgL3Ois (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 09:38:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:57632 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgL3Oir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 09:38:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 01D28ABA1;
        Wed, 30 Dec 2020 14:38:06 +0000 (UTC)
Date:   Wed, 30 Dec 2020 15:38:05 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Enzo Matsumiya <ematsumiya@suse.de>,
        linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: hwmon: fix crash on device teardown
Message-ID: <20201230143805.2v4izgkzbnisssvr@beryllium.lan>
References: <20201209213228.5044-1-ematsumiya@suse.de>
 <4ebb1b8c-4bb0-6ebf-3417-d4aee1bdd3a8@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ebb1b8c-4bb0-6ebf-3417-d4aee1bdd3a8@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 03:12:53PM +0100, Hannes Reinecke wrote:
> So why do we have to deallocate the hwmon attributes?
> And why on reset? And who's re-creating them after reset, seeing that
> 'initialized' should be true?

 nvmet: adding nsid 1 to subsystem blktests-subsystem-1
 nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uu.
 nvme-fabrics ctl: DEVRES ADD 000000009bc92dfd devm_kzalloc_release (552 bytes)
 nvme-fabrics ctl: DEVRES ADD 0000000099e1e156 devm_hwmon_release (8 bytes)

I've enabled CONFIG_DEVRES_DEBUG and see only 'DEVRES ADD' message. If I
read it correctly the problem is that the resource is attached to the ctl
devm object and not for the nvme devm object.
