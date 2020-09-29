Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A9C27D423
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgI2RIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgI2RIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:08:53 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F4E6208FE;
        Tue, 29 Sep 2020 17:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601399331;
        bh=fgF1bJOpcMdDn+jqrGIl64V3t7d9ejP1eI6JcGj14oM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HqVhd/NqT6J6AMhGqXTNwQE6GXaGK+E9I2l7khVps9tQx95AX69Uq9MrN5rCDxFFs
         KKys+2mZCtdiJU1Y2thDDjVnQVrSiErcvXQmVZMkZiFPxuaDOGKa+SCX5G314J8CMJ
         zGAkHbAcwIz8m9aO5E1cXeVIobcgmnuJiNntFgu4=
Date:   Tue, 29 Sep 2020 19:08:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v4 01/16] bcm-vk: add bcm_vk UAPI
Message-ID: <20200929170856.GA1351851@kroah.com>
References: <20200929001209.16393-1-scott.branden@broadcom.com>
 <20200929001209.16393-2-scott.branden@broadcom.com>
 <20200929102554.GB951772@kroah.com>
 <e8159e9d-0c8e-e494-407a-f4cde7c5015f@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8159e9d-0c8e-e494-407a-f4cde7c5015f@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 09:44:51AM -0700, Scott Branden wrote:
> 
> 
> On 2020-09-29 3:25 a.m., Greg Kroah-Hartman wrote:
> > On Mon, Sep 28, 2020 at 05:11:54PM -0700, Scott Branden wrote:
> >> Add user space api for bcm-vk driver.
> >>
> >> Provide ioctl api to load images and issue reset command to card.
> >> FW status registers in PCI BAR space also defined as part
> >> of API so that user space is able to interpret these memory locations
> >> as needed via direct PCIe access.
> >>
> >> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> >> ---
> >>  include/uapi/linux/misc/bcm_vk.h | 84 ++++++++++++++++++++++++++++++++
> >>  1 file changed, 84 insertions(+)
> >>  create mode 100644 include/uapi/linux/misc/bcm_vk.h
> >>
> >> diff --git a/include/uapi/linux/misc/bcm_vk.h b/include/uapi/linux/misc/bcm_vk.h
> >> new file mode 100644
> >> index 000000000000..5f1fc403bc67
> >> --- /dev/null
> >> +++ b/include/uapi/linux/misc/bcm_vk.h
> >> @@ -0,0 +1,84 @@
> >> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
> > Why do you need BSD-2 if you already have the syscall-note license?
> We include the header file outside of linux user space and use the defines in BSD and other code.
> Hence releasing the header as BSD-2 as well.

Are you _sure_ you need that extra license?  I ask as this is not the
"norm" for Linux api .h files.

Also note, given that you are the copyright holder, you can provide a
version in any other license in any other project, no need to put it
here.

I recommend going and talking to your license lawyers about this.

thanks,

greg k-h
