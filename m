Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304D827E6B4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 12:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgI3Kdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 06:33:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:59598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgI3Kdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:33:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1B94EAF27;
        Wed, 30 Sep 2020 10:33:39 +0000 (UTC)
Date:   Wed, 30 Sep 2020 12:33:36 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC V2] mm/vmstat: Add events for HugeTLB migration
Message-ID: <20200930103331.GA30472@linux>
References: <1601445649-22163-1-git-send-email-anshuman.khandual@arm.com>
 <20200930074639.GA26786@linux>
 <5f8a390c-8280-9b04-bf4a-3454d5984bf1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f8a390c-8280-9b04-bf4a-3454d5984bf1@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 03:32:10PM +0530, Anshuman Khandual wrote:
> Right, it would be simple. But as Mike had mentioned before PageHuge()
> check is more expensive than PageTransHuge(). This proposal just tries
> not to call PageHuge() unless the page first clears PageTransHuge(),
> saving some potential CPU cycles on normal pages.

Ah, I remember now.
I missed that, sorry.

-- 
Oscar Salvador
SUSE L3
