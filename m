Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 353AD19F964
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 17:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgDFP4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 11:56:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728645AbgDFP4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:56:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91222248B9;
        Mon,  6 Apr 2020 15:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586188566;
        bh=+3xwSPG5fNQlWz5dLxBAg7wLH73FhUVhMlCTgn4mUrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JxriaKdrqBa1M0yXrn7jw5T5uqtxLs9RbO4XF1mRU54zloISxhNeB26IYgNvOvS6n
         007qWUYQHXpoUVgbHkqP9pd6tyW3+YimSXx3MRt0nbgacGMg/eyrCBwenYgWrvE0Sz
         bhpnoHMtSUt4Y+TiVbxrTRLz/zStywgHpLJE63L4=
Date:   Mon, 6 Apr 2020 17:56:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Jason Wang <jasowang@redhat.com>,
        platform-driver-x86@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 1/2] virtio: stop using legacy struct vring
Message-ID: <20200406155602.GA160445@kroah.com>
References: <20200406153245.127680-1-mst@redhat.com>
 <20200406153245.127680-2-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406153245.127680-2-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 11:35:23AM -0400, Michael S. Tsirkin wrote:
> struct vring (in the uapi directory) and supporting APIs are kept
> around to avoid breaking old userspace builds.
> It's not actually part of the UAPI - it was kept in the UAPI
> header by mistake, and using it in kernel isn't necessary
> and prevents us from making changes safely.
> In particular, the APIs actually assume the legacy layout.
> 
> Add struct vring_s (identical ATM) and supporting
> legacy APIs and switch everyone to use that.

How are we going to know that "struct vring_s" is what we need/want to
use?  What does "_s" mean?

"struct vring_kernel"?

naming is hard...

greg k-h
