Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199F126E1FE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 19:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgIQRPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 13:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbgIQROk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:14:40 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75B5F221E7;
        Thu, 17 Sep 2020 17:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600362879;
        bh=N+eMo2ivbUAlU4tiuPV3XzvKxw5wJfWKr0TMAEzfrow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NTMWV6ITEHU1I15LMBE6Q7ueKeHjX4U9ool0IrdKy3+AKTHkedFGvinUS7ImrnOzN
         G/N38mYsPSnl0GhG+n4iJRpryht29fWyziwVTZ/nk+Vncn1oRAWrSf60Yg2mwOK/6U
         h1Wt3nSGI3bVJ4oXyflNwTSZNg1FeVNW5bdKp+44=
Date:   Thu, 17 Sep 2020 10:14:37 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: fix NULL pointer dereference
Message-ID: <20200917171437.GB3766534@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200916153648.5475-1-ztong0001@gmail.com>
 <20200916165433.GA3675881@dhcp-10-100-145-180.wdl.wdc.com>
 <CAA5qM4B-KpRvFuf+5YR4iOqNzic=fuYm=_seqwLoLp9+_xOqdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA5qM4B-KpRvFuf+5YR4iOqNzic=fuYm=_seqwLoLp9+_xOqdA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 12:56:59PM -0400, Tong Zhang wrote:
> The command_id in CQE is writable by NVMe controller, driver should
> check its sanity before using it.

We already do that.
