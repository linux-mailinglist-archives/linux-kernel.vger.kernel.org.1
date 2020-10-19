Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63212922CB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 09:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgJSHGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 03:06:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:60640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbgJSHGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 03:06:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603091211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cZoc8etLME1TcrchebfctJW/RG6gpIbgrhS4J7nrH+g=;
        b=MOLs08/jyBYO0a8WqiloLXgfVyXyoZierMjNWwvdlcmN77l6XFYgA7MYYyDvuTGsswptlF
        N3u5xlF8itd5qQzYmVyxYlt3AaTgjmHqfyz/ZQZXhtGM4U7oEICAlcwHJaA+MFWE6Z0haC
        QvZ+pe7dZthbQ3cQf/K/B0OwnCAavCQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C15E4B8FC;
        Mon, 19 Oct 2020 07:06:50 +0000 (UTC)
Date:   Mon, 19 Oct 2020 09:06:44 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Tianxianting <tian.xianting@h3c.com>
Cc:     "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH] mm: Make allocator take care of memoryless numa node
Message-ID: <20201019070644.GB27114@dhcp22.suse.cz>
References: <20201012082739.15661-1-tian.xianting@h3c.com>
 <20201012150554.GE29725@dhcp22.suse.cz>
 <10ae851702e346369db44e1ec9c830fb@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10ae851702e346369db44e1ec9c830fb@h3c.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 18-10-20 14:18:37, Tianxianting wrote:
> Thanks for the comments
> I found in current code, there are two places to call
> local_memory_node(node) before calling kzalloc_node(), I think we can
> remove them?

I am not sure which code you are talking about. git grep shows me 2
places in blk-mq code (e.g. bffed457160ab) and that looks quite bogus to
me. Bring that up with the respective maintainer and Raghavendra.
The changelog doesn't really describe any problem, if there is any. But
from the allocator semantic point of view memory less nodes are to be
expected and the allocator should fallback to the proper node. As long
as __GFP_THISNODE is not enforced of course.
-- 
Michal Hocko
SUSE Labs
