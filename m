Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F93C249AF8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 12:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgHSKtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 06:49:25 -0400
Received: from verein.lst.de ([213.95.11.211]:37194 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727019AbgHSKtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:49:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2F14E68BEB; Wed, 19 Aug 2020 12:49:16 +0200 (CEST)
Date:   Wed, 19 Aug 2020 12:49:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Javier Gonzalez <javier@javigon.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org,
        Damien.LeMoal@wdc.com, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        johannes.thumshirn@wdc.com, Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200819104915.GA3153@lst.de>
References: <20200818052936.10995-1-joshi.k@samsung.com> <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com> <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de> <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local> <20200818155004.GA26688@lst.de> <20200818180428.obipue6adpqqpwjj@MacBook-Pro.localdomain> <20200819074035.GA21991@lst.de> <20200819083353.rwblagiesocfcq7i@mpHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819083353.rwblagiesocfcq7i@mpHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 10:33:53AM +0200, Javier Gonzalez wrote:
> I would ask you to reconsider this position. I have a hard time
> understanding how zone append emulation is a good idea in SCSI and not
> in NVMe, when there is no performance penalty.

Per the numbers on btrfs and zonefs numbers zone append emulation is
faster than using serialized writes, but also way slower than native
zone append.  Zone append emulation for SCSI is the way to bring
support for pre-existing standards into the brave new world.  Not
requiring Zone Append in a standard designed around it because of
bowing down to last minute political interventions in the standards
committee is shooting ourselves in the foot.

