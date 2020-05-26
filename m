Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B911ABA59
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 09:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439860AbgDPHwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 03:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439830AbgDPHwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:52:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 682452076A;
        Thu, 16 Apr 2020 07:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587023549;
        bh=JEI7hlja06NOFImIQuSsZHBcvtS98Jsr6MWULdUk5gE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D4DZWvP5S5gQiFiCH/1IT5xKYhHmaLwun0F+NDFIqSckUTQXb3s0g05I6Y95SZSBq
         vEtxvcN2PLUbuOOq7RONRvNtGZfFYex6u2lcl/Q7Z+1/NHfwPBSDjdcSAmPv9VBzr1
         ksgbFxWvNyMTDcCas/1l7M72lETUsoJyyvGjHk5M=
Date:   Thu, 16 Apr 2020 09:52:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] driver core: remove device_create_vargs
Message-ID: <20200416075227.GA376871@kroah.com>
References: <20200416071519.807660-1-hch@lst.de>
 <20200416071519.807660-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416071519.807660-5-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 09:15:15AM +0200, Christoph Hellwig wrote:
> All external users of device_create_vargs are gone, so remove it and
> open code it in the only caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yes!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
