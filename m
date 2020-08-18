Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88024247F12
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 09:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHRHMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 03:12:53 -0400
Received: from verein.lst.de ([213.95.11.211]:60482 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgHRHMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:12:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A829068AFE; Tue, 18 Aug 2020 09:12:49 +0200 (CEST)
Date:   Tue, 18 Aug 2020 09:12:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     kbusch@kernel.org, hch@lst.de, Damien.LeMoal@wdc.com,
        axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, johannes.thumshirn@wdc.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200818071249.GB2544@lst.de>
References: <20200818052936.10995-1-joshi.k@samsung.com> <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com> <20200818052936.10995-3-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818052936.10995-3-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 10:59:36AM +0530, Kanchan Joshi wrote:
> If drive does not support zone-append natively, enable emulation using
> regular write.
> Make emulated zone-append cmd write-lock the zone, preventing
> concurrent append/write on the same zone.

I really don't think we should add this.  ZNS and the Linux support
were all designed with Zone Append in mind, and then your company did
the nastiest possible move violating the normal NVMe procedures to make
it optional.  But that doesn't change the fact the Linux should keep
requiring it, especially with the amount of code added here and how it
hooks in the fast path.
