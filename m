Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36F728EDF1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 09:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgJOHxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 03:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbgJOHxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 03:53:39 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF663C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 00:53:39 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id p11so1173096pld.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 00:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bK4qsi2vQb5CcRmG1LFQubHmZdcX1pxhKA8r2gNfteA=;
        b=E3UBUodvzdsS90mKNO9N28csgovPqzlgzsl0VBSfvdM6uFbiOFJ8J1uFI0iuR4DYOg
         5IYiXvJV1BBqXSxDrFolpK13DDvUfSlFM8M1cstQ4MySmYhHqOSrRSTkP5iInvUIdjGp
         KryouaMJLr8IjaJSNg99hMlUSXpXm7ImkG5fQRcYXsvKj7E2HSLTkeo9dQcKyhhb7UDD
         +Ycwmoz/Et60whwbHBGfgmcFL+gpPOgWXf+ZMX+AFkkqPfjlr1rYuk15zDa5qq4FKDk6
         /Ctuy7o4Wz/HVbiJbjWEzJaPzGtL1DljqT5v0XNXz3ph76ENyj/oe9BCjnzdIIUqOSJL
         hgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bK4qsi2vQb5CcRmG1LFQubHmZdcX1pxhKA8r2gNfteA=;
        b=p0m2r95GyOkC5jX9pMJYJVzEW+fHdmGzUYUThhZLWwMhEttqrfOETZSfUBOnRSHyIk
         7twopXKl6liZUq/qCF8bfZ5oybNxJY9wxDuuUrfoD2VfJp4LxhrgwY2QrCzel9SZh/KR
         WfLe7kZHyjX+t/WlSbI1DUd8NQHTj0bXaV1T7OUaQDg9Qtl905YO/l5/TR+TEV6rh/qa
         b+ZjtwNP1HisepfPGaA/JuTtwsdB9MaPq/EwuKhjvwGhwp4vcvop8g8PwpCEFrv3qJ1p
         L2uliXu29dyvb2PjoXp+zWojIR1JyCqz8dHW7FsY0VCIBFV7eqva6BuX+2FXuWuIoU67
         vQWw==
X-Gm-Message-State: AOAM533Y7DA7dC/F61BnabnviQvM8J7/bkobxyW6IpTlM64uMkxPaS3f
        LVWueKB4hX1nX4Wxg8RoLa4=
X-Google-Smtp-Source: ABdhPJzhnmWMonWIfVRqCGlB6Zjma+tVpECTOE6dxZ7Y736k6RGqnYqNGoNbWJreoFnhfbWCkFJHRA==
X-Received: by 2002:a17:90a:3486:: with SMTP id p6mr3221874pjb.23.1602748419050;
        Thu, 15 Oct 2020 00:53:39 -0700 (PDT)
Received: from gmail.com ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id fu19sm2143165pjb.43.2020.10.15.00.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 00:53:38 -0700 (PDT)
Date:   Thu, 15 Oct 2020 00:53:19 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [PATCH v3 2/3] fs/proc: apply the time namespace offset to
 /proc/stat btime
Message-ID: <20201015075319.GA271498@gmail.com>
References: <20201011145924.6554-1-michael.weiss@aisec.fraunhofer.de>
 <20201011145924.6554-3-michael.weiss@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201011145924.6554-3-michael.weiss@aisec.fraunhofer.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 04:59:23PM +0200, Michael Weiß wrote:
> @@ -79,6 +80,20 @@ static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
>  
>  #endif
>  
> +static void get_boottime(struct timespec64 *ts)
> +{

> +	ktime_t boottime;
> +
> +	/* get kernel internal system boot timestamp */
> +	getboottime64(ts);
> +
> +	/* shift boot timestamp according to the timens offset */
> +	boottime = timespec64_to_ktime(*ts);
> +	boottime = timens_ktime_to_host(CLOCK_BOOTTIME, boottime);

timens_ktime_to_host is used to convert timens' time to host's time.
Here it looks like we are using it in the opposite direction. I spent
some time to figure out what is going on here. I think it worth to add a
comment here.

> +
> +	*ts = ktime_to_timespec64(boottime);

I don't like all these conversions back and forth. Maybe something like
this will look better:

#ifdef CONFIG_TIME_NS
	if (current->nsproxy->time_ns != init_time_ns) {
		struct timens_offsets *ns_offsets;
		ns_offsets = &current->nsproxy->time_ns->offsets;
		ts = timespec64_sub(ts, timens_offsets->boottime);
	}
#endif


Thanks,
Andrei
