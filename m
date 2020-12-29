Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EDE2E6E66
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 06:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgL2Fyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 00:54:55 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37426 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbgL2Fyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 00:54:54 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BT5mhPY023907;
        Mon, 28 Dec 2020 21:53:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=21r0Wgg4SqFePaaMwMKR3GB5dlKK+OcybhYCrLth/Mo=;
 b=lSgyyrG9fbUspNVrv0MmqRE3ycZIORSy35KSO44sNZbozK2feQevflf71r/dBxfONEr1
 YUYttar+eJCrs9PVDUb+jbWvz4p+PdfIdYDG5TkX5iGlSCqlW5/Ag8ZXcV/woXH68qz9
 ymL8RVaZuPftLdOqo5WWdvjj2AzlLYdP7e4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35pp4bebuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 28 Dec 2020 21:53:52 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 28 Dec 2020 21:53:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMO15DWnPvXjO1YHXWtSoOdMmTQZMKu6U6R+6TIkohwNLxaHWUUQMmU5yHrsChb/97i/ma/6aFmjjjrldtWFUjlie8kUVzMCy0lwdYyuaBHuemdqnAxsFO1hnZ8VauhSwRq+oZqHJPYauoJsrT8wPNAzYrGT1f9qFQOafUBYmwKCykF07eID7TZMviMORqXCg93AvPEU/x/9aqVqHlTjgjn7l/o5yO/1XnLuM56Jk5+j+2kCb//b6ivukzxL+SbG0hWJEacHqQ7dsCBV+OvBufY3CnD3if5//c+MLBezGX5fKKX2Xsc2sZY7Hsq7SR2Lae7/T5lnUNc/nF66q/N87A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBKlk9johxAF/fCIJU+t/ca1PxE2wKP7RwObNDXS6oM=;
 b=lUTUcUMadHg9r3HdMywvfJCm5gbmC+iYX5y3yK53g+l0grIsT2fQYtpncJlexBNzQjQfmcJMWJk2RPlRp9mbzgslSGnocXG0fMFv1qoepdMMsLPGc4uuENXF3qOgDxWw0YlePJ3XHiaGY47Wty3L/CL9XO4ni+JUMsMlJW1Y6nHs+8YrXimpdYrpizj4r43EWIKz3g0e7sGcFl6WPgwNqNl9gplBWL99XxbDczArPdMhfXRSW8BSPg7puyEMHICiYlkYHGUrtdJL07dYYScfm6P/+OGju6qjvwOS25xIPqi6Nbq0LWxOl7RyMbtpui3nZqfi6m+I6TsvoCn1b9T74g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBKlk9johxAF/fCIJU+t/ca1PxE2wKP7RwObNDXS6oM=;
 b=O8G9BFLoSnTRMLiyj50K80rOBcygnAHCU0g/VKtV/3Dx6qtKGZzpEbYPQN4u9+JpisE4zsA6K81YYU2M0LEWhsK0dF3Icia5BF3zhymuQIbE8Fsf+MuJClu0b7AEg8/VR8l6J6ftabPFwy5d66TRdIANAhLaBkcSzmXeYC0Faag=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB4246.namprd15.prod.outlook.com (2603:10b6:a03:10e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Tue, 29 Dec
 2020 05:53:48 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::2c:f12b:82e9:105c]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::2c:f12b:82e9:105c%5]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 05:53:47 +0000
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
Thread-Index: AQHW3UCo6hW/vcfUc06GxX5agiqE96oM8OOAgAA7EgCAAGd6AA==
Date:   Tue, 29 Dec 2020 05:53:47 +0000
Message-ID: <A6A0ED56-9CC0-4361-BE7F-CDA7A40A9822@fb.com>
References: <20201228174054.907740-1-songliubraving@fb.com>
 <20201228174054.907740-4-songliubraving@fb.com>
 <20201228201159.GF521329@kernel.org>
 <6CB86649-9A1B-4585-8E1F-611F25935041@fb.com>
