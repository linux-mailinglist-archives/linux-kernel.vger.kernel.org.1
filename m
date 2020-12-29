Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F196F2E730B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 19:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgL2SnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 13:43:23 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:65172 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726111AbgL2SnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 13:43:22 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BTIQC71023965;
        Tue, 29 Dec 2020 10:42:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=7Tf2w+LGYaUs0N1NV1LBaVzpqvFT1hZPplSaB4c6+18=;
 b=Bxp2lzYJDeJaGVSBPSeMDKt4+rSon4oVs3A4ULAqPg3/LN3Km+Ja8AfNYTcvvDGsyo+b
 ozkm3EnqgfSxQgjjMhIFQygtz5pn2OrZ3Vdgf3iI+7XJWdT3qE5HjLIW1GbqQq9e4GlV
 GTMWZmGfOCLuuP+Ky3c+pMsNq2ZZ+ddSSAI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35pnqp8gq4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 29 Dec 2020 10:42:21 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Dec 2020 10:42:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGULj3VSpvNOufPPizYHD+bXF5AofCKsHsSKvqdOVsGj49ohAqhwFxcjlWIt4xFKcTTWxLI8Vn3Qjt+/Yg5HGurUVFyIIm4SuaFlvzHW/2fNLVhVtoDiDsb6xlbEKzKBfHrxGUQ9xNz/Wl4EdM7NJ2fsd9U0O5zCsOLODSRH3ZY/SjVweYB40QXOeKp9IVrblU1P5gvIe6MAOlw0F4uvy+A64BW91pTdPbUMzoSllvNEwe8axIxdrzzT9akvtf/e6Dvd8PLGV3vW4IAKnduEcNO8dI0mTtm2yr7ntGPihwTNDBCc7uzEWL0a+mY8GROs743+mlmdhPqmrJWRdOEtiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Tf2w+LGYaUs0N1NV1LBaVzpqvFT1hZPplSaB4c6+18=;
 b=FFWAcBenx+bmPGBdBK4hMMB9DJWiZVmN+CGdu0yGg13Edwx+Pi0J9RBo0BrI+OfsNFZAGDfKk2nFWkzpju+cXJooHiU+oh54E5WBLSMwfy2XV0mfrEOAAAVwOE0HyfGMlbdbq8ReQfj/O4H0JW5AhngK5boQgto1DhEBVjHw3jzkWGPrpM9iFYX3kkvALmsLr0mUcsOx88ejGTVQGWj8ITzrYLMqjn7GdCWVuYLzSOSLEyFtfeHrD97YC0vb5ED/nY/0KREh97Vk2S4P0t+0Wf2CbFtXVsYpKfa/PtUVChKmIDPk6dyzKnNyRTmSTqydZNlt+/0M0EPb5IKgimKqdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Tf2w+LGYaUs0N1NV1LBaVzpqvFT1hZPplSaB4c6+18=;
 b=FQczryo3FEYAe1SfBg0A1xX+35uD0+vyXyifbMoAQGfdFsjQ9jdkLhAtWio+Qe4XIIX1CymmXJE7xMsxFSwn9T67u+9stNeezYoRkQa6XuxH8nqA0nN16MaxN0l7r7nGLWVzOnDSG9qUOyuTPmBHosI/mFiLLsPfdtl8Dv/KCZ4=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2998.namprd15.prod.outlook.com (2603:10b6:a03:fc::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.31; Tue, 29 Dec
 2020 18:42:19 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::2c:f12b:82e9:105c]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::2c:f12b:82e9:105c%5]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 18:42:19 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v6 3/4] perf-stat: enable counting events for BPF programs
Thread-Topic: [PATCH v6 3/4] perf-stat: enable counting events for BPF
 programs
Thread-Index: AQHW3UCo6hW/vcfUc06GxX5agiqE96oM8OOAgAA7EgCAAQROAIAAOeYA
Date:   Tue, 29 Dec 2020 18:42:18 +0000
Message-ID: <3E293E73-ECB7-48E0-8A6E-337988218299@fb.com>
References: <20201228174054.907740-1-songliubraving@fb.com>
 <20201228174054.907740-4-songliubraving@fb.com>
 <20201228201159.GF521329@kernel.org>
 <6CB86649-9A1B-4585-8E1F-611F25935041@fb.com>
 <20201229151504.GI521329@kernel.org>
