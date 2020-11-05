Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B302A7715
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 06:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbgKEFhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 00:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgKEFhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 00:37:20 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68712C0613D1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 21:37:20 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id o9so836721ejg.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 21:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EfJjL1akExmM7MryZh1gsP+atrfYQFsCn4uSXTzdFys=;
        b=IAL9rcqKhpT6r323u029j5TlagQx0L3D0AAGR1yoYNnvILrTVe9xtX8YXqpJxTL9fO
         +sEz56pVfIzLZxT9ZhROLYQue/XaR0gP4/xX1LhE1RlQOjrhUV/4BTBU1zGRm1FF4c77
         IvH/KFb2Z8JjIEUSMX2TfC7qnISIgV6lNfHYuH4A8EPDYFcJAYpFFaRIrDMzIm4z1U7q
         buy60rFZlSl2X0PjrJMBOGmdsOxNqHsYTMkU/5MdnulLCwiMg/uo3jvoNAZ6Kx8OxgvK
         xIOlgu/g5hH59GfrnucDLCcPZvFraHDHYUYhLiDE7gtZ5/dHIPTdi8H7tlHhHF7ldmUd
         OmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EfJjL1akExmM7MryZh1gsP+atrfYQFsCn4uSXTzdFys=;
        b=GJpAO2b31vMGiyFtmuVaJ87VMC+r5VMuDjvZLTFFmxaVOOozBLM/ggPC2k/B3awlsi
         OPt+nkqm1B09Ztb9wYPvd9QjWWfM7q3mLAVeYcFrU/GNmsXrWjiBXIL2awFpfj3WDAPi
         ZSR65KtcmybS0MK3a8UVQ0yFO0lrw1Ye6MriErMfV8PvAWJtpE+uZezQko6jJlPBo7Ue
         fxVUPisuzN95iIUt4V3vZCzCMl+83AgCjuNCnyCO5dAVF+KKB9xIne4wA920IfiuDYa+
         JCVFlHvJKBRgLlz4oDRuCsFZMdnJPug7ahbKsaHK5+1cChmg+WGI23TZ0FcpuVF6q/4G
         5JQQ==
X-Gm-Message-State: AOAM532Nyuv8AYAnKyMRVd0KwozA81l+uwt24oxe48Z/KPqYZysxC6XD
        26g4qaarVQyEjcNaudL1KbCUBu14M9QVRsayA9HK0Q==
X-Google-Smtp-Source: ABdhPJznzbYV8sguutlJP+ym2wYmSr3JSs6Lt8G4t20KrAZBP5q9G8BwybKouTwwoVsrNXznzC+Bjxp4MJa1URC+4jk=
X-Received: by 2002:a17:906:280a:: with SMTP id r10mr649101ejc.45.1604554639040;
 Wed, 04 Nov 2020 21:37:19 -0800 (PST)
MIME-Version: 1.0
References: <20201105160453.0c2283b1@canb.auug.org.au>
In-Reply-To: <20201105160453.0c2283b1@canb.auug.org.au>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 4 Nov 2020 21:37:06 -0800
Message-ID: <CAPcyv4jLUp=h+mthXca67DW-OvS10sOtz78ESjMcKF9BOB8uTw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 4, 2020 at 9:05 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the akpm-current tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>
> In file included from include/linux/numa.h:25,
>                  from include/linux/nodemask.h:96,
>                  from include/linux/mount.h:15,
>                  from fs/pnode.c:9:
> arch/powerpc/include/asm/sparsemem.h:17:16: error: unknown type name 'pgprot_t'
>    17 |       int nid, pgprot_t prot);
>       |                ^~~~~~~~
>
> Caused by commit
>
>   45339c019cbc ("mm: fix phys_to_target_node() and memory_add_physaddr_to_nid() exports")
>
> I have reverted that commit for today (maybe I should not have added
> it :-().

Ugh, I'll check my cross-compile coverage.
