Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597F42C3524
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 00:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgKXXx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 18:53:56 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47476 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726197AbgKXXxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 18:53:55 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AONij4I010746;
        Tue, 24 Nov 2020 15:53:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=CMmaCi5q1TQxR2jEhX/jLW5w0AaGfjYryfJtQ8S2wsY=;
 b=CrdVyIn+hRm+GETxEZpBn2AsYuSiIsia/ZcOZmuwOYOKkIJ66BVZJEGU9T5R1FKK/oYK
 28K+XcWi72Jt/11GCbaVyKjV3kbPfRCSLa9XfD+9g7h95qojuPjieHPnF79yZL5lbbBX
 gBKyLYm79f7VL/Ix6vFZjp71nO4l3gHGRJ0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34ykxgm2r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Nov 2020 15:53:43 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 24 Nov 2020 15:53:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJaLLw+uWpShIuf8yHpLu82PKXcW9/gyyU6owYNfIOf+KwnIq/IJHkQ4qa9gDiPpV/sQnRpreJQ8hfhvJt4FtivV9iwTG82ERSzNsys6gXrBlLn2UMpf6zVDL3aCp1xB1sHYbWqEuE24I9Z59pO68bUJsMbX/TmA5k8pNiA4lhL5D9Fy58dyW+DhMzOC5gcQ7R6oZnI/bKS69wxQ1bSS0qxgAcMXO0MhJP65t1RD+e0Fe5KHm97WGwCMXijGvypatA/Y3oQAgi3ID5XrMCp5HbhKKwV9gN15YWds79gY9+LBICy8ikMrv+7/x3957yPRcp4HaoZeQP3yTGOGMQPH9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMmaCi5q1TQxR2jEhX/jLW5w0AaGfjYryfJtQ8S2wsY=;
 b=BMKYqcSNGX/2vhZaRtrvg5k3xwX6rpbbmVqckomEhUK90hqC1jY4N7V3sceIHlrvrlHxFZvMjfsTEQPMceP1yZID1N0nDGDE3asl2xQlR9uXQ9GwacPRmQ1fSyBpzSJ5ol1GDpqP9E7kiw9ZdZWMF2KW5CtgOn0eN79o5Z7fKV5Lp1GCd0pgGyr0om17s1vJj9CcWNecVrSgi850P159z61cpViXcRqURsSANq2C9UXQKUXejB3E3qj6VHJW/GcX91UvS6voaRXLtyR21Noikj4e5AGEQ/bSxI+R+ZkUCnRbLmAthtwMMNr+BdSBBOlKbLZvUUBfiEUrcQxrQ3nFOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMmaCi5q1TQxR2jEhX/jLW5w0AaGfjYryfJtQ8S2wsY=;
 b=M157k5AEp82U2cqaWDyi5Y5r0u/lPdbKFdNAj7BwPFzn5HEbXEv9zfhx2cKMI2X0hZf1U2Ujh8ShXtKZj0fZcY3HQOzUg5iK+aXH3+7RIcVjVJJVccwoKs1iiFqKCim03GRDpwoM3FQPNXR7kuvpyujn7DIzOVThXGIvvrd8kEY=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2566.namprd15.prod.outlook.com (2603:10b6:a03:150::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.30; Tue, 24 Nov
 2020 23:53:39 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b%7]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 23:53:39 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [RFC 1/2] perf: support build BPF skeletons with perf
Thread-Topic: [RFC 1/2] perf: support build BPF skeletons with perf
Thread-Index: AQHWvi+b1vCwOQIg40KNUQdgLO76QanXuf4AgABDsQA=
Date:   Tue, 24 Nov 2020 23:53:39 +0000
Message-ID: <3DD59629-4612-4D42-BFBB-7F0253CF59AB@fb.com>
References: <20201119045046.1491106-1-songliubraving@fb.com>
 <20201119045046.1491106-2-songliubraving@fb.com>
 <20201124195122.GD2164284@krava>
