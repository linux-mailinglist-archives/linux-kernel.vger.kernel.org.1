Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527DF2747DD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 19:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgIVR4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 13:56:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:60084 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgIVR4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 13:56:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EDB3DABD1;
        Tue, 22 Sep 2020 17:56:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 22 Sep 2020 19:56:19 +0200
From:   osalvador@suse.de
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     aris@ruivo.org, naoya.horiguchi@nec.com, mhocko@kernel.org,
        tony.luck@intel.com, cai@lca.pw, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v7 00/14] HWPOISON: soft offline rework
In-Reply-To: <20200922100314.1871b38a24289f32508c48a0@linux-foundation.org>
References: <20200922135650.1634-1-osalvador@suse.de>
 <20200922100314.1871b38a24289f32508c48a0@linux-foundation.org>
User-Agent: Roundcube Webmail
Message-ID: <92fdb08f6c7f1658392d14db12826235@suse.de>
X-Sender: osalvador@suse.de
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-22 19:03, Andrew Morton wrote:
> On Tue, 22 Sep 2020 15:56:36 +0200 Oscar Salvador <osalvador@suse.de> 
> wrote:
> 
>> This patchset is the latest version of soft offline rework patchset
>> targetted for v5.9.
> 
> Thanks.
> 
> Where do we now stand with the followon patches:
> 
> mmhwpoison-take-free-pages-off-the-buddy-freelists.patch
> mmhwpoison-drain-pcplists-before-bailing-out-for-non-buddy-zero-refcount-page.patch
> mmhwpoison-drop-unneeded-pcplist-draining.patch
> mmhwpoison-drop-unneeded-pcplist-draining-fix.patch
> mmhwpoison-remove-stale-code.patch
> 
> I don't have a record of these having been reviewed?

Hi Andrew,

I would drop those for now as they depend on this work, and I would 
rather have this patchset settled first.

Once things are calm, I will resend the other ones and I will ask Naoya 
to review it.

Thanks!

