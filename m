Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0642AE0D5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 21:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731681AbgKJUlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 15:41:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:55098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgKJUlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 15:41:20 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C8C42064B;
        Tue, 10 Nov 2020 20:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605040879;
        bh=yKv9frgTvVqzPfRFofFJ3n7ouGgpWudWfrCyAmsq0Ac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F6jMqfAn1AHkUEQ1J4oxIJsY6olAVg85Py7bpZib2TmtC6g1lYi0DngBOOIFt5utk
         EFXiTKY28UDOKNVDreRLLKKohuiIiXg9ONF3YKN2KD9yB2bif5xKWXrE3o0u6sihCB
         0DBiiPOPHC8Fu7Hr8yhImjwF9Wn4UU/3MV8rT0Eg=
Date:   Tue, 10 Nov 2020 21:42:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     david.kershner@unisys.com, keescook@chromium.org,
        peterz@infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] drivers/staging/unisys/visorhba: convert stats to
 use seqnum_ops
Message-ID: <X6r7LVcXBBvRIbd8@kroah.com>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
 <6fb679d23de785bbd1be6a528127e29f8ee6abd7.1605027593.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fb679d23de785bbd1be6a528127e29f8ee6abd7.1605027593.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 12:53:38PM -0700, Shuah Khan wrote:
> seqnum_ops api is introduced to be used when a variable is used as
> a sequence/stat counter and doesn't guard object lifetimes. This
> clearly differentiates atomic_t usages that guard object lifetimes.
> 
> seqnum32 variables wrap around to INT_MIN when it overflows and
> should not be used to guard resource lifetimes, device usage and
> open counts that control state changes, and pm states.
> 
> atomic_t variables used for error_count and ios_threshold are atomic
> counters and guarded by max. values. No change to the behavior with
> this change.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  .../staging/unisys/visorhba/visorhba_main.c   | 37 ++++++++++---------
>  1 file changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/unisys/visorhba/visorhba_main.c b/drivers/staging/unisys/visorhba/visorhba_main.c
> index 7ae5306b92fe..3209958b8aaa 100644
> --- a/drivers/staging/unisys/visorhba/visorhba_main.c
> +++ b/drivers/staging/unisys/visorhba/visorhba_main.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/seq_file.h>
>  #include <linux/visorbus.h>
> +#include <linux/seqnum_ops.h>
>  #include <scsi/scsi.h>
>  #include <scsi/scsi_host.h>
>  #include <scsi/scsi_cmnd.h>
> @@ -41,8 +42,8 @@ MODULE_ALIAS("visorbus:" VISOR_VHBA_CHANNEL_GUID_STR);
>  struct visordisk_info {
>  	struct scsi_device *sdev;
>  	u32 valid;
> -	atomic_t ios_threshold;
> -	atomic_t error_count;
> +	struct seqnum32 ios_threshold;
> +	struct seqnum32 error_count;

Are you sure the threshold variable is a sequence number?

It goes up and down, not just up and up and up.

An error count just goes up :)

thanks,

greg k-h
