Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC5F2F663F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 17:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbhANQsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 11:48:52 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:46086 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbhANQsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:48:51 -0500
Received: by mail-pf1-f178.google.com with SMTP id w2so3657605pfc.13;
        Thu, 14 Jan 2021 08:48:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eqwubZTNt3DRHLaHVHfb6TFQ3FZ3iI4PMB4r8+r0uhg=;
        b=BcorTvqJeoMUiWZJBLrDyPRoJo13w7cqEGnPK98asdRtQR7lOBVo40G3kZNFwhNTF5
         trmynrcTz9BAl4I4BVTPcWeBrYYiMbnC8f5sEERVdvQ8BBzm7+v1AaYfsZp0XHzbYhxH
         rhPMcCBFXt5gseP26HvbYUjWrGm6KmQctlPJJu9V7Q6ynVryzRlS+xxJ+Ml45sevs5Uo
         KCPw7gWOin8mDMm38pjOXyWqljPZuQUFXqYpJ9XL5TpbpJ1ZPBGjU2TknOxJSMtGBKYC
         AqxQdyFyxHz9iCj9tvZkLqFGPzB9IzylUh3uqFiX4alrfqCG9zsQjwy6yStU5DN4LegG
         2Kog==
X-Gm-Message-State: AOAM5334jtMJlNN0MuaIt23wdPcSn3vFmxkPDBSrc+loKQ/96L2rLw/r
        i0xCCmMo//vumtfbPwig4Og=
X-Google-Smtp-Source: ABdhPJxOakcQvK7jxYSLkKeFqJM45OeH1/g8iS1vJn3i7s4O9OgjjHcgaEKFS1VQ6Sm76HSJyMunGg==
X-Received: by 2002:a63:5d53:: with SMTP id o19mr8415505pgm.39.1610642890672;
        Thu, 14 Jan 2021 08:48:10 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id mv17sm6162090pjb.17.2021.01.14.08.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 08:48:09 -0800 (PST)
Date:   Thu, 14 Jan 2021 08:48:08 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        linux-kernel@vger.kernel.org, moritzf@google.com,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Russ Weight <russell.h.weight@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>,
        Sonal Santan <sonal.santan@xilinx.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCH 0/8] FPGA DFL Changes for 5.12
Message-ID: <YAB1yBvbGjxK8KTo@epycbox.lan>
References: <X/v2xs5Rnfw9F18E@kroah.com>
 <9bc01a73-726f-a979-1246-6ea048961670@redhat.com>
 <X/xmi/jJmDHnV5/N@kroah.com>
 <7923d9dc-c503-5318-6e4f-931f8c13c1be@redhat.com>
 <X/x4QjGyP8ssYUDI@kroah.com>
 <fe9739cf-abc9-c0c6-933e-8447a9d197a8@redhat.com>
 <X/yXOFYnQcA1MsUd@kroah.com>
 <dccc8075-b900-8680-3620-8050475858a7@redhat.com>
 <X/y0+ZCPsfrg/LUp@archbook>
 <ac1fd7f4-f53a-ddc4-192b-8c8af254f7ee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac1fd7f4-f53a-ddc4-192b-8c8af254f7ee@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 02:39:36PM -0800, Tom Rix wrote:
> 
> On 1/11/21 12:28 PM, Moritz Fischer wrote:
> > Tom,
> >
> > On Mon, Jan 11, 2021 at 11:46:03AM -0800, Tom Rix wrote:
> >
> > [..]
> >> I have been doing the first review in a couple of days after every patch landing.
> > I appreciate your help with doing reviews.
> >  
> >> I see some pretty good response from the developers to fix the issues raised.Ã‚Â 
> > ... yet patches have been rejected. So it doesn't seem purely a matter
> > of throughput?
> >
> >> But I do not see Moritz picking up the review until weeks later.
> > I'll admit there are delays that happen, I have a dayjob as I pointed
> > out in earlier conversations. Furthermore, just because I do not
> > immediately send out an email does not mean I don't look at stuff.
> >
> > If people show up with 100kLOC patchsets that don't pass checkpatch,
> > it'll take a while for me to even read up and understand what they're
> > doing / trying to do.
> >
> >> This consistent delay in timely reviews is a bottleneck.
> > As Greg pointed out even ones that were reviewed got rejected, so
> > clearly the issue is with the quality and not the speed at which we send
> > them on.
> >
> >> It would be good if the big first reviews could be done in parallel.
> > Again depending how the patchsets are structured it will take me a while
> > to process. Having them re-use existing infrastructure, following
> > coding and submission guidelines will speed up the process.
> >
> > On a personal level, being told I'm too slow and not doing my job as
> > maintainer doesn't exactly increase my motivation to get to it ...
> 
> Sorry about that.
> 
> I really do want to help out, earlier you mentioned patchwork problems.
> 
> If you can point me at the wreckage, I'll take a look.

I need to add you as reviewer there. Mostly needs triaging which of the
open patches are still relevant.

I think you could ping kernel.org helpdesk.

- Moritz
