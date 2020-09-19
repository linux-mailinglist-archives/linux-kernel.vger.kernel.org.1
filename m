Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BA4270BD3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 10:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgISI0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 04:26:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:56284 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgISI0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 04:26:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E5FC1ADA2;
        Sat, 19 Sep 2020 08:27:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 19 Sep 2020 10:26:38 +0200
From:   osalvador@suse.de
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, mhocko@kernel.org, mike.kravetz@oracle.com,
        tony.luck@intel.com, david@redhat.com,
        aneesh.kumar@linux.vnet.ibm.com, zeil@yandex-team.ru, cai@lca.pw,
        nao.horiguchi@gmail.com, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/12] mm,hwpoison: Rework soft offline for in-use
 pages
In-Reply-To: <20200918172359.e862562a7ad22e92388ce218@linux-foundation.org>
References: <20200806184923.7007-1-nao.horiguchi@gmail.com>
 <20200806184923.7007-9-nao.horiguchi@gmail.com>
 <7e948108488864b6d9131d990d5f6c80@suse.de>
 <20200918172359.e862562a7ad22e92388ce218@linux-foundation.org>
User-Agent: Roundcube Webmail
Message-ID: <a313bd619b2782e71fdb15087c50310f@suse.de>
X-Sender: osalvador@suse.de
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-19 02:23, Andrew Morton wrote:
> On Fri, 18 Sep 2020 09:58:22 +0200 osalvador@suse.de wrote:
> 
>> I just found out yesterday that the patchset Naoya sent has diverged
>> from mine in some aspects that lead to some bugs [1].
>> This was due to a misunderstanding so no blame here.
>> So, patch#8 and patch#9 need a little tweak [2].
>> 
>> I was wondering what do you prefer?
> 
> Well.  I (and I suspect the rest of the world) have lost track of
> what's going on here.
> 
> So please let's have a full resend of the whole series?

Sure, I will resend a new version squeezing  all changes into it on 
Monday.

