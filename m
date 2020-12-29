Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C9A2E732E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 20:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgL2TMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 14:12:09 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:23540 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726168AbgL2TMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 14:12:08 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BTJAdNu025852;
        Tue, 29 Dec 2020 11:11:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=UzT0Sk3wG1QZC6tGRXMOCDQJciJ9T42iOjIqYaPoss0=;
 b=cDN9mnJvkW00dpqS/EJIgYZRHQRnk37vwQ65OmZ6/R0g8SQvGDbnlBCWgew4PVpfGzKe
 RyS1fNhDeFUcXvkcCXrk/w89QTZ0+rPMQB+ZBVdb4SLXHNAtsRjcrB2twJZSNRfCdjJS
 HCzTdlpjZluXo5paJLDhxVo1SvsQooTbEMA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35ppadrj8y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 29 Dec 2020 11:11:18 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Dec 2020 11:11:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIkvEDBSjh1W18eRQeN1QK5hZAZ8V+8jHBPStuAKT03N7wKgpsXMTOFQ88pxYrztATiMDp/s4QQosSAN2zMVfWFDR0eJ0jlt900sn15y4xn0Q69HhKPNLXXxACDfdjWKJs26E7RrKKY1r2I943e6gUAkzqDoyhfzvq/IVp6D3GsQ/SNe5qZu48fKH8JN3x3PudE0fxAw8xpPvpDwlbp7Bz3efgwiCYxk9mUYbY14XbDEW9YxqDYRl+09RSfkgLk+HWvCDWfZ2wbWsgk1yIGEqF1G7p5Lh/pvMdOXE0jpR+emvjLZx1hgesQRkUs4kRnpjGYqqFvODrwm9ndrlhxenw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzT0Sk3wG1QZC6tGRXMOCDQJciJ9T42iOjIqYaPoss0=;
 b=lHYSxu1RpzPAT7Up1ir+JY+rh1GDOfxZgINgIoJzcduPE3ueLMrmH4S/i+yhG01q57Pqex3SHKde9QcaHUiyJ5Of+gzHAKDbk+kapPALxreB5AFOCOu3lChsDow548dob+Dmxnyy18+Q3LnGJo/v23FH7AKuOzbWX2sFQkhgRg80Eh4+XnFGJNGjZdhiGGNdURPa2dGCvWpBLuodvfmHqRLCeRS2O6Kb37ufsvRob8u0y+y7CZbNCcjRIgLt+vgCoLIpG6sIBWo9SxFVlc4WRa9QUlqysTPNeMxmLg7gSGKjLICBl6m9eVGPoS2gFsao7rjIxdl+cNoW+QIqgRSg9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzT0Sk3wG1QZC6tGRXMOCDQJciJ9T42iOjIqYaPoss0=;
 b=eirQLbUqFq9k+R4jYW1FsfnBzgZwG5dKEFfT+tdD8wMQaNHULv26LsDFRCQpg6QVLftiE1PDX0cwgfNgaQj49Bo6goEQt6DmFdE+N/SrSAq11j8ET7q9psb6ouaLJImtI0sd60oljhFduM76QYOURXWZcOC3lpPhXBTgO82w53w=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2407.namprd15.prod.outlook.com (2603:10b6:a02:8d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.31; Tue, 29 Dec
 2020 19:11:12 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::2c:f12b:82e9:105c]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::2c:f12b:82e9:105c%5]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 19:11:12 +0000
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
Thread-Index: AQHW3UCo6hW/vcfUc06GxX5agiqE96oM8OOAgAA7EgCAAQROAIAAOeYAgAABu4CAAAZXgA==
Date:   Tue, 29 Dec 2020 19:11:12 +0000
Message-ID: <9BDC4556-E802-4152-91E1-1A4696F62AAE@fb.com>
References: <20201228174054.907740-1-songliubraving@fb.com>
 <20201228174054.907740-4-songliubraving@fb.com>
 <20201228201159.GF521329@kernel.org>
 <6CB86649-9A1B-4585-8E1F-611F25935041@fb.com>
 <20201229151504.GI521329@kernel.org>
 <3E293E73-ECB7-48E0-8A6E-337988218299@fb.com>
 <20201229184829.GK521329@kernel.org>
