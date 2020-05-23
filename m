Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6E51DF42F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 May 2020 04:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387526AbgEWCbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 22:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387427AbgEWCbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 22:31:13 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7693EC061A0E;
        Fri, 22 May 2020 19:31:12 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w19so5128836ply.11;
        Fri, 22 May 2020 19:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YT/k1rfVjIePeTXXkpUPtF/OwHqLeXNiGhtIiGZ/dQo=;
        b=LNiX28rdTFOphtwhil5rORMlilHK/PI2wau7P7a6KmMQs0Sbu1Dvk8RGq9G1ewl+c5
         dBwAZOU3shEOXwiW3+KJT/3mGUGJcVp0NXqZ+5Wj85F0ZSZjopqbDCdmdScpze5Z9FE1
         gCBFL41HDHerefHUT6ijsdwGhrPqsYBZ2lzNdVRFu9I8t91RnMRyE0Va/ypawF4OLsIs
         vwTCoJExzUPEFjzJDn4xoi/RTtVb9hUT7FbsoDyWS0K3/nL2FAoZLGogzOLxfMdxYDY3
         2GdFIUon8Quts0ttXuR+LxNAbge9RXMAnRLoXoC3A8/CRIKcMVbDrubkpuy/vU+5JTD6
         S0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=YT/k1rfVjIePeTXXkpUPtF/OwHqLeXNiGhtIiGZ/dQo=;
        b=CMGB/C0arU+EMe5+0ZJQyhdHYcj1LBB544busgmapgcnaISHTih2DUa+PfjYiiMLJi
         LakZ68Eq8Wszzpq+cCtei/CMAfKXvVPKYxYIz7bEa3I1Cy0tlGjSFNB2ME+IXlTuJiHe
         i0w84e3JIiR5iXmycddJXd1OTPqGzf4BGBFgOR5f7XBfGWd8OTDFZPpqSfibyDONriw+
         0YMxhHbL5dwNAo06aqpQ6nem5hZuyGR/SP2REH9y0CbxAQosZw1l8rFEeQ3L5q+7XCuM
         A/ItGMH6K8vc/6g8g8W+UJIbBly+UByv/objAYs5IDfw+tLM+51GkULAdtmc5bKFZqfj
         kpLA==
X-Gm-Message-State: AOAM533abBv0x7MJQuH3e25XCVjfa1wi5hQ3PdLA6dLQl4PwoQwVKs2f
        50M7ToPOkkT8TyZQZkDk1/4=
X-Google-Smtp-Source: ABdhPJy+ggU6E08aod2PoTLkPztWYi27NlUh+WoJh3UjcTQtYRk/aCJOGPLhLckcoyhA25USa4eUnw==
X-Received: by 2002:a17:902:b088:: with SMTP id p8mr18347355plr.123.1590201071731;
        Fri, 22 May 2020 19:31:11 -0700 (PDT)
Received: from udknight.localhost ([59.57.156.148])
        by smtp.gmail.com with ESMTPSA id u1sm7038448pgf.28.2020.05.22.19.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 May 2020 19:31:11 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id 04N2V0wm008878;
        Sat, 23 May 2020 10:31:00 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id 04N2Uqhj008875;
        Sat, 23 May 2020 10:30:52 +0800
Date:   Sat, 23 May 2020 10:30:52 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>, Markus.Elfring@web.de,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v6] checkpatch: add support to check 'Fixes:' tag format
Message-ID: <20200523023052.GA6969@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>, Markus.Elfring@web.de,
        kernel-janitors@vger.kernel.org
References: <20200504082002.GA29972@udknight>
 <aaa0a1f9619130293a8d8810fa8de140d5612e45.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaa0a1f9619130293a8d8810fa8de140d5612e45.camel@perches.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 11:34:31AM -0700, Joe Perches wrote:
> On Mon, 2020-05-04 at 16:20 +0800, Wang YanQing wrote:
> > According to submitting-patches.rst, 'Fixes:' tag has a little
> > stricter condition about the one line summary than normal git
> > commit description:
> > “...
> > Do not split the tag across multiple lines, tags are exempt from
> > the "wrap at 75 columns" rule in order to simplify parsing scripts
> > ...”
> > 
> > And there is no sanity check for 'Fixes:' tag format in checkpatch
> > the same as GIT_COMMIT_ID for git commit description, so let's expand
> > the GIT_COMMIT_ID to add 'Fixes:' tag format check support.
> > 
> > The check supports below formats:
> > Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
> > Fixes: 85f7cd3a2aad ("Revert "media: Kconfig: better support hybrid TV devices"")
> > Fixes: 878520ac45f9 ("ext4: save the error code which triggered...")
> > Fixes: 878520ac45f9 ("ext4: save the error code which triggered")
> > Fixes: 277f27e2f277 ("SUNRPC/cache: Allow garbage collection ... ")
> > 
> > The check doesn't support below formats and it will emit diagnostics info for them:
> > Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface"
> > Fixes: 6c73698904aa pinctrl: qcom: Introduce readl/writel accessors
> > Fixes: 3fd6e7d9a146 (ASoC: tas571x: New driver for TI TAS571x power amplifiers)
> > Fixes: 55697cbb44e4 ("arm64: dts: renesas: r8a779{65,80,90}: Add IPMMU devices nodes)
> > Fixes: ba35f8588f47 (“ipvlan: Defer multicast / broadcast processing to a work-queue”)
> > Fixes: cd758a9b57ee "KVM: PPC: Book3S HV: Use __gfn_to_pfn_memslot in HPT page fault handler"
> > Fixes:      9b1640686470 ("scsi: lpfc: Fix use-after-free mailbox cmd completion")
> > Fixes: 03f6fc6de919 ('ASoC: rt5682: Add the soundwire support')
> > Fixes: 03404e8ae652("IB/mlx5: Add support to dropless RQ")
> > 
> > Because after GIT_COMMIT_ID supports 'Fixes:' tag format check, it could do
> > the same check as the UNKNOWN_COMMIT_ID, so we don't need UNKNOWN_COMMIT_ID
> > anymore and I decide to delete it.
> > 
> > Note: this patch also fixes double quotation mark issue for normal git
> >       commit description, and now it supports double quotation mark in
> >       title line, for example:
> >       Commit e33e2241e272 ("Revert "cfg80211: Use 5MHz bandwidth by default
> >       when checking usable channels"")
> > 
> > Note: this patch also adds diagnostics info support for normal git commit
> >       description format check.
> 
> Thanks YanQing.
> 
> All of this seems fine, but perhaps checkpatch's output message content
> could be a bit shorter.  I'll give it a think for a while.
> 

Hi! Joe

What are the status of these patches?
"[PATCH v2] checkpatch: fix can't check for too long invalid commit id"
"[PATCH v6] checkpatch: add support to check 'Fixes:' tag format"
"[PATCH v2] checkpatch: allow commit description spans across three lines"

This is a ping message, maybe you have forgot them?

Thanks.


