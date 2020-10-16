Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39A129073E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 16:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408904AbgJPOdw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Oct 2020 10:33:52 -0400
Received: from smtp.h3c.com ([60.191.123.50]:14970 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405999AbgJPOdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 10:33:52 -0400
Received: from DAG2EX10-IDC.srv.huawei-3com.com ([10.8.0.73])
        by h3cspam02-ex.h3c.com with ESMTPS id 09GEX97X045540
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Oct 2020 22:33:09 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX10-IDC.srv.huawei-3com.com (10.8.0.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 16 Oct 2020 22:33:13 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.1713.004; Fri, 16 Oct 2020 22:33:13 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mm: vmscan: avoid a unnecessary reschedule in
 shrink_slab()
Thread-Topic: [PATCH] mm: vmscan: avoid a unnecessary reschedule in
 shrink_slab()
Thread-Index: AQHWo29cMaRbAMdQE0ycFn5GylDeeqmZnPOAgACJFdD//4YYAIAAiVZw//+CoICAAJNtUA==
Date:   Fri, 16 Oct 2020 14:33:13 +0000
Message-ID: <ca5e3e13f00348898bb9205a7eeb4c85@h3c.com>
References: <20201016033952.1924-1-tian.xianting@h3c.com>
 <20201016120749.GG22589@dhcp22.suse.cz>
 <9a2b772b13f84bdd9517b17d8d72aa89@h3c.com>
 <20201016130208.GI22589@dhcp22.suse.cz>
 <8a25eacf4b37460897911ade338754d3@h3c.com>
 <20201016134457.GM22589@dhcp22.suse.cz>
In-Reply-To: <20201016134457.GM22589@dhcp22.suse.cz>
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
X-MAIL: h3cspam02-ex.h3c.com 09GEX97X045540
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the explain.
I got it.

-----Original Message-----
From: Michal Hocko [mailto:mhocko@suse.com] 
Sent: Friday, October 16, 2020 9:45 PM
To: tianxianting (RD) <tian.xianting@h3c.com>
Cc: akpm@linux-foundation.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: avoid a unnecessary reschedule in shrink_slab()

On Fri 16-10-20 13:20:41, Tianxianting wrote:
> Thanks
> I understood what you said :)
> But whether it is proper to check reschedule in every loop when lock is taken? 

I do not see any actual problem TBH. cond_resched is mostly to increase interactivity for non preemptible kernel. It can reduce throughput but this is a memory reclaim path and I do not expect this to contribute to any moderate hot paths. Direct reclaim doesn't really count as a hot path.

--
Michal Hocko
SUSE Labs
