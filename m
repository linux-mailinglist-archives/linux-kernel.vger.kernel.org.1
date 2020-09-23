Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3480D275966
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgIWOHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWOHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:07:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6709DC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 07:07:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600870061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7QRDlukRA7yINm4qIoOt4IW4nSKnDDsIjzp9cyHmjnk=;
        b=WAEvpikMQawF612x9tBsCcPS7TDrSMJaBbL4j/EFWojoDpXaPgwlPu/uJcdD1NQXp7REXD
        eKz8lPwnymM+OizwY276XbxMzW4/ZMP0/uhGpkTDVDRtPlxECJrfGU8mVI2hcfOLxVG9Hi
        J0UfLrFsKOXsbe6nOMvuTMEkERasQtD4gQvrT99PwVWZ4cJebfvyrsGrz8OySVdQV+pIlt
        iLdRSrP8HRJ0dDyMSBJm+v2ehrAF/vLMqTROsYLhSVttOXLcCx3P8PPZilop9AHimj3J4m
        Oi1w8L5McJwHmD8k/7XaskFvonmdmT+7z4bQEL1AhK/quarkq9SjLBs3Dw945Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600870061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7QRDlukRA7yINm4qIoOt4IW4nSKnDDsIjzp9cyHmjnk=;
        b=JZB4H91oOiCSzxk6JKiBaLLoZhkH4Zu5uIfao4CkdUhnQ8idbUPNaAlCWXQamBvPkFEST5
        GX2jb1KuOEhUCdCA==
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com
Subject: Re: [PATCH 6/9] sched: Massage set_cpus_allowed
In-Reply-To: <20200921163845.706308927@infradead.org>
References: <20200921163557.234036895@infradead.org> <20200921163845.706308927@infradead.org>
Date:   Wed, 23 Sep 2020 16:07:40 +0200
Message-ID: <87ft78a8nn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21 2020 at 18:36, Peter Zijlstra wrote:
> @@ -1899,7 +1900,9 @@ extern void update_group_capacity(struct
>  
>  extern void trigger_load_balance(struct rq *rq);
>  
> -extern void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask);
> +#define SCA_CHECK		0x01
> +

needs to move out of the CONFIG_SMP ifdef as it's used even on UP.

Thanks,

        tglx
