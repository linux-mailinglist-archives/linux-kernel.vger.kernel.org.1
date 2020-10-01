Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A8828082C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 21:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgJAT4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 15:56:38 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35886 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729993AbgJAT4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 15:56:38 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 091Jjvhj020093;
        Thu, 1 Oct 2020 12:56:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=D87sAriTPDCqJV0CuWhhXUzwKLJtMDfUKcSbRuJMw/A=;
 b=iQlpatmKY19MYbGdkt8gwR4brSA16L5quP3+1cyOwvEel7OGh1KlJeksS51nbGIAvHaN
 gvmd7LD/edTrxg40TWu8jmVEIK4zggT/we6s83fFxF0fJg3RnFaj1gC4f+ENUuavVWN0
 +T6cjJtGnWJFRC6faDvlmDIU4jdPKoOEQYI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33vvgrqur0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 01 Oct 2020 12:56:31 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 12:56:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6tpcx+1xOGQpds5AU00BfeyLhg9MtfW5spYnwrlUwVt30rNaKRgKXzDb5mDdo6zqa4tAPklb3egRlVlabM/gjLmPpUchls1huTIM185uVGER7AKrp0rLGuX/RQ7aQrYfziY3mPbaBHxiqCy3MgNYm39R1FSktWjLvG+Nh2knIEVwW2ZjdWFIS23zjRJHtPbhPzQws0Zp3uVy23E3FV/NOx5XghMj1KIiPxR2uAU18xmCoFa08/QvxR6gLKek96Mtxg26Bj7BDNjk/MWmzNMGag14wcZkNlle4YwfBrh54COL9z+6KQgUItSllBaRmAtjITHtafH9mlmRaLQcihBPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D87sAriTPDCqJV0CuWhhXUzwKLJtMDfUKcSbRuJMw/A=;
 b=dOjPrdN6OziWGqwyUTcWMAQJhueJpmJQpjKS+ntmPVEY66wMUWXZj/E6DGIScbluU5iCVasMAgPyaQX9Cv7hjGvvjYqGToojKAU4avTyCHx4D1+p/5/T6SP6jTcl7G/5XknUzsNKZjh8cPceUQ4UyMzfMJPsTkBHKpdOhnALhmb37ooYN68qvNZMI3KUwiM3lLGTNWi+UBLNOuyJbTuY9kBFU+pHrUxWKUBlOFjD7orcx3sOin9QsE+dbSgT0KGTt0qH3FobxAv9esyj5QbWw8YVxFejtAQr9MGg8CT8cH7Z/QOwOR0yqcvgV89Kng2aldHeHbZWZ/ajf67UTenMzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D87sAriTPDCqJV0CuWhhXUzwKLJtMDfUKcSbRuJMw/A=;
 b=ZzoJT3H4QfTDC32uVZNjJd0oQHFKzC6qRTg/3MlVNiLR/pJuYhAf3KPT3sz8wKp3GSgGnbO2kgQb81ZjKqPYoQNcX3JpVh5PwyNhDgxPjvBDkCccjjYoKkEGzS/Lq2UVKcZFUSp9Ow5RNFfvfObfICyfftC/83LzUC9dSxQ3kKA=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SN6PR15MB2350.namprd15.prod.outlook.com
 (2603:10b6:805:23::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Thu, 1 Oct
 2020 19:56:16 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a%7]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 19:56:16 +0000
Date:   Thu, 1 Oct 2020 12:56:10 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Bastian Bittorf <bb@npl.de>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.9-rc7 / VmallocTotal wrongly reported
Message-ID: <20201001195610.GC2706729@carbon.DHCP.thefacebook.com>
References: <20201001065104.apevlkqrs6nid3r5@hp-nas.internet>
 <CAHk-=wixd9kUup4o1d1y9Wg9WoRt6_mN7kM5sPX=_nrgrkZzFg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wixd9kUup4o1d1y9Wg9WoRt6_mN7kM5sPX=_nrgrkZzFg@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:a1f5]
