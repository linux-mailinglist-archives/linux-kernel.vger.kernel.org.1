Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9E92C2B43
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 16:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389738AbgKXP1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 10:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389371AbgKXP1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 10:27:43 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6E4C061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 07:27:43 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id h20so2108219qkk.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 07:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T1CJlj8IfSUUHiH+kqtPsU00jQAk/4cxU5HTLWgky3g=;
        b=JFbStEBIKWinwRehV0dG/qoEhAWyKvWiQAcUNmzhgCFsSOHXJxkNEFj0egRb0/3Sgg
         q8KlbvBm+SZWA8+kLS4QAKx1VMbVvr9WwqryXOZ+nR5L7jF7I75raMadKItlGdyFsXV4
         MAXLlg4J8SGJkJn/ndQd+F10zISr9GtcWt18YmMODwZOvgxHvEGGMFMb6q7Mcm+Our5Z
         cA7l+b63IFHl9JGoL794bcoTHGTctqQrHW9IfKnfgdMLNCdJzkdZSjFqFgZqy0gdO73i
         CG3TfNm0Q2N/eDAytp9pIzHdFBlHhU6va67BpY6PFvFMeeVBU9lbourS+JouXuxSIthE
         vQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T1CJlj8IfSUUHiH+kqtPsU00jQAk/4cxU5HTLWgky3g=;
        b=J5TEOwDYwAZCtRe+5baX0US2d5iGFAv3zmWbXE2NBbZRSlYBRJWyhrDTECHsQCW/od
         +1deM5lF6VrAqzQjOsibAzWq5J+hws6JKEnkFuClrfJKXr7TOXZE++Nsto5nMlQjWZdE
         tZsOadG4dGuhmA1CSDUPr/fi2K0niAfdV1ShXARKadrfwZ+Q83yQ57noC7MfQC26PKyS
         uA81Zau37GQ3Db7qodQO1VUXkfQ+tDpglLNCX/zJP2d6rfMaHFFN9QRXw1OwHf53NTp1
         UQ/AZBFEAmivfLNMMBYsUcm6YuoTkRedQp3iNLMbNL7gDFpAQU5SOULeYE/7LlmAULI5
         wBOw==
X-Gm-Message-State: AOAM531zR0CQU2CrOTGzGPTi030y+sW77BRfgMd+namjW2EN6bruklZ5
        2NWSH6DTs1m/pjCHWsOTVxVmjw==
X-Google-Smtp-Source: ABdhPJwWUvdVx1Vqxqge3kQRlk8iWNcGxBL9lgm9oszusQZMiFgHGeM23mQSdnOTIDE/+Anp4R5TCw==
X-Received: by 2002:a05:620a:404d:: with SMTP id i13mr758647qko.279.1606231662613;
        Tue, 24 Nov 2020 07:27:42 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id y23sm13290051qkb.26.2020.11.24.07.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 07:27:40 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1khaEF-000ogj-SX; Tue, 24 Nov 2020 11:27:39 -0400
Date:   Tue, 24 Nov 2020 11:27:39 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michel Lespinasse <walken@google.com>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dave Chinner <david@fromorbit.com>, Qian Cai <cai@lca.pw>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/3] mm: Extract might_alloc() debug check
Message-ID: <20201124152739.GF5487@ziepe.ca>
References: <20201120095445.1195585-1-daniel.vetter@ffwll.ch>
 <20201120095445.1195585-3-daniel.vetter@ffwll.ch>
 <20201120180719.GO244516@ziepe.ca>
 <20201124143411.GN401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124143411.GN401619@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 03:34:11PM +0100, Daniel Vetter wrote:
> On Fri, Nov 20, 2020 at 02:07:19PM -0400, Jason Gunthorpe wrote:
> > On Fri, Nov 20, 2020 at 10:54:43AM +0100, Daniel Vetter wrote:
> > > diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> > > index d5ece7a9a403..f94405d43fd1 100644
> > > +++ b/include/linux/sched/mm.h
> > > @@ -180,6 +180,22 @@ static inline void fs_reclaim_acquire(gfp_t gfp_mask) { }
> > >  static inline void fs_reclaim_release(gfp_t gfp_mask) { }
> > >  #endif
> > >  
> > > +/**
> > > + * might_alloc - Marks possible allocation sites
> > > + * @gfp_mask: gfp_t flags that would be use to allocate
> > > + *
> > > + * Similar to might_sleep() and other annotations this can be used in functions
> > > + * that might allocate, but often dont. Compiles to nothing without
> > > + * CONFIG_LOCKDEP. Includes a conditional might_sleep() if @gfp allows blocking.
> > > + */
> > > +static inline void might_alloc(gfp_t gfp_mask)
> > > +{
> > > +	fs_reclaim_acquire(gfp_mask);
> > > +	fs_reclaim_release(gfp_mask);
> > > +
> > > +	might_sleep_if(gfpflags_allow_blocking(gfp_mask));
> > > +}
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > Oh, I just had a another thread with Matt about xarray, this would be
> > perfect to add before xas_nomem():
> 
> Yeah I think there's plenty of places where this will be useful. Want to
> slap a sob onto this diff so I can include it for the next round, or will
> you or Matt send this out when my might_alloc has landed?

When this is merged I can do this - just wanted to point out the API
is good and useful

Jason
