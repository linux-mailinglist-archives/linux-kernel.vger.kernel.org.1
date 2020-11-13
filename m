Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419332B2059
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 17:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgKMQZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 11:25:08 -0500
Received: from verein.lst.de ([213.95.11.211]:47787 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbgKMQZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 11:25:08 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7C1706736F; Fri, 13 Nov 2020 17:25:03 +0100 (CET)
Date:   Fri, 13 Nov 2020 17:25:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 0/2] nvme-pic: improve max I/O queue handling
Message-ID: <20201113162502.GA16940@lst.de>
References: <20201112082302.82441-1-schnelle@linux.ibm.com> <20201112145325.GC2573679@dhcp-10-100-145-180.wdc.com> <10908f20-7e18-e967-76dd-1a38e216b378@linux.ibm.com> <20201112173634.GA2626470@dhcp-10-100-145-180.wdc.com> <c753af20-878a-91ad-c5c2-692016fe2014@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c753af20-878a-91ad-c5c2-692016fe2014@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 02:15:59PM +0100, Niklas Schnelle wrote:
> 
> 
> On 11/12/20 6:36 PM, Keith Busch wrote:
> > On Thu, Nov 12, 2020 at 04:45:35PM +0100, Niklas Schnelle wrote:
> >> You got to get something wrong, I hope in this case it's just the subject
> >> of the cover letter :D
> > 
> > I suppose the change logs could be worded a little better :)
> 
> Do you think I should send a v2 with an improved message?
> I just realized I'm pretty alone (and wrong) in starting
> the commit message body lower case too.

I'll pull in soon, no need to resend.
