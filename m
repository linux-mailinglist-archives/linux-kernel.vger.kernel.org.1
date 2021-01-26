Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3341A304EC9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbhA0A7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:59:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394639AbhAZSTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:19:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E497D206B7;
        Tue, 26 Jan 2021 18:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611685153;
        bh=/W0CpE+i5EJG4RMr7NnCLePZex2RvGmJHRmEsh1ZZ6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YB7JspRvUwnQftK+2RxlvQpsZW/6MJ8KrqM1YE4MWLmdvIaDruZb6y6NbyW2fjx1l
         N7xd6Z9nqFDcU7XgVwEVlfnbYCI92jTdlvwyq1Kh6AuLfloyBWDYRiXrlBhRqIjwT5
         z4zeCPw4GmKaadkh3tHk1tQViIoW6ywDHpyXizEc=
Date:   Tue, 26 Jan 2021 19:19:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jorgen Hansen <jhansen@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, pv-drivers@vmware.com
Subject: Re: [PATCH v2 0/3] VMCI: Queue pair bug fixes
Message-ID: <YBBdHz0zFPqFPywI@kroah.com>
References: <1611160324-30066-1-git-send-email-jhansen@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611160324-30066-1-git-send-email-jhansen@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 08:32:04AM -0800, Jorgen Hansen wrote:
> This series contains three bug fixes for the queue pair
> implementation in the VMCI driver.
> 
> v1 -> v2:
>   - format patches as a series
>   - use min_t instead of min to ensure size_t comparison
>     (issue pointed out by kernel test robot <lkp@intel.com>)
> 
> Jorgen Hansen (3):
>   VMCI: Stop log spew when qp allocation isn't possible
>   VMCI: Use set_page_dirty_lock() when unregistering guest memory
>   VMCI: Enforce queuepair max size for IOCTL_VMCI_QUEUEPAIR_ALLOC
> 
>  drivers/misc/vmw_vmci/vmci_queue_pair.c | 16 ++++++++++------
>  include/linux/vmw_vmci_defs.h           |  4 ++--
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> -- 
> 2.6.2
> 

Please in the future properly thread your emails so that tools like 'b4'
can pick them all up at once.

thanks,

greg k-h
