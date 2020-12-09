Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B842D4018
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 11:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbgLIKhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 05:37:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:53608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729964AbgLIKhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:37:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87C18AC94;
        Wed,  9 Dec 2020 10:36:52 +0000 (UTC)
Date:   Wed, 9 Dec 2020 11:36:49 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, n-horiguchi@ah.jp.nec.com,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,hwpoison: Return -EBUSY when migration fails
Message-ID: <20201209103649.GD30892@linux>
References: <20201209092818.30417-1-osalvador@suse.de>
 <a30f4786-7c54-9fa8-0d39-6ae4d10f93c2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a30f4786-7c54-9fa8-0d39-6ae4d10f93c2@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 10:59:04AM +0100, David Hildenbrand wrote:
> On 09.12.20 10:28, Oscar Salvador wrote:
> Do we expect callers to retry immediately? -EAGAIN might make also
> sense. But -EBUSY is an obvious improvement. Do we have callers relying
> on this behavior?

Not really, unless something LTP takes a look at the error code in retries
in case EBUSY.

Take into account that most of the callers do not even really check the
return code (GHES, RAS/CEC, etc.)

-- 
Oscar Salvador
SUSE L3
