Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8ED82966E8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 00:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372627AbgJVWEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 18:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372620AbgJVWES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 18:04:18 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C307C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 15:04:16 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t14so1881566pgg.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 15:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dUyWZKQk6Jd509JR1HWnGlhG34ZF3RzE+ItR8/csEOI=;
        b=af2WcgEUhMVdVEHg2sk74MHZXBT5DxoLwOBS00xAz5EohLXoViwwSmaU24AWRLzOZ6
         zYMUuBSqeYJ/qwD4xXLIAGGh58KA7lRlWvv/+eYhcdQ+erGUd2LKD0srl8w55Y7XV0F4
         j+qGHjaPGeR6vtPbmiQllPHVBLr0CpNir9LOJGXQK3w0qJsIYHFCJoDC3ws7MrB/IQ+G
         1IYlCLL0TFT2TvDhogL7kls8VQDccjVT+uV0djRG3tplfsjuK4UQYIre67O2aN5RgTJC
         YtjdV6iMnesCyRXjZ+RVKmg95xHsNCS2fZMH6eaO/S05rWYT61QMtwSjaqAQDS9YMtI9
         50TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dUyWZKQk6Jd509JR1HWnGlhG34ZF3RzE+ItR8/csEOI=;
        b=W6ENharOP1bgsd1l2gO11qUajytN7qI15z/qY7NPvF89kTrOVRCIN+QpvWZPXbffue
         uADF3/Z4ZkH/07Tos/SOUR4rjn4ZyEo7N865ainWbgqJz2P/RlV/aQ5NslQPg01p96KY
         aqNXRZdFCDe+XgUkvfTcM06nFtD7qfPyaEtk8i1N/OF5qjR9gMI4Q6T/X/XgG3TSwyvG
         s9X9IyF9UfbVVzOsIGcZL3VAiVIaQ+qgk9eLXFn8P2plEV+Gxhy+Itv6J6peIg12ng9f
         EDhc+RUUbJtNt2E/l9t+Z7U6NQKt6LaXp4wxrrHFk/4wXI47CtC2ddCQ2Da2RBnIaffT
         1wow==
X-Gm-Message-State: AOAM532ZYjwtLnJou0yOfNhJKjZ5vEdWeDGjyHfG89+oU/qUYjne1M2w
        e7UUiqPsYyg30GTTJ1/sO6vrvA==
X-Google-Smtp-Source: ABdhPJwcEQ3YeUH8ovZald8QJXaj4Ky438QGFKsn+C8K/zktkNFvlI8EP4KTVhCTcviIo4d9WpYQ7g==
X-Received: by 2002:a63:4c6:: with SMTP id 189mr3900717pge.233.1603404256042;
        Thu, 22 Oct 2020 15:04:16 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::4:f799])
        by smtp.gmail.com with ESMTPSA id y10sm3329203pff.119.2020.10.22.15.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 15:04:14 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:04:12 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH blktests v3 00/11] NVMe Target Passthru Block Tests
Message-ID: <20201022220412.GB1006674@relinquished.localdomain>
References: <20201008164024.12546-1-logang@deltatee.com>
 <29f3dc94-50c3-1548-034e-09c5394ef781@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29f3dc94-50c3-1548-034e-09c5394ef781@deltatee.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 12:45:25PM -0600, Logan Gunthorpe wrote:
> 
> On 2020-10-08 10:40 a.m., Logan Gunthorpe wrote:
> > Hi,
> > 
> > This series adds blktests for the nvmet passthru feature that was merged
> > for 5.9. It's been reconciled with Sagi's blktest series that Omar
> > recently merged.
> 
> Bump. This has been around for a while now. Omar, can you please
> consider picking this up?

There were a couple of shellcheck errors:

tests/nvme/rc:77:8: warning: Declare and assign separately to avoid masking return values. [SC2155]
tests/nvme/rc:278:7: note: Useless echo? Instead of 'echo $(cmd)', just use 'cmd'. [SC2005]

I fixed those up and applied, thanks.
