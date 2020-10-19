Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D192922DC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 09:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbgJSHOs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Oct 2020 03:14:48 -0400
Received: from smtp.h3c.com ([60.191.123.50]:43295 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbgJSHOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 03:14:47 -0400
Received: from DAG2EX01-BASE.srv.huawei-3com.com ([10.8.0.64])
        by h3cspam02-ex.h3c.com with ESMTPS id 09J7EToK036675
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Oct 2020 15:14:29 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX01-BASE.srv.huawei-3com.com (10.8.0.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 19 Oct 2020 15:14:31 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.2106.002; Mon, 19 Oct 2020 15:14:31 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
Subject: RE: [PATCH] mm: Make allocator take care of memoryless numa node
Thread-Topic: [PATCH] mm: Make allocator take care of memoryless numa node
Thread-Index: AQHWoHLpCFmBht8fWEyQ1LSKDhVJgamTi1oAgAnlFDCAAJVdAIAAh0lA
Date:   Mon, 19 Oct 2020 07:14:31 +0000
Message-ID: <20b7b8ae56894985a1ac0187426bc248@h3c.com>
References: <20201012082739.15661-1-tian.xianting@h3c.com>
 <20201012150554.GE29725@dhcp22.suse.cz>
 <10ae851702e346369db44e1ec9c830fb@h3c.com>
 <20201019070644.GB27114@dhcp22.suse.cz>
In-Reply-To: <20201019070644.GB27114@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 09J7EToK036675
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Michal,
Yes, it is the commit bffed457160ab. Sorry I forgot to paste it in my previous reply.


-----Original Message-----
From: Michal Hocko [mailto:mhocko@suse.com] 
Sent: Monday, October 19, 2020 3:07 PM
To: tianxianting (RD) <tian.xianting@h3c.com>
Cc: cl@linux.com; penberg@kernel.org; rientjes@google.com; iamjoonsoo.kim@lge.com; akpm@linux-foundation.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org; kuba@kernel.org; alexei.starovoitov@gmail.com
Subject: Re: [PATCH] mm: Make allocator take care of memoryless numa node

On Sun 18-10-20 14:18:37, Tianxianting wrote:
> Thanks for the comments
> I found in current code, there are two places to call
> local_memory_node(node) before calling kzalloc_node(), I think we can 
> remove them?

I am not sure which code you are talking about. git grep shows me 2 places in blk-mq code (e.g. bffed457160ab) and that looks quite bogus to me. Bring that up with the respective maintainer and Raghavendra.
The changelog doesn't really describe any problem, if there is any. But from the allocator semantic point of view memory less nodes are to be expected and the allocator should fallback to the proper node. As long as __GFP_THISNODE is not enforced of course.
--
Michal Hocko
SUSE Labs
