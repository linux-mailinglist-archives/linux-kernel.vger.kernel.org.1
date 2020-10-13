Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED6628D4D0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 21:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbgJMTmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 15:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgJMTmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 15:42:17 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CABC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 12:42:17 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id e7so417390pfn.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 12:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=5mrvqvMIaVx8YdFnVM8H9lrWw2mwZ5lC/eqzeoAO6ng=;
        b=ZMgcmjHlkYwfdx37LKAjX3+FOPNj5GtQEEj01BxtRkZGZXvC5cOBVQiRrw6rbtZdc3
         NDFQJrXR6KsTEtAnlY98eUCnEXSAYEV3aeDpHTzNmdJ8HlwPzvGKDP/M1RXhjCKoLtRb
         z8r8DCS78XwrdBHHCSAQ8LIXPEHKmwMffhT0UAyA1nFhWEaRXzdAR66UDDSThGzDhD3c
         janb150NhTM9My5elFPfRqO3pJWQDZQYFiCQmOQDxNvV9zkm4c7MBcPrav47ph8ydRDH
         mIMbCubwp0IzZrm6UGzOjiSouMCDBNc4ucVnyNTZyfEdzROQSgK0W3jUuM9WBEvtBNGM
         GtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=5mrvqvMIaVx8YdFnVM8H9lrWw2mwZ5lC/eqzeoAO6ng=;
        b=j4PIets3Fvk7o8Lyfn5RkLkSky/wgJJJet5rSRQGSsVF+sw1LX0t9Z9lXKGh9jFqjh
         nSpzKQTyNxdMrQbjoi1UM93fXXjRX9I94ABPZMOiMIxWGY3t6TNZAgs8WhC2O0P/els0
         x7Ar0xcsYbgFouQrTq3VFWFIHTLglSD9mLxAQqagLZpD8mi63GvV8WAnuP40uSCAdTFg
         6h7Iuv+w/02/CA1Y6ucIrd/y8uCco05OeBkX8Fm4v+otGzVuwhO0klvPBI5q8s4Pbr+Z
         D28kqcGYmukQnVrbP8DVPfMEMgYy04N3yLDumABaF3JkK3eHeMR/M9VB9qaUg8hp+lir
         YrZQ==
X-Gm-Message-State: AOAM532J6xOQR55qXW55Ye7eLMl+0X+zskgwbnhb87nis6frxLr3dO2c
        7iQus5fDgyXsgH0T4QsTriAIwg==
X-Google-Smtp-Source: ABdhPJwjagE9zWmgTakngcSQaS0UasG+EVCQ8vyFq2nEZtdDJjqIwPbNUPENFBELqAX+4T0bnM7MIw==
X-Received: by 2002:a62:5b81:0:b029:156:2dce:5aa with SMTP id p123-20020a625b810000b02901562dce05aamr1171241pfb.15.1602618136899;
        Tue, 13 Oct 2020 12:42:16 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id f9sm737237pjq.26.2020.10.13.12.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 12:42:16 -0700 (PDT)
Date:   Tue, 13 Oct 2020 12:42:15 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Axel Rasmussen <axelrasmussen@google.com>
cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/2] mmap_lock: add tracepoints around lock
 acquisition
In-Reply-To: <20201009220524.485102-3-axelrasmussen@google.com>
Message-ID: <alpine.DEB.2.23.453.2010131242010.2883230@chino.kir.corp.google.com>
References: <20201009220524.485102-1-axelrasmussen@google.com> <20201009220524.485102-3-axelrasmussen@google.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Oct 2020, Axel Rasmussen wrote:

> The goal of these tracepoints is to be able to debug lock contention
> issues. This lock is acquired on most (all?) mmap / munmap / page fault
> operations, so a multi-threaded process which does a lot of these can
> experience significant contention.
> 
> We trace just before we start acquisition, when the acquisition returns
> (whether it succeeded or not), and when the lock is released (or
> downgraded). The events are broken out by lock type (read / write).
> 
> The events are also broken out by memcg path. For container-based
> workloads, users often think of several processes in a memcg as a single
> logical "task", so collecting statistics at this level is useful.
> 
> The end goal is to get latency information. This isn't directly included
> in the trace events. Instead, users are expected to compute the time
> between "start locking" and "acquire returned", using e.g. synthetic
> events or BPF. The benefit we get from this is simpler code.
> 
> Because we use tracepoint_enabled() to decide whether or not to trace,
> this patch has effectively no overhead unless tracepoints are enabled at
> runtime. If tracepoints are enabled, there is a performance impact, but
> how much depends on exactly what e.g. the BPF program does.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: David Rientjes <rientjes@google.com>
