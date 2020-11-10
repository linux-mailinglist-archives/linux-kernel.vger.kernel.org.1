Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DA52ADB25
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 17:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbgKJQDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 11:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732552AbgKJQC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 11:02:59 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE78C0613CF;
        Tue, 10 Nov 2020 08:02:58 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id n15so12980028otl.8;
        Tue, 10 Nov 2020 08:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P+1WHSo5nRfK92zZpbEFbR6K1ACW8nD4DaHDRITvGs0=;
        b=keNSm7CIeqsK+4NzqrsVxLFDCyDGhismbak/bwpbcKmbNoq8WZ2ebMtR4muc3owxUw
         D+fZ2IItj4dOCItnthO4pQu+DkAM+rVEY8Lu6br38Qi7pLcUWVE5UexqfRQIWz9IWKkp
         AnzZEwRfNkwh3t54qMIzKE5RA6T96vUdzGRSKYKekrcQb781WHcjhMAujwBdXAqM3HqV
         /npzrWgTHukJNn+e4otjxQ5ce4T0+blwi8HKtr+4TIjw2SV32LBi2YXotVccQMOUznSd
         Ihbg0lw+Vu1WkHdQ/BQ9XF7HLCtxEIWouUEEm5WMKVCDrI8OTRj/Il3qgvHVaV0GIYV1
         QD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=P+1WHSo5nRfK92zZpbEFbR6K1ACW8nD4DaHDRITvGs0=;
        b=aH3Walls5AkK3jP1zBkbM6/aebYEp1GF5A/HE41joldB54spsvC3+UaL4/ONupZPB2
         8K63HllJjNSkn2YlZl2/s2WFQ392lEiIPBb38n2VvZZC1nU6JcKOWp7gwsbiPyIhIXvE
         HKB1iCaLpxRg2xgCt0m3s6sTzyiy1h9D3fQZ5D45i+x3G2s9MnHEFnHRCG6BIB9Qv/95
         lm9irVY4xJVDsZqJMjq9Yp9gdPOStdypw6f4qA7NmF6d1qdV8CxrnsxCVRGMoDTQP7Ar
         DhiXRtqCaoAeFnjzKoLJ+JfYj12F1o9lvPXUyBAoryxf/zlAYvRpXDzi1KFoNLwIdYJZ
         p4rw==
X-Gm-Message-State: AOAM530bWv5bIuBtEogZwynKtkl/9gR0Jpza5eAlVyWA+TOZ2nnPCeMZ
        sHqZHta9RblmZUQbcbpPMt4z5hta43w=
X-Google-Smtp-Source: ABdhPJxouxIKD/PzMgJof/XHeK54h+V20KEAFrGEMakSUFs4yQ2ZhAUm7DRXEWUEdTo1EZJiVASraw==
X-Received: by 2002:a9d:4704:: with SMTP id a4mr14043628otf.236.1605024177463;
        Tue, 10 Nov 2020 08:02:57 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k20sm3243328ooh.47.2020.11.10.08.02.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 08:02:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 10 Nov 2020 08:02:54 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Brad Campbell <brad@fnarfbargle.com>
Cc:     Henrik Rydberg <rydberg@bitmath.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com, Andreas Kemnade <andreas@kemnade.info>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v3] applesmc: Re-work SMC comms
Message-ID: <20201110160254.GB17288@roeck-us.net>
References: <aa60f673-427a-1a47-7593-54d1404c3c92@bitmath.org>
 <9109d059-d9cb-7464-edba-3f42aa78ce92@bitmath.org>
 <5310c0ab-0f80-1f9e-8807-066223edae13@bitmath.org>
 <57057d07-d3a0-8713-8365-7b12ca222bae@fnarfbargle.com>
 <41909045-9486-78d9-76c2-73b99a901b83@bitmath.org>
 <20201108101429.GA28460@mars.bitmath.org>
 <db65e8ba-80fd-2142-56f2-8f625defb160@roeck-us.net>
 <daa34876-55b6-1a85-2532-976934d2fbb1@fnarfbargle.com>
 <20201110045554.GA106049@roeck-us.net>
 <e1ed07e1-eb3a-eb61-37ca-875a4aa5c700@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1ed07e1-eb3a-eb61-37ca-875a4aa5c700@fnarfbargle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 04:40:23PM +1100, Brad Campbell wrote:
