Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3831521D1E0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 10:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgGMIiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 04:38:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbgGMIiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:38:15 -0400
Received: from localhost (unknown [84.241.194.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB6BB206F0;
        Mon, 13 Jul 2020 08:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594629494;
        bh=13Re6BBdyhIHwZPZY+5C/3VyHaCsE0XbUsOZV7lXL64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XQ6M/1oT9DrYn49VOF1GSbBmfsd8aMppbbOfGiqN4KYes6NY+7w52zN/+ou9kbuaq
         3P2/f3/j0FgNo8Ja5T2mwstcvs73PzIpFNesbg0cFSZ2FnOIG9PNIbJJlDjYPnikwh
         wHVv0tkTw4KUr886yEJpOgBqOvPB27PQax+COZ9g=
Date:   Mon, 13 Jul 2020 10:38:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] debugfs: add a proxy stub for ->read_iter
Message-ID: <20200713083811.GA215949@kroah.com>
References: <20200713073729.875584-1-hch@lst.de>
 <20200713073729.875584-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713073729.875584-2-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 09:37:29AM +0200, Christoph Hellwig wrote:
> debugfs registrations typically go through a set of proxy ops to deal
> with refcounting, which need to support every method that can be
> supported.  Add ->read_iter to the proxy ops to prepare for seq_file to
> be switch to ->read_iter.
> 
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
