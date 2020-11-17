Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B054A2B57F6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 04:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgKQDfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 22:35:34 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17204 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgKQDfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 22:35:33 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb3450e0001>; Mon, 16 Nov 2020 19:35:42 -0800
Received: from [10.2.57.97] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Nov
 2020 03:35:31 +0000
Subject: Re: [mm/gup] 47e29d32af: phoronix-test-suite.npb.FT.A.total_mop_s
 -45.0% regression
To:     kernel test robot <oliver.sang@intel.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>, <ying.huang@intel.com>, <feng.tang@intel.com>,
        <zhengjun.xing@intel.com>, <guobing.chen@intel.com>,
        <ming.a.chen@intel.com>, <frank.du@intel.com>,
        <Shuhua.Fan@intel.com>, <wangyang.guo@intel.com>,
        <Wenhuan.Huang@intel.com>, <jessica.ji@intel.com>,
        <shan.kang@intel.com>, <guangli.li@intel.com>,
        <tiejun.li@intel.com>, <yu.ma@intel.com>, <dapeng1.mi@intel.com>,
        <jiebin.sun@intel.com>, <gengxin.xie@intel.com>,
        <fan.zhao@intel.com>
References: <20201117024825.GA8169@xsang-OptiPlex-9020>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <24d9d093-5b7a-9aee-8d61-59c0007a9269@nvidia.com>
Date:   Mon, 16 Nov 2020 19:35:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201117024825.GA8169@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605584142; bh=jUB+JFDnCaI8NY05B0D8nF6NzAFcD+Qxv1P77ibpmMA=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=F07ESBNPFPoa50t0XaFH70E592EfoMKhT68hjwyKJv/eYA43772o8TD5I7gbraIgE
         lW2rAbviJdAqFu/MGmhg6mr3jN0pBQMq6M+LMDSSE4Ot0S8bwyeLrooyiUY5vKMX3A
         ugVrUmaU8B2BlfoiFG1nyRmn7yT3XVINLPYw0BkGofoECd7MJehD2/v3zxYi+xKijU
         Obla3Ico7koaL9qybj7PqxfqyHApCDDlO2v15VOTQRqZFz/2dTlIWhfRQQR6hYyPkt
         Ak2VRDAacwWY5V5ihmW2g6q8BpVDg7GXEFfDzX0yySWNeNKzxnnGotc6CakJZmG+34
         ok0gxRp6RLSNw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/16/20 6:48 PM, kernel test robot wrote:
>=20
> Greeting,
>=20
> FYI, we noticed a -45.0% regression of phoronix-test-suite.npb.FT.A.total=
_mop_s due to commit:
>=20

That's a huge slowdown...

>=20
> commit: 47e29d32afba11b13efb51f03154a8cf22fb4360 ("mm/gup: page->hpage_pi=
nned_refcount: exact pin counts for huge pages")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

...but that commit happened in April, 2020. Surely if this were a serious i=
ssue we
would have some other indication...is this worth following up on?? I'm incl=
ined to
ignore it, honestly.

thanks,
--=20
John Hubbard
NVIDIA
>=20
>=20
> in testcase: phoronix-test-suite
> on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with=
 192G memory
> with following parameters:
>=20
> 	test: npb-1.3.1
> 	option_a: FT.A
> 	cpufreq_governor: performance
> 	ucode: 0x5002f01
>=20
> test-description: The Phoronix Test Suite is the most comprehensive testi=
ng and benchmarking platform available that provides an extensible framewor=
k for which new tests can be easily added.
> test-url: http://www.phoronix-test-suite.com/
>=20
>=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>=20
>=20
> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>=20
>=20
> To reproduce:
>=20
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp install job.yaml  # job file is attached in this email
>          bin/lkp run     job.yaml
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/option_a/rootfs/tbox_group/test/testcas=
e/ucode:
>    gcc-9/performance/x86_64-rhel-8.3/FT.A/debian-x86_64-phoronix/lkp-csl-=
2sp8/npb-1.3.1/phoronix-test-suite/0x5002f01
>=20
> commit:
>    3faa52c03f ("mm/gup: track FOLL_PIN pages")
>    47e29d32af ("mm/gup: page->hpage_pinned_refcount: exact pin counts for=
 huge pages")
>=20
> 3faa52c03f440d1b 47e29d32afba11b13efb51f0315
> ---------------- ---------------------------
>         fail:runs  %reproduction    fail:runs
>             |             |             |
>            1:4          -25%            :4     kmsg.Spurious_LAPIC_timer_=
interrupt_on_cpu
>           %stddev     %change         %stddev
>               \          |                \
>        4585 =C2=B1  2%     -45.0%       2522        phoronix-test-suite.n=
pb.FT.A.total_mop_s
>        1223 =C2=B1  4%     +40.2%       1714        phoronix-test-suite.t=
ime.percent_of_cpu_this_job_got
>=20
>=20
>                                                                          =
       =20
>                       phoronix-test-suite.npb.FT.A.total_mop_s
>                                                                          =
       =20
>    6500 +----------------------------------------------------------------=
----+
>         |  .+.                      .+.      .+.                         =
    |
>    6000 |.+   +.+.+.++.+.+.+.+.+.+.+   +.+.++   +.+.+.+.+.+.+.+.+.++.+   =
    |
>    5500 |-+                                                           :  =
    |
>         |                                                             :  =
    |
>    5000 |-+                                                            : =
    |
>    4500 |-+                                                            +.=
+.+.|
>         |                                                                =
    |
>    4000 |-+                                                              =
    |
>    3500 |-+                                                              =
    |
>         |                                                                =
    |
>    3000 |-+                                                              =
    |
>    2500 |-+                                       O   O O                =
    |
>         | O O O O O OO O   O O O O O   O   O  O     O                    =
    |
>    2000 +----------------------------------------------------------------=
----+
>                                                                          =
       =20
>                                                                          =
       =20
> [*] bisect-good sample
> [O] bisect-bad  sample
>=20
>=20
>=20
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are prov=
ided
> for informational purposes only. Any difference in system hardware or sof=
tware
> design or configuration may affect actual performance.
>=20
>=20
> Thanks,
> Oliver Sang
>=20

