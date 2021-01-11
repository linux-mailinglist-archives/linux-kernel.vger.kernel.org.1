Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8072F1FE8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391291AbhAKTx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391265AbhAKTxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:53:25 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DFAC06179F;
        Mon, 11 Jan 2021 11:52:45 -0800 (PST)
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 26691728;
        Mon, 11 Jan 2021 19:52:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 26691728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1610394765; bh=+w50x7FXB4+mpahBlBjhsoFALsTddz8oIotgBm1N3hI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qgz8dQ7x4x8P2fwtNVtFqYu0WFylWrFtD/1pU6UpZjtGrGbaO/t3le05uE7xtsbPw
         xm3u131Px9OaUvFTXoGWhhnjPzflmuvB0RsmqEyq6ajnz+dBylUtIOxNC9F3eeBRK8
         5Htj+y6iHNDxL6QMphu5XjM9iCDyumGSpR0ngBNHdNtmRMuD750C9MxY0m+zQoeUDy
         c79P+0Q4qrrkLNSElPfx6wkq13KWzZlqp637fydORKzmvkg6L0tAX4N3ByC01hLTmf
         EuCtmsWq3+8tIxAivlU9yiOCXzlDM5sjm9JaRcn3cSd4fchsp6fQQ1Zw7+fzLatiMX
         /WFHvavlgwPZQ==
Date:   Mon, 11 Jan 2021 12:52:44 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     winndows@163.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: filesystems: vfs: Correct the struct name
Message-ID: <20210111125244.396e54e5@lwn.net>
In-Reply-To: <1610265599-5101-1-git-send-email-winndows@163.com>
References: <1610265599-5101-1-git-send-email-winndows@163.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jan 2021 15:59:59 +0800
winndows@163.com wrote:

> From: Liao Pingfang <winndows@163.com>
> 
> The struct name should be file_system_type instead of
> file_system_operations.
> 
> Signed-off-by: Liao Pingfang <winndows@163.com>
> ---
>  Documentation/filesystems/vfs.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index ca52c82..18d69a4 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -112,7 +112,7 @@ members are defined:
>  
>  .. code-block:: c
>  
> -	struct file_system_operations {
> +	struct file_system_type {
>  		const char *name;
>  		int fs_flags;
>  		struct dentry *(*mount) (struct file_system_type *, int,

The patch is clearly correct, so I've applied it.  There are a number of
other ways in which that block is out of date, though.  Sure would be nice
if somebody could bring it current...

Thanks,

jon
