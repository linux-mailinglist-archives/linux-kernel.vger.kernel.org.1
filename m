Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501203001C9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbhAVLlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:41:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:60350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727913AbhAVLje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 06:39:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BACA123106;
        Fri, 22 Jan 2021 11:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611315534;
        bh=w71kF5qhbE9BPRzz8heQopWnu1J/oTafgKsEZXhx/Dk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kzIKwYT7tzfn5AAdZIGvVoYaBNxRmBrb8T7YegQrnkqb18paH6mSAkLD4YejVz9Ja
         jI3cVoDCe+ESwXqWF74hxBqvJJpdbd2gs/B+IS8l4KGTaZYHtoAisXe0+iuCKK0rV8
         fP33m8Jhspms5Qi8hKiF5Oz5w6PbhzkWwRmhDr24=
Date:   Fri, 22 Jan 2021 12:38:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Sihang Chen <chensihang1@hisilicon.com>
Subject: Re: [PATCH] uacce: Add uacce_ctrl misc device
Message-ID: <YAq5S2RAQV25+iaG@kroah.com>
References: <1611220154-90232-1-git-send-email-wangzhou1@hisilicon.com>
 <YAlM8hC9OGm3X/0k@kroah.com>
 <dcbe9a53-8aa0-10f5-4e78-ae0ab94171de@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcbe9a53-8aa0-10f5-4e78-ae0ab94171de@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 07:33:40PM +0800, Zhou Wang wrote:
> >> +struct uacce_pin_address {
> >> +	unsigned long addr;
> >> +	unsigned long size;
> > 
> > These are not valid ioctl structure members for crossing the user/kernel
> > boundry.  Please make them work properly (i.e. use __u64 and friends).
> 
> Got it, will modify this to __u64 together with other problems found by 0-day robot.

Please also properly involve the mm and dma developers and, again,
consider just making this a syscall instead of an ioctl.

thanks,

greg k-h
