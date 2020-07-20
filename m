Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412C922618B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 16:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgGTOEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 10:04:14 -0400
Received: from verein.lst.de ([213.95.11.211]:47110 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgGTOEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:04:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5659268BFE; Mon, 20 Jul 2020 16:04:10 +0200 (CEST)
Date:   Mon, 20 Jul 2020 16:04:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v15 2/9] nvme: Create helper function to obtain command
 effects
Message-ID: <20200720140410.GB4627@lst.de>
References: <20200716203319.16022-1-logang@deltatee.com> <20200716203319.16022-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716203319.16022-3-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 02:33:12PM -0600, Logan Gunthorpe wrote:
> Separate the code to obtain command effects from the code
> to start a passthru request and open code nvme_known_admin_effects()
> in the new helper.
> 
> The new helper function will be necessary for nvmet passthru
> code to determine if we need to change out of interrupt context
> to handle the effects.

I actually found the nvme_known_admin_effects pretty nice, as the
function name documents why it is there.  The rest looks fine to me.
