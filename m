Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1789E2B83AF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 19:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgKRSRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 13:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgKRSRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 13:17:38 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A6DC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 10:17:38 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id t5so2355205qtp.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 10:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dD6sy6Ni7G98HJq3DqJZV//04hrVQ+nxAJOAbo7wvhk=;
        b=qJAbsThvMXyR4d+PIgohVNva/D2t9a7cD6go1AdmvAW672jq8QSw/vzECdpnCWRFZV
         WmV+DIarl5wFKmzjvTpuAMygG5s5ntdTMxfipQkR1U3EOIOEohxqhIybA9voWh67gGSP
         Q0gxOc1xVfObB2q5VWzdxsCfqkPJUaTulVCdycEMbIskP7JS8OdzXtKjLARGslX8zzD0
         7ptr7LEvupZHwCjxmZTo8b73zzPnKeOjVb1x6rCdGf2cvSRNkMT3nHbAljSMmp3Lkmx1
         fjkc7DzaAq5Pyt8Nbmie20hEUzgIXx2BaiJtUmAS9EX5C7oEeYCCsmOECgM+vAssCZek
         OlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dD6sy6Ni7G98HJq3DqJZV//04hrVQ+nxAJOAbo7wvhk=;
        b=tlCfbaw8A8R1Wnc4sjpqa+eH1Hxvkwoe9vc6AjFf5W5R1j9G1HlXbOWFMt4+432Jbt
         AnkeRLiVdINPD9y4wg3CAmEOknK3XtqoVx2ul3xKwM+Yhpj8jtpWt7n3K2TSgI2ckRT+
         gGhd19KVuemT1jCWGrr7QZc6mu5tWuTtPLX3T4ojW5sB06AElSDbm8Br3bMdh26nl4zG
         psja0mJUr5Uj2NNb2twfcSo/CYYmNU1aPIApjGOaVtrUKpWKHjFiQlxu2QQbAtEefnNw
         ieRAtNgK71X4vaXB5d3+nGRQKx3nxuFz20k9fOSfI69Mx5Oizs6rArSJg4iDgDJZa1F4
         6mgg==
X-Gm-Message-State: AOAM5328ZqWgwNa4zfNrjc6PuWHMcHNBllPi6Ibtqq9MRnf+0V/2Mtfg
        joJucIOGM6Js18OHTVFvgeyMHZCBFHcICCHTHWlq2g==
X-Google-Smtp-Source: ABdhPJwjIPP+a0W/JVbnUzrfqXk1ZwIHI0Yh5MJiflSzaI004PpAVODhE4lYuOadLU95uf/mjebeOwtldHsGIt2uKUs=
X-Received: by 2002:ac8:1089:: with SMTP id a9mr5781536qtj.111.1605723457613;
 Wed, 18 Nov 2020 10:17:37 -0800 (PST)
MIME-Version: 1.0
References: <20201117024825.GA8169@xsang-OptiPlex-9020> <24d9d093-5b7a-9aee-8d61-59c0007a9269@nvidia.com>
 <20201118134952.GE1981@quack2.suse.cz>
In-Reply-To: <20201118134952.GE1981@quack2.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 18 Nov 2020 10:17:27 -0800
Message-ID: <CAPcyv4g=MFAojCeCST+sF22A+2cetVMFmQuDtu7arEM+0a+Ebw@mail.gmail.com>
Subject: Re: [mm/gup] 47e29d32af: phoronix-test-suite.npb.FT.A.total_mop_s
 -45.0% regression
To:     Jan Kara <jack@suse.cz>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        kernel test robot <oliver.sang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kbuild test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        feng tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@intel.com>,
        guobing.chen@intel.com, ming.a.chen@intel.com, frank.du@intel.com,
        Shuhua.Fan@intel.com, wangyang.guo@intel.com,
        Wenhuan.Huang@intel.com, jessica.ji@intel.com, shan.kang@intel.com,
        guangli.li@intel.com, tiejun.li@intel.com, yu.ma@intel.com,
        dapeng1.mi@intel.com, jiebin.sun@intel.com, gengxin.xie@intel.com,
        fan.zhao@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 5:51 AM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 16-11-20 19:35:31, John Hubbard wrote:
> >
> > On 11/16/20 6:48 PM, kernel test robot wrote:
> > >
> > > Greeting,
> > >
> > > FYI, we noticed a -45.0% regression of phoronix-test-suite.npb.FT.A.total_mop_s due to commit:
> > >
> >
> > That's a huge slowdown...
> >
> > >
> > > commit: 47e29d32afba11b13efb51f03154a8cf22fb4360 ("mm/gup: page->hpage_pinned_refcount: exact pin counts for huge pages")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > ...but that commit happened in April, 2020. Surely if this were a serious
> > issue we would have some other indication...is this worth following up
> > on?? I'm inclined to ignore it, honestly.
>
> Why this was detected so late is a fair question although it doesn't quite
> invalidate the report...

I don't know what specifically happened in this case, perhaps someone
from the lkp team can comment? However, the myth / contention that
"surely someone else would have noticed by now" is why the lkp project
was launched. Kernels regressed without much complaint and it wasn't
until much later in the process, around the time enterprise distros
rebased to new kernels, did end users start filing performance loss
regression reports. Given -stable kernel releases, 6-7 months is still
faster than many end user upgrade cycles to new kernel baselines.
