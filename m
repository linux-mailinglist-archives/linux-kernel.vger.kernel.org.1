Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF112D000C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 02:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgLFBS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 20:18:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26600 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725920AbgLFBS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 20:18:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607217452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3oBqs4Sgc/+zmOSMdRU+JqaQfvk0jsHxfKMItF61nLE=;
        b=GaUDoh/xT6x2dw0AlwqpPV1sah6kWMsNMnTTwh6LOV7MhBPoOwbQeYHZdfqMGTa0sR6i5Q
        E07J1SgT7jbC6HAzu8Ww43YtWbGUvgM7T2PBol7rD1BLdm3Jg1fERTSmQXFAHV9DTQdJ6F
        YLylRbp78BKqP4Xsi51axNhRHgjcPZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-ROCizOzXNCOZBB4dPv2IRg-1; Sat, 05 Dec 2020 20:17:30 -0500
X-MC-Unique: ROCizOzXNCOZBB4dPv2IRg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 436691005504;
        Sun,  6 Dec 2020 01:17:28 +0000 (UTC)
Received: from ovpn-66-5.rdu2.redhat.com (unknown [10.10.67.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4E4D5C1A1;
        Sun,  6 Dec 2020 01:17:18 +0000 (UTC)
Message-ID: <665aeda20e06c7f21224a48a42044112d59b3754.camel@redhat.com>
Subject: Re: [PATCH v4 11/19] sched/core: Make migrate disable and CPU
 hotplug cooperative
From:   Qian Cai <qcai@redhat.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Date:   Sat, 05 Dec 2020 20:17:18 -0500
In-Reply-To: <jhjwnxwt7zh.mognet@arm.com>
References: <20201023101158.088940906@infradead.org>
         <20201023102347.067278757@infradead.org>
         <ff62e3ee994efb3620177bf7b19fab16f4866845.camel@redhat.com>
         <jhjpn4bwznx.mognet@arm.com>
         <c2c013282faf278ee6e0fc66deefbab165ff4e88.camel@redhat.com>
         <jhjwnxwt7zh.mognet@arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-12-05 at 18:37 +0000, Valentin Schneider wrote:
> From there I see:
> 
> [20798.166987][  T650] CPU127 nr_running=2
> [20798.171185][  T650]  p=migration/127
> [20798.175161][  T650]  p=kworker/127:1
> 
> so this might be another workqueue hurdle. This should be prevented by:
> 
>   06249738a41a ("workqueue: Manually break affinity on hotplug")

Well, since it was reproduced on the latest linux-next which has already
included the commit.

> Note that much earlier in your log, you have a softlockup on CPU127:
> 
> [   74.278367][  C127] watchdog: BUG: soft lockup - CPU#127 stuck for 23s!
> [swapper/0:1]

That's something separate. It was there all the time.

https://lore.kernel.org/linux-acpi/20200929183444.25079-1-cai@redhat.com/