In-Reply-To: <20201229151504.GI521329@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:7414]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f6cbd2a-afad-4674-b204-08d8ac2978a6
x-ms-traffictypediagnostic: BYAPR15MB2998:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2998BC8B0548326DF3F5C39DB3D80@BYAPR15MB2998.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0sG/Vw4ajH5ZYTv+diFvV2QouWiXz4tcmtRhOtVirmwZjcSrIcxqBwsWrBAQWKg9b9dI7VhBzy2kRBmpGcYXT+VqXmUkdQSQeZUXNZTERbQA/nQ5T3DAmQP484bUj1YEVQMMWSKWx+xsLrWDk1J7UEUHGBc5elo0Wj3sYlPbBi2q9KCFh09SKoFZ1By3XU5/NGlGPSHsE73S6du7bQyWSksBXtLjNelo8ipopCVz4G3FB2iCgKySwOtg4pNHqK+aKssWlFS1SoqxWa1b4UZPL8KyYJtJWZsDJqZpfUGzOzeIocmppb25AD/QBPFsYbROOeEepSW/0XxtXnIVXcVbRsW4AavxQNt3Bs+oaJU8V5qdHM+36gKlycJ0ppfpFyMvZP6NI9nX/LeEnz7yZ0FAspskWj6Gy+cy+X6F8GAVdsWerblmeBYoX9tDGbgU1nG3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(396003)(136003)(376002)(66946007)(76116006)(66476007)(5660300002)(91956017)(316002)(8936002)(6916009)(8676002)(64756008)(71200400001)(66446008)(6512007)(6506007)(53546011)(66556008)(54906003)(2616005)(36756003)(4326008)(2906002)(83380400001)(6486002)(33656002)(186003)(478600001)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PvVZex4stUpY+QbY3v2CETQy+pUqsCqu7jtgmsU3B2mOkYqLPh35HuMI7Ff5?=
 =?us-ascii?Q?290ax0TcrHRlFI1KC7dBI5gFbzUNhcpqEiSSWjiDbcokUTg2H5KqoG7uM7s2?=
 =?us-ascii?Q?C9WJ+hr+biYwgRtxHNvOdddjv38/fdzGOR714hreTh/CzOJPcxn1TjkgA/tV?=
 =?us-ascii?Q?ATrzgkWLuDtdtEaglEjrbEIs00JLqhZcqoFjv4FLo45keDODPAEPb1JP0u+9?=
 =?us-ascii?Q?Q3mXWsOwM4X37HjTtiQT+qh9lf4WLSFU9pGjV2n/9Ga8r4k+7aUwATglaa60?=
 =?us-ascii?Q?MMQlpOBx8V2t2TRxYJrrKn6z9GShC0i6UApFj+M6p/M/Lg1kavhsOnBMxkBk?=
 =?us-ascii?Q?RR6sZF1c5X087g53FZwYSv44ipCNEkOxFGis2/GnP+Et5Msj7Hy/uaKZEZAO?=
 =?us-ascii?Q?qFM5NZ35DZGn4SfO0TExwyflr/PoIcpEWysC4OkSd229hDZdMwGybMqfdhei?=
 =?us-ascii?Q?NBh+Hlv8QTw0/5QucDby5IVaSEYNjaiiDw47Bm7qzo7061TXnwP6+Xxq0TuI?=
 =?us-ascii?Q?jppm9/1PjQPpxhsfXL9unz2n5xgt9K+NpYSvnre2uUpdMoo0/AtEXvIWYZuM?=
 =?us-ascii?Q?LayXt3FIPVBiZh6eQm5OS4wvT6LGPrpyYd22vSeOhTdDe+EH5DdCWa9WhW5+?=
 =?us-ascii?Q?OlmGKahZ7V0QRDjtJcPIQhQ1OZSSv9LlUjsAVGBn61XYKCGHbpdPrYvSrjpx?=
 =?us-ascii?Q?RJbkAYoZTP+Dp/5TV2E+7QsBDrv6JvZyQLYIeBm3R9CN/+7sr1ttxIrP1RMj?=
 =?us-ascii?Q?q2A6xiWv1qi6ssO2SeGuj+aJRnf5cZ46UvgyGt/klHKl/5vdAc67ThnoNCQj?=
 =?us-ascii?Q?oTwwhzIZRVnyIJrjM2l6/74ziYgZF/bmHxKOlaWt/LShpQ9wIXyLJlGz7NIx?=
 =?us-ascii?Q?6MWFVGKSIcpCE6QSUWKGdd+Bl+wOEr+dHfvbNVHSOkJU8FmmuHM9+x/m/FzW?=
 =?us-ascii?Q?Ixw21Lamw97ZFaDiVtYx48nAYKvXrbg/tHuYYqFtBfxvJfiIPGKt+0WiAFIv?=
 =?us-ascii?Q?ME9YN+Zil8w0Y2C50U/tF2o0ftwo1GFRAIlt9Vy7cquCzys=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1870229BDFFC924FA75F2053B1B04FE6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6cbd2a-afad-4674-b204-08d8ac2978a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2020 18:42:18.9732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /y1KdlftdWujgfFW0hIdxTVapAXBncIEbME0nJKAbjxwo/ZrzYIwgbhatOD4ll1Mzvga+ad1uaPQ7oAXCFZNkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2998
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-29_13:2020-12-28,2020-12-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012290117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 29, 2020, at 7:15 AM, Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>=20
> Em Mon, Dec 28, 2020 at 11:43:25PM +0000, Song Liu escreveu:
>>=20
>>=20
>>> On Dec 28, 2020, at 12:11 PM, Arnaldo Carvalho de Melo <acme@kernel.org=
> wrote:
>>>=20
>>> Em Mon, Dec 28, 2020 at 09:40:53AM -0800, Song Liu escreveu:
>>>> Introduce perf-stat -b option, which counts events for BPF programs, l=
ike:
>>>>=20
>>>> [root@localhost ~]# ~/perf stat -e ref-cycles,cycles -b 254 -I 1000
>>>>    1.487903822            115,200      ref-cycles
>>>>    1.487903822             86,012      cycles
>>>>    2.489147029             80,560      ref-cycles
>>>>    2.489147029             73,784      cycles
>>>>    3.490341825             60,720      ref-cycles
>>>>    3.490341825             37,797      cycles
>>>>    4.491540887             37,120      ref-cycles
>>>>    4.491540887             31,963      cycles
>>>>=20
>>>> The example above counts cycles and ref-cycles of BPF program of id 25=
4.
>>>> This is similar to bpftool-prog-profile command, but more flexible.
>>>>=20
>>>> perf-stat -b creates per-cpu perf_event and loads fentry/fexit BPF
>>>> programs (monitor-progs) to the target BPF program (target-prog). The
>>>> monitor-progs read perf_event before and after the target-prog, and
>>>> aggregate the difference in a BPF map. Then the user space reads data
>>>> from these maps.
>>>>=20
>>>> A new struct bpf_counter is introduced to provide common interface tha=
t
>>>> uses BPF programs/maps to count perf events.
>>>=20
>>> Segfaulting here:
>>>=20
>>> [root@five ~]# bpftool prog  | grep tracepoint
>>> 110: tracepoint  name syscall_unaugme  tag 57cd311f2e27366b  gpl
>>> 111: tracepoint  name sys_enter_conne  tag 3555418ac9476139  gpl
>>> 112: tracepoint  name sys_enter_sendt  tag bc7fcadbaf7b8145  gpl
>>> 113: tracepoint  name sys_enter_open  tag 0e59c3ac2bea5280  gpl
>>> 114: tracepoint  name sys_enter_opena  tag 0baf443610f59837  gpl
>>> 115: tracepoint  name sys_enter_renam  tag 24664e4aca62d7fa  gpl
>>> 116: tracepoint  name sys_enter_renam  tag 20093e51a8634ebb  gpl
>>> 117: tracepoint  name sys_enter  tag 0bc3fc9d11754ba1  gpl
>>> 118: tracepoint  name sys_exit  tag 29c7ae234d79bd5c  gpl
>>> [root@five ~]#
>>> [root@five ~]# gdb perf
>>> GNU gdb (GDB) Fedora 10.1-2.fc33
>>> Reading symbols from perf...
>>> (gdb) run stat -e instructions,cycles -b 113 -I 1000
>>> Starting program: /root/bin/perf stat -e instructions,cycles -b 113 -I =
1000
>>> [Thread debugging using libthread_db enabled]
>>> Using host libthread_db library "/lib64/libthread_db.so.1".
>>> libbpf: elf: skipping unrecognized data section(9) .eh_frame
>>> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh=
_frame
>>> libbpf: elf: skipping unrecognized data section(9) .eh_frame
>>> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh=
_frame
>>>=20
>>> Program received signal SIGSEGV, Segmentation fault.
>>> 0x000000000058d55b in bpf_program_profiler__read (evsel=3D0xc612c0) at =
util/bpf_counter.c:217
>>> 217			reading_map_fd =3D bpf_map__fd(skel->maps.accum_readings);
>>> (gdb) bt
>>> #0  0x000000000058d55b in bpf_program_profiler__read (evsel=3D0xc612c0)=
 at util/bpf_counter.c:217