In-Reply-To: <6CB86649-9A1B-4585-8E1F-611F25935041@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:7414]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee077bb5-3f1c-4f82-6b56-08d8abbe1c30
x-ms-traffictypediagnostic: BYAPR15MB4246:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB4246E500312368A11097E3A7B3D80@BYAPR15MB4246.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:299;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZYFmftiDzmN9uh0OZWFE3aKkvKqk5CKJMZPVd54FR3LaOzIdkg8K+K2ji3VBroqpdkC9pMzabA369MDkVKbw3rY2JJ1r9HGHBkOcRHi4nlt0QblA+O2N9LTgDzDgTSo6N7DD/Y9MVzcxy65Rz1c50li2IDdf9msxv5/TrjBi3qlNXzEme8qFxyfh9cMuhU0qN9GIyWeLKEyuGQvW1mE0xvpA1hq+X+zs1smyiIqkR/T5cWQ1qW9jW9DK14FdqszgYXybQ7ie0R+9x4WDBi4ogPicMEElgK8P+c7dLZ+ReLo7ByR1D11r9Ija1FYWpyeJkZaRC5LBf+mFb7QgapCCwtYhEGpSe1m5cgMOxERJoTSYVH9C9dADZesH4EYEBQJzxSLZfqCr15upImp52cpqOGzcUOxFTYfnLkOYveNPt8moooMtZIIavhjSbVDyNAo4pb4WsJlH/RJnLpRLj7ts9TdYq2CdupCg1C93Z1TbapOVWq0N/UcyzYhaA656E9xZqV5kSsmAphxYlME9OO/r/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(396003)(39860400002)(136003)(2616005)(966005)(83380400001)(5660300002)(54906003)(66446008)(186003)(316002)(6916009)(71200400001)(4326008)(2906002)(8676002)(6512007)(53546011)(66946007)(64756008)(86362001)(6486002)(36756003)(33656002)(76116006)(66556008)(478600001)(8936002)(66476007)(6506007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ACCqT796eYk6p7OVMRqWhOJb1P9zuPzXPD6Avu7K7XUCfQk5+vF+LBBziYJr?=
 =?us-ascii?Q?scX3BEob4cWhdu4yZR6mtn8iFKiF8irwm6fJL1hFeqPpsr74YzDN2FlmRXi9?=
 =?us-ascii?Q?1lYR34TMQLdhT7Qox+TMiviSry8hn9B9uzzWvW0hWHRKHcUZIU76nMYwCG4p?=
 =?us-ascii?Q?Nw6KODB7PMRQ4p9tuincmuUSi/jrdrJohIo0MDNrX1bYlBvuGqtYLOrmcflC?=
 =?us-ascii?Q?LLq9eAUJatQJhRZ7oJHaoyt8QlJqCOS1ultPRfPl9nVJ1tgsEWNt6+XE/Aok?=
 =?us-ascii?Q?B2oG+he6VP7QmdB0mMKL3mR27nHjKPPxllwHzWrnOBdUJH2ddJsuW9tmBigO?=
 =?us-ascii?Q?VEwzZNjE1iIVR0y/eVt6E0Uk/Dv0wjO0lL1cTTKKDBmsEwn0KlJCnx7YCHMN?=
 =?us-ascii?Q?5zFdmc5LL3qZAnF05fuaxUa7ZoJmgVkFUxNeSmh3EtyEPIf4Y4o8MwGGqHbP?=
 =?us-ascii?Q?Wt84Ja6uSQZeQII3bve/T3c+SSurK/1VnM7fBQoplwXLGvdkaOMReg3O3mYA?=
 =?us-ascii?Q?1DKx8Z5fzbGSfLTZC8MXYZXol1mco6C25pXbvi3d36RiUo4OJopPbkE8ExLK?=
 =?us-ascii?Q?gUssykN+YR+GwTT+JDAJ6Za4n8GDvd6+iTJ9UlrlgHij/mZRzVwkxIzOoWRy?=
 =?us-ascii?Q?Z0quiRvvc2zPmjeSEDne0BYAr8pPsp94bEkxVKfJFhBszSZEyYQ9P2JdtkDj?=
 =?us-ascii?Q?MUGkzBI+ImQbOqqXyMFJGaF3XUfFn78QzO5TsGSip6lNZsLJCW4oC59MEQ+O?=
 =?us-ascii?Q?4JPwaAWlReyRe9DNmuW8bY/wRj1uZZdk48G0eL5VbBBH1CwYRH8I2Z/TLvQx?=
 =?us-ascii?Q?IYDUo8/gH9IeiU2Uip4HqZaZ0GXmudYu1902QBLYT8YBuiv+r32r9ZqvnraA?=
 =?us-ascii?Q?g/pIcSsiuxT7m4fU91bKBKQy9roKxyRGz6qX29d07gOxJLdBnYrAAiIx+P9x?=
 =?us-ascii?Q?xlKa6X4l7HesT4q8YS/sW0VKlIc9vQB02JLIhHnKIdCXWTjle5bA7064wXv/?=
 =?us-ascii?Q?4l/WFI/CIdiFkf+wJW82hoVpatWpyEAwrTiIrXyM3L9gwTw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <70D6E7902E7C944C85FB5AFA479C3B99@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee077bb5-3f1c-4f82-6b56-08d8abbe1c30
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2020 05:53:47.6447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mnWnABNqtB94/PFXMVqAINCsZjcDO0wpjXuJ9Q5JzG7Ki48N7XSLEqJt5nJo6TzSyADG7o/AO7QK96n0qVQmZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4246
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-29_04:2020-12-28,2020-12-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012290034
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 28, 2020, at 3:43 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
>=20
>=20
>> On Dec 28, 2020, at 12:11 PM, Arnaldo Carvalho de Melo <acme@kernel.org>=
 wrote:
>>=20
>> Em Mon, Dec 28, 2020 at 09:40:53AM -0800, Song Liu escreveu:
>>> Introduce perf-stat -b option, which counts events for BPF programs, li=
ke:
>>>=20
>>> [root@localhost ~]# ~/perf stat -e ref-cycles,cycles -b 254 -I 1000
>>>    1.487903822            115,200      ref-cycles
>>>    1.487903822             86,012      cycles
>>>    2.489147029             80,560      ref-cycles
>>>    2.489147029             73,784      cycles
>>>    3.490341825             60,720      ref-cycles
>>>    3.490341825             37,797      cycles
>>>    4.491540887             37,120      ref-cycles
>>>    4.491540887             31,963      cycles
>>>=20
>>> The example above counts cycles and ref-cycles of BPF program of id 254.
>>> This is similar to bpftool-prog-profile command, but more flexible.
>>>=20
>>> perf-stat -b creates per-cpu perf_event and loads fentry/fexit BPF
>>> programs (monitor-progs) to the target BPF program (target-prog). The
>>> monitor-progs read perf_event before and after the target-prog, and
>>> aggregate the difference in a BPF map. Then the user space reads data
>>> from these maps.
>>>=20
>>> A new struct bpf_counter is introduced to provide common interface that
>>> uses BPF programs/maps to count perf events.
>>=20
>> Segfaulting here:
>>=20
>> [root@five ~]# bpftool prog  | grep tracepoint
>> 110: tracepoint  name syscall_unaugme  tag 57cd311f2e27366b  gpl
>> 111: tracepoint  name sys_enter_conne  tag 3555418ac9476139  gpl
>> 112: tracepoint  name sys_enter_sendt  tag bc7fcadbaf7b8145  gpl
>> 113: tracepoint  name sys_enter_open  tag 0e59c3ac2bea5280  gpl
>> 114: tracepoint  name sys_enter_opena  tag 0baf443610f59837  gpl
>> 115: tracepoint  name sys_enter_renam  tag 24664e4aca62d7fa  gpl
>> 116: tracepoint  name sys_enter_renam  tag 20093e51a8634ebb  gpl
>> 117: tracepoint  name sys_enter  tag 0bc3fc9d11754ba1  gpl
>> 118: tracepoint  name sys_exit  tag 29c7ae234d79bd5c  gpl
>> [root@five ~]#
>> [root@five ~]# gdb perf
>> GNU gdb (GDB) Fedora 10.1-2.fc33
>> Reading symbols from perf...
>> (gdb) run stat -e instructions,cycles -b 113 -I 1000
>> Starting program: /root/bin/perf stat -e instructions,cycles -b 113 -I 1=
000
>> [Thread debugging using libthread_db enabled]
>> Using host libthread_db library "/lib64/libthread_db.so.1".
>> libbpf: elf: skipping unrecognized data section(9) .eh_frame
>> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_=
frame
>> libbpf: elf: skipping unrecognized data section(9) .eh_frame
>> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_=
frame
>>=20
>> Program received signal SIGSEGV, Segmentation fault.
>> 0x000000000058d55b in bpf_program_profiler__read (evsel=3D0xc612c0) at u=
til/bpf_counter.c:217
>> 217			reading_map_fd =3D bpf_map__fd(skel->maps.accum_readings);
>> (gdb) bt
>> #0  0x000000000058d55b in bpf_program_profiler__read (evsel=3D0xc612c0) =
at util/bpf_counter.c:217
>> #1  0x0000000000000000 in ?? ()
>> (gdb)
>>=20
>> [acme@five perf]$ clang -v |& head -2
>> clang version 11.0.0 (Fedora 11.0.0-2.fc33)
>> Target: x86_64-unknown-linux-gnu
>> [acme@five perf]$
>>=20
>> Do you need any extra info?
>=20
> Hmm... I am not able to reproduce this. I am trying to setup an environme=
nt similar
> to fc33 (clang 11, etc.). Does this segfault every time, and on all progr=
ams?=20
>=20

I tried it on CentOS Stream release 8, with=20

  gcc version 8.4.1 20200928 (Red Hat 8.4.1-1) (GCC)
  clang version 11.0.0 (Red Hat 11.0.0-0.2.rc2.module_el8.4.0+533+50191577)

Unfortunately, I still cannot repro it.=20

I didn't find the issue while looking through the code. AFAICS, the code
fail over when the skeleton is not ready, so bpf_program_profiler__read()
should find a valid skeleton.=20

Could you please help run the test with the following patch? The patch is=20
also available at=20

    https://git.kernel.org/pub/scm/linux/kernel/git/song/linux.git perf-das=
h-b

Thanks,
Song


diff --git i/tools/perf/util/bpf_counter.c w/tools/perf/util/bpf_counter.c
index f2cb86a40c882..e09c571365b56 100644
--- i/tools/perf/util/bpf_counter.c
+++ w/tools/perf/util/bpf_counter.c
@@ -46,8 +46,10 @@ static int bpf_program_profiler__destroy(struct evsel *e=
vsel)
 {
        struct bpf_counter *counter;

-       list_for_each_entry(counter, &evsel->bpf_counter_list, list)
+       list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
+               pr_debug("%s counter =3D %lx\n", __func__, (unsigned long)c=
ounter);
                bpf_prog_profiler_bpf__destroy(counter->skel);
+       }
        INIT_LIST_HEAD(&evsel->bpf_counter_list);
        return 0;
 }
