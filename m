Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011722F67FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbhANRn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:43:56 -0500
Received: from verein.lst.de ([213.95.11.211]:36786 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbhANRn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:43:56 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A3DC568B02; Thu, 14 Jan 2021 18:43:12 +0100 (CET)
Date:   Thu, 14 Jan 2021 18:43:11 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Li Feng <fengli@smartx.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "lifeng1519@gmail.com" <lifeng1519@gmail.com>
Subject: Re: [PATCH] nvme: reject the ns when the block size is smaller
 than a sector
Message-ID: <20210114174311.GB31188@lst.de>
References: <20210113160621.98615-1-fengli@smartx.com> <SN4PR0401MB35985C08E5FFCDF0F5817A9D9BA90@SN4PR0401MB3598.namprd04.prod.outlook.com> <87698545-de26-c0ca-01e9-4dc2ddcacc80@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87698545-de26-c0ca-01e9-4dc2ddcacc80@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 02:12:59PM -0800, Sagi Grimberg wrote:
>> But this only catches a physical block size < 512 for NVMe, not any other block device.
>>
>> Please fix it for the general case in blk_queue_physical_block_size().
>
> We actually call that later and would probably be better to check here..

We had a series for that a short while ago that got lost.
