Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EA41ABA67
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 09:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440129AbgDPHx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 03:53:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439413AbgDPHxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:53:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A44420771;
        Thu, 16 Apr 2020 07:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587023627;
        bh=2mO4W183quN8A/qSOci2cOeeilx0Nn/1SJDwnEaLI+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2dnQ+Gcruh+xqOntinWp47U2G3kjfROZ5hfPBOKfPgZ03N5r74gn4zbNTzTYC2TD9
         UVHaBcq560WnLn2ZN4CPNBFbyRme6XUdDvIw7jXlUQC4VLLdOgiEdDeVtOeqBhGS3D
         osShDsMT/f2rKhGsKteBEsJA45g9Ug0w1k/wHx4Q=
Date:   Thu, 16 Apr 2020 09:53:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] bdi: remove bdi_register_owner
Message-ID: <20200416075345.GF376871@kroah.com>
References: <20200416071519.807660-1-hch@lst.de>
 <20200416071519.807660-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416071519.807660-7-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 09:15:17AM +0200, Christoph Hellwig wrote:
> Split out a new bdi_set_owner helper to set the owner, and move the policy
> for creating the bdi name back into genhd.c, where it belongs.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
