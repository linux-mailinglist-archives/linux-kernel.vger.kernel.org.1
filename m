Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFA22DDD30
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 04:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbgLRDK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 22:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgLRDK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 22:10:58 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2475C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 19:10:17 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i24so844242edj.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 19:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AkEXl4qStkmYT3+mIwl6Q3Q3mHzuVuFn+pGe0fZurTg=;
        b=kAtNLYT7czydmG2yKG2/GUQcgugCOuv67CY2PquMXr8/J2nJRiSHtbHBCN23JLDI+W
         SxB7GDNx7G5LUQ4RD6svX1zxWbWadfPb8xIxF8pqZikVdVZUTCWgM+Ok3Pxy10Yh1XYD
         aOMAdCKu+mLPU4evb1gnQg7k3T71nSdVIJRlJsXUzcE4q3reyT4SY7fJsL/O7S5T33cO
         uwmlZwTYjrc2LqBdepjUfliTLXsdroHSu945lTcG16Q7hJPTbKkQVtAMu6n0B30PEf7Q
         lfn9yNx0K7yK/sVUcL6M5GlkxMo65NLuzYpBVOr7SnZqlTJF+aAVh9zf+ZZ8WrhwmDcw
         PYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AkEXl4qStkmYT3+mIwl6Q3Q3mHzuVuFn+pGe0fZurTg=;
        b=W5cqluodw5BJWWa0f2SO90LhPgsFJpBeuBvyWjpTxCkCzGKi5vixnx5FZvyRjg+/Eh
         gp/esrH8TeVpsR2F1TPeDB3GuBNXeR1kNJPVJWHYjnii3pb+DyzJCxSs49INuXWqD9os
         U+owI/m9YIxNqr/0AeJdN8xoBCpn83PwarN5qTZ6exYWqEycgzvY5s+JDBnyJpl6VMmV
         7CzpogxpiSdiiHeKMqSAkMDH7bEyYsYjsqSFocWP8ImCRIucmJf7FK++D9rwQTFcNrzS
         jQRzBlTrqMH2TBdPlGmlbLHzz2xSkWF/UDbJ6sOCDMMWAUy92zd7lvZBd5h6hKNuaOa4
         wXxA==
X-Gm-Message-State: AOAM530rerlqrI/l0Oih35bps6wbQKEpStRUsFu/nQnxLaOaU6tYYNTu
        C23U+FJtK88lvNXnB4OSU9uxZ8YWsn1NsuuJXEoCfg==
X-Google-Smtp-Source: ABdhPJznkBnJXzOf7SdEY10Kh5oWG5k2t9apJPLinrpGixUO6+G+9aI+DGvwJptB+N0HUNXjeW+Tm8kH7KEVnFqM5k8=
X-Received: by 2002:a50:e0ce:: with SMTP id j14mr2471193edl.18.1608261014688;
 Thu, 17 Dec 2020 19:10:14 -0800 (PST)
MIME-Version: 1.0
References: <20201120092251.2197-1-thunder.leizhen@huawei.com>
In-Reply-To: <20201120092251.2197-1-thunder.leizhen@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 17 Dec 2020 19:10:04 -0800
Message-ID: <CAPcyv4jxgbawSbYF39g857fiDCRmMACr1u-OiSWkz4M0+2UPbQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] device-dax: avoid an unnecessary check in alloc_dev_dax_range()
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jane Chu <jane.chu@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 1:23 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> Swap the calling sequence of krealloc() and __request_region(), call the
> latter first. In this way, the value of dev_dax->nr_range does not need to
> be considered when __request_region() failed.

This looks ok, but I think I want to see another cleanup go in first
before this to add a helper for trimming the last range off the set of
ranges:

static void dev_dax_trim_range(struct dev_dax *dev_dax)
{
        int i = dev_dax->nr_range - 1;
        struct range *range = &dev_dax->ranges[i].range;
        struct dax_region *dax_region = dev_dax->region;

        dev_dbg(dev, "delete range[%d]: %#llx:%#llx\n", i,
                (unsigned long long)range->start,
                (unsigned long long)range->end);

        __release_region(&dax_region->res, range->start, range_len(range));
        if (--dev_dax->nr_range == 0) {
                kfree(dev_dax->ranges);
                dev_dax->ranges = NULL;
        }
}

Care to do a lead in patch with that cleanup, then do this one?

I think that might also cleanup a memory leak report from Jane in
addition to not needing the "goto" as well.

http://lore.kernel.org/r/c8a8a260-34c6-dbfc-1f19-25c23d01cb45@oracle.com
