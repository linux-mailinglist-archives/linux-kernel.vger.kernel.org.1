Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7782FCADA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 06:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbhATFuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 00:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbhATFtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 00:49:42 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9205BC061575
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 21:49:01 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a10so15220306ejg.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 21:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sg+eQWX5XmG9UPozm9aMIM4vRUAvpfwp/DxyqeQH+kM=;
        b=OiI0fbiI56Dj8fIBLthH32GIJ3u7qZMzkqtuEfwJfMCjukrgQil63Qm7UqGaBUkwia
         MCYmQYyLT3cE0hCAe9Gx6e8Gsb/H5VyK0tep68wl/HtRlH5hudx4VQEERZcMWbk7OY0+
         51mZJRszvEqsavZbPxncvlJMPVVpeBb+hMGhLO6ru0JRVFSYOt3gySV3q7LirwVTl6cQ
         2HaCzjikz3yhw7SnwdsasLoh6ggiSAYuR1yez13Xst8PSSa4UpDHpPmd1MyAxhv5Cp8R
         q3oVBFRb4yQqSmImL3Z5xnWitWbcfoEbKeAkmJm9l4H0pW9E0I6nVGI3sm5l0y55vXCb
         dTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sg+eQWX5XmG9UPozm9aMIM4vRUAvpfwp/DxyqeQH+kM=;
        b=Ak0jvq6FEU9Vx94iKrmcpYftCYKAo0p6jzc+xkcRIPWNmQBwng9n924e/NRZceN2tJ
         viQAyQXP2HePF52hs0Dm7xsBO/Qw7Ra6dA4QG9Y+iCcMoDUkFGpD4NOnnRn8+44ZPdKx
         VMJFMzXriS/UDU6XbRau3N5cvmVGq6R1otSFVhT627GSGW8zYbi/Wd699ynodJwql8TN
         wC3Y39bwHC/11GACrsNB+bLM+OX+giNk97M9SCqxzFaRxX2K45iG15rPaDj/7Vb3eSWN
         mx19j+dFzjPNksIaqtBujiPIdYiLgKaB3fMe8mOQdUdGuvNZqnXYn7YoHmePqrrVzpa0
         VXpQ==
X-Gm-Message-State: AOAM533fT+juWYcBCX1DyFcSTuWGFnjsypcQo1iWL42UkEXUUBgb2W+F
        3tzau94HgSokpA3ihqxV3CY0Ma4Ynv69RwPWicEtiwrRZ/ySOQ==
X-Google-Smtp-Source: ABdhPJzTVjE2cR/ZiMdJedsP8fFfGV5dFl3LwNkye6sKcMtpux+YQjEBhqeTGFG+eC5rCmwZMVi729qK7PquOeg7CgA=
X-Received: by 2002:a17:906:f246:: with SMTP id gy6mr4930989ejb.264.1611121740333;
 Tue, 19 Jan 2021 21:49:00 -0800 (PST)
MIME-Version: 1.0
References: <20210120162518.4fdc8f00@canb.auug.org.au>
In-Reply-To: <20210120162518.4fdc8f00@canb.auug.org.au>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Jan 2021 21:48:52 -0800
Message-ID: <CAPcyv4jrrNthnSkj7RVjOMSDGJAoiw7KjniKaid5Jr-86B4Auw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 9:25 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the akpm-current tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>
> mm/memory_hotplug.c: In function 'move_pfn_range_to_zone':
> mm/memory_hotplug.c:772:24: error: 'ZONE_DEVICE' undeclared (first use in this function)
>   772 |  if (zone_idx(zone) == ZONE_DEVICE) {
>       |                        ^~~~~~~~~~~
>
> Caused by commit
>
>   e821cf25cfee ("mm: teach pfn_to_online_page() about ZONE_DEVICE section collisions")
>
> I applied the patch from Randy Dunlap for today.
>
> That, however, lead to this warning:
>
> mm/memory_hotplug.c:730:13: warning: 'section_taint_zone_device' defined but not used [-Wunused-function]
>   730 | static void section_taint_zone_device(unsigned long pfn)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~
>

I sent this one as an alternate:

http://lore.kernel.org/r/161111619868.2787408.1710192276369197040.stgit@dwillia2-desk3.amr.corp.intel.com
