Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6C5278685
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 14:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgIYMAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 08:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbgIYMAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 08:00:20 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72491C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 05:00:20 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id t138so2491134qka.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 05:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rIuYtEL8Ho/A+a5HBfrQNagOxrR0aWDpVzG6iTo4eE8=;
        b=erbaTgqjcRvgzvAj3JDGURJKefgiqFgAtYhbtoxeo5AsoLv7f6EB9N3ZzNsEOPSp8v
         6sq/HX7Uxi9akTTh+XFsHzFtUXMqbirMtYYzCCgWVy5GYLkDdYl2JH6K2QIQDYcm4fQH
         WMWugilt5Hjg1+dQEw5amV4Dy3t8QgUTR4ai9V29Z9GA6Dg7YtEvZvM24An3iOOhmJs8
         zzB2oFkbCby/mvR7NPzSowW9Rw8OJg+7xsDCgPYDhC5XSlDCp7GDpjUhmE6nxPeVmdp5
         KWwCU7JsmsVmNzfXNstQisrXorK1WeS15j9w+R6P6UAWzAfGJNYKbLAd6MPAQAPQwc1s
         O6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rIuYtEL8Ho/A+a5HBfrQNagOxrR0aWDpVzG6iTo4eE8=;
        b=raVEQMsKyAgCvfoqWL28PChpcotWVAo+IohUGVBwGgEBtqL/3bqplme8hn8ro9lnAF
         yxFL1yt+WcQYgw+PWn79w+PcOVAsw28BFFghFsgyIO2YUMj3HrPlEwqJHJfle+mvNw5S
         P/6RpSuc3SqQU2Z7sxT/V10gnZQ+5eNpg9bTPqjo09ZLc6o7G00/BzDDORCcQ5j242+q
         0Uqjew1IU9lEvYZMTGU2zMzvaiM/SNkB5Q1E6rxkj5X8LoAqB+P7xfgOQh+KJ/W+/8aH
         NH4GN5mKWHTq6ei47I3c4wLUKhaJZsJE7P1lgUSn/lm1lG6+7E+otVeLAoYJp045lyh6
         aLtQ==
X-Gm-Message-State: AOAM532zRyO/NVYWT1Y+ia3ZotV2glNshMghOQqstGR+PC/7wnf8AJmG
        LRNRRZx3F5ixt4+9y0HR8JMROQ==
X-Google-Smtp-Source: ABdhPJwMSZO4wBP1qq0t6fhMdo1TSXgA0/hT/4ls6tA8iNgqFTTpehyXXULUgKbSvrFWL38LELQ5qw==
X-Received: by 2002:a37:a50b:: with SMTP id o11mr3520279qke.439.1601035219677;
        Fri, 25 Sep 2020 05:00:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id g19sm1521418qka.84.2020.09.25.05.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 05:00:19 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kLmOg-000nSE-8H; Fri, 25 Sep 2020 09:00:18 -0300
Date:   Fri, 25 Sep 2020 09:00:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH] tpm: of: avoid __va() translation for event log address
Message-ID: <20200925120018.GH9916@ziepe.ca>
References: <20200922094128.26245-1-ardb@kernel.org>
 <20200925055626.GC165011@linux.intel.com>
 <CAMj1kXFLWsFz7HV4sHLbwBkuiEu0gT4esSH8umVrvDDrJaOLrQ@mail.gmail.com>
 <20200925102920.GA180915@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925102920.GA180915@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 01:29:20PM +0300, Jarkko Sakkinen wrote:
> On Fri, Sep 25, 2020 at 09:00:56AM +0200, Ard Biesheuvel wrote:
> > On Fri, 25 Sep 2020 at 07:56, Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> > >
> > > On Tue, Sep 22, 2020 at 11:41:28AM +0200, Ard Biesheuvel wrote:
> > > > The TPM event log is provided to the OS by the firmware, by loading
> > > > it into an area in memory and passing the physical address via a node
> > > > in the device tree.
> > > >
> > > > Currently, we use __va() to access the memory via the kernel's linear
> > > > map: however, it is not guaranteed that the linear map covers this
> > > > particular address, as we may be running under HIGHMEM on a 32-bit
> > > > architecture, or running firmware that uses a memory type for the
> > > > event log that is omitted from the linear map (such as EfiReserved).
> > >
> > > Makes perfect sense to the level that I wonder if this should have a
> > > fixes tag and/or needs to be backported to the stable kernels?
> > >
> > 
> > AIUI, the code was written specifically for ppc64, which is a
> > non-highmem, non-EFI architecture. However, when we start reusing this
> > driver for ARM, this issue could pop up.
> > 
> > The code itself has been refactored a couple of times, so I think it
> > will require different versions of the patch for different generations
> > of stable kernels.
> > 
> > So perhaps just add Cc: <stable@vger.kernel.org>, and wait and see how
> > far back it applies cleanly?
> 
> Yeah, I think I'll cc it with some note before the diffstat.
> 
> I'm thinking to cap it to only 5.x kernels (at least first) unless it is
> dead easy to backport below that.

I have this vauge recollection of pointing at this before and being
told that it had to be __va for some PPC reason?

Do check with the PPC people first, I see none on the CC list.

Jason
