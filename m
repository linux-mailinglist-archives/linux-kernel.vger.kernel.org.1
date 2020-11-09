Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374D42AC00E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 16:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbgKIPjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 10:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729658AbgKIPjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 10:39:37 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087A0C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 07:39:37 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id g11so4897337pll.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 07:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VzY1hjUfAc6GKStaIwRVGn/GJgL4dhk/7nsRnJXrCMQ=;
        b=bdMxPQw/a1HFaqKUHUJOjpWmnGfObjuyHg3vqLsChRMyZCc0xd8WlMn0alLnGwwmoJ
         hFKAcPgMf62pzGTyUEoweIpqlv7RqSxvVGJEu/sTpVbn19yDYa+5N8YMoEIaFFENpaSY
         NDheeAJAswLF8QD0pBRjGRa0DtI5qlY81KF1g73vaMhaWDg7lXncwct3Gg1riqlN0h2Y
         ilpNad9b/BV1FOlSHSfMfiEsK6LzeywPdzbGiEWlU2rmERnDMqJNt7Ffv8vNX6I9eLdX
         YSIwvbEogKdb18WGHqhFR5uuLHBitZJu/jDftHgboQajmAKsWTMgBWMVNm+UP8oFaGsO
         qZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=VzY1hjUfAc6GKStaIwRVGn/GJgL4dhk/7nsRnJXrCMQ=;
        b=lCF5toncYcfCmvdFsG+Vq0ev3YYVnOiDTpR3HazJIHSRotr2Q3sc5BfUahERL1kHJ2
         NqSXq6kdY4KikClAI0W9HHIbiO3SVVA0oerJAiAX5Sl+VgZjQ6Wg/gNjbElmcVqfDyn1
         fd+61bsYDQeElraGLiCgLFSS8A8zJatuJPj7jqKrMn7lfuldwrobFQ4ZBOkVyE7vL+uT
         t7ps//aal/X490QnSyDwDCPLbSJCT9/GUfUa62Lem07EfZ6GUGVJ8Lw1PzPDNXHWCZS7
         LM3oCQes8tQvOFPgDYpd3IBA2ON6lRVzRCru8RZOmDJAFzhq6zbLG8CFc+nvvJQRqG/Y
         zt2w==
X-Gm-Message-State: AOAM530R0IVKSHl9mrKpCDSq4/E/eY1xBNlWwBmznj9AnPpZyAU51rE6
        GK5k408k9AExgwFl7RRIzgJu+HpbNjY=
X-Google-Smtp-Source: ABdhPJwoHWyxKnfYVEVZ8gwkXHNZBtYvGhW9WbvhHURsi/7lCWGxELpqEmF0jppDFWS7+BtgyruOUw==
X-Received: by 2002:a17:902:8f83:b029:d7:ec99:d2fd with SMTP id z3-20020a1709028f83b02900d7ec99d2fdmr1470629plo.17.1604936376507;
        Mon, 09 Nov 2020 07:39:36 -0800 (PST)
Received: from google.com (c-67-188-94-199.hsd1.ca.comcast.net. [67.188.94.199])
        by smtp.gmail.com with ESMTPSA id l190sm11270280pfl.205.2020.11.09.07.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 07:39:35 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 9 Nov 2020 07:39:33 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: introduce oom_kill_disable sysctl knob
Message-ID: <20201109153933.GA449970@google.com>
References: <20201106203238.1375577-1-minchan@kernel.org>
 <20201109073706.GA12240@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109073706.GA12240@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 08:37:06AM +0100, Michal Hocko wrote:
> On Fri 06-11-20 12:32:38, Minchan Kim wrote:
> > It's hard to have some tests to be supposed to work under heavy
> > memory pressure(e.g., injecting some memory hogger) because
> > out-of-memory killer easily kicks out one of processes so system
> > is broken or system loses the memory pressure state since it has
> > plenty of free memory soon so.
> 
> I do not follow the reasoning here. So you want to test for a close to
> no memory available situation and the oom killer stands in the way
> because it puts a relief?

Yub, technically, I'd like to have consistent memory pressure to cause
direct reclaims on proesses on the system and swapping in/out.

> 
> > Even though we could mark existing process's oom_adj to -1000,
> > it couldn't cover upcoming processes to be forked for the job.
> 
> Why?

Thing is the system has out-of-control processes created on demand.
so only option to prevent OOM is echo -1000 > `pidof the process`
since they are forked. However, I have no idea when they are forked
so should race with OOM with /proc polling and OOM is frequently
ahead of me.

> 
> > This knob is handy to keep system memory pressure.
> 
> This sounds like a very dubious reason to introduce a knob to cripple
> the system.
> 
> I can see some reason to control the oom handling policy because the
> effect of the oom killer is really disruptive but a global on/off switch
> sounds like a too coarse interface. Really what kind of production
> environment would ever go with oom killer disabled completely?

I don't think shipping production system will use it. It would be
just testing only option.
My intention uses such heavy memory load to see various system behaviors
before the production launching because it usually happens in real workload
once we shipped but hard to generate such a corner case without artificial
memory pressure.

Any suggestion?
