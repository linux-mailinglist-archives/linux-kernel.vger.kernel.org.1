Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6211EBEA1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 17:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgFBPBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 11:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgFBPBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 11:01:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0C5C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 08:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aqztiuYMqiGIh8TbQtZTWQvnokYpywsvJH4dIeVj5Lk=; b=HZlUrwUUu18Htas/y2yfNP47VA
        Qfc3hOF/6Z+e3aTQzP9UuMLSIFh7JCanKaat5GpGpjPsjodslf5482hlaLBFSWutAO+P3Ganw0cif
        YrX8BKHtiGbLK1dbJSTHkekSv87WcpDBdH7WGlxE7DjaduToc/HYFHh/n2EyIXmZVOEnV8f1GPI1H
        9GmLWrnC6ZrnoOUjikTYroBi3JZOcCIm178spSbN9t2N58XjKSWTTK9Xw7SH9H+0+VufkSxMDoQT1
        H0aof9O61pMsoBTS2iREJc4CNRsgqP9lARzk6WDmuG7B4Ewb6eU3oudj6ssbxfnByoNe56KFQS8RO
        QDo1Y01w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jg8QA-00008H-1K; Tue, 02 Jun 2020 15:01:42 +0000
Date:   Tue, 2 Jun 2020 08:01:41 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, hughd@google.com,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmstat: Add events for PMD based THP migration
 without split
Message-ID: <20200602150141.GN19604@bombadil.infradead.org>
References: <1590118444-21601-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590118444-21601-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 09:04:04AM +0530, Anshuman Khandual wrote:
> This adds the following two new VM events which will help in validating PMD
> based THP migration without split. Statistics reported through these events
> will help in performance debugging.
> 
> 1. THP_PMD_MIGRATION_SUCCESS
> 2. THP_PMD_MIGRATION_FAILURE

There's nothing actually PMD specific about these events, is there?
If we have a THP of a non-PMD size, you'd want that reported through the
same statistic, wouldn't you?

