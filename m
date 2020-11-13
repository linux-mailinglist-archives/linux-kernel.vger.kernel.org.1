Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0A52B13FB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 02:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgKMBqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 20:46:40 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6186 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725965AbgKMBqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 20:46:39 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AD1ilD9030223;
        Thu, 12 Nov 2020 17:46:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=18aMaml0aO/rKzuf9U/glhTVW9D1tshy5MNeBveN9P4=;
 b=FAJFS2V7ag01FUpgaknJAKEakC7YfRBX1tQXfdhjNTLnGCvHIvwr+BmySVn3NR1uP0GQ
 NpKbJElmySovTTiFsXB1SdGjurGygmmxlC5+WkZZXoho/le3LEKZrcauKqrwHmmFKcHp
 anUJZo2AGbn8P4tCiOuz1yP/TbPJdytBRWs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 34se3prrqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Nov 2020 17:46:30 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 12 Nov 2020 17:46:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HORR7mgSJS4Z6cZ12bOMRFyLXupXGKFGTT31f9a7QeEz+uj9blHrFZUidIQ3S3QYLDXSxt8fEIlENLpD6tJ5qx/Qdrn3CEF2j02j5/K6vTPQgwjMs1IShstQLrHj2oYvd3UBy7AusbsWCIID44z+FAsh1A8SFFP3tErJ9fm+eEv9Gy0tQdRZXwMzi1Rog3PnWO0UZ1oeXRCWZfke+9DOv2fQq5K3hrpbg95xfz9ESahYZJ3qaoL9kZf+C8sZ/AiPGxdjL8Pg6IA4N3t5TndEokdW7m3bLNKbTkiM6sxMj36lDpYU+tS+tI5wS5w2VvZx9rQs1JfmVyyJJm7xAUFzWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18aMaml0aO/rKzuf9U/glhTVW9D1tshy5MNeBveN9P4=;
 b=j2hLLWqavhPm9TUbIpo1tpLbQhIlbGshdetLjcY05E2U7Wet6xKZssfQpQih3Ed8QK9HZXYtFuVD//nrZqUEwPSimGlAlaEFeWlq685jd7iygkYYv7bRY/OyX3J9rXu1knyXKwaGdiDcF6CunV/mQnux05e7eZryKnRd18AMhSw+tB9v45aiyEJuyxOTVaSk1wtukkxc/FDiwnbQStarrBEPnx4h3XRb0idcRLpbc+PQoisFyegomIBYkT6lnhlQTKg+ibkh5T4Q4Nw00hBS7+6qcQgcoEQNs21y4Q5+o9HOQeNtil9yOJh//3r3s38foi03pso9bQYrGK8mEIInQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18aMaml0aO/rKzuf9U/glhTVW9D1tshy5MNeBveN9P4=;
 b=ZrvGVEj2u+SDNlcTXnCv2cctR7JdcvZ2oxQvYnlgIZMBQ1tyGtBVqbA9FFufLxYOldBxYL7un8Bq2o/Fod2qRlYSaZGGpgIcxUHa0b6/RYpKCPLsbM6jLeBUjTCd8YZBQ539gdQqL4k6bi06CToCUtVTXF/UznyoMYUHCOL1iqY=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3397.namprd15.prod.outlook.com (2603:10b6:a03:10b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Fri, 13 Nov
 2020 01:46:27 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 01:46:27 +0000
Date:   Thu, 12 Nov 2020 17:46:22 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>, <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH 2/2] mm: memcg/slab: pre-allocate obj_cgroups for slab
 caches with SLAB_ACCOUNT
Message-ID: <20201113014622.GA2942851@carbon.DHCP.thefacebook.com>
References: <20201110195753.530157-1-guro@fb.com>
 <20201110195753.530157-2-guro@fb.com>
 <20201112162303.GB873621@cmpxchg.org>
 <20201113001926.GA2934489@carbon.dhcp.thefacebook.com>
 <20201112171239.4f8ef107f741c3462556731f@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112171239.4f8ef107f741c3462556731f@linux-foundation.org>
