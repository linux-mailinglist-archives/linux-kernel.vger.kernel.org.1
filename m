Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BE92A8094
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbgKEOPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730922AbgKEOPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:15:52 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078CEC0613CF;
        Thu,  5 Nov 2020 06:15:52 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id n16so458936ooj.2;
        Thu, 05 Nov 2020 06:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y++wwA2trwoLTeidmcO6HyXS/KDcURbyY/O4LhQQQ6M=;
        b=ha1QZSeeAlAiTnjwS63lsPoRvbfSsQWqdLQ2EGZjZBRoudlDSqohQgFDSuR0xtuj+U
         xyY75x/1lUo9RaZOfMPjtFwXZso4SNSE83B9Yu9pqIQij8XCIWx1S3lHNVymVsUXoU1U
         KuXjpdbOY+rFru/M89FZ5/vt5uoFgXrGCjTQQ7lQgiAo0tNuyA5YW0iAhX/9smMKEfNW
         7R3frLknjvlimjnqUMRgzwGu+RgqLOHzNF3RYhnVEiABY/4K0mZPkVqYtWVh0ZAEgVSX
         QsNF5ikBNYngO93BU3vozWy5Qpr4DJSVAybU2GAPW14CYUS3ciP57EtgUy2tP/5RH5ls
         qmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=y++wwA2trwoLTeidmcO6HyXS/KDcURbyY/O4LhQQQ6M=;
        b=AGqebtsEOSksDwCEQ8XeMslWP55mzl9cI97HKNCKCmLQRhBtBP6KDwhoevi5YKBPWQ
         EbBBG+BaKxS9piddC6WhcSAjSk4eRoghIRQECFbMj0cd1PmCR5VB4EXktrUdXFZH6tog
         HB4rAIP/UilLpbJoamVXpUUTS3RdDZqdILKiQfEVG35bLv34TSyRBJS5iEHeDT3t5VOg
         Pb8WK7cA86fEgfmLbRdScgeC0DcqYeyP9vS199xDulmZOLwFecWGkU6jjgImEKUyN0/5
         PDs2yGRUYd9V76ZSVjCwF3UZmNIHflFrMgWqXHlWCI+816lpNIT2CajKboe3Aea7eZsE
         /V0A==
X-Gm-Message-State: AOAM530zCjjc2S/iNC3jcNWMuFzYTA7wllWIrCy6SF6QiVbJp6EH+H8R
        85ucHxMnAPajFwLt65WAaQUT9lSYHdU=
X-Google-Smtp-Source: ABdhPJxbVW5EMauDC4fb3QXE0Z5KS/uYP+xGsu5usDkf7xMtKhy4T/g/tl9bfb7eojbjgiAFpTS6FA==
X-Received: by 2002:a4a:cf09:: with SMTP id l9mr1987400oos.30.1604585751422;
        Thu, 05 Nov 2020 06:15:51 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m11sm358655oop.6.2020.11.05.06.15.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 06:15:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 5 Nov 2020 06:15:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     Colin King <colin.king@canonical.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] hwmon: corsair-psu: fix unintentional sign
 extension issue
Message-ID: <20201105141549.GA1389@roeck-us.net>
References: <20201105115019.41735-1-colin.king@canonical.com>
 <20201105133233.10edda5b@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105133233.10edda5b@monster.powergraphx.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 01:32:33PM +0100, Wilken Gottwalt wrote:
> On Thu,  5 Nov 2020 11:50:19 +0000
> Colin King <colin.king@canonical.com> wrote:
> 
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The shifting of the u8 integer data[3] by 24 bits to the left will
> > be promoted to a 32 bit signed int and then sign-extended to a
> > long. In the event that the top bit of data[3] is set then all
> > then all the upper 32 bits of a 64 bit long end up as also being
> > set because of the sign-extension. Fix this by casting data[3] to
> > a long before the shift.
> > 
> > Addresses-Coverity: ("Unintended sign extension")
> > Fixes: ce15cd2cee8b ("hwmon: add Corsair PSU HID controller driver")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/hwmon/corsair-psu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> > index e92d0376e7ac..5d19a888231a 100644
> > --- a/drivers/hwmon/corsair-psu.c
> > +++ b/drivers/hwmon/corsair-psu.c
> > @@ -241,7 +241,7 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8
> > rail, l
> >  	 * the LINEAR11 conversion are the watts values which are about 1200 for the strongest
> > psu
> >  	 * supported (HX1200i)
> >  	 */
> > -	tmp = (data[3] << 24) + (data[2] << 16) + (data[1] << 8) + data[0];
> > +	tmp = ((long)data[3] << 24) + (data[2] << 16) + (data[1] << 8) + data[0];
> >  	switch (cmd) {
> >  	case PSU_CMD_IN_VOLTS:
> >  	case PSU_CMD_IN_AMPS:
> 
> Yeah, this could happen if the uptime value in the micro-controller gets bigger
> than 68 years (in seconds), and it is the only value which actually uses more
> than 2 bytes for the representation. So what about architectures which are 32 bit
> wide and where a long has 32 bits? I guess this simple cast is not enough.
> 

The hwmon subsystem uses 'long' to pass values back to the core.
While that may be a bit unfortunate as it doesn't support uptimes
of more than 68 years in seconds, we are not going to change the
hwmon core to accommodate it. If the incoming data is always
expected to be positive, and you don't want to risk the overflow,
feel free to either use "data[3] & 0x7f" instead, or max out the
result at INT_MAX (from <linux/limits.h>).

Thanks,
Guenter
