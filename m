Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A0426D7BC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 11:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgIQJea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 05:34:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:45390 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgIQJeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 05:34:16 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 05:34:15 EDT
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=cantorsusede;
        t=1600335254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YUIHjUHj2KNUMPbEwkFTOw+UMqfbAFdHA56mSK8V/WA=;
        b=uEt0Q+3D/ug0xpI+hk1Rr30foykGdOQy7JITrXnwaNZVcatK2gxFBDdUzrdN+lupywFO6j
        R+fVsrvCkTB0Vj9Xx1h5TA1tMQrWGFTTidjqxCq3EKF4nHld3MpbKlSawzIXxrOgb0/0sK
        W76fkM9cI19wrDGUU0WKHx8fBda9CPOYiIgIYeNx+0XwbdEeOQRT6K/nYrOHu9AWgdp+DK
        B9z3NfJGC6F0LBm8gRJcGPlTVP7jiSMGhCErIToLZnUEKEMSLYAAr96Q6CU70o2Ud93fip
        GSWT1pnAxDoo9mS1DdhDarSTsKeKlAaqu0vYsyRmK+yqEn6MFleb0Qh1JuczIg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 51802B13B;
        Thu, 17 Sep 2020 09:34:48 +0000 (UTC)
Date:   Thu, 17 Sep 2020 11:34:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allen Pais <apais@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [v4] mm: khugepaged: avoid overriding min_free_kbytes set by user
Message-ID: <20200917093413.GB29887@dhcp22.suse.cz>
References: <1600324779-6782-1-git-send-email-vijayb@linux.microsoft.com>
 <20200917092805.GA29887@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917092805.GA29887@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17-09-20 11:28:06, Michal Hocko wrote:
> On Wed 16-09-20 23:39:39, Vijay Balakrishna wrote:
> > set_recommended_min_free_kbytes need to honor min_free_kbytes set by the
> > user.  Post start-of-day THP enable or memory hotplug operations can
> > lose user specified min_free_kbytes, in particular when it is higher than
> > calculated recommended value.
> 
> I was about to recommend a more detailed explanation when I have
> realized that this patch is not really needed after all. Unless I am
> missing something.
> 
> init_per_zone_wmark_min ignores the newly calculated min_free_kbytes if
> it is lower than user_min_free_kbytes. So calculated min_free_kbytes >=
> user_min_free_kbytes.
> 
> Except for value clamping when the value is reduced and this likely
> needs fixing. But set_recommended_min_free_kbytes should be fine.

Something like
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fab5e97dc9ca..69731b19d9bf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7875,9 +7875,9 @@ int __meminit init_per_zone_wmark_min(void)
 	if (new_min_free_kbytes > user_min_free_kbytes) {
 		min_free_kbytes = new_min_free_kbytes;
 		if (min_free_kbytes < 128)
-			min_free_kbytes = 128;
+			min_free_kbytes = max(128, user_min_free_kbytes);
 		if (min_free_kbytes > 262144)
-			min_free_kbytes = 262144;
+			min_free_kbytes = max(262144, user_min_free_kbytes);
 	} else {
 		pr_warn("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
 				new_min_free_kbytes, user_min_free_kbytes);
-- 
Michal Hocko
SUSE Labs
