Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5BF2F4D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbhAMOqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbhAMOqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:46:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E6EC061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kAzgUz2KEsrg0xT9ogQwhS+LJKUEtC5fWN2IKSI3oVM=; b=iGY7QKjxuVwuOsnd6GDG/9Vq0K
        l/9PPhF/xBHmTkMEoJ4HvnUjcPPlsb6YNOusryTwkrSh/mK8kCtXPKfbxBGVrurrJWcuw6jgI3jt1
        YTPDSC6T9edUffOnBHI1Qy12Sdq+GuRoL9B4WcyFGXzqXi1ro1DtORqrYt22E3FXoOkvbLWXJXeFn
        30+qbIDlasjhvvhGwuI2mAgKQRFLOccFhZvOcpF5fobH4buETq1w/qfd5njEGK9FL017XlfS1ANZe
        sOcm6A9FxF270HPf3YgvndmJVrdCelZ2ruZ7d6/tn1SoqvGyMTwihYSHAWImAJk1cEw3wmhG/gHm+
        qmiNuQOg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kzhOi-006NJx-LS; Wed, 13 Jan 2021 14:45:28 +0000
Date:   Wed, 13 Jan 2021 14:45:20 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/3] hugetlb: use page.private for hugetlb specific
 page flags
Message-ID: <20210113144520.GO35215@casper.infradead.org>
References: <20210111210152.118394-1-mike.kravetz@oracle.com>
 <20210111210152.118394-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111210152.118394-2-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 01:01:50PM -0800, Mike Kravetz wrote:
> +	if (hpage_spool(page)) {

Could this be named hpage_subpool(), please?