In-Reply-To: <20201229184829.GK521329@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:7414]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34fd7dc0-c876-483e-111c-08d8ac2d81a0
x-ms-traffictypediagnostic: BYAPR15MB2407:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2407403FE867E3A214AB1A26B3D80@BYAPR15MB2407.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9yG4fMR9WAsmUczm4oy+v9+vIFvPhOVRbwXgTAy/2ks7NohwaoR8UWA5+neDi88ZcN0J+tlJtMnPQntKiyGt7NudW/F04OxrpukguhY7astHPLQeup1qxaMQi5WfojWDlQSxhjs8LjDIJHbc84l6Sm7RDwVN1xjjjK5AEZCObD1nh+dL0V5m+WdBU2an17o8CPCImcm6go9EQCsoSH6koe/F+KcxwrXt2RiiuipeFPKF6LfWIQmaHCsCFwi+2+9C05ArIlStSuQ5l4ViCtK6jOr7tzH6tlLioFHTaDzZUO2BQHSvRPVos4OTZck7gLEc9EzH+deB5mlOa8pEGw3fmfy7YKkhgi9cUk9LkIb4bTOTyufINm6vfx/vGzH4OWjbLrchYunjIETQiL+zv2Uy8yORneDpmcY13D4M+ZEjk2DEpcK/pfqqn+rKZoJxZo6m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39850400004)(396003)(376002)(66946007)(2906002)(91956017)(54906003)(66476007)(76116006)(66446008)(6512007)(64756008)(186003)(4326008)(36756003)(66556008)(8936002)(33656002)(6486002)(316002)(86362001)(2616005)(53546011)(5660300002)(71200400001)(6916009)(83380400001)(478600001)(8676002)(6506007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?qQZmFLlfmv0Mk/mpd4j2dQTOtiGvIws6ktzyXqvZNkYeu9VllLp8h/tCQXId?=
 =?us-ascii?Q?EnXjW9T2SSnv3IOyPkpeTXFNpJM+awSi4YedCBZzxOwMYJg4154t2rx9nBDM?=
 =?us-ascii?Q?hv4nEWq3CpOy43RhiudLjKyh/x3fEsdJxxE7D42qTNwIzaIQdYfB/7Cycbq7?=
 =?us-ascii?Q?x8b26ClRRN88+aMlYp7jSgSNJmRt6aL+W760/q65o74LBBMmimA3P3PWQ2s7?=
 =?us-ascii?Q?UQyLiGlzC2dxtzRHRhzfyANfSxS36yWl+uss2qgBQmqD0nOVfp4g02YSU/iQ?=
 =?us-ascii?Q?1aVRiWMjriT0jCQn4EU4MF4dMk0ZvIqPUbd9TFg4EX4DtzFmyImCE7DUY4O0?=
 =?us-ascii?Q?M3u6JLJFWLwnHQZ+Rg65r3L4H0IP4i5IlVspxXW3H0nSCd/ciq79kHS/lGSV?=
 =?us-ascii?Q?asJSCG2RrcVCSFGTsgpkBnvk5puf+pbgKO7y+q3BtlovqpPSgOQLK28ERTr5?=
 =?us-ascii?Q?kqYXiYnzK5v8hUqzT0gzretCen77vLRlUJRr0ToqeIRiSC9359Nj28Jf9vTg?=
 =?us-ascii?Q?SUESXkKBUn6sWH3dsPR7+VzQjRlsJ8jDJapLb7zEW9YMPBNasIkb9zbfe1Wg?=
 =?us-ascii?Q?D/CaPoXLE6GbzB/9cPHJ+5X92LlvD3JeTF9oCW19bA2U7A9pJAB8uFhA6UZx?=
 =?us-ascii?Q?5cIyCcz1CvJwoPDpC83NPFNlySYJuWPQCbT7PBPUSC+csMsznPMBikFSwQc3?=
 =?us-ascii?Q?EkfG2t0BrdBW1wmwtESTgrTDeyCkI5kK89f4V04MHwIHKSkAb1q6oFXfCPPr?=
 =?us-ascii?Q?YsRdQfoNs7imVyj2k/PliI+/+X1zJT2Jr5SL+NX6Lar+/nu8x3UyWmyGdiC6?=
 =?us-ascii?Q?yMdn/lD4yBdNfrW0T9t4m1V0EjLsSYWh9DRuX7YjyKWbgM9zQzrjYfBhlS9+?=
 =?us-ascii?Q?+zq8h6K9XxW5lIhq8zlChNVCkfeCPlUtPKv8Yu5HfiL4AeY6PLSFzsspDvkQ?=
 =?us-ascii?Q?AxEkqTO9uJO1C1Aq6U5j3qEd/7qqGKiC89lQZXwayQCIFX0o3VOTlXaNIAX6?=
 =?us-ascii?Q?gh1iRbxvBNLK0jwycgvVPW11FJmDLcvbf9xJypp4XWhetSw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FFC92DDD34F2294887BE956250E09220@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34fd7dc0-c876-483e-111c-08d8ac2d81a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2020 19:11:12.0432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HD6oZrB7oLy+//o9n8IGuljrLxc193i0EDG94g5+QeS7tlEOh2awsYM6VXpuNGPVqcsUL0nQ1GlbEekBhrOnbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2407
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-29_16:2020-12-28,2020-12-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012290119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 29, 2020, at 10:48 AM, Arnaldo Carvalho de Melo <acme@kernel.org> =
wrote:
>=20
> Em Tue, Dec 29, 2020 at 06:42:18PM +0000, Song Liu escreveu:
>>=20
>>=20
>>> On Dec 29, 2020, at 7:15 AM, Arnaldo Carvalho de Melo <acme@kernel.org>=
 wrote:
>>>=20
>>> Em Mon, Dec 28, 2020 at 11:43:25PM +0000, Song Liu escreveu:
>>>>=20
>>>>=20
>>>>> On Dec 28, 2020, at 12:11 PM, Arnaldo Carvalho de Melo <acme@kernel.o=
rg> wrote:
>>>>>=20
>>>>> Em Mon, Dec 28, 2020 at 09:40:53AM -0800, Song Liu escreveu:
>>>>>> Introduce perf-stat -b option, which counts events for BPF programs,=
 like:
>>>>>>=20
>>>>>> [root@localhost ~]# ~/perf stat -e ref-cycles,cycles -b 254 -I 1000
>>>>>>   1.487903822            115,200      ref-cycles
>>>>>>   1.487903822             86,012      cycles
>>>>>>   2.489147029             80,560      ref-cycles
>>>>>>   2.489147029             73,784      cycles
>>>>>>   3.490341825             60,720      ref-cycles
>>>>>>   3.490341825             37,797      cycles
>>>>>>   4.491540887             37,120      ref-cycles
>>>>>>   4.491540887             31,963      cycles
>>>>>>=20
>>>>>> The example above counts cycles and ref-cycles of BPF program of id =
254.
>>>>>> This is similar to bpftool-prog-profile command, but more flexible.
>>>>>>=20
>>>>>> perf-stat -b creates per-cpu perf_event and loads fentry/fexit BPF
>>>>>> programs (monitor-progs) to the target BPF program (target-prog). Th=
e
>>>>>> monitor-progs read perf_event before and after the target-prog, and
>>>>>> aggregate the difference in a BPF map. Then the user space reads dat=
a
>>>>>> from these maps.
>>>>>>=20
>>>>>> A new struct bpf_counter is introduced to provide common interface t=
hat
>>>>>> uses BPF programs/maps to count perf events.
>>>>>=20
>>>>> Segfaulting here:
>>>>>=20
>>>>> [root@five ~]# bpftool prog  | grep tracepoint
>>>>> 110: tracepoint  name syscall_unaugme  tag 57cd311f2e27366b  gpl
>>>>> 111: tracepoint  name sys_enter_conne  tag 3555418ac9476139  gpl
>>>>> 112: tracepoint  name sys_enter_sendt  tag bc7fcadbaf7b8145  gpl
>>>>> 113: tracepoint  name sys_enter_open  tag 0e59c3ac2bea5280  gpl
>>>>> 114: tracepoint  name sys_enter_opena  tag 0baf443610f59837  gpl
>>>>> 115: tracepoint  name sys_enter_renam  tag 24664e4aca62d7fa  gpl
>>>>> 116: tracepoint  name sys_enter_renam  tag 20093e51a8634ebb  gpl
>>>>> 117: tracepoint  name sys_enter  tag 0bc3fc9d11754ba1  gpl
>>>>> 118: tracepoint  name sys_exit  tag 29c7ae234d79bd5c  gpl
>>>>> [root@five ~]#
>>>>> [root@five ~]# gdb perf
>>>>> GNU gdb (GDB) Fedora 10.1-2.fc33
>>>>> Reading symbols from perf...
>>>>> (gdb) run stat -e instructions,cycles -b 113 -I 1000
>>>>> Starting program: /root/bin/perf stat -e instructions,cycles -b 113 -=
I 1000
>>>>> [Thread debugging using libthread_db enabled]
>>>>> Using host libthread_db library "/lib64/libthread_db.so.1".
>>>>> libbpf: elf: skipping unrecognized data section(9) .eh_frame
>>>>> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .=
eh_frame
>>>>> libbpf: elf: skipping unrecognized data section(9) .eh_frame
>>>>> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .=
eh_frame
>>>>>=20
>>>>> Program received signal SIGSEGV, Segmentation fault.
>>>>> 0x000000000058d55b in bpf_program_profiler__read (evsel=3D0xc612c0) a=
t util/bpf_counter.c:217
>>>>> 217			reading_map_fd =3D bpf_map__fd(skel->maps.accum_readings);
>>>>> (gdb) bt
>>>>> #0  0x000000000058d55b in bpf_program_profiler__read (evsel=3D0xc612c=
0) at util/bpf_counter.c:217
>>>>> #1  0x0000000000000000 in ?? ()
>>>>> (gdb)
>>>>>=20
>>>>> [acme@five perf]$ clang -v |& head -2
>>>>> clang version 11.0.0 (Fedora 11.0.0-2.fc33)
>>>>> Target: x86_64-unknown-linux-gnu
>>>>> [acme@five perf]$
>>>>>=20
>>>>> Do you need any extra info?
>>>>=20
>>>> Hmm... I am not able to reproduce this. I am trying to setup an enviro=
nment similar
>>>> to fc33 (clang 11, etc.). Does this segfault every time, and on all pr=
ograms?=20
>>>=20
>>> I'll try it with a BPF proggie attached to a kprobes, but here is
>>> something else I noticed:
>>>=20
>>> [root@five perf]# export PYTHONPATH=3D/tmp/build/perf/python
>>> [root@five perf]# tools/perf/python/twatch.py
>>> Traceback (most recent call last):
>>> File "/home/acme/git/perf/tools/perf/python/twatch.py", line 9, in <mod=
ule>
>>>   import perf
>>> ImportError: /tmp/build/perf/python/perf.cpython-39-x86_64-linux-gnu.so=
: undefined symbol: bpf_counter__destroy
>>> [root@five perf]# perf test python
>>> 19: 'import perf' in python                                         : F=
AILED!
>>> [root@five perf]# perf test -v python
>>> 19: 'import perf' in python                                         :
>>> --- start ---
>>> test child forked, pid 3198864
>>> python usage test: "echo "import sys ; sys.path.append('/tmp/build/perf=
/python'); import perf" | '/usr/bin/python3' "
>>> Traceback (most recent call last):
>>> File "<stdin>", line 1, in <module>
>>> ImportError: /tmp/build/perf/python/perf.cpython-39-x86_64-linux-gnu.so=
: undefined symbol: bpf_counter__destroy
>>> test child finished with -1
>>> ---- end ----
>>> 'import perf' in python: FAILED!
>>> [root@five perf]#
>>>=20
>>> This should be trivial, I hope, just add the new object file to
>>> tools/perf/util/python-ext-sources, then do a 'perf test python', if it
>>> fails, use 'perf test -v python' to see what is preventing the python
>>> binding from loading.
>>=20
>> I fixed the undefined bpf_counter__destroy. But this one looks trickier:
>>=20
>> 19: 'import perf' in python                                         :
>> --- start ---
>> test child forked, pid 2714986
>> python usage test: "echo "import sys ; sys.path.append('python'); import=
 perf" | '/bin/python2' "
>> Traceback (most recent call last):
>>  File "<stdin>", line 1, in <module>
>> ImportError: XXXXX /tools/perf/python/perf.so: undefined symbol: bpf_map=
_update_elem
>>=20
>> Given I already have:
>=20
> I'll check this one to get a patch that at least moves the needle here,
> i.e. probably we can leave supporting bpf counters in the python binding
> for a later step.

Thanks Arnaldo!

Currently, I have:
1. Fixed issues highlighted by Namhyung;
2. Merged 3/4 and 4/4;
3. NOT found segfault;
4. NOT fixed python import perf.=20

I don't have good ideas with 3 and 4... Shall I send current code as v7?

Thanks,
Song

>=20
> - Arnaldo
>=20
>> diff --git i/tools/perf/util/python-ext-sources w/tools/perf/util/python=
-ext-sources
>> index a9d9c142eb7c3..2cac55273eca2 100644
>> --- i/tools/perf/util/python-ext-sources
>> +++ w/tools/perf/util/python-ext-sources
>> @@ -35,3 +35,6 @@ util/symbol_fprintf.c
>> util/units.c
>> util/affinity.c
>> util/rwsem.c
>> +util/bpf_counter.c
>> +../lib/bpf/bpf.c
>> +../lib/bpf/libbpf.c
>>=20
>>=20
>> How should I fix this?=20
>>=20
>> Thanks,
>> Song
>>=20
>> PS: I still cannot reproduce that segfault...
>>=20
>>>=20
>>=20
>=20
> --=20
>=20
> - Arnaldo

