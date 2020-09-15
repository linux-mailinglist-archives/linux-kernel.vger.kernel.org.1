Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95302269EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 08:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgIOGjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 02:39:37 -0400
Received: from verein.lst.de ([213.95.11.211]:46615 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbgIOGj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 02:39:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A44226736F; Tue, 15 Sep 2020 08:39:23 +0200 (CEST)
Date:   Tue, 15 Sep 2020 08:39:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Harald Freudenberger <freude@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: Re: [PATCH] s390/zcrypt: remove set_fs() invocation in zcrypt
 device driver
Message-ID: <20200915063923.GA19468@lst.de>
References: <20200910102838.28887-1-freude@linux.ibm.com> <20200911062134.GB21597@lst.de> <e367fef4-1634-7b8e-0ef5-4cdc108edadd@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e367fef4-1634-7b8e-0ef5-4cdc108edadd@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 09:36:07AM +0200, Harald Freudenberger wrote:
> Christoph, maybe you have a greater idea on how to solve this. So don't hesitate and tell me.
> Otherwise how to we provide this fix then ? My recommendation would be to go the 'usual' way:
> Commit this s390 internal and then let this go out with the next kernel merge window when
> next time Linus is pulling patches from the s390 subsystem for the 5.10 kernel development cycle.

What I did for the networking code is to add a new structure that
contains a union of the kernel and userspace pointer and a flag for
which one to use.  That is pretty much the same as what you did, just
a little more structured and type safe.  The other alternative would
be to use the iov_iter infrastructure, but that has some overhead.