In-Reply-To: <20201124195122.GD2164284@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:f2e3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc56eb05-9dd3-420e-bada-08d890d42a63
x-ms-traffictypediagnostic: BYAPR15MB2566:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB25667871E6D43E138A7852C0B3FB0@BYAPR15MB2566.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xKUOvsstWGIlY0mO8BaERN6+BIGVYZTqEL4MLgIUkkTKnAlSz5mo3m5Mr3Zgg2I78hiIWQ8aEe8Gs58qNivx90TWIDnsqttJIx/Sq7DI7Y2pCYK8YfuiFsj5xNJIFfHPWgUNzxwtQY24wwbM7NLdu3cq5Gv+XV2YvCDk9ig4KRfjF0UxqaRtc5fEQ5Lfcd01YkkVfS1AijkNVcgvAF6HNTKsUCgCBo7aJT+G2j9eR86zrJ9C7kcrtGxPdhhe2b6b6xY8ta2CeVhQ+4+BHWWKI4DpEBoGJL7BGwjQQo4wnMtD08V2T7ioPlAyVcc5T6Sc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(6512007)(5660300002)(36756003)(86362001)(6506007)(53546011)(54906003)(4326008)(66476007)(2616005)(33656002)(498600001)(8936002)(71200400001)(8676002)(66946007)(66446008)(76116006)(6486002)(66556008)(64756008)(2906002)(6916009)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?U03NKqrqYqkN6I5xP6lVKsAHjZI7NywvrThIS69ySSOxyeaKzJTW4/u21nFm?=
 =?us-ascii?Q?WSy7ia3vlgHsNa1l5LESIJCWZyOQ9X6eeXzSJNtJH0FOUoTvOZR7W/1O1va7?=
 =?us-ascii?Q?Vl9jMRGbZtNVi5upn4BXgVri+oiSmosIY/9WxtgvUfanRRfh9R1G0b2j+cEi?=
 =?us-ascii?Q?6rIBrnCEPH5t7Z/WaYHjBs6fksfuSl5PtXfBF1ll+k/HUn7T1rO+ci8s1bXT?=
 =?us-ascii?Q?5U8E27EPu3AcHwKSrD8SSWDUQ21TF0hphfKF1TTYHwVAaBvPXq5/dvCQl0zi?=
 =?us-ascii?Q?L5Kuy+I2my/oQvizffELDfjjHKDjtL4a5XepmKfxV9xGcH1FLtumNF7K6/ND?=
 =?us-ascii?Q?LFzRej4P0XH42KSNibYrpZxyjXtYNlwfKJDgfObilYTuilJB81vk/5dPNMoH?=
 =?us-ascii?Q?fSI6tsjd6My+mQT/4Cc8yh/MdcbEJ6J/yRrK0B8yEYy8hSLkslXZQUCGOB1G?=
 =?us-ascii?Q?peBG9nEw8HCh8sRu01y2R1kFepYsFlOEg7p9EZNTK4XPquIWI2YC0dng3Fue?=
 =?us-ascii?Q?3tbK24yTtBqQ7dkCaWwDuOO37KhSvUiv77hXzDtgjNiLP1irxBaa0TyrBndD?=
 =?us-ascii?Q?X7RwR4X+KSJgkxxg86Lu/i/nf1cOEJ3AlY+2E4Ol5uqoHpphz+aVKigZmNFP?=
 =?us-ascii?Q?AsjBNyRi5ND+WrIOzImh0JvGlnDHOEKrrLJCFpxPnySeUw52SlOwqkw6Zhhp?=
 =?us-ascii?Q?vOmQA3/bEVB1RkHaQ7vuz4ixj/JgMPPf2xVpdXr/AVpCJKrbndlBFQrWE5Tc?=
 =?us-ascii?Q?p5Y3lHijCucoLt2F1VOr2rjlhEhqR4Wb9x74ig88h8+taF/AaIUaTJH6tAG1?=
 =?us-ascii?Q?Kgl/6WiBbJHt6tfUF+vWulOyGOS6X0dVMnRE45CvKvn6UWak41/Ny0/8m9JM?=
 =?us-ascii?Q?tscMzAJL7KNHToR+Yw1wSN10nVa4sitSbULp91dFTEI0UI0SBsf6l3aaVdbt?=
 =?us-ascii?Q?OCmg/H1Adz/UqVyfVywod3pxOeg/lJFI04sF3eiPCt3kk1PdQPH7tAfHANwe?=
 =?us-ascii?Q?y+NrscoCrESEG8/4adUkmu52sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24324FA9B0DE5F458143F41A54A502B3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc56eb05-9dd3-420e-bada-08d890d42a63
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 23:53:39.0211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9mElP5GrvAE9ITttAT7gjVk33dMJnvnDRvLVzyzcvVIbZRVmPkHGJ5xphMMCglRiqM2Snm0tPcWcm5O5wgpXqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2566
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_11:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240139
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 24, 2020, at 11:51 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Wed, Nov 18, 2020 at 08:50:45PM -0800, Song Liu wrote:
>=20
> SNIP
>=20
>> +	$(Q)$(BPFTOOL) gen skeleton $< > $@
>> +
>> +$(TMP_OUTPUT)/%.bpf.o: %.bpf.c $(TMP_OUTPUT)/vmlinux.h $(BPFOBJ) | $(TM=
P_OUTPUT)
>> +	$(call msg,BPF,$@)
>> +	$(Q)$(CLANG) -g -O2 -target bpf $(INCLUDES)			      \
>> +		 -c $(filter %.c,$^) -o $@ &&				      \
>> +	$(LLVM_STRIP) -g $@
>> +
>> +$(TMP_OUTPUT):
>> +	$(call msg,MKDIR,$@)
>> +	$(Q)mkdir -p $(TMP_OUTPUT)
>> +
>> +$(TMP_OUTPUT)/vmlinux.h: $(VMLINUX_BTF_PATH) | $(TMP_OUTPUT) $(BPFTOOL)
>=20
> please add support to specify VMLINUX_H as it is in selftests
> or bpftool, we will need it in out building setup
>=20
> thanks,
> jirka

Let me try that.=20

Thanks,
Song=
