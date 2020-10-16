Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B762907F0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 17:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406809AbgJPPFY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Oct 2020 11:05:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:55660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406455AbgJPPFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 11:05:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 594B3B1AB;
        Fri, 16 Oct 2020 15:05:22 +0000 (UTC)
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook> <87sgaesba0.fsf@suse.de>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Richard Palethorpe <rpalethorpe@suse.de>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Roman Gushchin <guro@fb.com>, ltp@lists.linux.it,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Shakeel Butt" <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
Reply-To: rpalethorpe@suse.de
In-reply-to: <87sgaesba0.fsf@suse.de>
Date:   Fri, 16 Oct 2020 16:05:21 +0100
Message-ID: <87pn5irz2m.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Richard Palethorpe <rpalethorpe@suse.de> writes:

> Hello Michal,
>
> Michal Koutný <mkoutny@suse.com> writes:
>
>> Hello.
>>
>> On Wed, Oct 14, 2020 at 08:07:49PM +0100, Richard Palethorpe <rpalethorpe@suse.com> wrote:
>>> SLAB objects which outlive their memcg are moved to their parent
>>> memcg where they may be uncharged. However if they are moved to the
>>> root memcg, uncharging will result in negative page counter values as
>>> root has no page counters.
>> Why do you think those are reparented objects? If those are originally
>> charged in a non-root cgroup, then the charge value should be propagated up the
>> hierarchy, including root memcg, so if they're later uncharged in root
>> after reparenting, it should still break even. (Or did I miss some stock
>> imbalance?)
>
> I traced it and can see they are reparented objects and that the root
> groups counters are zero (or negative if I run madvise06 multiple times)
> before a drain takes place. I'm guessing this is because the root group
> has 'use_hierachy' set to false so that the childs page_counter parents
> are set to NULL. However I will check, because I'm not sure about
> either.

Yes, it appears that use_hierarchy=0 which is probably because the test
mounts cgroup v1, creates a child group within that and does not set
use_hierarchy on the root. On v2 root always has use_hierarchy enabled.

>
>>
>> (But the patch seems justifiable to me as objects (not)charged directly to
>> root memcg may be incorrectly uncharged.)
>>
>> Thanks,
>> Michal

I'm don't know if that could happen without reparenting. I suppose if
use_hierarchy=1 then actually this patch will result in root being
overcharged, so perhaps it should also check for use_hierarchy?

-- 
Thank you,
Richard.
