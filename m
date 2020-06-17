Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C2D1FD602
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 22:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgFQU1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 16:27:47 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:29098 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726758AbgFQU1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:27:46 -0400
X-IronPort-AV: E=Sophos;i="5.73,523,1583190000"; 
   d="scan'208";a="455254845"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 22:27:43 +0200
Date:   Wed, 17 Jun 2020 22:27:43 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] coccinelle: api: add device_attr_show script
In-Reply-To: <20200615130242.11825-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2006172225570.3083@hadrien>
References: <20200615130242.11825-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Jun 2020, Denis Efremov wrote:

> According to the documentation[1] show() methods of device attributes
> should return the number of bytes printed into the buffer. This is
> the return value of scnprintf(). show() must not use snprintf()
> when formatting the value to be returned to user space. snprintf()
> returns the length the resulting string would be, assuming it all
> fit into the destination array[2]. scnprintf() return the length of
> the string actually created in buf. If one can guarantee that an
> overflow will never happen sprintf() can be used otherwise scnprintf().

The semantic patch looks fine.  Do you have any accepted patches from
this?

julia


>
> [1] Documentation/filesystems/sysfs.txt
> [2] "snprintf() confusion" https://lwn.net/Articles/69419/
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  scripts/coccinelle/api/device_attr_show.cocci | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 scripts/coccinelle/api/device_attr_show.cocci
>
> diff --git a/scripts/coccinelle/api/device_attr_show.cocci b/scripts/coccinelle/api/device_attr_show.cocci
> new file mode 100644
> index 000000000000..d8ec4bb8ac41
> --- /dev/null
> +++ b/scripts/coccinelle/api/device_attr_show.cocci
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// From Documentation/filesystems/sysfs.txt:
> +///  show() must not use snprintf() when formatting the value to be
> +///  returned to user space. If you can guarantee that an overflow
> +///  will never happen you can use sprintf() otherwise you must use
> +///  scnprintf().
> +///
> +// Confidence: High
> +// Copyright: (C) 2020 Denis Efremov ISPRAS
> +// Options: --no-includes --include-headers
> +//
> +
> +virtual report
> +virtual org
> +virtual context
> +virtual patch
> +
> +@r depends on !patch@
> +identifier show, dev, attr, buf;
> +position p;
> +@@
> +
> +ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	<...
> +*	return snprintf@p(...);
> +	...>
> +}
> +
> +@rp depends on patch@
> +identifier show, dev, attr, buf;
> +@@
> +
> +ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	<...
> +	return
> +-		snprintf
> ++		scnprintf
> +			(...);
> +	...>
> +}
> +
> +@script: python depends on report@
> +p << r.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING: use scnprintf or sprintf")
> +
> +@script: python depends on org@
> +p << r.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING: use scnprintf or sprintf")
> --
> 2.26.2
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
