Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24862C6B97
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 19:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgK0S26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 13:28:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50779 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726206AbgK0S26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 13:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606501736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IkTWFBcwzu++e32mVL/RpzVs2QrFeazS4AUMu9HErZY=;
        b=BCCowTKtaCA0sD+tNTjXrruIDMJcFttKDwYKg3THA0cULx/WliW5lqJv9WazkCURkdByj+
        zDfuLqJloBTfwoHZ9+HjrPNpSGKCS5bYdObwgX8du+zSSm7kd4zzqxFa02ByJMgZSJsukG
        tPeOgluIK525dy9Y37fMR861T69/dd4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-C_4hSPciP0yo7vlDYBgI5g-1; Fri, 27 Nov 2020 13:28:55 -0500
X-MC-Unique: C_4hSPciP0yo7vlDYBgI5g-1
Received: by mail-qv1-f72.google.com with SMTP id b9so3500575qvj.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 10:28:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IkTWFBcwzu++e32mVL/RpzVs2QrFeazS4AUMu9HErZY=;
        b=jvUkfk8T5BGw5bA150dJaEUuo2TJ97u3CJFA316mq6cjidFbDdrc70Utj0at0SSazi
         uAYbpGupy3EWFnCyAw/i1rAs5WwDnkmS/lsIqYKwVPdF8zvli6eVhcEIbbaD8cMjTCZA
         r5xcITBToW/reI1Zbi5juVOPuEqtWfhSgrERBAZJKeRWmIul/tW1lJrMjrNyKILMUf71
         4WF8ejfLkYJ6/UPf9A2vdLn6eHoz8VzSoqegLujiJy/5GtC0lDEuO7mEc9P9sQwrk7Jz
         hv7a4vjnzgvlUa/B9sjK/BbWoPryA4b0eCkCtnAGqQOPz75oedC84ByhDcIutBmVnlp5
         7Rbw==
X-Gm-Message-State: AOAM532zBVoTjg7iHzWAX8WlQJBFlZehKjCOzWw/LcvHIXetO5lmlPNr
        yR6Qc0irWScSAKeEdUjCHLxlBqD+YVtexiov5wCZRUaF06py2eDoppqCu9/bS00L4eTU5nlZcYA
        8Oh5XvX7cMNcWlanD1CsVrQLk
X-Received: by 2002:a05:620a:138b:: with SMTP id k11mr9580957qki.323.1606501734993;
        Fri, 27 Nov 2020 10:28:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxiTlY2LZgRMrMpgD+MszQsFGQ6n1ceQEGLtfgWBy4aXST/poBhhxcqqxiBbbWEeKBStW1gRg==
X-Received: by 2002:a05:620a:138b:: with SMTP id k11mr9580932qki.323.1606501734692;
        Fri, 27 Nov 2020 10:28:54 -0800 (PST)
Received: from xz-x1 ([142.126.81.247])
        by smtp.gmail.com with ESMTPSA id v28sm6533054qkj.103.2020.11.27.10.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 10:28:53 -0800 (PST)
Date:   Fri, 27 Nov 2020 13:28:52 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH] mm: Don't fault around userfaultfd-registered regions on
 reads
Message-ID: <20201127182852.GD6573@xz-x1>
References: <20201126222359.8120-1-peterx@redhat.com>
 <a240da04-1446-9282-c250-00507b745744@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a240da04-1446-9282-c250-00507b745744@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 06:00:44PM +0100, David Hildenbrand wrote:
> On 26.11.20 23:23, Peter Xu wrote:
> > Faulting around for reads are in most cases helpful for the performance so that
> > continuous memory accesses may avoid another trip of page fault.  However it
> > may not always work as expected.
> > 
> > For example, userfaultfd registered regions may not be the best candidate for
> > pre-faults around the reads.
> 
> Are we getting uffd faults even though no-one actually accessed it?

Userfaultfd should only notify if someone accessed it.

> So in case I would track what some part of my program actually reads, I
> would get wrong notifications?

For shmem, we can't track it right now, afaict.  The message will only generate
if the page cache is not there.

While tracking page reads without page cache is helpless.. because they're all
zeros.

Thanks,

-- 
Peter Xu

