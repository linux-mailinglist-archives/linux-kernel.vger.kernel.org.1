Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B15F2778E7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 21:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgIXTCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 15:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbgIXTCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 15:02:53 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278B6C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 12:02:53 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gr14so292705ejb.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 12:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zwh0H2Di2EjtS2oxRbwDl/g8AzPPtz4bTYVlHB6Q43U=;
        b=PSB3PcPl255zINexLzD5htRXOK8A7IpaIdKXFGiLO32U75F2k9xaAm8mZS7ely1gPq
         yZLW+0hCIn45DdWUyYO8G9jfS8J6+rlp2nsVNrm8+l/5IaMYV707qmr5UQ0dfW8t8mFM
         TGM/ejnQq6OR4f+ghs/rkS7hDoJYuUJW4L657stRoYQr04STf5dpZEl4CMwmFaDzfbER
         EPIt5iCUQqcQiTMaJpgnlFWhAOySGAsfIYSWvKD+cpfQaaZ8pNFsj3lLaMbMZTcQHkyw
         RvAYj9nOfidFYdho2D68Le7t2VZhia2mhnOBKQiCeSv5uNiyhRaV9CGBi+SEG1SSy/ah
         LHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zwh0H2Di2EjtS2oxRbwDl/g8AzPPtz4bTYVlHB6Q43U=;
        b=nqv2gWmHBK5F3SguTX2cHXiYYi3owGeIRetjoGDMn2wk7dPr8LLwgAUPMK3VmDDct/
         xLX/sghf0UaYsPmL5NU/3UxX/ak/NW5c8Rii9TUdv+dG1MiG5vkxSmwXP0Xxq3i5T7No
         7jvjjNdJIHsQiQKc30/8JoTW7yJwTpSp6wHZ9RSOFOG9dFGUQAc4CtU2A8Fm39mNgZG/
         GsUUFNPu23wLCIzem++wXklWhjXGeWx75gPjXYFL4j65iUEbv6PJCITi+ZK52wmRLS0Q
         QOnKKSp1+a7PJ5FjLUSVRHYe6HjVu6D52e04JtSZbZpYw+uC8l/CyglNWGbIoyFiPUJx
         cmxw==
X-Gm-Message-State: AOAM533QKjIwc3Sw0iPPJrJT8WuNvRf1vN6jKAJE2l57qLtEYMb6vvfH
        G4sFfHjnXFgzt5dMQc6vHLsAwTrL5KCjvrZ4v7IMVA==
X-Google-Smtp-Source: ABdhPJyIjxPAbvw6mQwJDfqAdCr+NXbyHb0p0fA9nsaaQoL9Tj0/ldsUQQNqjWQJKZxocvoYQ0aBvveDA8qxbuKZJtY=
X-Received: by 2002:a17:907:4035:: with SMTP id nk5mr79283ejb.418.1600974171842;
 Thu, 24 Sep 2020 12:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200901083326.21264-1-roger.pau@citrix.com> <20200901083326.21264-3-roger.pau@citrix.com>
In-Reply-To: <20200901083326.21264-3-roger.pau@citrix.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 24 Sep 2020 12:02:40 -0700
Message-ID: <CAPcyv4isGqsNXqz7tmVbu3UZMNSpZUphCKUkyBMgWYwv5o6OLw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] memremap: rename MEMORY_DEVICE_DEVDAX to MEMORY_DEVICE_GENERIC
To:     Roger Pau Monne <roger.pau@citrix.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Juergen Gross <jgross@suse.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 1:33 AM Roger Pau Monne <roger.pau@citrix.com> wrote:
>
> This is in preparation for the logic behind MEMORY_DEVICE_DEVDAX also
> being used by non DAX devices.
>

FWIW I would not call this MEMORY_DEVICE_GENERIC. This is really
MEMORY_DEVICE_SIMPLE and the kernel-doc can clarify in contrast to the
other MEMORY_DEVICE types this type implies no need for driver or
filesystem notification when a page goes idle.
