Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271E31ABA5B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 09:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439923AbgDPHwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 03:52:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439830AbgDPHwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:52:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DA392076A;
        Thu, 16 Apr 2020 07:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587023563;
        bh=8dSskBGG89yYYoNeDiNuETPE7qY9p5mkWbUWskYbeQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RtTBGfoHQWfRyJB964dT0UHDVXMNRkRyXuBOJJLx/NoYc1hZOdbSO3WHPmFAXAxRL
         RrowYNUi+lDr8dJlu88rNcOd3qg4+/q+lN29ZryYudARmz08zEAJejMUfkk8XCtGC2
         9TwWjl+jjlbNSphcK3ZYht6kkThkIJPLk3qMXDsU=
Date:   Thu, 16 Apr 2020 09:52:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] bdi: add a ->dev_name field to struct
 backing_dev_info
Message-ID: <20200416075241.GB376871@kroah.com>
References: <20200416071519.807660-1-hch@lst.de>
 <20200416071519.807660-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416071519.807660-4-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 09:15:14AM +0200, Christoph Hellwig wrote:
> Cache a copy of the name for the life time of the backing_dev_info
> structure so that we can reference it even after unregistering.
> 
> Fixes: 68f23b89067f ("memcg: fix a crash in wb_workfn when a device disappears")
> Reported-by: Yufen Yu <yuyufen@huawei.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
