Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23292F0ECB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 10:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbhAKJOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 04:14:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:55376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728323AbhAKJOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:14:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBED0224F9;
        Mon, 11 Jan 2021 09:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610356455;
        bh=Npb6UaECTy8VDi/eZrBMLvCAVCD/glv4uAXFYUi/Iq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sdI/KY38wiQQwATMddevMBnHNAWmVbV5YJP+0E1kw256TqolaceueBvKTrBoaU9mO
         5qeqZd2rXux1NKQrjUEvLdLhHvcPqMQoFJy3xam0+7RF31LeqXbHy8juPzMS3zJZHw
         QcYbkkqq3/A+DU8IIz1OEn+QNE7nj6TDFHMRjewE=
Date:   Mon, 11 Jan 2021 10:13:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Alexander Egorenkov <egorenar@linux.ibm.com>, dyoung@redhat.com,
        vgoyal@redhat.com, lijiang@redhat.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, ktkhai@virtuozzo.com,
        keescook@chromium.org, christian.brauner@ubuntu.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] kdump: append uts_namespace.name offset to
 VMCOREINFO
Message-ID: <X/wWnGF5ajYk0bf4@kroah.com>
References: <20200930102328.396488-1-egorenar@linux.ibm.com>
 <20210108033248.GA4959@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108033248.GA4959@MiWiFi-R3L-srv>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 11:32:48AM +0800, Baoquan He wrote:
> On 09/30/20 at 12:23pm, Alexander Egorenkov wrote:
> > The offset of the field 'init_uts_ns.name' has changed
> > since commit 9a56493f6942 ("uts: Use generic ns_common::count").
> 
> This patch is merged into 5.11-rc1, but we met the makedumpfile failure
> of kdump test case in 5.10.0 kernel. Should affect 5.9 too since
> commit 9a56493f6942 is merged into 5.9-rc2.
> 
> Below tag and CC should have been added into patch when posted. 
> 
> Fixes: commit 9a56493f6942 ("uts: Use generic ns_common::count")
> Cc: <stable@vger.kernel.org>
> 
> Hi Greg,
> 
> Do we still have chance to make it added into stable?

Wait, 9a56493f6942 ("uts: Use generic ns_common::count") is in 5.11-rc1,
and this commit fixes that one, so why does anything need to be
backported?

Are you _SURE_ that this commit is needed in 5.10.y?

thanks,

greg k-h
