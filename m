Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B782CF203
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbgLDQhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:37:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:50878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbgLDQhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:37:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 71851AC9A;
        Fri,  4 Dec 2020 16:36:21 +0000 (UTC)
Subject: Re: [PATCH] mm: mmap_lock: fix use-after-free race and css ref leak
 in tracepoints
To:     Shakeel Butt <shakeelb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Tejun Heo <tj@kernel.org>, Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michel Lespinasse <walken@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Yafang Shao <laoar.shao@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, dsahern@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>, liuhangbin@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
References: <20201130233504.3725241-1-axelrasmussen@google.com>
 <CALvZod42+o7naLOkpo9Jngmhru-aR4K6RCuTk7TukCikAYrDbQ@mail.gmail.com>
 <CAJHvVcgtoyJ_C0L=KByb8UbZm6x_RtCTnznYA1HwmdzX4Y=mHw@mail.gmail.com>
 <xr93lfehl8al.fsf@gthelen.svl.corp.google.com>
 <CALvZod4j9fFpGRfkios1ef0D5qhyw3XA_VSVm0k__RuMG1Qhwg@mail.gmail.com>
 <CAJHvVchcm_HLd1RaibCZDZi27_2CVCwUWDX515dvnPPyTpHBHw@mail.gmail.com>
 <CALvZod5CpPhvzB99VZTc33Sb5YCbJNHFe3k33k+HwNfJvJbpJQ@mail.gmail.com>
 <CAJHvVcjBErccEwNjuDqzsrbuzSmJva7uknZKhtBwWfs9_t4zTg@mail.gmail.com>
 <CALvZod6qpbEX+kp_gh5O4U1-kc+DfoG4DnGoWMvVnuXUOTLBBg@mail.gmail.com>
 <20201201200715.6171d39b@oasis.local.home>
 <CALvZod5mAtes0T5DFCgjU+CKVBVOdYc=jPFHXvAU+LzDqGXomg@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <1eb44e95-1fae-5d64-d114-d305c9b8ef63@suse.cz>
Date:   Fri, 4 Dec 2020 17:36:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CALvZod5mAtes0T5DFCgjU+CKVBVOdYc=jPFHXvAU+LzDqGXomg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/20 2:11 AM, Shakeel Butt wrote:
> On Tue, Dec 1, 2020 at 5:07 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>> On Tue, 1 Dec 2020 16:36:32 -0800
>> Shakeel Butt <shakeelb@google.com> wrote:
>>
>> > SGTM but note that usually Andrew squash all the patches into one
>> > before sending to Linus. If you plan to replace the path buffer with
>> > integer IDs then no need to spend time fixing buffer related bug.
>>
>> I don't think Andrew squashes all the patches. I believe he sends Linus
>> a patch series.
> 
> I am talking about the patch and the following fixes to that patch.
> Those are usually squashed into one patch.

Yeah, if there's a way forward that doesn't need to construct full path on each
event and the associated complexity and just use an ID, let's convert to the ID
and squash it, for less churn. Especially if there are other existing
tracepoints that use the ID.

If there's further (somewhat orthogonal) work to make the IDs easier for
userspace, it can be added on top later, but really shouldn't need to add the
current complex solution only to remove it later?

Thanks,
Vlastimil
