Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519302781E6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgIYHpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:45:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:51176 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgIYHpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:45:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601019922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w4IZtChfnmFV3JATmUmxGNM4D36/NyaZqDrcAMFzUV4=;
        b=lqn8ID2FpPLUbzun3FNca8qgk7JY+/jzKltfYgVEaEJcsxr056QL65OYhah+XftaXMtrd7
        k+YOfFJmNhIwhz0PEbjZ9w1EmDIrh95kTD7RIFK3IgQ8EaJBaPFE9POaexHNTV9+PDogGN
        /jwX5uaRiEBaIMLJ0tIeQkzKcZnq2DU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 019B5AF54;
        Fri, 25 Sep 2020 07:45:22 +0000 (UTC)
Date:   Fri, 25 Sep 2020 09:45:18 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vijay Balakrishna <vijayb@linux.microsoft.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allen Pais <apais@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [v3 1/2] mm: khugepaged: recalculate min_free_kbytes after
 memory hotplug as expected by khugepaged
Message-ID: <20200925074518.GB3389@dhcp22.suse.cz>
References: <1600305709-2319-1-git-send-email-vijayb@linux.microsoft.com>
 <1600305709-2319-2-git-send-email-vijayb@linux.microsoft.com>
 <4adef7e1-039f-0ef6-1231-5522a43e4095@linux.microsoft.com>
 <20200924195103.8d6cc9fcd60802baef3107c6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924195103.8d6cc9fcd60802baef3107c6@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24-09-20 19:51:03, Andrew Morton wrote:
> On Wed, 23 Sep 2020 14:27:30 -0700 Vijay Balakrishna <vijayb@linux.microsoft.com> wrote:
> 
> > Can this patch be included?  As Kirill is ok with patch now.
> 
> He is?  I can't immediately find that email.

http://lkml.kernel.org/r/20200922070726.dlw24lf3wd3p2ias@black.fi.intel.com
-- 
Michal Hocko
SUSE Labs