> On 10/11/20 3:55 pm, Guenter Roeck wrote:
> > On Tue, Nov 10, 2020 at 01:04:04PM +1100, Brad Campbell wrote:
> >> On 9/11/20 3:06 am, Guenter Roeck wrote:
> >>> On 11/8/20 2:14 AM, Henrik Rydberg wrote:
> >>>> On Sun, Nov 08, 2020 at 09:35:28AM +0100, Henrik Rydberg wrote:
> >>>>> Hi Brad,
> >>>>>
> >>>>> On 2020-11-08 02:00, Brad Campbell wrote:
> >>>>>> G'day Henrik,
> >>>>>>
> >>>>>> I noticed you'd also loosened up the requirement for SMC_STATUS_BUSY in read_smc(). I assume
> >>>>>> that causes problems on the early Macbook. This is revised on the one sent earlier.
> >>>>>> If you could test this on your Air1,1 it'd be appreciated.
> >>>>>
> >>>>> No, I managed to screw up the patch; you can see that I carefully added the
> >>>>> same treatment for the read argument, being unsure if the BUSY state would
> >>>>> remain during the AVAILABLE data phase. I can check that again, but
> >>>>> unfortunately the patch in this email shows the same problem.
> >>>>>
> >>>>> I think it may be worthwhile to rethink the behavior of wait_status() here.
> >>>>> If one machine shows no change after a certain status bit change, then
> >>>>> perhaps the others share that behavior, and we are waiting in vain. Just
> >>>>> imagine how many years of cpu that is, combined. ;-)
> >>>>
> >>>> Here is a modification along that line.
> >>>>
> >>>
> >>> Please resend this patch as stand-alone v4 patch. If sent like it was sent here,
> >>> it doesn't make it into patchwork, and is thus not only difficult to apply but
> >>> may get lost, and it is all but impossible to find and apply all tags.
> >>> Also, prior to Henrik's Signed=off-by: there should be a one-line explanation
> >>> of the changes made.
> >>>
> >>> Thanks,
> >>> Guenter
> >>>
> >>>> Compared to your latest version, this one has wait_status() return the
> >>>> actual status on success. Instead of waiting for BUSY, it waits for
> >>>> the other status bits, and checks BUSY afterwards. So as not to wait
> >>>> unneccesarily, the udelay() is placed together with the single
> >>>> outb(). The return value of send_byte_data() is augmented with
> >>>> -EAGAIN, which is then used in send_command() to create the resend
> >>>> loop.
> >>>>
> >>>> I reach 41 reads per second on the MBA1,1 with this version, which is
> >>>> getting close to the performance prior to the problems.
> >>>>
> >>
> >> Can I get an opinion on this wait statement please?
> >>
> >> The apple driver uses a loop with a million (1,000,000) retries spaced with a 10uS delay.
> >>
> >> In my testing on 2 machines, we don't busy wait more than about 2 loops.
> >> Replacing a small udelay with the usleep_range kills performance.
> >> With the following (do 10 fast checks before we start sleeping) I nearly triple the performance
> >> of the driver on my laptop, and double it on my iMac. This is on an otherwise unmodified version of
> >> Henriks v4 submission.
> >>
> >> Yes, given the timeouts I know it's a ridiculous loop condition.
> >>
> >> static int wait_status(u8 val, u8 mask)
> >> {
> >> 	unsigned long end = jiffies + (APPLESMC_MAX_WAIT * HZ) / USEC_PER_SEC;
> >> 	u8 status;
> >> 	int i;
> >>
> >> 	for (i=1; i < 1000000; i++) {
> > 
> > The minimum wait time is 10 us, or 16uS after the first 10
> > attempts. 1000000 * 10 = 10 seconds. I mean, it would make
> > some sense to limit the loop to APPLESMC_MAX_WAIT /
> > APPLESMC_MIN_WAIT iterations, but why 1,000,000 ?
> 
> I had to pick a big number and it was easy to punch in 6 zeros as that is what is in
> the OSX driver. In this instance it's more a proof of concept rather than sane example
> because it'll either abort on timeout or return the correct status anyway.
> Could also have been a while (true) {} but then I'd need to manually increment i.
> 
> >> 		status = inb(APPLESMC_CMD_PORT);
> >> 		if ((status & mask) == val)
> >> 			return status;
> >> 		/* timeout: give up */
> >> 		if (time_after(jiffies, end))
> >> 			break;
> >> 		if (i < 10)
> >> 			udelay(10);
> >> 		else
> >> 			usleep_range(APPLESMC_MIN_WAIT, APPLESMC_MIN_WAIT * 16);
> > 
> > The original code had the exponential wait time increase.
> > I don't really see the point of changing that. I'd suggest
> > to keep the exponential increase but change the code to
> > something like
> > 		if (us < APPLESMC_MIN_WAIT * 4)
> > 			udelay(us)
> > 		else
> > 			usleep_range(us, us * 16);
> 
> The main reason I dropped the exponential was best case on this laptop the modified code with exponential
> wait as described above increase increases the performance from ~40 -> 62 reads/sec, whereas the version 
> I posted with the first 10 loops at 10uS goes from ~40 -> 100 reads/sec.
> 
> About 95% of waits never get past a few of iterations of that loop (so ~30-60uS). With a
> modified exponential starting at 8uS a 30uS requirement ends up at 56uS. If it needed 60us with
> the original we end up waiting 120uS.
> 
> If it needs longer than 120uS it's rare enough that a bigger sleep isn't going to cause much
> of a performance hit.
> 
> Getting completely pathological and busy waiting with a fixed 10uS delay like the OSX driver
> does give about 125 reads/sec but I was trying to find a balance and 10 loops seemed to hit that mark.
>  
> > Effectively that means the first wait would be 16 uS,
> > followed by 32 uS, followed by increasingly larger sleep
> > times. I don't know the relevance of APPLESMC_MIN_WAIT
> > being set to 16, but if you'd want to start with smaller
> > wait times you could reduce it to 8. If you are concerned
> > about excessively large sleep times you could reduce
> > the span from us..us*16 to, say, us..us*4 or us..us*2.
> 
> I was tossing up here between the overhead required to manage a tighter usleep_range
> vs some extra udelays. 
> 
> It's not exactly a performance sensitive driver, but I thought there might be a balance to be
> struck between performance and simplicity. The exponential delay always struck me as odd.
> 
> If the preference is to leave it as is or modify as suggested I'm ok with that too.
> Appreciate the input.

Ok, not worth arguing about.

Guenter

> 
> Regards,
> Brad