>>> #1  0x0000000000000000 in ?? ()
>>> (gdb)
>>>=20
>>> [acme@five perf]$ clang -v |& head -2
>>> clang version 11.0.0 (Fedora 11.0.0-2.fc33)
>>> Target: x86_64-unknown-linux-gnu
>>> [acme@five perf]$
>>>=20
>>> Do you need any extra info?
>>=20
>> Hmm... I am not able to reproduce this. I am trying to setup an environm=
ent similar
>> to fc33 (clang 11, etc.). Does this segfault every time, and on all prog=
rams?=20
>=20
> I'll try it with a BPF proggie attached to a kprobes, but here is
> something else I noticed:
>=20
> [root@five perf]# export PYTHONPATH=3D/tmp/build/perf/python
> [root@five perf]# tools/perf/python/twatch.py
> Traceback (most recent call last):
>  File "/home/acme/git/perf/tools/perf/python/twatch.py", line 9, in <modu=
le>
>    import perf
> ImportError: /tmp/build/perf/python/perf.cpython-39-x86_64-linux-gnu.so: =
undefined symbol: bpf_counter__destroy
> [root@five perf]# perf test python
> 19: 'import perf' in python                                         : FAI=
LED!
> [root@five perf]# perf test -v python
> 19: 'import perf' in python                                         :
> --- start ---
> test child forked, pid 3198864
> python usage test: "echo "import sys ; sys.path.append('/tmp/build/perf/p=
ython'); import perf" | '/usr/bin/python3' "
> Traceback (most recent call last):
>  File "<stdin>", line 1, in <module>
> ImportError: /tmp/build/perf/python/perf.cpython-39-x86_64-linux-gnu.so: =
undefined symbol: bpf_counter__destroy
> test child finished with -1
> ---- end ----
> 'import perf' in python: FAILED!
> [root@five perf]#
>=20
> This should be trivial, I hope, just add the new object file to
> tools/perf/util/python-ext-sources, then do a 'perf test python', if it
> fails, use 'perf test -v python' to see what is preventing the python
> binding from loading.

I fixed the undefined bpf_counter__destroy. But this one looks trickier:

19: 'import perf' in python                                         :
--- start ---
test child forked, pid 2714986
python usage test: "echo "import sys ; sys.path.append('python'); import pe=
rf" | '/bin/python2' "
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ImportError: XXXXX /tools/perf/python/perf.so: undefined symbol: bpf_map_up=
date_elem

Given I already have:

diff --git i/tools/perf/util/python-ext-sources w/tools/perf/util/python-ex=
t-sources
index a9d9c142eb7c3..2cac55273eca2 100644
--- i/tools/perf/util/python-ext-sources
+++ w/tools/perf/util/python-ext-sources
@@ -35,3 +35,6 @@ util/symbol_fprintf.c
 util/units.c
 util/affinity.c
 util/rwsem.c
+util/bpf_counter.c
+../lib/bpf/bpf.c
+../lib/bpf/libbpf.c


How should I fix this?=20

Thanks,
Song

PS: I still cannot reproduce that segfault...

>=20

