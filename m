Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817D828D4CF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 21:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbgJMTmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 15:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729221AbgJMTl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 15:41:57 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1CBC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 12:41:57 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l18so351721pgg.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 12:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=gmYq+uYWoMDaYz8nXexSWVs/u/6+4ydcWzNjxfPB2d4=;
        b=FICocnetZtgJIJcbLZYrFAFtO3AInGRhMhGutVFbukqmYQJIIf/bmOcS+xuDoU7aZM
         AJ3Hc9agk86uaCQCl0eafZrCn9k7CRQzXefVEnVRMkhJIPx50uAdSQICjrHhzKeDSl+m
         v0oUPJeHdPQ0G+PqRey6IZLqZNi0F4ZV1czac22bTGeER5YPvOJZCv2PRje7OSTHJPpn
         37NKrB7emcbfV2vwyEFcvNm23cQ5cRiIvJRonZqy3yBChJMiibtSympcS0GYU5S8EbuO
         MpVtIa6h0VyeFN6vt8MSQDmZuruTZJnxdTjYjMQwfhyXabcENJNNIt2I7DokRM6jySoX
         DS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=gmYq+uYWoMDaYz8nXexSWVs/u/6+4ydcWzNjxfPB2d4=;
        b=jDDwFVMhu+wXdwx86gR09ukHhYcDL0B2k0ZslDCksEhWKKKzgXjWC9UNvvVRicwC9J
         Ols1V4bxBDTqXkkSJzed3sYyQIG7vg3PWBvTcIOHmrtsoKtNul6NOPPHB+zg2XKJm3QH
         V5NQGkwiOPF2/ZoZgV0WJXX3Z2p0v679mh96ChNIoI14CcvDja62MODWXkPEkSk1LQn5
         kg4axrIG3c3EWiCGFtzIi8GrxDcG2yiVvWm7SqVafQVhdzlXSBiVIOYcsz/WmVbRUP6x
         ZryRBxsN1KrjHie7ylj9BSOMITuh2YzwjtQ2MtawXEqAHiZlRzmVFRlSCrc0TrQO/IEB
         NHdw==
X-Gm-Message-State: AOAM530/upTCC9j9zJYLfrg1//iwoV9YJNrgmU3TikfD0pWXGim3U1Mi
        P4uo93KtKtZJIEZp5eQrWObGow==
X-Google-Smtp-Source: ABdhPJw7IX/0EU1/lRDVU4SMAE1BbP4RHZmBX3ss69w7WvrR6CEEi/ON6NBFiE3no9Crf8Pxj2nZYQ==
X-Received: by 2002:a62:830c:0:b029:152:3490:c8e6 with SMTP id h12-20020a62830c0000b02901523490c8e6mr1114061pfe.6.1602618116420;
        Tue, 13 Oct 2020 12:41:56 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id g17sm451245pfu.130.2020.10.13.12.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 12:41:55 -0700 (PDT)
Date:   Tue, 13 Oct 2020 12:41:54 -0700 (PDT)
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
Subject: Re: [PATCH v3 1/2] tracing: support "bool" type in synthetic trace
 events
In-Reply-To: <20201009220524.485102-2-axelrasmussen@google.com>
Message-ID: <alpine.DEB.2.23.453.2010131241400.2883230@chino.kir.corp.google.com>
References: <20201009220524.485102-1-axelrasmussen@google.com> <20201009220524.485102-2-axelrasmussen@google.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Oct 2020, Axel Rasmussen wrote:

> It's common [1] to define tracepoint fields as "bool" when they contain
> a true / false value. Currently, defining a synthetic event with a
> "bool" field yields EINVAL. It's possible to work around this by using
> e.g. u8 (assuming sizeof(bool) is 1, and bool is unsigned; if either of
> these properties don't match, you get EINVAL [2]).
> 
> Supporting "bool" explicitly makes hooking this up easier and more
> portable for userspace.
> 
> [1]: grep -r "bool" include/trace/events/
> [2]: check_synth_field() in kernel/trace/trace_events_hist.c
> 
> Acked-by: Michel Lespinasse <walken@google.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: David Rientjes <rientjes@google.com>
