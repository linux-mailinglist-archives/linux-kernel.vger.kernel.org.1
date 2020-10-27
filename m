Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F0B29B1CE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 15:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760326AbgJ0Oej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 10:34:39 -0400
Received: from m12-16.163.com ([220.181.12.16]:34075 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2902442AbgJ0Od0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=ctGoC
        uYGiGfmGEAlz+BN596hi54m6Xj0GmX91XNTnVA=; b=n1GzKZJRRMWNQfFiWShuF
        mgdcXBpnTfmWYdJjzvS1zv7/VUqd5SARAaMJmjNDJZ6zqWtEfdLvlACWkDuGMx43
        HjJJxmAOVMk4CK25hjtOwYNqNcFoF158JWobPHyBWOKF0bQnkuks2XzLtZwMnRfR
        pq0cGj+hdLrT77/CE0xqy0=
Received: from localhost (unknown [101.86.209.121])
        by smtp12 (Coremail) with SMTP id EMCowADnLi+FL5hfIiZqIQ--.63101S2;
        Tue, 27 Oct 2020 22:32:37 +0800 (CST)
Date:   Tue, 27 Oct 2020 22:32:37 +0800
From:   Hui Su <sh_def@163.com>
To:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,oom_kill: fix the comment of is_dump_unreclaim_slabs()
Message-ID: <20201027143237.GA2910@rlk>
References: <20200926041526.GA179745@rlk>
 <20201027071118.GM20500@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027071118.GM20500@dhcp22.suse.cz>
X-CM-TRANSID: EMCowADnLi+FL5hfIiZqIQ--.63101S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF1kGryUJFy3Jw17JFyUGFg_yoWfXwcE9a
        9Fqw1DJrWvga45GayIkrZ5Xa4fGr48Aa48Jw1rWrZxX34YqF4fCrZ7Wrn7X3WDZrWFkrs0
        9FyDW3s8A3sFqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8sZ23UUUUU==
X-Originating-IP: [101.86.209.121]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiIAXKX10TB9ZXxAAAs8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 08:11:18AM +0100, Michal Hocko wrote:
> On Sat 26-09-20 12:15:26, Hui Su wrote:
> > fix the comment of is_dump_unreclaim_slabs(), it just check
> > whether nr_unreclaimable slabs amount is greater than user
> > memory.
> 
> The original comment is meant to say when the function should be used.
> Your update makes the comment makes it a kerneldoc for an internal
> function which on its own is not very useful. It is quite clear what
> the function does. The intention is not clear anymore though.
> 
> If you find the comment confusing, however, then I would just propose either
> dropping it altogether or rename it to should_dump_unreclaimable_slab.
> Which is quite mouthful TBH.
>  

Hi, Michal:

Thanks for your explanation.

I also think maybe we should delete the comment, and change the rename it to
should_dump_unreclaimable_slabs().

Andrew,
Is that ok?