X-Originating-IP: [2620:10d:c090:400::5:b498]
X-ClientProxiedBy: MW4PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:303:b6::30) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:b498) by MW4PR03CA0085.namprd03.prod.outlook.com (2603:10b6:303:b6::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Fri, 13 Nov 2020 01:46:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae0a2209-3b28-449e-b81f-08d88775ef78
X-MS-TrafficTypeDiagnostic: BYAPR15MB3397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB33975474D8A7897785E09732BEE60@BYAPR15MB3397.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xe+KeQARKsEsS2Ceki+j2fPo3/Fzw53CQiwSfk28aO/0QSS1OtK1ncu4pnQNI01FtvnQgXPiCqRoQpq/Lr8636YLICGz2c2cMx4YawZLGd1zE4/z0oYWk/5OVfMQ3OfN5NNBOBCggYqBwcFdnkN3PHgl0Igeackl/dgJKLuX95Wcfr5VD33RIhzxCo31W7IKClBs+wZnmFKHuEKSF5xekRjvqfTzPpFlJe0vtgjyL3eTKD9962g798MfqjhBqcjUtAbMl2gD1B1RZBAxt7/TiLr+EnQ+xR1AMhhp+TsiFIjEhO/9sK9owhSU+jA73ZmtwvH3eoE2ELUqN80RVw2fDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(396003)(136003)(39860400002)(16526019)(33656002)(8936002)(6506007)(53546011)(52116002)(5660300002)(6666004)(4326008)(66476007)(66556008)(6916009)(186003)(1076003)(478600001)(54906003)(316002)(83380400001)(7696005)(55016002)(86362001)(2906002)(9686003)(8676002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: YsRzN/aKPRbrdO6hYJvzbROhiA855RHro+v9CEId2NIJqJPQdZV/hxkahedM8MgpZKTc6LXVguJX2SKMEKycNOcIOYyxeiBEPE+P6/cBzebgypZ8KkGZThDRtReqyfgYAaVqJiEknVETwoq79e4mdq6N3F+fDP5GF3sBJWsiZhofKhLkVbwa6cas8efRNH9VyBKQqR+ysm7lFlRxuyShqASTT49lToCr1+Ry+YxKZ/dyUE5XL7XyUI8twKjhZJBvt8CMfpUBVKCGQrvaDy2+pe/FLr1Oa7fCj5/lEjddAuGgSvoycTjj4dASlezyhymd3ku4mQm82y27JrUcyuFy7cyneBbNHPPoP9FIN+mw9U7gxkXput0h44SQBRAk9Q1qj0ZHjGlkuAMoTUUXnkTQC35GIGjQJvJKA+mH/+ATRiTL74jzOBEcNkWlRB0I6Lbnp+bgXDPVD6P1Hp+Iq0jtbnno+Sjip2AG0057WLCQVJhPiUnTrmCnU5Ht0KdNRrtxyZ2l+3OgBy8VpfVkFDOQejV2Jb1BpeJkBK1fmFhio98DyaAUhRiwWMt8hpxi86tQwOVXYBPNXszGbO6Y8S2Jz+taYg0CfW3kkGvC5mbZ8FntyXIA1ApPcxF6rUiVXOGAQN93MMfr/HPf3ZjWaXx4XowOFrIOKVIvYg07ryJ/qc52zLf0AAfNPA9ThyvEX5o2
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0a2209-3b28-449e-b81f-08d88775ef78
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 01:46:27.3913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FbXfaBqZaeMt0mbvm26JWcadmp/ZdXDOZ+vGAo0rCVNhuCo2aDrVtvZXDTgynh+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3397
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_16:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 mlxscore=0
 adultscore=0 suspectscore=1 bulkscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011130008
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 05:12:39PM -0800, Andrew Morton wrote:
> On Thu, 12 Nov 2020 16:19:26 -0800 Roman Gushchin <guro@fb.com> wrote:
> 
> > >From 8b28d91475d54c552e503e66f169e1e00475c856 Mon Sep 17 00:00:00 2001
> > From: Roman Gushchin <guro@fb.com>
> > Date: Wed, 16 Sep 2020 15:43:48 -0700
> > Subject: [PATCH v2 2/2] mm: memcg/slab: pre-allocate obj_cgroups for slab
> >  caches with SLAB_ACCOUNT
> > 
> > In general it's unknown in advance if a slab page will contain
> > accounted objects or not. In order to avoid memory waste, an
> > obj_cgroup vector is allocated dynamically when a need to account
> > of a new object arises. Such approach is memory efficient, but
> > requires an expensive cmpxchg() to set up the memcg/objcgs pointer,
> > because an allocation can race with a different allocation on another
> > cpu.
> > 
> > But in some common cases it's known for sure that a slab page will
> > contain accounted objects: if the page belongs to a slab cache with a
> > SLAB_ACCOUNT flag set. It includes such popular objects like
> > vm_area_struct, anon_vma, task_struct, etc.
> > 
> > In such cases we can pre-allocate the objcgs vector and simple assign
> > it to the page without any atomic operations, because at this early
> > stage the page is not visible to anyone else.
> > 
> > v2: inline set_page_objcgs() and add some comments, by Johannes
> 
> Had me confused!  I was looking for the inlined function
> set_page_objcgs().  I think "open-code" is a better term here than
> "inline".

Sorry for the confusion! And thanks for picking up the new version!

Roman
