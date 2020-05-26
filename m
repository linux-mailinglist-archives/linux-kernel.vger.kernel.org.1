Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDACB1ABA5F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 09:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439983AbgDPHxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 03:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439955AbgDPHw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:52:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D0552078B;
        Thu, 16 Apr 2020 07:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587023577;
        bh=2YuLyG7f1XDF6lmYug81NLLQ2VsOpsIASi5MYOVzSPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q6MJNRb1bMcJJbMSHGkNbkqa/Y5qeNri7ItQOfyF9nNx+0Ue0K1Xyupk+ybn+537C
         6iGa+riwRBnqbr6mnyQFoQs3hryiBtsJhotfv1Id3Wj0FqZkVz8qaArS2RG6Vn8N30
         N1e+qSkxLSBYkWjQLReD+m4B7xRUZ4KZye42hxaU=
Date:   Thu, 16 Apr 2020 09:52:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] bdi: move bdi_dev_name out of line
Message-ID: <20200416075254.GD376871@kroah.com>
References: <20200416071519.807660-1-hch@lst.de>
 <20200416071519.807660-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416071519.807660-2-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 09:15:12AM +0200, Christoph Hellwig wrote:
> bdi_dev_name is not a fast path function, move it out of line.  This
> prepares for using it from modular callers without having to export
> an implementation detail like bdi_unknown_name.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
