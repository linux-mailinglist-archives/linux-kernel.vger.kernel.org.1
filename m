Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1189E2D283D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgLHJzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:55:46 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:33046 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgLHJzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:55:45 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201208095501epoutp04f8f4ba9eba07a5649b3d5b14eca98cd4~OtShbhP2v2291222912epoutp04t
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 09:55:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201208095501epoutp04f8f4ba9eba07a5649b3d5b14eca98cd4~OtShbhP2v2291222912epoutp04t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1607421301;
        bh=1VsZbVl9DIEzJB74W06iyXr2yv2GRJn5pEtucpPTPII=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=X4a/tui9tN3+is5LyZBjybej28e56uQuGryWwYoWFdONzkibad/62nmaMnS3v3v/N
         Vn8H0DywPvFPSHJB+ydI2WkVlaH/IuLabUGPrh0sZbs6Ww5tgtcsqjOJI6FOiCufhr
         vfLZ6O2nZ21TkMts7iU0UZv4AYXHLCjef1XtCgtY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20201208095501epcas2p35b586b579f6767fa2af995fc82293b51~OtSgwJHSY2313123131epcas2p3_;
        Tue,  8 Dec 2020 09:55:01 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.183]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4CqwX30msjzMqYkh; Tue,  8 Dec
        2020 09:54:59 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.72.56312.27D4FCF5; Tue,  8 Dec 2020 18:54:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20201208095458epcas2p2a7f07ed67737a2b9e3126cd8c1c2578c~OtSeXFn0R2415924159epcas2p2y;
        Tue,  8 Dec 2020 09:54:58 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201208095458epsmtrp24a86b8a8c09fbfa6174fede0593294ea~OtSeWKoD42500725007epsmtrp2Z;
        Tue,  8 Dec 2020 09:54:58 +0000 (GMT)
