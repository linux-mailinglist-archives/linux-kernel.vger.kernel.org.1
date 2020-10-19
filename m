Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0462923DF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 10:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbgJSIpf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Oct 2020 04:45:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:56498 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729121AbgJSIpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 04:45:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 111FFAC8C;
        Mon, 19 Oct 2020 08:45:34 +0000 (UTC)
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook> <20201016145308.GA312010@cmpxchg.org>
 <20201016171502.GA102311@blackbook>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Richard Palethorpe <rpalethorpe@suse.de>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        ltp@lists.linux.it, Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
Reply-To: rpalethorpe@suse.de
In-reply-to: <20201016171502.GA102311@blackbook>
Date:   Mon, 19 Oct 2020 09:45:32 +0100
Message-ID: <87lfg2ob83.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Michal Koutný <mkoutny@suse.com> writes:

> On Fri, Oct 16, 2020 at 10:53:08AM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
>> The central try_charge() function charges recursively all the way up
>> to and including the root.
> Except for use_hiearchy=0 (which is the case here as Richard
> wrote). The reparenting is hence somewhat incompatible with
> new_parent.use_hiearchy=0 :-/
>

Yes and it also seems

new_parent.use_hierarch=0 -> new_child.use_hierarchy=0

and

new_parent.use_hierarch=0 -> new_child.use_hierarchy=1

are considered valid on cgroupsV1. The kernel will also allow more
descendants on new_child.use_hierarchy=0, but sets
broken_hierarchy=1. However this will not stop the stack trace occuring
(AFAICT) when the reparenting happens between two descendants.

>> We should clean this up one way or another: either charge the root or
>> don't, but do it consistently.
> I agree this'd be good to unify. One upside of excluding root memcg from
> charging is that users are spared from the charging overhead when memcg
> tree is not created.  (Actually, I thought that was the reason for this
> exception.)
>
> Michal


-- 
Thank you,
Richard.
