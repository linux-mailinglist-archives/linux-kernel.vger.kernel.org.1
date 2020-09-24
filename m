Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882DA277A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 22:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgIXU1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 16:27:38 -0400
Received: from mail.efficios.com ([167.114.26.124]:43158 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXU1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:27:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B3E932D8CD5;
        Thu, 24 Sep 2020 16:27:34 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id P6-DlwbzrdhB; Thu, 24 Sep 2020 16:27:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 82C572D8EB7;
        Thu, 24 Sep 2020 16:27:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 82C572D8EB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1600979254;
        bh=VWAAUSy3q2f1VKXG0qi/7cIhdZcmoPgz+peeSW6yLys=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Mb1z+0+bxZk4sbyxiYEgrUriRvJz2OVA3ZEFRSSVxHFQC0N8D/rOIRpAYe0QH1VM8
         JDgYV23ecyfs8hprvXHQ/Zbpp3dqYRiwmcERuy8/r2wJuIhhZlht452CCgepbWSipS
         eYVv1BdIkbmNAYWtuU+WxFxXeVCQhvBRWZC7fo1evroAKnO6pSvgbrCOYaKwEvBd8f
         ptMOZYzc4TzlQd7lxF65TFddNSD0WrjLVIdX6H4nmv+/lesS6DCF2Y0DByiCiPDGaG
         nd8W9WpGuar3tsBtuCgg82yJORYwpgt70bepbWfiHAkHz3R1ShJHthx/VfNVTAL9PI
         MmfZtD1IiynOg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 37zL9rzPIwht; Thu, 24 Sep 2020 16:27:34 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 734432D8CD2;
        Thu, 24 Sep 2020 16:27:34 -0400 (EDT)
Date:   Thu, 24 Sep 2020 16:27:34 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        linux-mm <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Message-ID: <1430794518.69084.1600979254425.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200924161328.760f5e79@oasis.local.home>
References: <20200924170928.466191266@goodmis.org> <20200924171846.993048030@goodmis.org> <2006335081.68212.1600969345189.JavaMail.zimbra@efficios.com> <20200924143025.58dc3c1f@gandalf.local.home> <166273261.68446.1600974510284.JavaMail.zimbra@efficios.com> <20200924153517.73f5f257@oasis.local.home> <221547373.69067.1600977935633.JavaMail.zimbra@efficios.com> <20200924161328.760f5e79@oasis.local.home>
Subject: Re: [PATCH 1/2] tracepoints: Add helper to test if tracepoint is
 enabled in a header
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3965 (ZimbraWebClient - FF80 (Linux)/8.8.15_GA_3963)
Thread-Topic: tracepoints: Add helper to test if tracepoint is enabled in a header
Thread-Index: o2U8/o9Dn5/x/EZln0vPYatbBRgl3g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 24, 2020, at 4:13 PM, rostedt rostedt@goodmis.org wrote:

> On Thu, 24 Sep 2020 16:05:35 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> If headers which happens to be included by include/trace/events/ headers are
>> the issue, and they happen to only be needed by CREATE_TRACE_PROBES, then we
>> should consider wrapping those #include with #ifdef CREATE_TRACE_PROBES guards.
> 
> Well, we are at a point you can't even use preempt_disable().
> 
> Whatever wants to use this tracepoint_enabled() macro, is going to have
> to include something that doesn't include tracepoint.h.

I'd be a bit more specific: so far, the msr.h use-case requires to include
directly tracepoint-defs.h and use a tracepoint_enabled() macro defined there.

Other less "core" header use-cases could still include tracepoint.h, as long as
there is no circular dependency.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
