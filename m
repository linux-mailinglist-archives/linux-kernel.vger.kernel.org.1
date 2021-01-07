Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B130F2EC859
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 03:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbhAGCzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 21:55:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726297AbhAGCzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 21:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609988017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RlmE8gtKZ+mcWaD+9WFmA0/MsQMlwlKVF0NW+mmjFVw=;
        b=OuV2WIhq2mZv0LigIWvtiAocbZc0Yh8q9NW/ukpNiW0lZ/0oeaJ6qsuydZu6mf/RwpTCvf
        yq9W6kGqUlNdF26WnvOLGSFWbfmBJlqKsqrMM/1clDpsWAn0DZDen53P24H7wjmLavrjOZ
        n5Li7t4zmhutqMYtVnv0I8/E4U2wDBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-iUQ3oHCiO2OS24FN5zkMfw-1; Wed, 06 Jan 2021 21:53:34 -0500
X-MC-Unique: iUQ3oHCiO2OS24FN5zkMfw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE128180A094;
        Thu,  7 Jan 2021 02:53:32 +0000 (UTC)
Received: from localhost (ovpn-12-191.pek2.redhat.com [10.72.12.191])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE5C752791;
        Thu,  7 Jan 2021 02:53:31 +0000 (UTC)
Date:   Thu, 7 Jan 2021 10:53:28 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Hui Su <sh_def@163.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/memcontrol: fix warning in mem_cgroup_page_lruvec()
Message-ID: <20210107025328.GB4820@MiWiFi-R3L-srv>
References: <alpine.LSU.2.11.2101032056260.1093@eggly.anvils>
 <20210106064935.GA3338@MiWiFi-R3L-srv>
 <20210106113531.6f327d37eff78e4e1bb0e13a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106113531.6f327d37eff78e4e1bb0e13a@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/21 at 11:35am, Andrew Morton wrote:
> On Wed, 6 Jan 2021 14:49:35 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > > Fixes: 9a1ac2288cf1 ("mm/memcontrol:rewrite mem_cgroup_page_lruvec()")
> > 
> > ...
> >
> > Thanks for fixing this. We also encountered this issue in kdump kernel
> > with the mainline 5.10 kernel since 'cgroup_disable=memory' is added.
> 
> Wait.  9a1ac2288cf1 isn't present in 5.10?
> 

Yes, just checked, commit 9a1ac2288cf1 was merged in 5.11-rc1, not in
5.10.0. Seems Redhat CKI doesn't treat the kernel release correctly, it
calls all kernel 5.11-rcx as 5.10.0. Sorry for the confusion, I will
send mail to them to change this.

I got the failure report from redhat's CKI test, the kernel repo is as
below, but the subject of failure report and 'uname -r' told it's
5.10.0.

       Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
            Commit: 58cf05f597b0 - Merge tag 'sound-fix-5.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound

