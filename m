Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887812B7FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 15:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgKROou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 09:44:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24627 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726306AbgKROot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 09:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605710688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YmxyhTdWNlkE/cIxG1YVUOv6A3OxAK7WsSp8uPLWUVg=;
        b=g7lMBbv9CS9GVBQ0FEkHhWLc1TRN2sw8twGW8ZvjsjTmzBTN9q6LlzpcdwhN+VxEQNfYZS
        dlSOOf88s5kNwot2Y0oyY8pRSoTOngC5o6pzzH3eLuTsdNDmtUZ5Cya1K4EotJvhwdgrSk
        a/Cen1zSX9Qly4wdAGb8YW4WwxomVyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-uukPLlPLObe4B95_nFsnug-1; Wed, 18 Nov 2020 09:44:46 -0500
X-MC-Unique: uukPLlPLObe4B95_nFsnug-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BC3610051BC;
        Wed, 18 Nov 2020 14:44:44 +0000 (UTC)
Received: from ovpn-66-242.rdu2.redhat.com (ovpn-66-242.rdu2.redhat.com [10.10.66.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A6845C1A3;
        Wed, 18 Nov 2020 14:44:35 +0000 (UTC)
Message-ID: <dda3b8f67a23dd60d36e5325dbb0c406be18e1db.camel@redhat.com>
Subject: Re: [PATCH v4 11/19] sched/core: Make migrate disable and CPU
 hotplug cooperative
From:   Qian Cai <cai@redhat.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Date:   Wed, 18 Nov 2020 09:44:34 -0500
In-Reply-To: <jhjpn4bwznx.mognet@arm.com>
References: <20201023101158.088940906@infradead.org>
         <20201023102347.067278757@infradead.org>
         <ff62e3ee994efb3620177bf7b19fab16f4866845.camel@redhat.com>
         <jhjpn4bwznx.mognet@arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-11-17 at 19:28 +0000, Valentin Schneider wrote:
> We did have some breakage in that area, but all the holes I was aware of
> have been plugged. What would help here is to see which tasks are still
> queued on that outgoing CPU, and their recent activity.
> 
> Something like
> - ftrace_dump_on_oops on your kernel cmdline
> - trace-cmd start -e 'sched:*'
>  <start the test here>
> 
> ought to do it. Then you can paste the (tail of the) ftrace dump.
> 
> I also had this laying around, which may or may not be of some help:

Once I have found a reliable reproducer, I'll report back.

