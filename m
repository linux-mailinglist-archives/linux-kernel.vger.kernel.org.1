Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328242D3EF7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgLIJje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:39:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:52968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728311AbgLIJjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:39:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C0707AC94;
        Wed,  9 Dec 2020 09:38:43 +0000 (UTC)
Date:   Wed, 9 Dec 2020 10:38:41 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
Subject: Re: [RFC PATCH v3 3/4] mm,memory_hotplug: Enable
 MHP_MEMMAP_ON_MEMORY when supported
Message-ID: <20201209093841.GB30590@linux>
References: <20201201115158.22638-1-osalvador@suse.de>
 <20201201115158.22638-4-osalvador@suse.de>
 <aebea77d-0f13-3e59-f748-001329c9ed94@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aebea77d-0f13-3e59-f748-001329c9ed94@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 10:37:23AM +0100, David Hildenbrand wrote:
 
> Please split that patch into two parts, one for each subsystem.

I did not feel the need but if it eases the review, why not :-)


-- 
Oscar Salvador
SUSE L3
