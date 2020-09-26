Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB97279576
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 02:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbgIZAPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 20:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729749AbgIZAPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 20:15:14 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98500C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 17:15:14 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id h8so1166728ooc.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 17:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IzqcIIIVjcTzZOrnik99fl+SNFAYOQfWnQfkvCmEFDQ=;
        b=BbFBE7wQLNIkTBvEy8i0RgoomvuTE+IujdSmUTMhlJPvm5iesc3zxcRX24M6cibvH9
         PXJopEuG05NYcrunmZ99eHmf4YUpRIiBl9Fd8uB1b1oUAoUgcRRGjpfz7SmWOdYcsPFi
         sr/QPWkRKNYgwANb47XzCAMmGP+cS/++vDuQ/cdms1alnBy4UFnU/aLIssessAWSDRwC
         TYRiMNaA9oxV7tQoA+Oul1UrHW+0q6AyIDpBge1CCbh7Hd816hVg+ie2MTSi4C8Zn8GS
         17atVIEQ7WvGqluKFicFMJx/gRkpzmzHQ89dVb3NyLl/S2QUfmgy39L8waTJyEcUTSdT
         I52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=IzqcIIIVjcTzZOrnik99fl+SNFAYOQfWnQfkvCmEFDQ=;
        b=bign34yJj6R/KmATqvZLUz5MR9yugnLCmpyQEn5tQp1mS8tX3DepUvfeyJRo+55jI9
         G6A9OZ0okAikb2+l2iTd9qbp1KX0jr935Wvzpkt6+Yv3IGC9DjV9FiRQLCFEVujjH0vZ
         IMDY+HgK9jvQo+DrnmlcjjvZIs4TOx4ykhg1scFTGDPSZkxIR1IE/Pa9hauxddvKuAtX
         IWZ5+MLGJVoEjQxv02WMFc428PT9DHjZdYcow26pYo+rUEuOGMeihV/gmlgOpSpnCdQ0
         /WCc+D4jFdPa0trJWEnKHj/g+TFQ3feSVgHI24cK1Kx0FrKaustJ02I2sdvTAOXwwkbw
         Hobw==
X-Gm-Message-State: AOAM533i23xESRAArjwa9Dic5PDdIkJrQK8Lhr7pWGqjqkaWPtN2yZTr
        HtKaQw8oAfuARtCG4lsaxw==
X-Google-Smtp-Source: ABdhPJxKKVB+Ta3jiRes060TdPSxnKgD8dm+Q+ajwigFwiW9T5z+6ERR1pP8tFWh4N+4nh+9Xd4KRw==
X-Received: by 2002:a4a:96a3:: with SMTP id s32mr2559408ooi.17.1601079313917;
        Fri, 25 Sep 2020 17:15:13 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.156])
        by smtp.gmail.com with ESMTPSA id l1sm204519ooe.20.2020.09.25.17.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 17:15:12 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:f4c0:523f:f851:b38b])
        by serve.minyard.net (Postfix) with ESMTPSA id EEB2118003E;
        Sat, 26 Sep 2020 00:15:11 +0000 (UTC)
Date:   Fri, 25 Sep 2020 19:15:10 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, keescook@chromium.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] drivers/char/ipmi: convert stats to use
 counter_atomic32
Message-ID: <20200926001510.GH3674@minyard.net>
Reply-To: minyard@acm.org
References: <cover.1601073127.git.skhan@linuxfoundation.org>
 <b742c2637a8b6083c471a6dd829db70071909f83.1601073127.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b742c2637a8b6083c471a6dd829db70071909f83.1601073127.git.skhan@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 05:47:23PM -0600, Shuah Khan wrote:
> counter_atomic* is introduced to be used when a variable is used as
> a simple counter and doesn't guard object lifetimes. This clearly
> differentiates atomic_t usages that guard object lifetimes.
> 
> counter_atomic* variables will wrap around to 0 when it overflows and
> should not be used to guard resource lifetimes, device usage and
> open counts that control state changes, and pm states.
> 
> atomic_t variables used for stats are atomic counters. Overflow will
> wrap around and reset the stats and no change with the conversion.
> 
> Convert them to use counter_atomic32.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Reviewed-by: Corey Minyard <cminyard@mvista.com>

