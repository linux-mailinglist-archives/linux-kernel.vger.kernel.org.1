Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565C22FE4C1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbhAUIRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:17:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:51830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbhAUIQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:16:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EA932395B;
        Thu, 21 Jan 2021 08:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611216948;
        bh=jlGXwu1tfbij7TJcmlF5/XEfn/3LQg2wD0tO1MQn1WE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rgOWqcHpKKCiOpXET9VzHjKBIXwWiW2ZUWA+oV/ir8LnBLyEjWZzWCxPQow8wKKan
         CsYu2KuRioZXH9e2rDzBeY3BTOoFyIhgoTrUUmxGBmvsMMPwAAopQEg6ro8g6R2Zwu
         FIFwsPrENE3I8GA+JQNG1xu+K47RJUOo/Wni4tZk=
Date:   Thu, 21 Jan 2021 09:15:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, logang@deltatee.com,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 3/3] libnvdimm/ioctl: Switch to cdev_register_queued()
Message-ID: <YAk4MMMmmbKe6XEQ@kroah.com>
References: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161117154856.2853729.1012816981381380656.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161117154856.2853729.1012816981381380656.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 11:39:08AM -0800, Dan Williams wrote:
> The ioctl implementation in libnvdimm is a case study in what can be
> cleaned up when the cdev core handles synchronizing in-flight ioctls
> with device removal. Switch to cdev_register_queued() which allows for
> the ugly context lookup and activity tracking implementation to be
> dropped, among other cleanups.

I'm confused, the cdev handles the filesystem access from /dev/ which
handles the ioctl.  Any use of a cdev with relationship to a struct
device that might go away is independent, so we really should not tie
these together in any way.

thanks,

greg k-h
