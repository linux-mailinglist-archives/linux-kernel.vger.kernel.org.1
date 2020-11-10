Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A062ACEAD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 05:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbgKJEz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 23:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbgKJEz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 23:55:57 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1767C0613CF;
        Mon,  9 Nov 2020 20:55:57 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id n2so2804422ooo.8;
        Mon, 09 Nov 2020 20:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ifykcxQA07fH/LRmh7VNN3kiYpv6Q67MPmUgKPYWStE=;
        b=sIZHPMrijh0NtdiCgl+aMSWDRliLJv+7AcEKFbQ0JIadtBbkUvz5iVXaLcDrNFXvya
         D2br2lPagHKuw9pNFBbazDXKt3IKdHGNNp0E7NZ9Ci0FwCMeYskJe+F1ISEVLcywsrrH
         4xUrZ/BPgAt3iC6WUsOskGKcp8M3LVAAobDI5a+wuNW1J86hu6VJtLXB+4OmdZbbRKyl
         yZ8Q+yn4yTAQKzuA7MU2p1kF1WiUYsdnghAiz5gbJ+zkSm6KzCpKyQv7/QGnPG/HXA+1
         FtigbwBJZNd4RP2hxt8INPQ1bmEOfwMto7iP/vjIJ+evaqDX/2g7CUeQJTiQQhAfvU0V
         s9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ifykcxQA07fH/LRmh7VNN3kiYpv6Q67MPmUgKPYWStE=;
        b=qx6P7pecnM/TNRl5+mOAP2KprmT2KAeMt+e7CzfkWKmfT6j41dSh0Xrz9BGbxnyxgJ
         RMmu+9GZP4cwxO/D29oZKpLz9PPYqSZFBRGZZul9++ArGp54uzySzuh9Ddk4bpdQawcC
         Qfzr/0kSB0oJ9kWX8FLtnU1peRqd9r3t7KgmQxkxBmsuVbq0PXO0Yn8lbcmPlGp/ZnRH
         p6FmYAThkJUe3E1RayHhNiH0GITE+ZRsccqX2OQcIzS/mERtBwPYpHpaQq+t+Orx+Cnq
         o6CI/JgqcYUSYkihCZg1FLRMBMRKQ4h5pQQZPg6lak9FVnrLuUJnMgYiLxgiBRrLYT7+
         UVOg==
X-Gm-Message-State: AOAM533OoGfown6I7oUUDbY4Xgxk5fArY0HJQ2NKHzlvVdJ5JzCklfom
        8nwGJWDqO8w4mDc4vqfA41Tg2oaompE=
X-Google-Smtp-Source: ABdhPJyDRPRcyooqGmqli4Er+UWy02Z7ULosaePcmUf/fNvtqmlktoQKOEgn+vmMhB8EIqxtVTWhjg==
X-Received: by 2002:a4a:d81a:: with SMTP id f26mr5653471oov.59.1604984157081;
        Mon, 09 Nov 2020 20:55:57 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t6sm2927116ooo.22.2020.11.09.20.55.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Nov 2020 20:55:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 9 Nov 2020 20:55:54 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Brad Campbell <brad@fnarfbargle.com>
Cc:     Henrik Rydberg <rydberg@bitmath.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com, Andreas Kemnade <andreas@kemnade.info>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v3] applesmc: Re-work SMC comms
Message-ID: <20201110045554.GA106049@roeck-us.net>
References: <8e117844-d62a-bcb1-398d-c59cc0d4b878@fnarfbargle.com>
 <e5a856b1-fb1a-db5d-0fde-c86d0bcca1df@bitmath.org>
 <aa60f673-427a-1a47-7593-54d1404c3c92@bitmath.org>
 <9109d059-d9cb-7464-edba-3f42aa78ce92@bitmath.org>
 <5310c0ab-0f80-1f9e-8807-066223edae13@bitmath.org>
 <57057d07-d3a0-8713-8365-7b12ca222bae@fnarfbargle.com>
 <41909045-9486-78d9-76c2-73b99a901b83@bitmath.org>
 <20201108101429.GA28460@mars.bitmath.org>
 <db65e8ba-80fd-2142-56f2-8f625defb160@roeck-us.net>
 <daa34876-55b6-1a85-2532-976934d2fbb1@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daa34876-55b6-1a85-2532-976934d2fbb1@fnarfbargle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 01:04:04PM +1100, Brad Campbell wrote:
