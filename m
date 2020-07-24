Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C03A22CEB6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 21:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGXTfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 15:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgGXTfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:35:12 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D3EE206D8;
        Fri, 24 Jul 2020 19:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595619312;
        bh=OyWnGKGYTbGw+IY4gpJNqzKFV+CQ5aSvZCLKgmsvSw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NFdEZU6IOueyntu8q4uunWpKhG/WXNlg+x2jV/pxv6WEM7UJcXJtfBsxQ6E2L7gz/
         go0xqISCK/aUR+Nj1Zn0UpxkXA5C9aILzzIO9UVNmK1zvXTKKATScDgPPkcYVq09w8
         YYuHLCAF/9PlnTYbuJ02Myf6CID30DiQgroi96zI=
Date:   Fri, 24 Jul 2020 12:35:09 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v16 0/9] nvmet: add target passthru commands support
Message-ID: <20200724193509.GB2857771@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200724172520.16318-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724172520.16318-1-logang@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 11:25:11AM -0600, Logan Gunthorpe wrote:
> This is v16 of the passthru patchset which make a bunch of cleanup as
> suggested by Christoph.

Thank, looks great. Just the comment on 6/9, which probably isn't super
important anyway.

Reviewed-by: Keith Busch <kbusch@kernel.org>
