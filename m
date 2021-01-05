Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA602EA629
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 08:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbhAEHvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 02:51:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:41940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbhAEHvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 02:51:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609833029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zN1ZQptkDr2Sx20lZHpIUYbZZweZ0jHrozA2d7eEC+c=;
        b=EPW3hX0CHvyETxVQ+oZKb2FjUUWU1c6cS30QrikW+VmFz1wBFlbSlKVUeXjGw2U+864x01
        jpK6IoTPuN1gR5ftY4QdElRbV2wI/xy4Lxupa69QEUDRWtVTmxGEsJzk3tn3A+/Ibyeagu
        Sioj6pFN6/sJP4frdYjP14ZOKNjwChk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 72744ACAF;
        Tue,  5 Jan 2021 07:50:29 +0000 (UTC)
Date:   Tue, 5 Jan 2021 08:50:28 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: uninitialized pmem struct pages
Message-ID: <20210105075028.GS13207@dhcp22.suse.cz>
References: <20210104100323.GC13207@dhcp22.suse.cz>
 <033e1cd6-9762-5de6-3e88-47d3038fda7f@redhat.com>
 <CAPcyv4h6mdKrwpqXfO0e_=sKjB-pY5KbP9ii+tQyFsK5bPkb=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h6mdKrwpqXfO0e_=sKjB-pY5KbP9ii+tQyFsK5bPkb=A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04-01-21 21:17:43, Dan Williams wrote:
> On Mon, Jan 4, 2021 at 2:45 AM David Hildenbrand <david@redhat.com> wrote:
[...]
> > I believe Dan mentioned somewhere that he wants to see a real instance
> > of this producing a BUG before actually moving forward with a fix. I
> > might be wrong.
> 
> I think I'm missing an argument for the user-visible effects of the
> "Bad." statements above. I think soft_offline_page() is a candidate
> for a local fix because mm/memory-failure.c already has a significant
> amount of page-type specific knowledge. So teaching it "yes" for
> MEMORY_DEVICE_PRIVATE-ZONE_DEVICE and "no" for other ZONE_DEVICE seems
> ok to me.

I believe we do not want to teach _every_ pfn walker about zone device
pages. This would be quite error prone. Especially when a missig check
could lead to a silently broken data or BUG_ON with debugging enabled
(which is not the case for many production users). Or are we talking
about different bugs here?
-- 
Michal Hocko
SUSE Labs