I assume for this conversion that the plan is to eliminate atomic_t
completely and convert all atomic counters used for object lifetime to
struct kref?  The new naming is certainly more clear and I'm happy with
this change.

-corey

> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 9 +++++----
>  drivers/char/ipmi/ipmi_si_intf.c    | 9 +++++----
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 737c0b6b24ea..36c0b1be22fb 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -34,6 +34,7 @@
>  #include <linux/uuid.h>
>  #include <linux/nospec.h>
>  #include <linux/vmalloc.h>
> +#include <linux/counters.h>
>  
>  #define IPMI_DRIVER_VERSION "39.2"
>  
> @@ -584,7 +585,7 @@ struct ipmi_smi {
>  	struct ipmi_my_addrinfo addrinfo[IPMI_MAX_CHANNELS];
>  	bool channels_ready;
>  
> -	atomic_t stats[IPMI_NUM_STATS];
> +	struct counter_atomic32 stats[IPMI_NUM_STATS];
>  
>  	/*
>  	 * run_to_completion duplicate of smb_info, smi_info
> @@ -630,9 +631,9 @@ static LIST_HEAD(smi_watchers);
>  static DEFINE_MUTEX(smi_watchers_mutex);
>  
>  #define ipmi_inc_stat(intf, stat) \
> -	atomic_inc(&(intf)->stats[IPMI_STAT_ ## stat])
> +	counter_atomic32_inc(&(intf)->stats[IPMI_STAT_ ## stat])
>  #define ipmi_get_stat(intf, stat) \
> -	((unsigned int) atomic_read(&(intf)->stats[IPMI_STAT_ ## stat]))
> +	((unsigned int) counter_atomic32_read(&(intf)->stats[IPMI_STAT_ ## stat]))
>  
>  static const char * const addr_src_to_str[] = {
>  	"invalid", "hotmod", "hardcoded", "SPMI", "ACPI", "SMBIOS", "PCI",
> @@ -3448,7 +3449,7 @@ int ipmi_add_smi(struct module         *owner,
>  	INIT_LIST_HEAD(&intf->cmd_rcvrs);
>  	init_waitqueue_head(&intf->waitq);
>  	for (i = 0; i < IPMI_NUM_STATS; i++)
> -		atomic_set(&intf->stats[i], 0);
> +		counter_atomic32_set(&intf->stats[i], 0);
>  
>  	mutex_lock(&ipmi_interfaces_mutex);
>  	/* Look for a hole in the numbers. */
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index 77b8d551ae7f..0909a3461f05 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -43,6 +43,7 @@
>  #include "ipmi_si_sm.h"
>  #include <linux/string.h>
>  #include <linux/ctype.h>
> +#include <linux/counters.h>
>  
>  /* Measure times between events in the driver. */
>  #undef DEBUG_TIMING
> @@ -237,7 +238,7 @@ struct smi_info {
>  	bool dev_group_added;
>  
>  	/* Counters and things for the proc filesystem. */
> -	atomic_t stats[SI_NUM_STATS];
> +	struct counter_atomic32 stats[SI_NUM_STATS];
>  
>  	struct task_struct *thread;
>  
> @@ -245,9 +246,9 @@ struct smi_info {
>  };
>  
>  #define smi_inc_stat(smi, stat) \
> -	atomic_inc(&(smi)->stats[SI_STAT_ ## stat])
> +	counter_atomic32_inc(&(smi)->stats[SI_STAT_ ## stat])
>  #define smi_get_stat(smi, stat) \
> -	((unsigned int) atomic_read(&(smi)->stats[SI_STAT_ ## stat]))
> +	((unsigned int) counter_atomic32_read(&(smi)->stats[SI_STAT_ ## stat]))
>  
>  #define IPMI_MAX_INTFS 4
>  static int force_kipmid[IPMI_MAX_INTFS];
> @@ -2013,7 +2014,7 @@ static int try_smi_init(struct smi_info *new_smi)
>  	atomic_set(&new_smi->req_events, 0);
>  	new_smi->run_to_completion = false;
>  	for (i = 0; i < SI_NUM_STATS; i++)
> -		atomic_set(&new_smi->stats[i], 0);
> +		counter_atomic32_set(&new_smi->stats[i], 0);
>  
>  	new_smi->interrupt_disabled = true;
>  	atomic_set(&new_smi->need_watch, 0);
> -- 
> 2.25.1
> 
