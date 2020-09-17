Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D145726D7ED
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 11:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgIQJns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 05:43:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:51076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgIQJno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 05:43:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=cantorsusede;
        t=1600334886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FwWPfDrCUnyxcQdgYg+FPBsfaE9zUa4R5PcsOTmxFv0=;
        b=uDVPRbCTaT2ftWuX3z/pI91Ujj/KU81C6J+sJrjB76TgxMowwvIvDoGcOKnBh+m6WgWpVU
        ahcO5bV1L36LwHmXl6ORgjJSei2fFH910gSSW8nrjihGG8+r0+4dNKFklBq1SvWzoPXwKu
        EBl6Wu0B8WsqJ9G1q89QlgVua4fzN+yaFm54ZZSsNG0JZ2aGD9Id7hDs3BKHTjivGhwVsY
        AW1GBdfnPnHiodblOy5bUsTw1U6EoWtW8dqc4MuDyKjplzHknGldlaR+hXTTzMfw3dmGZt
        UBg0a2Y0x03WGg/A2dJslKFRp0+2aMigR1RhkarOECIPmMI13RSWU21GDvJq9g==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D2576AFEC;
        Thu, 17 Sep 2020 09:28:39 +0000 (UTC)
Date:   Thu, 17 Sep 2020 11:28:05 +0200
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
Message-ID: <20200917092805.GA29887@dhcp22.suse.cz>
References: <1600324779-6782-1-git-send-email-vijayb@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600324779-6782-1-git-send-email-vijayb@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-09-20 23:39:39, Vijay Balakrishna wrote:
> set_recommended_min_free_kbytes need to honor min_free_kbytes set by the
> user.  Post start-of-day THP enable or memory hotplug operations can
> lose user specified min_free_kbytes, in particular when it is higher than
> calculated recommended value.

I was about to recommend a more detailed explanation when I have
realized that this patch is not really needed after all. Unless I am
missing something.

init_per_zone_wmark_min ignores the newly calculated min_free_kbytes if
it is lower than user_min_free_kbytes. So calculated min_free_kbytes >=
user_min_free_kbytes.

Except for value clamping when the value is reduced and this likely
needs fixing. But set_recommended_min_free_kbytes should be fine.
-- 
Michal Hocko
SUSE Labs
