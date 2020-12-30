Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C582E7A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 16:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgL3PRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 10:17:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:41278 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgL3PRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 10:17:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BF456AE53;
        Wed, 30 Dec 2020 15:16:53 +0000 (UTC)
Date:   Wed, 30 Dec 2020 16:16:53 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: hwmon: fix crash on device teardown
Message-ID: <20201230151653.ozlqlwef7f2tarwz@beryllium.lan>
References: <20201209213228.5044-1-ematsumiya@suse.de>
 <4ebb1b8c-4bb0-6ebf-3417-d4aee1bdd3a8@suse.de>
 <20201230143805.2v4izgkzbnisssvr@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230143805.2v4izgkzbnisssvr@beryllium.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 03:38:05PM +0100, Daniel Wagner wrote:
> I've enabled CONFIG_DEVRES_DEBUG and see only 'DEVRES ADD' message. If I
> read it correctly the problem is that the resource is attached to the ctl
> devm object and not for the nvme devm object.

I've attached the hwmon to the nvme object, which fixes the obvious
problem. But I still don't see any 'DEVRES REM' message. This would
indicate the nvme object never really goes away... more debugging...
