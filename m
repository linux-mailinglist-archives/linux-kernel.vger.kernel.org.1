Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AB22D0FD6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgLGL64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 06:58:56 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:26344 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgLGL6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:58:55 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201207115812epoutp017b4a8c9ff345dd538d06fac47597f8d5~ObUxsOQ5G2710427104epoutp01S
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 11:58:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201207115812epoutp017b4a8c9ff345dd538d06fac47597f8d5~ObUxsOQ5G2710427104epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1607342292;
        bh=EKU59/ZcPOnYuRcIpLZfbTLpvw0FVbLbHIp7DsjPRyQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=sVq8f6bv1N2ip0dQh/vkIpWLvMf4WjZ0QI8rBF+fkRh5SBVDOEImF0q3Q74uadNLd
         wkDRWpin2NIgWcDXX+INvgDqtPPL6bfhsg3psCnhq1S2EO2oKo/OnZdf7Wr8OBIJo+
         AuUC753ST12XvguzlaZT+S1PyEsMIP3n3/yFkF24=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20201207115811epcas2p2d64d4a7a03174285471ff34f1cd767c4~ObUxQFyuj0385403854epcas2p2D;
        Mon,  7 Dec 2020 11:58:11 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.186]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4CqMJf2nFyzMqYkZ; Mon,  7 Dec
        2020 11:58:10 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.E8.10621.2D81ECF5; Mon,  7 Dec 2020 20:58:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20201207115809epcas2p27357338e523393e51399eadb7a2c2351~ObUvj8Re_0385403854epcas2p2-;
        Mon,  7 Dec 2020 11:58:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201207115809epsmtrp2d89c368dfb86d1163f5f949b4549b4d0~ObUvjDlKj0558405584epsmtrp2F;
        Mon,  7 Dec 2020 11:58:09 +0000 (GMT)
