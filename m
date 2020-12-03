Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71DDD2CDCDE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgLCR5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgLCR5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:57:53 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD29C061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 09:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=/6p+WtO8lbZakuFj10Vrbmq/JbLV71y6SYo+gtoGxHc=; b=ORhYCptCvFZF36zjfTvOYTF6zU
        d4d1M/gnE+HsXo+wcZQRgVcdj1aUwa37r3X9a6AqSik0CRaWVXx/1wK3YT3tUQzo+lXudYB6zLIDK
        6xig9qlXV+4gV2DjSJri3AYyOQ8SsU9z4bRdoG52OgTiJ3YDcPKD5fZP2UZpLAxvdLj7QZk9C3yGV
        8lY1uVKUnBpL5zxmjUNZgnNyMgZSk4bcJu/2xQ+xl+albH/8bqyQPfHdirLzjreCzG+2+f3u1Kpyl
        wsr3RpU2fWrxw/wjpJrrIBZc2FRjSiH6+dZ0T5usRgrRb9dvMESoyVX34YaIubHBV6zmQAy3GV0LA
        1w08bl0A==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kksqs-0007Zl-18; Thu, 03 Dec 2020 17:57:10 +0000
Subject: Re: [PATCH] Documentation: fix multiple typos found in the
 admin-guide subdirectory
To:     Andrew Klychkov <andrew.a.klychkov@gmail.com>, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org
References: <20201203082029.GA44830@spblnx124.lan>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6d35bc17-223f-6667-a6b5-aa0523e64bbc@infradead.org>
Date:   Thu, 3 Dec 2020 09:57:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201203082029.GA44830@spblnx124.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 12/3/20 12:20 AM, Andrew Klychkov wrote:
> Fix thirty seven typos in dm-integrity.rst, dm-raid.rst, dm-zoned.rst,
> verity.rst, writecache.rst, tsx_async_abort.rst, ldm.rst, md.rst,
> bttv.rst, dvb_references.rst, frontend-cardlist.rst, gspca-cardlist.rst,
> ipu3.rst, remote-controller.rst, mm/index.rst, numaperf.rst,
> userfaultfd.rst, module-signing.rst, imx-ddr.rst,
> intel-speed-select.rst, intel_pstate.rst, ramoops.rst, abi.rst,
> kernel.rst, vm.rst
> 
> Signed-off-by: Andrew Klychkov <andrew.a.klychkov@gmail.com>
> ---
>  Documentation/admin-guide/device-mapper/dm-integrity.rst | 4 ++--
>  Documentation/admin-guide/device-mapper/dm-raid.rst      | 2 +-
>  Documentation/admin-guide/device-mapper/dm-zoned.rst     | 6 +++---
>  Documentation/admin-guide/device-mapper/verity.rst       | 2 +-
>  Documentation/admin-guide/device-mapper/writecache.rst   | 4 ++--
>  Documentation/admin-guide/hw-vuln/tsx_async_abort.rst    | 2 +-
>  Documentation/admin-guide/ldm.rst                        | 2 +-
>  Documentation/admin-guide/md.rst                         | 2 +-
>  Documentation/admin-guide/media/bttv.rst                 | 2 +-
>  Documentation/admin-guide/media/dvb_references.rst       | 2 +-
>  Documentation/admin-guide/media/frontend-cardlist.rst    | 4 ++--
>  Documentation/admin-guide/media/gspca-cardlist.rst       | 2 +-
>  Documentation/admin-guide/media/ipu3.rst                 | 6 +++---
>  Documentation/admin-guide/media/remote-controller.rst    | 2 +-
>  Documentation/admin-guide/mm/index.rst                   | 4 ++--
>  Documentation/admin-guide/mm/numaperf.rst                | 2 +-
>  Documentation/admin-guide/mm/userfaultfd.rst             | 2 +-
>  Documentation/admin-guide/module-signing.rst             | 4 ++--
>  Documentation/admin-guide/perf/imx-ddr.rst               | 2 +-
>  Documentation/admin-guide/pm/intel-speed-select.rst      | 4 ++--
>  Documentation/admin-guide/pm/intel_pstate.rst            | 6 +++---
>  Documentation/admin-guide/ramoops.rst                    | 2 +-
>  Documentation/admin-guide/sysctl/abi.rst                 | 2 +-
>  Documentation/admin-guide/sysctl/kernel.rst              | 2 +-
>  Documentation/admin-guide/sysctl/vm.rst                  | 2 +-
>  25 files changed, 37 insertions(+), 37 deletions(-)
> 

> diff --git a/Documentation/admin-guide/ldm.rst b/Documentation/admin-guide/ldm.rst
> index 12c5713..2cb4146 100644
> --- a/Documentation/admin-guide/ldm.rst
> +++ b/Documentation/admin-guide/ldm.rst
> @@ -19,7 +19,7 @@ longer any primary or extended partitions.  Normal MSDOS style partitions are
>  now known as Basic Disks.
>  
>  If you wish to use Spanned, Striped, Mirrored or RAID 5 Volumes, you must use
> -Dynamic Disks.  The journalling allows Windows to make changes to these
> +Dynamic Disks.  The journaling allows Windows to make changes to these

Recognized alternative spellings are OK...

>  partitions and filesystems without the need to reboot.
>  
>  Once the LDM driver has divided up the disk, you can use the MD driver to


> diff --git a/Documentation/admin-guide/module-signing.rst b/Documentation/admin-guide/module-signing.rst
> index f8b5841..219e286 100644
> --- a/Documentation/admin-guide/module-signing.rst
> +++ b/Documentation/admin-guide/module-signing.rst
> @@ -185,7 +185,7 @@ in a keyring called ".builtin_trusted_keys" that can be seen by::
>  	[root@deneb ~]# cat /proc/keys
>  	...
>  	223c7853 I------     1 perm 1f030000     0     0 keyring   .builtin_trusted_keys: 1
> -	302d2d52 I------     1 perm 1f010000     0     0 asymmetri Fedora kernel signing key: d69a84e6bce3d216b979e9505b3e3ef9a7118079: X509.RSA a7118079 []
> +	302d2d52 I------     1 perm 1f010000     0     0 asymmetric Fedora kernel signing key: d69a84e6bce3d216b979e9505b3e3ef9a7118079: X509.RSA a7118079 []

Hm, well, no.  The size of that print field is limited to 9 characters.
Unfortunately.  Maybe that should be changed, but that's how it is now.

>  	...
>  
>  Beyond the public key generated specifically for module signing, additional

All of the others look good to me.


thanks.
-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
