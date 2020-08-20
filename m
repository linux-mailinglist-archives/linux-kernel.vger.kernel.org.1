Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CAD24AF71
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 08:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgHTGwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 02:52:55 -0400
Received: from verein.lst.de ([213.95.11.211]:40942 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgHTGwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:52:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4C3FD68BEB; Thu, 20 Aug 2020 08:52:50 +0200 (CEST)
Date:   Thu, 20 Aug 2020 08:52:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Javier Gonzalez <javier@javigon.com>
Cc:     Jens Axboe <axboe@kernel.dk>, david.fugate@linux.intel.com,
        Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200820065250.GA6885@lst.de>
References: <20200818052936.10995-1-joshi.k@samsung.com> <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com> <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de> <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com> <9fa64efe-8477-5d33-20ed-9619a9fe8d70@kernel.dk> <20200820063719.q6wftb23op45wigk@MacBook-Pro.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820063719.q6wftb23op45wigk@MacBook-Pro.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 08:37:19AM +0200, Javier Gonzalez wrote:
> We will stop pushing for this emulation. We have a couple of SSDs where
> we disabled Append, we implemented support for them, and we wanted to
> push the changes upstream. That's it. This is no politics not a
> conspiracy against the current ZNS spec. We spent a lot of time working
> on this spec and are actually doing a fair amount of work to support
> Append other places in the stack. In any case, the fuzz stops here.

FYI, from knowing your personally I'm pretty confident you are not
part of a conspiracy and you are just doing your best given the context,
and I appreciate all your work!

I'm a lot less happy about thinks that happen in other groups not
involving you directly, and I'm still pretty mad at how the games were
played there, and especially other actors the seem to be reading the
list here, and instead of taking part in the discussion are causing fuzz
in completely unrelated venues.