X-AuditID: b6c32a45-34dff7000001297d-b1-5fce18d28ef5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        09.65.13470.1D81ECF5; Mon,  7 Dec 2020 20:58:09 +0900 (KST)
Received: from KORCO039056 (unknown [10.229.8.156]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201207115809epsmtip2ce556400882a23e1d17aa05ca33b63b7~ObUvSuX2d1852518525epsmtip2G;
        Mon,  7 Dec 2020 11:58:09 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Will Deacon'" <will@kernel.org>,
        "'Chanho Park'" <parkch98@gmail.com>
Cc:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "'Mike Leach'" <mike.leach@linaro.org>,
        "'Leo Yan'" <leo.yan@linaro.org>,
        "'John Garry'" <john.garry@huawei.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Ingo Molnar'" <mingo@redhat.com>,
        "'Arnaldo Carvalho de Melo'" <acme@kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Jiri Olsa'" <jolsa@redhat.com>,
        "'Namhyung Kim'" <namhyung@kernel.org>,
        "'Khem Raj'" <raj.khem@gmail.com>
In-Reply-To: <20201207105359.GA4198@willie-the-truck>
Subject: RE: [PATCH] perf arm pmu: fix build error on MUSL libc
Date:   Mon, 7 Dec 2020 20:58:09 +0900
Message-ID: <001101d6cc90$3b491310$b1db3930$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL9yUid8Wz8jDy8suCkHfvhsfGAdwJrg0gYATsEmCungEns0A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc+5tbwvaeikoJx2P5uILlkLLbDmoDKeM3IWZ1WySzCzWDi6U
        rLRNC0QXjcCE8HDGBny0IoMozCFCeLQ85W3YSwcsQ8LDLAJD2QpEtkXcqmu5NeO/zz3f3zff
        3/fce/m46FdCzM/QZzEmvUZHEb4cx2C4UjoGH6hlg1YBKnnUTqDOThw19+Zz0b37LgyV2ccI
        1Dw7zkU/d1YQqObhKIbs3X0YWnl8hYfG+qowlF9r56Dl5WoCDX/pFgof2gCyTk0BdG5accCP
        rq+sB3SHbYZHnxtycumWWxF0c10xQU+PdxN0y82z9NTLWZxe7vmFoFebQ1S+x3T7tYwmlTFJ
        GH2KITVDnx5HJX2oPqRWKGVyqTwWxVASvSaTiaMS3ldJEzN07jaUJEejy3YfqTRmMxX19n6T
        ITuLkWgN5qw4ijGm6oxyuTHSrMk0Z+vTI1MMmXvlMlm0wj15Qqe9Vt6DGRvIk12jLm4uWBKW
        AB8+JPfApbwbvBLgyxeR7QCO/rsI2IdnAFZVjnqVvwG0rH2Pvbb0T5USrHAXwNqOr9cFEfkE
        QFdeiIcJMgo+LXJwPRxAJsEeeynuMeCknQMbL90BHsGHVMDzvfd4HvYn4+FCgYXjYQ65HT4q
        deIeFpCxsHW+i8uyH/zOOrc+g5OhsM1ZgbMbSeDafK037CBseNYC2JkAeK24cD0Ykq/4cL68
        gcMaEmDXxHUuy/5wcbiVx7IYri7dJVg+C289zveazwP49PJLb1o8tM7XuCvz3QnhsLEzyoOQ
        DINDk97dhLBo0MVjjwWwqFDEGnfBvrYr3g2CYWnFKvcioGwbmtk2NLNtaGD7P6sKcOrANsZo
        zkxnzNFG+ca33QzWP/WId9tBmXMlcgBgfDAAIB+nAgQ7xffVIkGq5tTnjMmgNmXrGPMAULjv
        2oKLt6YY3P+KPkstV0QrlbJYBVIooxEVKDj6zQW1iEzXZDGfMYyRMb32YXwfcS4WE7N7QRBX
        MFP5jyvp9pwzsglu3d2ReLobk3+QQ25rUrry3hPr/Nqiz9SsyC49P+6aOXhU9cmTP3YGSx0h
        uabTH1/4dkIoUSqiyjD5Cxg2trTpxSnaGZwjS94VqvO/nD1dWfPTnfi1+E3aI1+9WgmfDYrx
        mQgsUXHeUZ3465Cjf8tF+Kdlx74Epmrhd8qaXz6kHFHEald+TDtzVSnb51isvl1v+eikoT88
        +cDkHPeLH3qKreNN1rDMtqCB4Tf2HH9eFzqi3L6lNyhRmtY4Mv3W4eG9ljSh9EbjZmLHtN6v
        ui7X+VvfkU/b8zfbjvHyyOvJqKAnsBU9EL5pTcBCIqyTiUKKY9Zq5BG4yaz5D+UWJNFzBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsWy7bCSvO5FiXPxBgf2qVh03dvBZrFrF7PF
        pv1NrBZHz/5lspi89RKbxabH11gtLu+aw2ax9PpFJoutew4wWXx4NJ3d4tKBBUwWTcu2sli8
        f7+QzeJ4L1Ci7fosRouZt28zWrTcMXUQ9Fgzbw2jx85Zd9k9Wo68ZfXYvELLY9OqTjaPO9f2
        sHlsXlLvcfvfY2aP9/uusnl83iQXwBXFZZOSmpNZllqkb5fAlTF7yj6mgnUCFbsv/mVtYHzH
        18XIySEhYCJx8HY3WxcjF4eQwG5GiXVXZ7FBJGQlnr3bwQ5hC0vcbznCClH0jFHiUPN9FpAE
        m4C+xMuObawgtoiAr8TCH78YQYqYBQ6zSCy9/4oVbuzyC9vARnEKmEr07D8KZgsL2Es8b50I
        NolFQEXiXvdbZhCbV8BSYsvT3awQtqDEyZlPgGo4gKbqSbRtZAQJMwvIS2x/O4cZ4joFiZ9P
        l0Ed4SSx7tNmqBoRidmdbcwTGIVnIZk0C2HSLCSTZiHpWMDIsopRMrWgODc9t9iwwDAvtVyv
        ODG3uDQvXS85P3cTIzi6tTR3MG5f9UHvECMTB+MhRgkOZiURXjWps/FCvCmJlVWpRfnxRaU5
        qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MO1rCvyvI1lc6iLeGu5ma3bZfZrd
        9cIiuVu8k9pz+3/f3bzup6Elx781cy6LeD5Mm3ZX4EXdpy8vlry/MUtbfv6V6ynH//xvFazY
        XqKYX7tz/h15Dk8rkfbSBZ9K7ZtFfJe/zLm1SnXGbzsOVrWshGuz33YdfvNU+MIroeodoX9/
        +j0TVtPbt7giirNWYt9vpf70PuejIVxequtXnyx7IPdx1epzkc45zjav1x6ZxxfkcXHt3M8H
        76UmJP7iV+ua/OOepUzXlslNCtc/cpQsu9V6+GP/mms2jUnLnkw2qdRN+OHwfaH7omPxEYvm
        F+jmXthwas5R5pTYVdZOj/f3v6ra5R/6KuRHl1pWyPZFtjFKLMUZiYZazEXFiQBDfeTeXQMA
        AA==
X-CMS-MailID: 20201207115809epcas2p27357338e523393e51399eadb7a2c2351
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,
 
> Looks like other files just include this unconditionally, but have a
> comment explaining why. See util/branch.h and util/event.h. Maybe we
> should do the same for util/pmu.h, which is already included here?

I found below files which perf includes <linux/perf_event.h>. Instead of
doing same for all, we'd better put this only for
tools/include/uapi/linux/perf_event.h.

--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -17,6 +17,9 @@
 
 #include <linux/types.h>
 #include <linux/ioctl.h>
+#if !defined(__GLIBC__)
+#include <linux/stddef.h>
+#endif
 #include <asm/byteorder.h>
 
 /*

tools/perf/arch/arm/util/pmu.c:#include <linux/perf_event.h>
tools/perf/arch/x86/util/pmu.c:#include <linux/perf_event.h>
tools/perf/arch/x86/util/tsc.c:#include <linux/perf_event.h>
tools/perf/lib/include/internal/evsel.h:#include <linux/perf_event.h>
tools/perf/lib/include/perf/event.h:#include <linux/perf_event.h>
tools/perf/lib/tests/test-evlist.c:#include <linux/perf_event.h>
tools/perf/lib/tests/test-evsel.c:#include <linux/perf_event.h>
tools/perf/tests/hists_common.c:#include <linux/perf_event.h>
tools/perf/util/auxtrace.c:#include <linux/perf_event.h>
tools/perf/util/auxtrace.h:#include <linux/perf_event.h>
tools/perf/util/branch.h:#include <linux/perf_event.h>
tools/perf/util/event.c:#include <linux/perf_event.h>
tools/perf/util/evsel.c:#include <linux/perf_event.h>
tools/perf/util/evsel.h:#include <linux/perf_event.h>
tools/perf/util/header.h:#include <linux/perf_event.h>
tools/perf/util/mem-events.h:#include <linux/perf_event.h>
tools/perf/util/namespaces.h:#include <linux/perf_event.h>
tools/perf/util/record.h:#include <linux/perf_event.h>
tools/perf/util/session.h:#include <linux/perf_event.h>
tools/perf/util/pmu.h:#include <linux/perf_event.h>
tools/perf/util/synthetic-events.c:#include <linux/perf_event.h>
tools/perf/util/parse-events.h:#include <linux/perf_event.h>
tools/perf/util/perf_event_attr_fprintf.c:#include <linux/perf_event.h>

Best Regards,
Chanho Park

