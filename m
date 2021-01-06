Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802CC2EC3D1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 20:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbhAFTTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 14:19:20 -0500
Received: from gentwo.org ([3.19.106.255]:56954 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbhAFTTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 14:19:19 -0500
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jan 2021 14:19:19 EST
Received: by gentwo.org (Postfix, from userid 1002)
        id 02B783F551; Wed,  6 Jan 2021 19:09:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 007B53F550;
        Wed,  6 Jan 2021 19:09:25 +0000 (UTC)
Date:   Wed, 6 Jan 2021 19:09:25 +0000 (UTC)
From:   Christoph Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Qian Cai <cai@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC 0/3] mm, slab, slub: remove cpu and memory hotplug locks
In-Reply-To: <20210106174029.12654-1-vbabka@suse.cz>
Message-ID: <alpine.DEB.2.22.394.2101061907330.2652@www.lameter.com>
References: <20210106174029.12654-1-vbabka@suse.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jan 2021, Vlastimil Babka wrote:

> rather accept some wasted memory in scenarios that should be rare anyway (full
> memory hot remove), as we do the same in other contexts already. It's all RFC
> for now, as I might have missed some reason why it's not safe.

Looks good to me. My only concern is the kernel that has hotplug disabled.
Current code allows the online/offline checks to be optimized away.

Can this patch be enhanced to do the same?

