Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718B61ABA77
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 09:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439930AbgDPHz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 03:55:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440183AbgDPHyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:54:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41A45206E9;
        Thu, 16 Apr 2020 07:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587023663;
        bh=Abz5pSmwk1KTWLiBpkLTEnr6DI7w9tkGqdSG1qVM7Iw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kodGNv81Ugiz0EHVEVJPyurl5xazIMM1Bfm1yVdNqnHqi3F4oNAB1ZuessyOuCI+l
         96IOKmnVgNevEQ7ap5eLeM+a8oFKSkwrcqlzObL+IhrkJ9DoO0sb05b0llOM1kxy7t
         e5ghtal89lD/uEfz5JKEeV3vhFe+kRpK4z4OClVs=
Date:   Thu, 16 Apr 2020 09:54:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] bdi: simplify bdi_alloc
Message-ID: <20200416075421.GG376871@kroah.com>
References: <20200416071519.807660-1-hch@lst.de>
 <20200416071519.807660-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416071519.807660-8-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 09:15:18AM +0200, Christoph Hellwig wrote:
> Merge the _node vs normal version and drop the superflous gfp_t argument.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