X-AuditID: b6c32a46-1d9ff7000000dbf8-a9-5fcf4d726924
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.5E.08745.27D4FCF5; Tue,  8 Dec 2020 18:54:58 +0900 (KST)
Received: from KORCO039056 (unknown [10.229.8.156]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201208095458epsmtip229d729032a78302fe8fe45b9eb75ecc4~OtSeDghvG1946519465epsmtip2a;
        Tue,  8 Dec 2020 09:54:58 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Jiri Olsa'" <jolsa@redhat.com>,
        "'Namhyung Kim'" <namhyung@kernel.org>
Cc:     "'Will Deacon'" <will@kernel.org>,
        "'Chanho Park'" <parkch98@gmail.com>, <mathieu.poirier@linaro.org>,
        <suzuki.poulose@arm.com>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'Mike Leach'" <mike.leach@linaro.org>,
        "'Leo Yan'" <leo.yan@linaro.org>,
        "'John Garry'" <john.garry@huawei.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Ingo Molnar'" <mingo@redhat.com>,
        "'Arnaldo Carvalho de Melo'" <acme@kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Khem Raj'" <raj.khem@gmail.com>
In-Reply-To: <20201207132840.GA4070632@krava>
Subject: RE: [PATCH] perf arm pmu: fix build error on MUSL libc
Date:   Tue, 8 Dec 2020 18:54:58 +0900
Message-ID: <001001d6cd48$303a8810$90af9830$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL9yUid8Wz8jDy8suCkHfvhsfGAdwJrg0gYATsEmCsCM/My1AK/Az8hAumiFLSnQuOvAA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDJsWRmVeSWpSXmKPExsWy7bCmqW6x7/l4g3/HGS267u1gs9i1i9li
        0/4mVoujZ/8yWUzeeonNYtPja6wWl3fNYbNYev0ik8XWPQeYLD48ms5ucenAAiaLpmVbWSze
        v1/IZnG8FyjRdn0Wo8XM27cZLVrumDoIeqyZt4bRY+esu+weLUfesnpsXqHlsWlVJ5vHnWt7
        2Dw2L6n3uP3vMbPH+31X2Tw+b5IL4IrKsclITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0
        tDBXUshLzE21VXLxCdB1y8wB+kZJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2Bo
        WKBXnJhbXJqXrpecn2tlaGBgZApUmZCTsXWCVcEC/orXfzexNzDu5eli5OSQEDCR+Hh8FlMX
        IxeHkMAORok5e3vYQRJCAp8YJX5v44RIfGaUuLKhkaWLkQOs42FnFkR8F6PE894jjBDOC0aJ
        E19XgXWzCehLvOzYxgpiiwj4SHRdnckGYjMLHGWRWNESA2JzCuhKPLzfwgJiCwvYSzxvnQhm
        swioSPw9sIUZZBmvgKXE/zOxIGFeAUGJkzOfsECMkZfY/nYOM8QHChI/ny6DWhUm8bTpEtQq
        EYnZnW3MILdJCLRzSrxfdpgdosFFYvaOZ4wQtrDEq+NboOJSEp/f7WWDsOslVjxqgmruYZR4
        Oe0f1DZ7iZlPlzKBHMcsoCmxfpc+JFCUJY7cgrqNT6Lj8F92iDCvREebEESjusSB7dNZIGxZ
        ie45n1knMCrNQvLZLCSfzULywSyEXQsYWVYxiqUWFOempxYbFRghx/QmRnAy13LbwTjl7Qe9
        Q4xMHIyHGCU4mJVEeNWkzsYL8aYkVlalFuXHF5XmpBYfYjQFBvVEZinR5HxgPskriTc0NTIz
        M7A0tTA1M7JQEucNXdkXLySQnliSmp2aWpBaBNPHxMEp1cBU93Zzzwev8ONzrB5qXd0aWLju
        6+zzt5mP7cln35ZtMcd+xTpG/iN7q1Lv1skW7j0QbOxa1uB8XrT2eljF3oyIE7Gx6hFZ/+bz
        9P49abr0YvH5921+FwI7/02tLtjduD2LXfBf+6lYwdUqLjuM2Gx5zJttlN221Dx40a6zheOq
        naDQYa8HCVaZe0yn39Y6+0qZw1r89lfltXkBS62Y+ysmvJH7fKgqydXVROb+McftbFNn2B6L
        Cc5VmNbSJJ88M0pwk/bldSdd50m/eaa4IahR+slyn2BNid02wp92n7/w1F41V/epz75N6058
        zPhywjYgMk2r0Xxt8VSPrM5pYeHdE5OvJAgGcx/6ee3oZ20lluKMREMt5qLiRAD9U0yUbwQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsWy7bCSvG6R7/l4g93TZC267u1gs9i1i9li
        0/4mVoujZ/8yWUzeeonNYtPja6wWl3fNYbNYev0ik8XWPQeYLD48ms5ucenAAiaLpmVbWSze
        v1/IZnG8FyjRdn0Wo8XM27cZLVrumDoIeqyZt4bRY+esu+weLUfesnpsXqHlsWlVJ5vHnWt7
        2Dw2L6n3uP3vMbPH+31X2Tw+b5IL4IrisklJzcksSy3St0vgytg6wapgAX/F67+b2BsY9/J0
        MXJwSAiYSDzszOpi5OIQEtjBKHH+2WemLkZOoLisxLN3O9ghbGGJ+y1HWCGKnjFKzGrdxAyS
        YBPQl3jZsY0VxBYR8JNoa/jNBlLELHCZRWLd9JWMEB3nmSTuPlzGCFLFKaAr8fB+CwuILSxg
        L/G8dSKYzSKgIvH3wBZmkJN4BSwl/p+JBQnzCghKnJz5hAUkzCygJ9G2EWwKs4C8xPa3c5gh
        jlOQ+Pl0GdQNYRJPmy6xQdSISMzubGOewCg8C8mkWQiTZiGZNAtJxwJGllWMkqkFxbnpucWG
        BUZ5qeV6xYm5xaV56XrJ+bmbGMFxraW1g3HPqg96hxiZOBgPMUpwMCuJ8KpJnY0X4k1JrKxK
        LcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1OqgUkq6YzJ0gsz7PycuQ3e
        V3zcs3EL4xz7r41yr8zTLJgnJ8yIsXgetil6/mfWJ3e+sn5hj9oWm7TIddm6h8dNzqb0TetP
        Nn/cGrBT4UF4/6RczYnT7a+ezVE4+v1kGdNDpb6G/3+28dfvnnm5tsu5z//ftMcuvyTf5q/g
        fdC9Yol+hcDl+1sOzDoUseT64ilnbk7OFX7Nz9649X9qZNSx7bJfHHU5FBvD32x0PrGDd/rP
        mlfvBAr5cgOb1ZxjjylvLf9+S8FwfkH+Ws2X1jG/mOzCOx7e5l3KusB79bp9pSc13VabBM44
        +G+OecOL1GXbP/20PmrycfL1aHfOjOSEmg9aHWrOeUY5Ude2LJnjKaGlxFKckWioxVxUnAgA
        W44wjFoDAAA=
X-CMS-MailID: 20201208095458epcas2p2a7f07ed67737a2b9e3126cd8c1c2578c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201207105410epcas2p3f9210689886172422d27870f25a79df3
References: <20201206144527.1670483-1-chanho61.park@samsung.com>
        <CGME20201207105410epcas2p3f9210689886172422d27870f25a79df3@epcas2p3.samsung.com>
        <20201207105359.GA4198@willie-the-truck>
        <001101d6cc90$3b491310$b1db3930$@samsung.com>
        <CAM9d7chU0SP79cjuZOBg1Rhe2NYaxAOnKzdQ+XQ65fenTzak0A@mail.gmail.com>
        <20201207132840.GA4070632@krava>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung and Jiri,

> -----Original Message-----
> From: Jiri Olsa <jolsa@redhat.com>
> Sent: Monday, December 7, 2020 10:29 PM
> To: Namhyung Kim <namhyung@kernel.org>
> Cc: Chanho Park <chanho61.park@samsung.com>; Will Deacon
<will@kernel.org>;
> Chanho Park <parkch98@gmail.com>; mathieu.poirier@linaro.org;
> suzuki.poulose@arm.com; coresight@lists.linaro.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel <linux-kernel@vger.kernel.org>;
> Mike Leach <mike.leach@linaro.org>; Leo Yan <leo.yan@linaro.org>; John
> Garry <john.garry@huawei.com>; Peter Zijlstra <peterz@infradead.org>; Ingo
> Molnar <mingo@redhat.com>; Arnaldo Carvalho de Melo <acme@kernel.org>;
> Mark Rutland <mark.rutland@arm.com>; Khem Raj <raj.khem@gmail.com>
> Subject: Re: [PATCH] perf arm pmu: fix build error on MUSL libc
> 
> On Mon, Dec 07, 2020 at 09:31:06PM +0900, Namhyung Kim wrote:
> > Hi Chanho,
> >
> > On Mon, Dec 7, 2020 at 8:58 PM Chanho Park <chanho61.park@samsung.com>
> wrote:
> > >
> > > Hi Will,
> > >
> > > > Looks like other files just include this unconditionally, but have
> > > > a comment explaining why. See util/branch.h and util/event.h.
> > > > Maybe we should do the same for util/pmu.h, which is already
> included here?
> > >
> > > I found below files which perf includes <linux/perf_event.h>.
> > > Instead of doing same for all, we'd better put this only for
> > > tools/include/uapi/linux/perf_event.h.
> >
> > It's a copy of the kernel header, I'm not sure we want to add something
> there.
> 
> right, we want to copy that directly from kernel uapi so let's not do any
> changes in here
> 

I tried to modify it from include/uapi/linux/perf_event.h but it didn't
work. And then, I found perf tool tried to refer the header from
tools/include/ directory. I should go include/uapi first and sync the change
to tools/ directory. I'll re-spin this patch.

Best Regard,
Chanho Park

