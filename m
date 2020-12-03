Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0892CE271
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 00:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbgLCXNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 18:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgLCXNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 18:13:35 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E335DC061A52
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 15:12:54 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 989172204;
        Thu,  3 Dec 2020 23:12:54 +0000 (UTC)
Date:   Thu, 3 Dec 2020 16:12:53 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andrew Klychkov <andrew.a.klychkov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] (fixed after review) Documentation: fix typos found in
 admin-guide subdirectory
Message-ID: <20201203161253.1c00647c@lwn.net>
In-Reply-To: <20201203072247.GA41394@spblnx124.lan>
References: <20201203072247.GA41394@spblnx124.lan>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Dec 2020 10:22:47 +0300
Andrew Klychkov <andrew.a.klychkov@gmail.com> wrote:

> --- a/Documentation/admin-guide/cifs/usage.rst
> +++ b/Documentation/admin-guide/cifs/usage.rst
> @@ -115,7 +115,7 @@ later source tree in docs/manpages/mount.cifs.8
>  Allowing User Unmounts
>  ======================
>  
> -To permit users to ummount directories that they have user mounted (see above),
> +To permit users to unmount directories that they have user mounted (see above),
>  the utility umount.cifs may be used.  It may be invoked directly, or if
>  umount.cifs is placed in /sbin, umount can invoke the cifs umount helper
>  (at least for most versions of the umount utility) for umount of cifs
> @@ -197,7 +197,7 @@ that is ignored by local server applications and non-cifs clients and that will
>  not be traversed by the Samba server).  This is opaque to the Linux client
>  application using the cifs vfs. Absolute symlinks will work to Samba 3.0.5 or
>  later, but only for remote clients using the CIFS Unix extensions, and will
> -be invisbile to Windows clients and typically will not affect local
> +be invisibile to Windows clients and typically will not affect local

So this one replaces one typo with another - perhaps not what you had in
mind :)

>  applications running on the same server as Samba.

Thanks,

jon
