Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189751FD657
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 22:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgFQUqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 16:46:47 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:13264
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726809AbgFQUqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:46:47 -0400
X-IronPort-AV: E=Sophos;i="5.73,523,1583190000"; 
   d="scan'208";a="351906452"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 22:46:14 +0200
Date:   Wed, 17 Jun 2020 22:46:13 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] coccinelle: api: add device_attr_show script
In-Reply-To: <871aeea8-9b61-5eaa-4b0d-a377ba82c2d0@linux.com>
Message-ID: <alpine.DEB.2.22.394.2006172246010.3083@hadrien>
References: <20200615130242.11825-1-efremov@linux.com> <alpine.DEB.2.22.394.2006172225570.3083@hadrien> <871aeea8-9b61-5eaa-4b0d-a377ba82c2d0@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Jun 2020, Denis Efremov wrote:

>
>
> On 6/17/20 11:27 PM, Julia Lawall wrote:
> >
> >
> > On Mon, 15 Jun 2020, Denis Efremov wrote:
> >
> >> According to the documentation[1] show() methods of device attributes
> >> should return the number of bytes printed into the buffer. This is
> >> the return value of scnprintf(). show() must not use snprintf()
> >> when formatting the value to be returned to user space. snprintf()
> >> returns the length the resulting string would be, assuming it all
> >> fit into the destination array[2]. scnprintf() return the length of
> >> the string actually created in buf. If one can guarantee that an
> >> overflow will never happen sprintf() can be used otherwise scnprintf().
> >
> > The semantic patch looks fine.  Do you have any accepted patches from
> > this?
>
> It's not my patches, but:
>
> 3f9f8daad342 cpuidle: sysfs: Fix the overlap for showing available governors
> 117e2cb3eeee sparc: use scnprintf() in show_pciobppath_attr() in vio.c
> 03a1b56f501e sparc: use scnprintf() in show_pciobppath_attr() in pci.c
> 3dee04262898 iio: tsl2772: Use scnprintf() for avoiding potential buffer overflow
> dbdd24eaac4e edd: Use scnprintf() for avoiding potential buffer overflow
> abdd9feb45ed btrfs: sysfs: Use scnprintf() instead of snprintf()
> f21431f2de33 thermal: int340x_thermal: Use scnprintf() for avoiding potential buffer overflow
> 40501c70e3f0 s390/zcrypt: replace snprintf/sprintf with scnprintf
> eb3e064b8dd1 s390/zcrypt: Use scnprintf() for avoiding potential buffer overflow
> 06b522d6de9d video: uvesafb: Use scnprintf() for avoiding potential buffer overflow
> bf1b615ad97e video: omapfb: Use scnprintf() for avoiding potential buffer overflow
> b40e288bfb53 platform/x86: sony-laptop: Use scnprintf() for avoiding potential buffer overflow
> ef21e1750158 ALSA: Use scnprintf() instead of snprintf() for show

Thanks.

julia

>
> and many more
>
> Thanks,
> Denis
>
