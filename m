Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AFE29F941
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 00:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgJ2Xtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 19:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2Xtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 19:49:41 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA64C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 16:49:41 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x1so4855074eds.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 16:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYbBo34otKohd0s7kTm1XugNJiCX5mPJkPuJ3gJnJIM=;
        b=rvks6cEna40F2UhnrFGRWKupODeV/ihrOcGqTOFYnt7HHXV95LQD+TigT1UNqohSHj
         8ONmFiGA6W7PLWvhl4PRM1lwNjWlIxkVyQ9h6AnIlPQ3RHP1j5T0RDZ5KL0jvawxnCxw
         A95d5LVttZeRDzZzlqmwmX1T1BwSneOedsT7+JoU7QpX3F+Z1Ku83e1lk4O2pHezjUvg
         oTLdm82in+NwI3wgrjaUJIeUHDPHS936uxYyTmYbcLvPFJJSk8pw3yDNQOXwdU4AmJS1
         rLdHOQSF3NMTHeNzc11d0zdaKi+RCGAu94Zn/i0yRK9gXuWDYZ3d76iUZvlnRHZfCHFU
         RnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYbBo34otKohd0s7kTm1XugNJiCX5mPJkPuJ3gJnJIM=;
        b=ZRHdOgwQXLoiDAjjj4pb9Z/Vnjcy0E0FaAzYVqH/B2RPVYnFkaYo4WfXPzuZV/1gNh
         p7u+j7JUTICab5ae5EsugmExbLxeV/4gg/nJs/20oUCJD2HO9BRfwwPFMQ/4bJavz4k/
         t9dXILuZ8+saDF7rb+VcDS1xs/BYdmi9nQlFy68WU2jvaAA6gPOE9mxDOrk5h7fol8ay
         +PnSEQ1CSsXQ8jXGUdb1xT2M3mSqbUi/GsvQ0kmYHVFLRZ/PC8N6LH/FVwPcQBeCdPsC
         wyT4KZ9em6o67bWpX4oi/yvO+56Nm5Jk5ePOUnwNnfsOuwPa35fHYi9P0+gELYyvMzmU
         XQUA==
X-Gm-Message-State: AOAM531G0kVdhsBIcEsJXf/fVZhNuldoa2Kkb1Iza6ZP6BZ0Z9x92fWq
        w5FBxh3eirlEzJX3UNby9FB2P2lZDS+Td/gcQ5t/ew==
X-Google-Smtp-Source: ABdhPJy7mdATEbwlejokklHReFhi0lUGuX9LnD3I5X1m+d1wj3h3Saea3LsTHoX+TA722sj5Kz2+SOM2mb8RVPSIsF4=
X-Received: by 2002:a05:6402:1201:: with SMTP id c1mr6805498edw.210.1604015378972;
 Thu, 29 Oct 2020 16:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <87sg9wodp1.fsf@nanos.tec.linutronix.de> <CAPcyv4hBSwdDocpgFh2=qbVQN=Mc+15cW4cV5m_S-SxVCYY=mA@mail.gmail.com>
 <20201029230920.GA32559@intel.com> <d066788b-0f69-37e5-fd5c-12755f498677@infradead.org>
 <8613f74e-b774-a544-60df-b8012cc4ee14@infradead.org>
In-Reply-To: <8613f74e-b774-a544-60df-b8012cc4ee14@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 29 Oct 2020 16:49:23 -0700
Message-ID: <CAPcyv4g1XNrpTHmEAuXetg4uU=E4fRZ7MwqdfbUBJwkCEP+Vqw@mail.gmail.com>
Subject: Re: [Build fail] i386 & nvdimm is unhappy
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Philip Li <philip.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 4:29 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 10/29/20 4:13 PM, Randy Dunlap wrote:
> > On 10/29/20 4:09 PM, Philip Li wrote:
> >> On Thu, Oct 29, 2020 at 03:52:42PM -0700, Dan Williams wrote:
> >>> On Thu, Oct 29, 2020 at 3:44 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >>>>
> >>>> Dan,
> >>>>
> >>>> x86 32bit build fails with the config below with this:
> >>>>
> >>>>   ERROR: modpost: "phys_to_target_node" [drivers/nvdimm/nd_e820.ko]
> >>>>   undefined!
> >>>
> >>> Acknowledged, I'm on it.
> >>>
> >>> Wonder how 0-day missed this or I missed the 0-day report?
> >> Sorry about this Dan. Can you share some info like which kconfig and bad commit?
> >> We will investigate this to provide update in earliest time.
> >>
> >> Thanks
> >>
> >>>
> >
> > I posted earlier today about the same failure on x86_64 & linux-next:
> >
> > https://lore.kernel.org/linux-next/0faac4da-a7bc-3fc7-e278-ad4f72499224@infradead.org/T/#u
> >
> >
> > Thomas and I both included kernel config files.
> >
>
> Here is a patch that Dan was cc-ed on.
>
> https://lore.kernel.org/linux-mm/aaae71a7-4846-f5cc-5acf-cf05fdb1f2dc@oracle.com/

Thanks for that archaeology Randy. That was when I was out on leave
and I apologize for missing it. I'll get that merged up.