> On 9/11/20 3:06 am, Guenter Roeck wrote:
> > On 11/8/20 2:14 AM, Henrik Rydberg wrote:
> >> On Sun, Nov 08, 2020 at 09:35:28AM +0100, Henrik Rydberg wrote:
> >>> Hi Brad,
> >>>
> >>> On 2020-11-08 02:00, Brad Campbell wrote:
> >>>> G'day Henrik,
> >>>>
> >>>> I noticed you'd also loosened up the requirement for SMC_STATUS_BUSY in read_smc(). I assume
> >>>> that causes problems on the early Macbook. This is revised on the one sent earlier.
> >>>> If you could test this on your Air1,1 it'd be appreciated.
> >>>
> >>> No, I managed to screw up the patch; you can see that I carefully added the
> >>> same treatment for the read argument, being unsure if the BUSY state would
> >>> remain during the AVAILABLE data phase. I can check that again, but
> >>> unfortunately the patch in this email shows the same problem.
> >>>
> >>> I think it may be worthwhile to rethink the behavior of wait_status() here.
> >>> If one machine shows no change after a certain status bit change, then
> >>> perhaps the others share that behavior, and we are waiting in vain. Just
> >>> imagine how many years of cpu that is, combined. ;-)
> >>
> >> Here is a modification along that line.
> >>
> > 
> > Please resend this patch as stand-alone v4 patch. If sent like it was sent here,
> > it doesn't make it into patchwork, and is thus not only difficult to apply but
> > may get lost, and it is all but impossible to find and apply all tags.
> > Also, prior to Henrik's Signed=off-by: there should be a one-line explanation
> > of the changes made.
> > 
> > Thanks,
> > Guenter
> > 
> >> Compared to your latest version, this one has wait_status() return the
> >> actual status on success. Instead of waiting for BUSY, it waits for
> >> the other status bits, and checks BUSY afterwards. So as not to wait
> >> unneccesarily, the udelay() is placed together with the single
> >> outb(). The return value of send_byte_data() is augmented with
> >> -EAGAIN, which is then used in send_command() to create the resend
> >> loop.
> >>
> >> I reach 41 reads per second on the MBA1,1 with this version, which is
> >> getting close to the performance prior to the problems.
> >>
> 
> Can I get an opinion on this wait statement please?
> 
> The apple driver uses a loop with a million (1,000,000) retries spaced with a 10uS delay.
> 
> In my testing on 2 machines, we don't busy wait more than about 2 loops.
> Replacing a small udelay with the usleep_range kills performance.
> With the following (do 10 fast checks before we start sleeping) I nearly triple the performance
> of the driver on my laptop, and double it on my iMac. This is on an otherwise unmodified version of
> Henriks v4 submission.
> 
> Yes, given the timeouts I know it's a ridiculous loop condition.
> 
> static int wait_status(u8 val, u8 mask)
> {
> 	unsigned long end = jiffies + (APPLESMC_MAX_WAIT * HZ) / USEC_PER_SEC;
> 	u8 status;
> 	int i;
> 
> 	for (i=1; i < 1000000; i++) {

The minimum wait time is 10 us, or 16uS after the first 10
attempts. 1000000 * 10 = 10 seconds. I mean, it would make
some sense to limit the loop to APPLESMC_MAX_WAIT /
APPLESMC_MIN_WAIT iterations, but why 1,000,000 ?

> 		status = inb(APPLESMC_CMD_PORT);
> 		if ((status & mask) == val)
> 			return status;
> 		/* timeout: give up */
> 		if (time_after(jiffies, end))
> 			break;
> 		if (i < 10)
> 			udelay(10);
> 		else
> 			usleep_range(APPLESMC_MIN_WAIT, APPLESMC_MIN_WAIT * 16);

The original code had the exponential wait time increase.
I don't really see the point of changing that. I'd suggest
to keep the exponential increase but change the code to
something like
		if (us < APPLESMC_MIN_WAIT * 4)
			udelay(us)
		else
			usleep_range(us, us * 16);

Effectively that means the first wait would be 16 uS,
followed by 32 uS, followed by increasingly larger sleep
times. I don't know the relevance of APPLESMC_MIN_WAIT
being set to 16, but if you'd want to start with smaller
wait times you could reduce it to 8. If you are concerned
about excessively large sleep times you could reduce
the span from us..us*16 to, say, us..us*4 or us..us*2.

Thanks,
Guenter

> 	}
> 	return -EIO;
> }
> 
> Regards,
> Brad
