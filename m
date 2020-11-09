Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5FC2AB2A6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 09:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbgKIIof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 03:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729730AbgKIIoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 03:44:34 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD80C0613CF;
        Mon,  9 Nov 2020 00:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TzAYk+oLfVC+xVZW8MM6v2hBnX5j/D5hCWL6Cocma5o=; b=Dt4afT0z6eA27cnX+8KRhbMcrn
        29om7M2uPWubzw18vMW7SHfQwjicrvhjDvY+Ez+XvS+hyyWqy8n8jRGptzGAajg5ylxKGRw5aNIJ0
        e/Y1Rd44uXpCKW7i6+fg/LsUwsCATVPJsbZuRcIGbVeNg170AZnX0e7jwJz0SwR+oivA=;
Received: from p200300ccff0815001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff08:1500:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kc2mn-0008R6-8n; Mon, 09 Nov 2020 09:44:25 +0100
Date:   Mon, 9 Nov 2020 09:44:24 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Henrik Rydberg <rydberg@bitmath.org>
Cc:     Brad Campbell <brad@fnarfbargle.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v3] applesmc: Re-work SMC comms
Message-ID: <20201109094424.1c10651f@aktux>
In-Reply-To: <20201108101429.GA28460@mars.bitmath.org>
References: <70331f82-35a1-50bd-685d-0b06061dd213@fnarfbargle.com>
        <3c72ccc3-4de1-b5d0-423d-7b8c80991254@fnarfbargle.com>
        <6d071547-10ee-ca92-ec8b-4b5069d04501@bitmath.org>
        <8e117844-d62a-bcb1-398d-c59cc0d4b878@fnarfbargle.com>
        <e5a856b1-fb1a-db5d-0fde-c86d0bcca1df@bitmath.org>
        <aa60f673-427a-1a47-7593-54d1404c3c92@bitmath.org>
        <9109d059-d9cb-7464-edba-3f42aa78ce92@bitmath.org>
        <5310c0ab-0f80-1f9e-8807-066223edae13@bitmath.org>
        <57057d07-d3a0-8713-8365-7b12ca222bae@fnarfbargle.com>
        <41909045-9486-78d9-76c2-73b99a901b83@bitmath.org>
        <20201108101429.GA28460@mars.bitmath.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Nov 2020 11:14:29 +0100
Henrik Rydberg <rydberg@bitmath.org> wrote:

> On Sun, Nov 08, 2020 at 09:35:28AM +0100, Henrik Rydberg wrote:
> > Hi Brad,
> > 
> > On 2020-11-08 02:00, Brad Campbell wrote:  
> > > G'day Henrik,
> > > 
> > > I noticed you'd also loosened up the requirement for SMC_STATUS_BUSY in read_smc(). I assume
> > > that causes problems on the early Macbook. This is revised on the one sent earlier.
> > > If you could test this on your Air1,1 it'd be appreciated.  
> > 
> > No, I managed to screw up the patch; you can see that I carefully added the
> > same treatment for the read argument, being unsure if the BUSY state would
> > remain during the AVAILABLE data phase. I can check that again, but
> > unfortunately the patch in this email shows the same problem.
> > 
> > I think it may be worthwhile to rethink the behavior of wait_status() here.
> > If one machine shows no change after a certain status bit change, then
> > perhaps the others share that behavior, and we are waiting in vain. Just
> > imagine how many years of cpu that is, combined. ;-)  
> 
> Here is a modification along that line.
> 
> Compared to your latest version, this one has wait_status() return the
> actual status on success. Instead of waiting for BUSY, it waits for
> the other status bits, and checks BUSY afterwards. So as not to wait
> unneccesarily, the udelay() is placed together with the single
> outb(). The return value of send_byte_data() is augmented with
> -EAGAIN, which is then used in send_command() to create the resend
> loop.
> 
> I reach 41 reads per second on the MBA1,1 with this version, which is
> getting close to the performance prior to the problems.
> 
> From b4405457f4ba07cff7b7e4f48c47668bee176a25 Mon Sep 17 00:00:00 2001
> From: Brad Campbell <brad@fnarfbargle.com>
> Date: Sun, 8 Nov 2020 12:00:03 +1100
> Subject: [PATCH] hwmon: (applesmc) Re-work SMC comms
> 
> Commit fff2d0f701e6 ("hwmon: (applesmc) avoid overlong udelay()")
> introduced an issue whereby communication with the SMC became
> unreliable with write errors like :
> 
> [  120.378614] applesmc: send_byte(0x00, 0x0300) fail: 0x40
> [  120.378621] applesmc: LKSB: write data fail
> [  120.512782] applesmc: send_byte(0x00, 0x0300) fail: 0x40
> [  120.512787] applesmc: LKSB: write data fail
> 
> The original code appeared to be timing sensitive and was not reliable
> with the timing changes in the aforementioned commit.
> 
> This patch re-factors the SMC communication to remove the timing
> dependencies and restore function with the changes previously
> committed.
> 
> Tested on : MacbookAir6,2 MacBookPro11,1 iMac12,2, MacBookAir1,1,
> MacBookAir3,1
> 
> Fixes: fff2d0f701e6 ("hwmon: (applesmc) avoid overlong udelay()")
> Reported-by: Andreas Kemnade <andreas@kemnade.info>
> Tested-by: Andreas Kemnade <andreas@kemnade.info> # MacBookAir6,2
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Brad Campbell <brad@fnarfbargle.com>
> Signed-off-by: Henrik Rydberg <rydberg@bitmath.org>
> 
> ---
> Changelog : 
> v1 : Inital attempt
> v2 : Address logic and coding style
> v3 : Removed some debug hangover. Added tested-by. Modifications for MacBookAir1,1
> v4 : Do not expect busy state to appear without other state changes
> 

still works here (MacBookAir6,2)

Regards,
Andreas
