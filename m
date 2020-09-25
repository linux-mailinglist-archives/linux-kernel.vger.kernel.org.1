Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8272792DA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 23:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgIYVBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 17:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIYVBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 17:01:49 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C51BC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:01:49 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id r7so447998ejs.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k1HBr67Ra9XD8Qto5IYLfIorshpKmidVCi7EV9X3ssA=;
        b=VVRXzrYwvG3Z0Gn4lOVTifjiE4oRRKeIhUzTVLkI1NNLFEbWjqmM5ejCHh2j1zsT1k
         lIG4wxOiyNkRDEK9QSA+pqeW/q64To+33QaVyXoRmeecwHK1cOzbebXMNJid+WHzAap3
         wJkw/4fRQoItzRRgQjRrM0/QdLy+8K6zRBg1BOdfVmRjU5p8wa/+apJOY0B12VmmRvN4
         sUu5sK48nEz23VAXLUmVAV/mBna3N/1vOYo59dyfP+klGaNvHtJkqNXzY9Zh7nIWDQrA
         V3Jlkj+OtqhCfj7rtAKzmtZDswAnmPcR00SSA34lr4sLZIOrCLeGZK8cZxInK53Ax/NX
         gQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k1HBr67Ra9XD8Qto5IYLfIorshpKmidVCi7EV9X3ssA=;
        b=sHzU39KB61rwZtU8pvHF6FHEi37UCuT22ZZLd/M51DBXEdaOG8lpxslvB3fBD935/1
         c+kpSDsCT+neYHhzC7AWh/UDjFXT3UzQZBAMFCV+Dtj0tkkytQqCQ+toU40s6N4mz/Yo
         fQWaoCn1qktLWGJFEOcgl+V9X1i5msyr6+MbwuR1X+eUKgHIAVEoo7iLWm1zbgKy6wAz
         eyRJZlu5JBx0DGLuI6Fl6ge0Kyp4bTnizv8EM8a62wNiNAkZL0quSEJ5TzkqKIH+uFeY
         oaiuDxAo/xGR41NptdfKuMJJTzaF3NA6Y1VSKuI1OMJM+SoyTx51jPKZGjWY/oAXqipp
         6HtQ==
X-Gm-Message-State: AOAM533ILrPHPgC+JG1S3pshIrZRo7nBhR7fsHAiq7Cf6VAAYa5g3GBZ
        lr8yT042vZM005HlmACrsw+GqvnHZU263hs++OEvNQ==
X-Google-Smtp-Source: ABdhPJw4qrnS+JVSq3hVhm/S1Jy5YBAyn1Y+JpVWvmDirB7KTpYDgjyYVq8lHHJ3/fHmFPJSuEmf5s72xt5cfkv/IQo=
X-Received: by 2002:a17:906:14c9:: with SMTP id y9mr4802942ejc.523.1601067707943;
 Fri, 25 Sep 2020 14:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
 <8370d493-e38d-cbac-1233-14cbbef63936@oracle.com>
In-Reply-To: <8370d493-e38d-cbac-1233-14cbbef63936@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 25 Sep 2020 14:01:36 -0700
Message-ID: <CAPcyv4je4PzCRo=Na7WfCpnvS0VpBN8qArr5HZv7jhwTNui4eg@mail.gmail.com>
Subject: Re: [PATCH v5 00/17] device-dax: support sub-dividing soft-reserved ranges
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Hulk Robot <hulkci@huawei.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jia He <justin.he@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Yan <yanaijie@huawei.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Juergen Gross <jgross@suse.com>,
        Daniel Vetter <daniel@ffwll.ch>, Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 1:52 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> Hey Dan,
>
> On 9/25/20 8:11 PM, Dan Williams wrote:
> > Changes since v4 [1]:
> > - Rebased on
> >   device-dax-move-instance-creation-parameters-to-struct-dev_dax_data.patch
> >   in -mm [2]. I.e. patches that did not need fixups from v4 are not
> >   included.
> >
> > - Folded all fixes
> >
>
> Hmm, perhaps you missed the fixups before the above mentioned patch?
>
> From:
>
>         https://www.ozlabs.org/~akpm/mmots/series
>
> under "mm/dax", I am listing those fixups here:
>
> x86-numa-add-nohmat-option-fix.patch
> acpi-hmat-refactor-hmat_register_target_device-to-hmem_register_device-fix.patch
> mm-memory_hotplug-introduce-default-phys_to_target_node-implementation-fix.patch
> acpi-hmat-attach-a-device-for-each-soft-reserved-range-fix.patch
>
> (in https://www.ozlabs.org/~akpm/mmots/broken-out/)

I left those for Andrew to handle. I actually should have started this
set one more down in his stack because that's where my new changes
start.
