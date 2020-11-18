Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58012B8485
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 20:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgKRTRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 14:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgKRTRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:17:12 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AFBC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 11:17:11 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id k27so4314838ejs.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 11:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=81PlRLP0p2YmMe4H5uWqNhtURGW1y1XdOZLIO5F9YLc=;
        b=IEmV9qoEH+VLpoYyNzawjBU3gJvxj8OcypC3VnxKE5lxNmuD+wiOJCRCW+/QUlkc14
         +In7+KyScQJ2+u99Bg5waJ/8B9TXdZB1YBsHDuWTYKobjPNVfmVgxLs/ix+1YdkaF7RZ
         8J5RjPK7huvShsX6yV+DYRlaioR55ExxT1IjTvdGSv9HTEzDg0WikN6WBtCO3IYfk+PE
         spu678zJdUE5jBpeN1VpR6a9niGLPcQnW7jO86kg/DITRrbRRdNQczR478OTtDF3850l
         thoFHoHCoSUtduio/nxfyPLyxJ+cVBG/NA2QMrsvIMIb3/rmDPC56fsQVUKcRxW5RZh1
         reXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81PlRLP0p2YmMe4H5uWqNhtURGW1y1XdOZLIO5F9YLc=;
        b=eqJkGpOhNree1xx6ED5k0im45a8ttVHx+2yCFUZa5soVM3ALdW7x7c+gfUMR+h7cw3
         wYhLoGuzYy2LdJ4PrOYwskSzRBgRSctqHmOyFCVrdwHndBw39iWNFaqgX4361cXzvVE5
         NJ5S3cQOdcpFj9K+i1u4QV1t9MixKSr3OjHb/QNCzEBMpdCslzxxgDXOQgZnbxLA5MTE
         kEvLxBiai9eTq19X1IcQ0ReMhCzfHWA8ZIVclBXAfsIVH4DUfmA1TgAoVI5QZSnG8Ilv
         GlzQavXNCd+QSSxCMET8X4VcmWUcY2PAP1cxlBYnY4CinBfBP3+lPE+lYpmeANL7bjVV
         Mopw==
X-Gm-Message-State: AOAM531OqUa6TgEtRmoG4DVj5lc7I+bJpilNMOQZNrEq6cF/EKcyw2io
        ZyC09OZNjkBegDU0xQP5ER1aEXG503hSewgIE6R4Qw==
X-Google-Smtp-Source: ABdhPJwvNVfgBGELqNuL/n59F+v052BHnvvJO98npzqht+NZtcKSmy214B4JUAm0W8adcIQwvB6JKQnKtNN/1ytPB/0=
X-Received: by 2002:a17:906:914d:: with SMTP id y13mr13924322ejw.45.1605727030657;
 Wed, 18 Nov 2020 11:17:10 -0800 (PST)
MIME-Version: 1.0
References: <20201118084117.1937-1-thunder.leizhen@huawei.com> <9b8310ed-e93f-e708-eefa-520701e6d044@huawei.com>
In-Reply-To: <9b8310ed-e93f-e708-eefa-520701e6d044@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 18 Nov 2020 11:16:59 -0800
Message-ID: <CAPcyv4hc0bw=+HQ-Zj0AWfB2-xMEEC--64zNxBkyapkiQRVVdg@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI/nfit: correct the badrange to be reported in nfit_handle_mce()
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 12:55 AM Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
>
>
>
> On 2020/11/18 16:41, Zhen Lei wrote:
> > The badrange to be reported should always cover mce->addr.
> Maybe I should change this description to:
> Make sure the badrange to be reported can always cover mce->addr.

Yes, I like that better. Can you also say a bit more about how you
found this bug? As far as I can see this looks like -stable material.
