Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C265298E78
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 14:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780684AbgJZNuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 09:50:18 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33233 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404378AbgJZNuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 09:50:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id j62so6691398qtd.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TxfXjOwfBykntP1Jpf/tQTb6j5RyS9vTmp3y0ZTz9iY=;
        b=hj2Xzb1lS89qCPlK7eJpZN6WVDn7yEvhz2twlUFqiehOWCaTaej0//mbn2FMaBLWIn
         F8DmpTbIeRFOrtl/Okvy7RHEq7WiFTwBo+PePbx+LWTp2YCj4xddlYVuscGpZ3IJ+oG5
         b3UES6VFcG9UeaEmeEa9bqNb87n5yviccl9+PDzNl894xBrHxr5ZNPj92FHGAHIAN8TY
         ooyxG4RgS33cDTqkBXOv0bc2i+LsBV1CkYSOwgTxt0QD7bG3eqnfluHeFkPQfBDRrIBs
         gRLxte4i3wvSPNT3sKqXiR5eJ+1OqAy2afreeXeTYcDBDdHkf0qFclAlhIc3y/aZheQ/
         65TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TxfXjOwfBykntP1Jpf/tQTb6j5RyS9vTmp3y0ZTz9iY=;
        b=iJI8sNtDWNnFl/UhxLhrVZlDLd7fEnDLoGDxV4OY/Hl+c5VBGpkdG/iLXdN0qbjQRa
         RTfOSEvHe0TXmF5iYI27KiDr8b4SpTuiI/U2Kb9iuYO6QWAwSMIRyPnopdUeZadafpBy
         PR/PA9rg9w1vqwb9jgjxD++Ud6IB0GJx4rtX5PwDKq8JqNfdLOENUIVP3GtrELqwniJi
         2h94da/nBz3H6uFjngzP8UYXJrb39k9m9G1CsicV/g5xTkeFLhQejo1PlwuLBs5wVZgn
         MIldqHE2roygieN7EQ/xh710oxPSt0EdU1NVzc4PYkhlMB+pqqBNfN3ObCz+0xiKR3ZA
         jzlw==
X-Gm-Message-State: AOAM532KpkkfcxQQ3ID4tcFgJIlla71CbAc7sES/TgYIdhQzgh4gNdrc
        TLETncapBukAMDv0u6r58ZzWxuI0g128+w==
X-Google-Smtp-Source: ABdhPJxOEtJ6n3AC1FOzURdLuieNu+2Vq5bFekGeLN4FlTYCZJELfdfRy36ovzb2dYtDTXJBwu97mQ==
X-Received: by 2002:aed:31e3:: with SMTP id 90mr1350645qth.300.1603720215250;
        Mon, 26 Oct 2020 06:50:15 -0700 (PDT)
Received: from localhost (dhcp-48-d6-d5-c6-42-27.cpe.echoes.net. [199.96.181.106])
        by smtp.gmail.com with ESMTPSA id b191sm6651842qkg.81.2020.10.26.06.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 06:50:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Oct 2020 09:50:11 -0400
From:   Tejun Heo <tj@kernel.org>
To:     qiang.zhang@windriver.com
Cc:     pmladek@suse.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] kthread_worker: re-set CPU affinities if CPU come online
Message-ID: <20201026135011.GC73258@mtj.duckdns.org>
References: <20201026065213.30477-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026065213.30477-1-qiang.zhang@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 02:52:13PM +0800, qiang.zhang@windriver.com wrote:
> @@ -737,8 +741,11 @@ __kthread_create_worker(int cpu, unsigned int flags,
>  	if (IS_ERR(task))
>  		goto fail_task;
>  
> -	if (cpu >= 0)
> +	if (cpu >= 0) {
>  		kthread_bind(task, cpu);
> +		worker->bind_cpu = cpu;
> +		cpuhp_state_add_instance_nocalls(kworker_online, &worker->cpuhp_node);
> +	}
>  
>  	worker->flags = flags;
>  	worker->task = task;
...
> +static int kworker_cpu_online(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct kthread_worker *worker = hlist_entry(node, struct kthread_worker, cpuhp_node);
> +	struct task_struct *task = worker->task;
> +
> +	if (cpu == worker->bind_cpu)
> +		WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpumask_of(cpu)) < 0);
> +	return 0;
> +}

I don't think this works. The kthread may have changed its binding while
running using set_cpus_allowed_ptr() as you're doing above. Besides, when a
cpu goes offline, the bound kthread can fall back to other cpus but its cpu
mask isn't cleared, is it?

Thanks.

-- 
tejun
