Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B3A281155
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 13:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387578AbgJBLjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 07:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgJBLjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 07:39:47 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62574C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 04:39:47 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id j10so559424qvk.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 04:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q4iK1I/SnNAoc+7Y+E8xiOO2Lt6oZM4orbJzQinvTvs=;
        b=kQh4ocMexmYDSbQ5KWrwdjVrKH3hcwpgq8aAUpOrtz7LIAcY6z1nGDvzWxWXPyDX8G
         FNL8V9YmTeOLHsW4KqHlaFqTBorTQEIVM5rjcvrCBxtpU/WqYFPDhZ17jkYT4056IZkC
         Ow8D8qF/wZkTtz3xkSXJxrmh3YgIZE/gwpsn8heaiVL0SjoZm3P7J1XGBzqD9qW5kfgL
         XD7c1Ua9PBS/kzHnTlh3D2Aqkjp603UN1PRCkxf0IrLUx5Z7KyIWTBh4xOmBKVV54cs+
         XjXd6QOgu4CqIJNgMTnIvYNtyZX0IL4DHocziXzl9kwGI44vH9rajDP3SRFIOaaAag+V
         r5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q4iK1I/SnNAoc+7Y+E8xiOO2Lt6oZM4orbJzQinvTvs=;
        b=GCwueyVXmlAOUbS2X0YgeO9lWi21Id2IS+c9I2+Wz1rlP8xM7xZXVq+y6Deguuw1i+
         UTioQZkpff5OtsVpemQ7/PZvH9/F1SjHwN6vshXAcH23daj/2RxMlPPK580EzZNHxA1K
         jrX2bEltV6FdchbYjdNktpawouxVzZqwMpEIqTH8vtxl9BydddWWxsyIrPTOUNBh6Ag3
         CcJrN1zvMBy5kUpvlh9OxxwRQoJXXM0p6vGZayUB0ugHeknIGQ+pCu3lw7GCourL4P6i
         2iouyKSP+sDQhpu7ghTWW4wLfkrpD4wm4gakdpHFRmj4CpUlwO8FnxatoBqW/TLHss7d
         vVhg==
X-Gm-Message-State: AOAM5334kiMaKhPOciL9o9NG2Wdanrx6tT7+DnUrqIBWIIPbcsyJpx96
        hmyiaobsQESUfBuCYNo3nFQJ0A==
X-Google-Smtp-Source: ABdhPJyj4/OCeK99T3cxyXoCe9rfZhXRSkt6RP3645TYyjAREoTemtw4nsP/mTiWY/lLuXpZi11ULA==
X-Received: by 2002:a0c:dd81:: with SMTP id v1mr1742177qvk.62.1601638786662;
        Fri, 02 Oct 2020 04:39:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id h40sm827396qte.59.2020.10.02.04.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 04:39:45 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kOJPd-005Yy6-0U; Fri, 02 Oct 2020 08:39:45 -0300
Date:   Fri, 2 Oct 2020 08:39:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michel Lespinasse <walken@google.com>
Cc:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 1/2] mmap locking API: Order lock of nascent mm outside
 lock of live mm
Message-ID: <20201002113944.GH9916@ziepe.ca>
References: <CAG48ez1+ok5c5PK4DjA6-rYkg9qPeKoRrJmc5jsGf=TZZbShJg@mail.gmail.com>
 <CAG48ez1kMuPUW8VKp=9=KDLVisa-zuqp+DbYjc=A-kGUi_ik3A@mail.gmail.com>
 <CANN689H9hXzaV0_vpFfrvjQD6xAEaPnjok_17zWGHumRNs-ZWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANN689H9hXzaV0_vpFfrvjQD6xAEaPnjok_17zWGHumRNs-ZWg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 02:17:49AM -0700, Michel Lespinasse wrote:
> Also FYI I was going to play with these patches a bit to help answer
> these questions on my own, but wasn't able to easily apply them as
> they came lightly mangled (whitespace issues) when I saved them.

Me too

It seems OK, you've created sort of a SINGLE_DEPTH_NESTING but in
reverse - instead of marking the child of the nest it marks the
parent.

It would be nice to add a note in the commit message where the nesting
happens on this path.

Thanks,
Jason