X-ClientProxiedBy: MWHPR14CA0018.namprd14.prod.outlook.com
 (2603:10b6:300:ae::28) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:a1f5) by MWHPR14CA0018.namprd14.prod.outlook.com (2603:10b6:300:ae::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Thu, 1 Oct 2020 19:56:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1aab32b7-2dad-41f3-04fd-08d866440e77
X-MS-TrafficTypeDiagnostic: SN6PR15MB2350:
X-Microsoft-Antispam-PRVS: <SN6PR15MB23507B4F1DEDC7F8FD8A3DABBE300@SN6PR15MB2350.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Nsk/grHpt7aCRVO2x81TkYmJogIRMzsD5g1uaf/TqffKOHL3M4YPC1p2nNXyfhErjO4a3+0t4L1Fs78+IzhjAnvjNGMP29uX7XRF/old2sk/0Pe6WG2ToVNlprukOhFaZDZzmTL4AgzKYHfJhmP5pHqKvHjaTebLU6bWx8NJsjXCq+wikCNWgYO1AHMxhUMtq5VgqqygPBTJz0lik3xWEq5McmX7bYEzDFcnrmSPYuSw6pf3RZs2WX7d0SHnSVOUjpZ3QWw6uPmQjD2r+2d8S2Euwx5BDfVfOo+9Q4w28Z3YpEBq8TxjLaYji1Bodqz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39860400002)(346002)(366004)(396003)(53546011)(6916009)(55016002)(5660300002)(6666004)(8936002)(8676002)(4326008)(186003)(1076003)(83380400001)(478600001)(54906003)(66476007)(66556008)(33656002)(66946007)(316002)(9686003)(7696005)(16526019)(2906002)(52116002)(6506007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: wIpbcmva/9COVMETME1ej29kEnsFQyXk89tu1V8nzmWdjnnSWL+AC0dPacvRoImB0sFUNYN2vuFXrlB4eCo/jdbui0BlZQKRaJcf0wjy8mV+s/Jbum/NXFBeo/SHXxoNIkd3I1vGkUMvlknpumOX1LzwAKktrm1HOdqpMQ4HtP+J0EMntCJTpdvee+MtiiG2bP3lWXaB5fnq+bZPoe6jIzBptI7jH/4Q12udzbr9M8qzSFDWxDsiebszQ5VwHc4qBOIelhXYKUj5jwkNsvQjSIALgIgXdWz7cSzpfF3uVjSYEntFrpg878BrKMqDSW9nN9Ih8ec55n8tRq3HMJCK34Y3U+1NL+r8SJZZpUQx+sx2YOKuY+6ut+5inf1dfHu4meyVDjJijgrzctbhsAqIc+rAxZOG01e7//xylDq4db04nuyCofUpwqv38LRXhkvNE/Y0ShomNj5+tjF7Pwfs4trPC7VnKwOtm/BLLIOFE4NPP+67R2ccNx8O8oy911ygDoU9RJZh84KUIOVX9ff9qiJQ8C+xObSGyO5dwbUHo3/zb9x0NaOLhZh2Zye8u1CF5rIB7okt3lw/RC/QVUsHF44aFRN7QKYDN0pb0qRjoqv1snvJZWdVrujeGOHkCHrnpP1VOsBoCz0oOHMVEm+li+OldE8sNr0E2qFYVyYJE6I=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aab32b7-2dad-41f3-04fd-08d866440e77
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 19:56:16.2603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sw8vmMFJ5v7QGU9ZpywC/aGTPNWt9b/FuZuLx0B7fTMtHRa8W+ES+/mX3LsJ5LZJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2350
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_07:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 clxscore=1011 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 suspectscore=5 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2010010159
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 12:19:57PM -0700, Linus Torvalds wrote:
> Adding Vlastimil, Roman and the kernel mailing list to the cc.
> 
> Vlastimil, Roman - this looks like a slab regression. And while others
> have touched slab in this merge window, you guys did so more than
> most.. Comments?

Thank you, Linus!

I think it's a regression from my slab controller changes, and I have a theory.
Bastian, can you, please, share your config?

I will come up with a patch soon.

Thanks!

> 
> On Wed, Sep 30, 2020 at 11:55 PM Bastian Bittorf <bb@npl.de> wrote:
> >
> > Since 5.9-rc1 i can see false values, booting with qemu (128mb RAM):
> >
> > / # free
> >               total        used        free      shared  buff/cache available
> > Mem:         122176 18014398506028288      114848           0 3461024     3568096
> 
> that looks like a negative 64-bit number shifted down by 10 bits (bytes -> kB).
> 
> > / # cat /proc/meminfo | grep ^V
> > VmallocTotal:   34359738367 kB
> 
> .. but this part is normal. VMALLOC_TOTAL is the VM space for vmalloc
> areas, and it's large on a 64-bit machine.
> 
> And afaik, it hasn't changed in a long time.
> 
> So I think there's something else confusing 'free'.
> 
> I think it's this:
> 
> > / # cat /proc/meminfo
> > MemAvailable:    3617184 kB
> ..
> > Slab:           10321920 kB
> > SReclaimable:    3506176 kB
> > SUnreclaim:      6815744 kB
> 
> because those slab reclaimable/unreclaimable numbers look completely
> bogus. You have more unreclaimable slab space than you have memory.
> 
> Hmm. I'm not seeing anything similar. And your config looks sane, with
> the main difference I see wrt SLAB being that you have
> 
> # CONFIG_SLAB_MERGE_DEFAULT is not set
> 
> but there's nothing wrong with that either.
> 
> It would be lovely if you could bisect it, but maybe Vlastimil or
> Roman will go "Ahh, obviously.."
> 
>                  Linus