@@ -141,8 +143,14 @@ static int bpf_program_profiler_load_one(struct evsel =
*evsel, u32 prog_id)
        counter->skel =3D skel;
        list_add(&counter->list, &evsel->bpf_counter_list);
        close(prog_fd);
+       pr_debug("%s counter =3D %lx\n", __func__, (unsigned long)counter);
+       pr_debug("%s skel =3D %lx\n", __func__, (unsigned long)skel);
+       pr_debug("%s return 0\n", __func__);
        return 0;
 err_out:
+       pr_debug("%s counter =3D %lx\n", __func__, (unsigned long)counter);
+       pr_debug("%s skel =3D %lx\n", __func__, (unsigned long)skel);
+       pr_debug("%s return -1\n", __func__);
        free(counter);
        close(prog_fd);
        return -1;
@@ -214,11 +222,22 @@ static int bpf_program_profiler__read(struct evsel *e=
vsel)
        list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
                struct bpf_prog_profiler_bpf *skel =3D counter->skel;

+               pr_debug("%s counter =3D %lx\n", __func__, (unsigned long)c=
ounter);
+               pr_debug("%s skel =3D %lx\n", __func__, (unsigned long)skel=
);
+               if (!skel) {
+                       pr_err("%s !skel\n", __func__);
+                       continue;
+               }
+               if (!skel->maps.accum_readings) {
+                       pr_err("%s !skel->maps.accum_readings", __func__);
+                       continue;
+               }
+
                reading_map_fd =3D bpf_map__fd(skel->maps.accum_readings);

                err =3D bpf_map_lookup_elem(reading_map_fd, &key, values);
                if (err) {
-                       fprintf(stderr, "failed to read value\n");
+                       pr_err("failed to read value\n");
                        return err;
                }

@@ -240,6 +259,8 @@ static int bpf_program_profiler__install_pe(struct evse=
l *evsel, int cpu,

        list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
                skel =3D counter->skel;
+               pr_debug("%s counter =3D %lx\n", __func__, (unsigned long)c=
ounter);
+               pr_debug("%s skel =3D %lx\n", __func__, (unsigned long)skel=
);
                ret =3D bpf_map_update_elem(bpf_map__fd(skel->maps.events),
                                          &cpu, &fd, BPF_ANY);
                if (ret)=
