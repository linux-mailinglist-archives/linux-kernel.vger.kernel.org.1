Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C24429067F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408385AbgJPNpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:45:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:37418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408215AbgJPNo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:44:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602855897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oJzTVfxC1T+cdhkKfW+N+P+KAqQPZlXHhvLRm/Sh2UM=;
        b=scgYfHVyt8AM1Sy5FfasCZEUnUJnECD6w/I3XOY2ZvFbjfNtH+S7wf+Kz8j/VFdPN5ut+0
        gTVfziLVOyud9RZIHpaYfYxUmSWgeJkBSPSfxJenfX+hKh6LDRUu7O7b1afLOEBPhWtEWs
        xQFkFvsPhJ+907P0V/kucUabBO+L0zI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7C89B2D2;
        Fri, 16 Oct 2020 13:44:57 +0000 (UTC)
Date:   Fri, 16 Oct 2020 15:44:57 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Tianxianting <tian.xianting@h3c.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: vmscan: avoid a unnecessary reschedule in
 shrink_slab()
Message-ID: <20201016134457.GM22589@dhcp22.suse.cz>
References: <20201016033952.1924-1-tian.xianting@h3c.com>
 <20201016120749.GG22589@dhcp22.suse.cz>
 <9a2b772b13f84bdd9517b17d8d72aa89@h3c.com>
 <20201016130208.GI22589@dhcp22.suse.cz>
 <8a25eacf4b37460897911ade338754d3@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a25eacf4b37460897911ade338754d3@h3c.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-10-20 13:20:41, Tianxianting wrote:
> Thanks
> I understood what you said :)
> But whether it is proper to check reschedule in every loop when lock is taken? 

I do not see any actual problem TBH. cond_resched is mostly to increase
interactivity for non preemptible kernel. It can reduce throughput but
this is a memory reclaim path and I do not expect this to contribute to
any moderate hot paths. Direct reclaim doesn't really count as a hot
path.

-- 
Michal Hocko
SUSE Labs
