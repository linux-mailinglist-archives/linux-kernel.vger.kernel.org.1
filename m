Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6F62E9F4A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 22:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbhADVG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 16:06:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:33062 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbhADVG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 16:06:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 44B2EAD1B;
        Mon,  4 Jan 2021 21:06:15 +0000 (UTC)
Date:   Mon, 4 Jan 2021 18:06:10 -0300
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: hwmon: fix crash on device teardown
Message-ID: <20210104210610.hliiupywksawgei3@hyori>
References: <20201209213228.5044-1-ematsumiya@suse.de>
 <4ebb1b8c-4bb0-6ebf-3417-d4aee1bdd3a8@suse.de>
 <20201230143805.2v4izgkzbnisssvr@beryllium.lan>
 <20201230151653.ozlqlwef7f2tarwz@beryllium.lan>
 <20201230153138.4f2jd2yd2vkqndby@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201230153138.4f2jd2yd2vkqndby@beryllium.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you all for the feedback. I'll re-evaluate my patch and resubmit
it soon.

The problem clearly exists as I can easily reproduce it on my test
setup, but the strategy to fix it needs some rework apparently.

@Daniel maybe try tweaking your tests to use a smaller controller
loss timeout (-l option)? I do this on my tests because the default
value kicks in about 30min after hot-removal -- i.e. you
have to actually wait for the timeout to expire to trigger the bug.


Cheers,

Enzo
