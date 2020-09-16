Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072D826C4D8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 18:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgIPQDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 12:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57596 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726373AbgIPP4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 11:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600271776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uiBkPILqgj6+XmxQSXdoL8r4H4tFY2Qbd0jwLhGYEas=;
        b=UYbIAeYaTnzU3Rwh/beQ0bTu70Frdy9HY49znz3e4uJcfMLeO3uj73NCUkKyRCzA5+Rb01
        V3Y2anLexqNk5PNahSFVkX+vadF7Kyt6koKJqBlIyz4QTGsgoxn+E4xUKtQ44o4OT4Y9/3
        ZLnbkpjXDIM0z2l0Odeltt44Em+n7Kw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-l1_h9eZYNqGQg-zimJyxXg-1; Wed, 16 Sep 2020 09:39:18 -0400
X-MC-Unique: l1_h9eZYNqGQg-zimJyxXg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65B92188C129;
        Wed, 16 Sep 2020 13:39:16 +0000 (UTC)
Received: from ovpn-66-86.rdu2.redhat.com (ovpn-66-86.rdu2.redhat.com [10.10.66.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C70E6607A1;
        Wed, 16 Sep 2020 13:39:14 +0000 (UTC)
Message-ID: <2fe2a22235a0474b4a3de939cc22c19affc945fd.camel@redhat.com>
Subject: Re: [RFC] autonuma: Migrate on fault among multiple bound nodes
From:   Qian Cai <cai@redhat.com>
To:     Huang Ying <ying.huang@intel.com>,
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
Date:   Wed, 16 Sep 2020 09:39:14 -0400
In-Reply-To: <20200916005936.232788-1-ying.huang@intel.com>
References: <20200916005936.232788-1-ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-09-16 at 08:59 +0800, Huang Ying wrote:
>  static int apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
> @@ -2474,11 +2481,13 @@ int mpol_misplaced(struct page *page, struct
> vm_area_struct *vma, unsigned long
>  	int thisnid = cpu_to_node(thiscpu);
>  	int polnid = NUMA_NO_NODE;
>  	int ret = -1;
> +	bool moron;

Are you really going to use that name those days?

