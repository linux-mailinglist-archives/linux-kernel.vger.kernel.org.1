Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37BF2E9559
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 13:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbhADM4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 07:56:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:54460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbhADM4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 07:56:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609764956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=msIW88wK00DoAnz9CIDN560ghwz+bPy+u/wMPHdrQPA=;
        b=JccxXLpGBLoGDL28F8aGR/x0pglghkevXPipC+8umQI1PkJEXYxdzOYoAjVCActmCw3KDG
        wAg4gMgIhGwbNtAqqTo/lYC00eLNaTb5SUafFV0fKu4BpLjNRl3GpenCkL4mw9kVGUcc0e
        HQMsEDaQVMonsKFIqbcJLa5S7u/N7xU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4ED38AFEF;
        Mon,  4 Jan 2021 12:55:56 +0000 (UTC)
Date:   Mon, 4 Jan 2021 13:55:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Liang Li <liliang.opensource@gmail.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Liang Li <liliangleo@didiglobal.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [RFC v2 PATCH 0/4] speed up page allocation for __GFP_ZERO
Message-ID: <20210104125554.GE13207@dhcp22.suse.cz>
References: <20201221162519.GA22504@open-light-1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221162519.GA22504@open-light-1.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-12-20 11:25:22, Liang Li wrote:
[...]
> Security
> ========
> This is a weak version of "introduce init_on_alloc=1 and init_on_free=1
> boot options", which zero out page in a asynchronous way. For users can't
> tolerate the impaction of 'init_on_alloc=1' or 'init_on_free=1' brings,
> this feauture provide another choice.

Most of the usecases are about the start up time imporvemtns IIUC. Have
you tried to use init_on_free or this would be prohibitive for your
workloads?

-- 
Michal Hocko
SUSE Labs
