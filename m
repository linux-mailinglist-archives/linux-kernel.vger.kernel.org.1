Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6382684EA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 08:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgINGcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 02:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgINGcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 02:32:01 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCE0C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 23:31:59 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 58D5FC009; Mon, 14 Sep 2020 08:31:58 +0200 (CEST)
Date:   Mon, 14 Sep 2020 08:31:43 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jianyong Wu <jianyong.wu@arm.com>
Cc:     lucho@ionkov.net, justin.he@arm.com, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Greg Kurz <groug@kaod.org>
Subject: Re: [V9fs-developer] [PATCH RFC 4/4] 9p: fix race issue in fid
 contention.
Message-ID: <20200914063143.GA19326@nautica>
References: <20200914033754.29188-1-jianyong.wu@arm.com>
 <20200914033754.29188-5-jianyong.wu@arm.com>
 <20200914055535.GA30672@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200914055535.GA30672@nautica>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominique Martinet wrote on Mon, Sep 14, 2020:
> Jianyong Wu wrote on Mon, Sep 14, 2020:
>  - Ideally base yourself of my 9p-test branch to have async clunk:
> https://github.com/martinetd/linux/commits/9p-test
> I've been promising to push it to next this week™ for a couple of weeks
> but if something is based on it I won't be able to delay this much
> longer, it'll get pushed to 5.10 cycle anyway.
> (I'll resend the patches to be clean)
>
>> tests:
>> race issue test from the old test case:
>> for file in {01..50}; do touch f.${file}; done
>> seq 1 1000 | xargs -n 1 -P 50 -I{} cat f.* > /dev/null

hmpf, so that made me insist a bit on this test on my patch and I see
a problem with that as well. The me from a few years ago was good!

With that said I'll want to work a bit more on this, so feel free to
base off master and I'll deal with rebase if required.

Part of me thinks it's the same bug that will be fixed with refcounting
and I just made it easier to hit, but I'm honestly unsure at this point
and testing would basically mean I just code what I asked you to...

Well, let me know if you want me to do the refcounting, but I'd rather
let you finish what you started. If possible put the patch first in the
series so commits can be tested independently.


Thanks,
-- 
Dominique
