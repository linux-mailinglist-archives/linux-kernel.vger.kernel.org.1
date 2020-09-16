Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FD726C8E5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgIPS7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:59:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37218 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727416AbgIPRvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600278634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=94FZRbp8AcSQD0vP4z88A9nd5B7RpuwhLxKLeX1vNOE=;
        b=heWYoQlTj5C0MOjNQ33cpBg368KWE0w8nA3RUhdcUbf8ZmizD2PCSDgtrMgJWtGm9MLo6n
        FGAHN+tWwvUefFHve1gfG8/onB9FZw2ZhviL8hDcg5SrJsQvZj06TdySIYzjqa/z0RZy+m
        enhRbgnqIFXalxd//L/WPXZ9YAxSNkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-FmMPfPBYPgyThWG_YCM86w-1; Wed, 16 Sep 2020 11:35:23 -0400
X-MC-Unique: FmMPfPBYPgyThWG_YCM86w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 984B118BA283;
        Wed, 16 Sep 2020 15:35:21 +0000 (UTC)
Received: from ovpn-66-86.rdu2.redhat.com (ovpn-66-86.rdu2.redhat.com [10.10.66.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E615419D61;
        Wed, 16 Sep 2020 15:35:16 +0000 (UTC)
Message-ID: <d9064a334a680ac9eee0ff62c66863637099e93b.camel@redhat.com>
Subject: Re: [RFC] autonuma: Migrate on fault among multiple bound nodes
From:   Qian Cai <cai@redhat.com>
To:     David Hildenbrand <david@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
Date:   Wed, 16 Sep 2020 11:35:16 -0400
In-Reply-To: <91cfda06-0286-cb36-01fb-23cf28facee4@redhat.com>
References: <20200916005936.232788-1-ying.huang@intel.com>
         <2fe2a22235a0474b4a3de939cc22c19affc945fd.camel@redhat.com>
         <91cfda06-0286-cb36-01fb-23cf28facee4@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-09-16 at 17:29 +0200, David Hildenbrand wrote:
> On 16.09.20 15:39, Qian Cai wrote:
> > On Wed, 2020-09-16 at 08:59 +0800, Huang Ying wrote:
> > >  static int apply_policy_zone(struct mempolicy *policy, enum zone_type
> > > zone)
> > > @@ -2474,11 +2481,13 @@ int mpol_misplaced(struct page *page, struct
> > > vm_area_struct *vma, unsigned long
> > >  	int thisnid = cpu_to_node(thiscpu);
> > >  	int polnid = NUMA_NO_NODE;
> > >  	int ret = -1;
> > > +	bool moron;
> > 
> > Are you really going to use that name those days?
> > 
> > 
> 
> include/uapi/linux/mempolicy.h:#define MPOL_F_MORON     (1 << 4) /*
> Migrate On protnone Reference On Node */
> 
> Not commenting the decision for that name. It's uapi ... and naming the
> variable like the uapi flag seems to be a sane thing to do ... hmmm ...

One can argue there is no need to enforce that past decision today. Also, it
could be total different thing with a prefix and all capital letters (correct
for abbreviation). Anyway, not going to insist on it at all.

