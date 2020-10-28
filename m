Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C648B29D7E1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387396AbgJ1W1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733282AbgJ1W1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:27:34 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D79C0613CF;
        Wed, 28 Oct 2020 15:27:34 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id bl9so564938qvb.10;
        Wed, 28 Oct 2020 15:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JuzDUdCe2w+w28rdeAmQTlU9jyTM7YJ+llzJx19PImc=;
        b=g9QU+Foc/no8WnHkeWW+oiFQMFS/hiNSaIlXiN1wtlZuqLDY0oenJ64/CZStC35fsF
         Pl+0YZ18/sB+/oa3OPTLowJelNafPlRMP7AfI8yCyCEYL8z/IUSvdobX2KPkUdjxrdWA
         zfshLOj6udgSjmOJ1P/rGwdozTW62K6FlbFm+e6/+ST+78ilg5dtp3BqzW1qm7poWMOF
         1ks1t6CHVp3zVV1wVMeb05dcSBNkYl0kc0hww3xg9Cl37Rn11d5FeCW/uYXIvoOnmFFs
         HByXVWBIJwFsSi0gQS305wwgEwXb8/VPr6KKJHjOJ+lCAg/nPXPfC8bpFUB3kaBCONOU
         a3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JuzDUdCe2w+w28rdeAmQTlU9jyTM7YJ+llzJx19PImc=;
        b=spfWQxyDAldt5ef58KOXD+G+1G6gMK2yUkBenh8yk8jfWqK+sr6p/8Mc6parfBwmJW
         beBlYrtGV1HXiQoFgdam/HnvOJuW8Sga2heqL0vSJTe4wQiVmkRSzXeHjPM1n3TKVnUe
         wydve2W06KB13bQpJKiD74VZO9ds2QBtPQyuTzzFtsXWVgED1GAB8aWhnrZVZEXQy7bP
         9/mUHrDjpY/qDts9rRsHP9C9pnXBiRLwd9wihykzH5RAtVQM01hPC7TU0sBhseiJJSJW
         eONr1vTgi0UEV7iVtSKFhDviEu+uTErMoNEA1LpU1C1+V4INMWWRLloewnMu5wqsEl2m
         mCwA==
X-Gm-Message-State: AOAM533ycJpW07kKeCwLzXmNhXSniCiJrzNXu3kSq7yCp6Mhn9XKvXxw
        Nr/g7Ekc2hSDxR+fezARtg6f198vk1uK2g==
X-Google-Smtp-Source: ABdhPJwGQBMGdYPB8lUcMRQ3i+i6C4mdaUQc54gZfkunUxJSpzMfa6QVLivDoIz79GoJBhg43c32SQ==
X-Received: by 2002:aa7:9622:0:b029:160:7bc:4d00 with SMTP id r2-20020aa796220000b029016007bc4d00mr7761490pfg.51.1603896201478;
        Wed, 28 Oct 2020 07:43:21 -0700 (PDT)
Received: from localhost (23.83.224.115.16clouds.com. [23.83.224.115])
        by smtp.gmail.com with ESMTPSA id x7sm6285203pfr.61.2020.10.28.07.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 07:43:20 -0700 (PDT)
Date:   Wed, 28 Oct 2020 22:43:15 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v3] usb: dwc3: core: fix a issue about clear connect state
Message-ID: <20201028144315.GA3766@nuc8i5>
References: <20201020135806.30268-1-zhengdejin5@gmail.com>
 <875z6wdq62.fsf@kernel.org>
 <20201028125812.GA59692@nuc8i5>
 <87y2jqlahc.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2jqlahc.fsf@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 03:57:03PM +0200, Felipe Balbi wrote:
> 
> Hi,
> 
> Dejin Zheng <zhengdejin5@gmail.com> writes:
> >> Dejin Zheng <zhengdejin5@gmail.com> writes:
> >> > According to Synopsys Programming Guide chapter 2.2 Register Resets,
> >> > it cannot reset the DCTL register by setting DCTL.CSFTRST for core soft
> >> > reset, if DWC3 controller as a slave device and stay connected with a usb
> >> > host, then, while rebooting linux, it will fail to reinitialize dwc3 as a
> >> > slave device when the DWC3 controller did not power off. because the
> >> > connection status is incorrect, so we also need to clear DCTL.RUN_STOP
> >> > bit for disabling connect when doing core soft reset. There will still
> >> > be other stale configuration in DCTL, so reset the other fields of DCTL
> >> > to the default value 0.
> >> 
> >> This commit log is a bit hard to understand. When does this problem
> >> actually happen? It seems like it's in the case of, perhaps, kexecing
> >> into a new kernel, is that right?
> >> 
> > It happens when entering the kernel for the second time after the reboot
> > command.
> >
> >> At the time dwc3_core_soft_reset() is called, the assumption is that
> >> we're starting with a clean core, from power up. If we have stale
> >> configuration from a previous run, we should fix this on the exit
> >> path. Note that if we're reaching probe with pull up connected, we
> >> already have issues elsewhere.
> >> 
> >> I think this is not the right fix for the problem.
> >>
> > I think you are right, Thinh also suggested me fix it on the exit path
> > in the previous patch v2. Do you think I can do these cleanups in the
> > shutdown hook of this driver? Balbi, is there a more suitable place to
> > do this by your rich experience? Thanks!
> 
> I don't think shutdown is called during removal, I'm not sure. I think
> we had some fixes done in shutdown time, though. Test it out, but make
> sure there are no issues with a regular modprobe cycle.
>
Balbi, thanks for your suggestions, I will do a test in the shutdown
hook first.
> -- 
> balbi


