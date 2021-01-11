Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE9C2F1A71
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388517AbhAKQHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:07:16 -0500
Received: from verein.lst.de ([213.95.11.211]:51776 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731709AbhAKQHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:07:16 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4D9A667373; Mon, 11 Jan 2021 17:06:33 +0100 (CET)
Date:   Mon, 11 Jan 2021 17:06:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Daniel Wagner <dwagner@suse.de>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: hwmon: fix crash on device teardown
Message-ID: <20210111160633.GA27554@lst.de>
References: <20201209213228.5044-1-ematsumiya@suse.de> <4ebb1b8c-4bb0-6ebf-3417-d4aee1bdd3a8@suse.de> <20201230143805.2v4izgkzbnisssvr@beryllium.lan> <20201230151653.ozlqlwef7f2tarwz@beryllium.lan> <20201230153138.4f2jd2yd2vkqndby@beryllium.lan> <20210104210610.hliiupywksawgei3@hyori> <20210105094545.3tq7c6ev5yn3bhyi@beryllium.lan> <412d45ef-40af-24c3-4aa2-042ecbba05cd@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412d45ef-40af-24c3-4aa2-042ecbba05cd@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We could just stop using devm and do explicit resource management.

Btw, for the next patch please cc the author of the nvme-hwmon code.
