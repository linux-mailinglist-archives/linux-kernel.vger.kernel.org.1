Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0DB2702AC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgIRQzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIRQzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:55:05 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E10BC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 09:55:04 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n13so6683515edo.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 09:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yxwRMmZAvscI9qLISrOKxKWDWXBsK0Qiq++otHhpMpM=;
        b=vW9xAgzLdO0QTngXP251avBoOv0g0D8jITnPZCJ5/Gugk+FHUHF/kvs6N/4BGb4yRp
         kwWQrpEvWarWlY6oGD1By4fOTSpcnfY6T5RGy1jX3cdIMv/EEDhvGn5NMNtptRwMLdk9
         TeIAV3rz/9S3/Lu+cwsk0KqQ/wvILgP0cetKg5Ci454hEpq8RvIg4WXN774E5PSIoMHa
         DsJC9VcCZV4SAA+etDYxCrS/HmvNAGtSF0KuTLpB/dl9CdoduF6NOwxzGVgG6ZJCJvpV
         bIXTRwy1i/WvQl4YY+EbOK5NGuWUtetdeY9jGfArhxhr2VbmzVU9ho3TRx2nE6NTGkEk
         2xTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yxwRMmZAvscI9qLISrOKxKWDWXBsK0Qiq++otHhpMpM=;
        b=BFDldmeDO6+kM9pg4w4GrcL/6o+OGHoXENrL9rfZcSoO0KUmy4K/TpWUnmISVi2Wug
         1ZecypM8C6cOjPlpqjjK/jeffd+QKkXiyp4MX0wtb71HEoJMvCC2bJs7Nt7WLGjBCV8a
         xatDDKcSxk6iYKDgTMAcFOnHrNKGUlyN56+GjtGPkFVdrjR9Uf2eT/FaMHSAj5J/c5sJ
         wncmI98kdgM5b2H/eSJzhHVsF9XpWC8jEp/hi2Ap4fkZ/OMLkG5cxVzYyuAAps/HmEGO
         zZvmfJH9kdYQDArBAXwlkRASkmna+keR+k2p6h/sm6aHmP1Dupq9VZsU4H4lOZyxCvft
         eeyA==
X-Gm-Message-State: AOAM530Ev6cZocUFCHcn2J1u7TJwVNkbsBo9K+JOEyRsAt3w7cgb1Tip
        M7BMiwHoJGuJjKsSS2xWvR4GJ/jh9w8bauI/JO+rUw==
X-Google-Smtp-Source: ABdhPJxcLHTp2HmWlgI7Su041TxmNFgVD/jngcdBcxMjvp5IOfJeNJy8OR2y4k4Bfa6ELWveIGOQjFysEqiHQiktakY=
X-Received: by 2002:aa7:c511:: with SMTP id o17mr40445469edq.300.1600448103080;
 Fri, 18 Sep 2020 09:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <160040692945.25320.13233625491405115889.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200918153041.GN7954@magnolia>
In-Reply-To: <20200918153041.GN7954@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Sep 2020 09:54:51 -0700
Message-ID: <CAPcyv4ii+NWnJhLWwz=Z+2aAJ=DdjwQoqPC+hO88CsM2ub5FEw@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH v2] dm: Call proper helper to determine dax support
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>, Jan Kara <jack@suse.cz>,
        Mike Snitzer <snitzer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Adrian Huang <ahuang12@lenovo.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 8:31 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Thu, Sep 17, 2020 at 10:30:03PM -0700, Dan Williams wrote:
> > From: Jan Kara <jack@suse.cz>
> >
> > DM was calling generic_fsdax_supported() to determine whether a device
> > referenced in the DM table supports DAX. However this is a helper for "leaf" device drivers so that
> > they don't have to duplicate common generic checks. High level code
> > should call dax_supported() helper which that calls into appropriate
> > helper for the particular device. This problem manifested itself as
> > kernel messages:
> >
> > dm-3: error: dax access failed (-95)
> >
> > when lvm2-testsuite run in cases where a DM device was stacked on top of
> > another DM device.
>
> Is there somewhere where it is documented which of:
>
> bdev_dax_supported, generic_fsdax_supported, and dax_supported
>
> one is supposed to use for a given circumstance?

generic_fsdax_supported should be private to device drivers populating
their dax_operations. I think it deserves a rename at this point.
dax_supported() knows how to route through multiple layers of stacked
block-devices to ask the "is dax supported" question at each level.

> I guess the last two can test a given range w/ blocksize; the first one
> only does blocksize; and the middle one also checks with whatever fs
> might be mounted? <shrug>
>
> (I ask because it took me a while to figure out how to revert correctly
> the brokenness in rc3-5 that broke my nightly dax fstesting.)

Again, apologies for that.
