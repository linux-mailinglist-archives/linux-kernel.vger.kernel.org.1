Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DC12AAA10
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 09:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgKHIWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 03:22:07 -0500
Received: from mailrelay1-2.pub.mailoutpod1-cph3.one.com ([46.30.212.0]:26658
        "EHLO mailrelay1-2.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbgKHIWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 03:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitmath.org; s=20191106;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:cc:to:subject:from;
        bh=vcNxa8iue2751WIIc39z1vwhRHUbXhsp3/e3p7XyzFM=;
        b=Q+Nu9eZKLBv+w/mIVGV2z68aLti+/evalA6kRi+r/mMLTKiZXGpEJ4oQZuO/arz/QjMahEdgu3Yvj
         rx17ytYYFtg5Yu9msDoBxeC9SG4WTVsllVFMuETcCZ89LTc+KjL49nsVZaMAI/MoLmYVHLZHuDb//o
         cWxo3IGuUEpFtzLCGUT3gazOPrQ7gld6e8a9L9ouO6sPLPlWdDxihzVbhRW04qvUEZHeScsdN/+P0f
         HM/BKqOM17AgDWflqhypR3EGWt/nw/AnshP4HjiG6n8JTAWjNY7TXyz7zwrpzVdAiOwWFUNob+Vhoh
         pmAT5ccKgW6yqbMIlRCQ9CK8ZU21WqA==
X-HalOne-Cookie: 0cc1958e164cd661d1012c3cb799f400dc010809
X-HalOne-ID: 7a4837aa-219b-11eb-9658-d0431ea8a283
Received: from [192.168.19.13] (h-155-4-128-97.na.cust.bahnhof.se [155.4.128.97])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 7a4837aa-219b-11eb-9658-d0431ea8a283;
        Sun, 08 Nov 2020 08:22:02 +0000 (UTC)
Subject: Re: [PATCH] applesmc: Re-work SMC comms v2
To:     Brad Campbell <brad@fnarfbargle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com, Guenter Roeck <linux@roeck-us.net>,
        Andreas Kemnade <andreas@kemnade.info>,
        Jean Delvare <jdelvare@suse.com>
References: <20200930105442.3f642f6c@aktux> <20201002002251.28462e64@aktux>
 <7543ef85-727d-96c3-947e-5b18e9e6c44d@roeck-us.net>
 <20201006090226.4275c824@kemnade.info>
 <db042e9b-be41-11b1-7059-3881b1da5c8b@fnarfbargle.com>
 <68467f1b-cea1-47ea-a4d4-8319214b072a@fnarfbargle.com>
 <20201104142057.62493c12@aktux>
 <2436afef-99c6-c352-936d-567bf553388c@fnarfbargle.com>
 <7a085650-2399-08c0-3c4d-6cd1fa28a365@roeck-us.net>
 <fc36d066-c432-e7d2-312f-a0a592446fe2@fnarfbargle.com>
 <10027199-5d31-93e7-9bd8-7baaebff8b71@roeck-us.net>
 <70331f82-35a1-50bd-685d-0b06061dd213@fnarfbargle.com>
 <3c72ccc3-4de1-b5d0-423d-7b8c80991254@fnarfbargle.com>
 <6d071547-10ee-ca92-ec8b-4b5069d04501@bitmath.org>
 <8e117844-d62a-bcb1-398d-c59cc0d4b878@fnarfbargle.com>
 <e5a856b1-fb1a-db5d-0fde-c86d0bcca1df@bitmath.org>
 <aa60f673-427a-1a47-7593-54d1404c3c92@bitmath.org>
 <9109d059-d9cb-7464-edba-3f42aa78ce92@bitmath.org>
 <5310c0ab-0f80-1f9e-8807-066223edae13@bitmath.org>
 <26d3f4f5-2e9a-cd20-1531-74cf44ef738c@fnarfbargle.com>
From:   Henrik Rydberg <rydberg@bitmath.org>
Message-ID: <bddf0050-4189-4ca4-8077-71683bcc4b10@bitmath.org>
Date:   Sun, 8 Nov 2020 09:22:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <26d3f4f5-2e9a-cd20-1531-74cf44ef738c@fnarfbargle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brad,

> G'day Henrik,
> 
> Which kernel was this based on? It won't apply to my 5.9 tree.

I was being lazy and applied the diff to linus/master on top of my 
current stable branch. More importantly, I sent the mail out from an 
email client that may not format the patch properly; I'll fix that.

> I assume the sprinkling of udelay(APPLESMC_MIN_WAIT) means the SMC is
> slow in getting its status register set up. Could we instead just put
> a single one of those up-front in wait_status?

That works fine, just a matter of taste.

> Any chance you could try this one? I've added a retry to send_command and
> added a single global APPLESMC_MIN_WAIT before each status read.
> 
>  From looking at your modified send_command, it appears the trigger for a
> retry is sending a command and the SMC doing absolutely nothing. This
> should do the same thing.

Not quite, unfortunately. The patch that works waits for a drop of 
IB_CLOSED, then checks the BUSY status. If not seen, it resends 
immediately, never expecting to see it. The patch in this email creates 
a dreadfully sluggish probe, and the occasional failure.

> Interestingly enough, by adding the udelay to wait_status on my machine I've
> gone from 24 reads/s to 50 reads/s.

Yep, I experience the same positive effect.

> I've left out the remainder of the cleanups. Once we get a minimally working
> patch I was going to look at a few cleanups, and I have some patches pending
> to allow writing to the SMC from userspace (for setting BCLM and BFCL mainly)

All fine. I will respond to the v3 mail separately.

Henrik
