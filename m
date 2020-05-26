Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBE01C8863
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 13:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgEGLe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 07:34:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27994 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726134AbgEGLez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588851293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eqvOBlgVIEs8Gtl6xmPaDqDCYhUqYo/jU6Ly/l67Miw=;
        b=b9sh/ViF78+Ie46oAG+ViNrAHkq3LfepixJ868NikyxEJx9prhfy5G/jL61eqAmY8lHOnS
        zWUmG/eWAgKOpoR6p/gCJkXuVRpew/J9P0uokIO+yEy5FYfXxWuF1b2cEtv5ZsbmqULaaE
        bIvkFLcK8Q1Z8dpaBJGllST9SuLTvas=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-zG1G9_l1NoGEbcG7BpyymQ-1; Thu, 07 May 2020 07:34:52 -0400
X-MC-Unique: zG1G9_l1NoGEbcG7BpyymQ-1
Received: by mail-wm1-f69.google.com with SMTP id o26so2480051wmh.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 04:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eqvOBlgVIEs8Gtl6xmPaDqDCYhUqYo/jU6Ly/l67Miw=;
        b=dLSI3T/vNWtKIRWHssazKsxd079W8S5/dPdOMU0XSnXq2m5RqyMGzs+k62f+guC3d8
         14+zJEP1iBpBdaJE+g9fkRQTQH6MM226GT7TdOuuuHdlOd4/5DM48sfD4/VO2hnr+Cjj
         X+vSeBhCb6Talvw/8k+uUTOlOCQh1V0ZEhLUeAgddOw9JMW31HALFCOIiNMUkyp44XkZ
         fmdJnEPrAy+2NsV6kHfMi/SH0aK+AVe985BaQPPIxrCuoz4Ybvmxtluiq9LlZvMhXVpO
         /MMF8Csm4ElddDU1O5l/yupgoTK8aE2QXklEnTkVqIkvCsZXKEIu7+HsQTQ9apT92I5X
         s5FQ==
X-Gm-Message-State: AGi0PubOBmXJVT1BCrD3411EctEXH8gRX2Bi6SKWAQ/dl+dEz5+lyDfL
        0XKBMkd/k6KyA0ko9dc+f7zg12V1Q5Tl9PHkDrDHxEwB1R5obiGOGbIg5bDfblx6Gg6N5gPmRF3
        wiLjP1QlezNeX4PgAk9JYLEWD
X-Received: by 2002:a1c:e910:: with SMTP id q16mr396242wmc.158.1588851290758;
        Thu, 07 May 2020 04:34:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypIEJon7vaENbs1OmaRUfHXUhggPEYtcAd12YfpgMWFk8LZpYJx8EDfrRw7rVSkow6cjB/BCLg==
X-Received: by 2002:a1c:e910:: with SMTP id q16mr396213wmc.158.1588851290530;
        Thu, 07 May 2020 04:34:50 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id k4sm3182951wmf.41.2020.05.07.04.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 04:34:49 -0700 (PDT)
Date:   Thu, 7 May 2020 07:34:45 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v3 07/15] mm/memory_hotplug: Introduce
 offline_and_remove_memory()
Message-ID: <20200507073408-mutt-send-email-mst@kernel.org>
References: <20200507103119.11219-1-david@redhat.com>
 <20200507103119.11219-8-david@redhat.com>
 <20200507064558-mutt-send-email-mst@kernel.org>
 <a915653f-232e-aa13-68f7-f988704fa84c@redhat.com>
 <441bfb92-ecfa-f54e-3661-b219ea166e55@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441bfb92-ecfa-f54e-3661-b219ea166e55@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 01:33:23PM +0200, David Hildenbrand wrote:
> >> I get:
> >>
> >> error: sha1 information is lacking or useless (mm/memory_hotplug.c).
> >> error: could not build fake ancestor
> >>
> >> which version is this against? Pls post patches on top of some tag
> >> in Linus' tree if possible.
> > 
> > As the cover states, latest linux-next. To be precise
> > 
> > commit 6b43f715b6379433e8eb30aa9bcc99bd6a585f77 (tag: next-20200507,
> > next/master)
> > Author: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date:   Thu May 7 18:11:31 2020 +1000
> > 
> >     Add linux-next specific files for 20200507
> > 
> 
> The patches seem to apply cleanly on top of
> 
> commit a811c1fa0a02c062555b54651065899437bacdbe (linus/master)
> Merge: b9388959ba50 16f8036086a9
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Wed May 6 20:53:22 2020 -0700
> 
>     Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

Because you have the relevant hashes in your git tree not pruned yet.
Do a new clone and they won't apply.

> 
> I can resend based on that, after giving it a short test.
> 
> -- 
> Thanks,
> 
> David / dhildenb

