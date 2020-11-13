Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443F72B27A0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgKMWC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgKMWAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:00:14 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976A0C061A47;
        Fri, 13 Nov 2020 14:00:07 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 80C2F4FA;
        Fri, 13 Nov 2020 22:00:06 +0000 (UTC)
Date:   Fri, 13 Nov 2020 15:00:05 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Siddhant Gupta <siddhantgupta416@gmail.com>
Cc:     mortonm@chromium.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mamtashukla555@gmail.com,
        himadrispandya@gmail.com
Subject: Re: [PATCH] Documentation: admin-guide: LSM: improve the title
 underline
Message-ID: <20201113150005.6265d600@lwn.net>
In-Reply-To: <20201112091353.GA19262@Sleakybeast>
References: <20201112091353.GA19262@Sleakybeast>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020 14:43:53 +0530
Siddhant Gupta <siddhantgupta416@gmail.com> wrote:

> Fix warning of title underline too short
> 
> Signed-off-by: Siddhant Gupta <siddhantgupta416@gmail.com>
> ---
>  Documentation/admin-guide/LSM/SafeSetID.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/LSM/SafeSetID.rst b/Documentation/admin-guide/LSM/SafeSetID.rst
> index 17996c9070e2..0ec34863c674 100644
> --- a/Documentation/admin-guide/LSM/SafeSetID.rst
> +++ b/Documentation/admin-guide/LSM/SafeSetID.rst
> @@ -107,7 +107,7 @@ for a UID/GID will prevent that UID/GID from obtaining auxiliary setid
>  privileges, such as allowing a user to set up user namespace UID/GID mappings.
>  
>  Note on GID policies and setgroups()
> -==================
> +====================================

This was already fixed by Mauro last month.

Thanks,

jon
