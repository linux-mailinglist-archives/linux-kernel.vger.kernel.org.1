Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20F52687C2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgINJAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:00:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:60302 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgINI7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 04:59:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3C5D9AC46;
        Mon, 14 Sep 2020 09:00:09 +0000 (UTC)
Date:   Mon, 14 Sep 2020 10:59:53 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     akpm@linux-foundation.org, David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        nathanl@linux.ibm.com, cheloha@linux.ibm.com,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: replace memmap_context by memplug_context
Message-ID: <20200914085953.GD16999@dhcp22.suse.cz>
References: <20200911134831.53258-1-ldufour@linux.ibm.com>
 <20200911134831.53258-2-ldufour@linux.ibm.com>
 <20200914084904.GA16999@dhcp22.suse.cz>
 <d3843235-2e02-a4ad-494c-20222a7e3b45@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3843235-2e02-a4ad-494c-20222a7e3b45@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-09-20 10:51:06, Laurent Dufour wrote:
> Le 14/09/2020 à 10:49, Michal Hocko a écrit :
[...]
> > /*
> >   * Memory initialization context, use to differentiate memory added by
> >   * the platform statically or via memory hotplug interface.
> >   */
> > enum meminit_context {
> > 	MEMINIT_EARLY,
> > 	MEMINIT_HOTPLUG
> > }
> > 
> 
> Sounds good too.
> What about its definition's place, in include/mm/zone.h as David suggested ?

Yes. This shouldn't be in the hotplug proper.

-- 
Michal Hocko
SUSE Labs
