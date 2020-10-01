Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090A028015B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbgJAOeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732020AbgJAOeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:34:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A01EC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 07:34:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601562846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S2QJoOtmDGQzFB97c2AzQDjXDpD1raiskue/FiVYfiE=;
        b=3esHQL+tHM8nDhoyx1bpdnF7ZAjhA78Qhmv2gRNe2D4tCYlHemhs751sgaMvKClU8gQwn4
        PBfB7q5ffXz536Nl+mPlB5IBsDTF0wWEi4nkxPAOUHJsxlpJt0Pyo6fUzeyIQYDl9Js0sG
        WFLnAAAgKRWZDMtc+wkNjvHJcWmjKeuoSZuMDJXwZ9bOpwUoLTZAzFpYglkwFCOAAm23s7
        Hnk7q5XxG/lhVD3QLNY3Rqm0DPGlWYPapk8jlw9uipmo7DpOJqOjp6K6zZ1iLZj4JCCymj
        Av0D78lHTI0gz097SirV1FSbup9V6OBCjbZvxz3og0QngF9rMM5EgHkSsvqgpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601562846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S2QJoOtmDGQzFB97c2AzQDjXDpD1raiskue/FiVYfiE=;
        b=zmeYKySxCZHRtHWboCBvPa+JxZC9XhZ6QKJATYHV2tydVYzVPTUvHzV70Q0pNPVjZ4LBq/
        vLRUMJ+juz7R0YAg==
To:     Qianli Zhao <zhaoqianligood@gmail.com>, axboe@kernel.dk,
        akpm@linux-foundation.org, Felix.Kuehling@amd.com, sboyd@kernel.org
Cc:     john.stultz@linaro.org, ben.dooks@codethink.co.uk,
        bfields@redhat.com, cl@rock-chips.com,
        linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
Subject: Re: [PATCH v5] kthread: Add debugobject support
In-Reply-To: <7a7af0e893e3ceb0d8d1f055bffca1d47025d7ba.1597645588.git.zhaoqianli@xiaomi.com>
References: <7a7af0e893e3ceb0d8d1f055bffca1d47025d7ba.1597645588.git.zhaoqianli@xiaomi.com>
Date:   Thu, 01 Oct 2020 16:34:06 +0200
Message-ID: <87a6x6f21t.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17 2020 at 14:37, Qianli Zhao wrote:
> From: Qianli Zhao <zhaoqianli@xiaomi.com>
>
> Add debugobject support to track the life time of kthread_work
> which is used to detect reinitialization/free active object problems
> Add kthread_init_work_onstack()/kthread_init_delayed_work_onstack() for
> kthread onstack support
>
> If we reinitialize a kthread_work that has been activated,
> this will cause delayed_work_list/work_list corruption.
> enable this config,there is an chance to fixup these errors
> or WARNING the wrong use of kthread_work
>
> [30858.395766] list_del corruption. next->prev should be ffffffe388ebbf88, but was ffffffe388ebb588
> [30858.395788] WARNING: CPU: 2 PID: 387 at kernel/msm-4.19/lib/list_debug.c:56 __list_del_entry_valid+0xc8/0xd0
> ...
> [30858.395906] Call trace:
> [30858.395909]  __list_del_entry_valid+0xc8/0xd0
> [30858.395912]  __kthread_cancel_work_sync+0x98/0x138
> [30858.395915]  kthread_cancel_delayed_work_sync+0x10/0x20
> [30858.395917]  sde_encoder_resource_control+0xe8/0x12c0
> [30858.395920]  sde_encoder_prepare_for_kickoff+0x5dc/0x2008
> [30858.395923]  sde_crtc_commit_kickoff+0x280/0x890
> [30858.395925]  sde_kms_commit+0x16c/0x278
> [30858.395928]  complete_commit+0x3c4/0x760
> [30858.395931]  _msm_drm_commit_work_cb+0xec/0x1e0
> [30858.395933]  kthread_worker_fn+0xf8/0x190
> [30858.395935]  kthread+0x118/0x128
> [30858.395938]  ret_from_fork+0x10/0x18
>
> crash> struct kthread_worker.delayed_work_list 0xffffffe3893925f0
>  [ffffffe389392620] delayed_work_list = {
>     next = 0xffffffe388ebbf88,
>     prev = 0xffffffe388ebb588
>   }
> crash> list 0xffffffe388ebbf88
> ffffffe388ebbf88

This changelog is confusing at best. Something like this perhaps?

  kthread_work is not covered by debug objects, but the same problems as with
  regular work objects apply.

  Some of the issues like reinitialization of an active kthread_work are hard
  to debug because the problem manifests itself later in a completely
  different context.

  Add debugobject support along with the necessary fixup functions to make
  debugging of these problems less tedious. 

> +static void stub_kthread_work(struct kthread_work *unuse)

unused?

> +{
> +	WARN_ON(1);
> +}
>  void kthread_flush_work(struct kthread_work *work)
>  {
>  	struct kthread_flush_work fwork = {
> -		KTHREAD_WORK_INIT(fwork.work, kthread_flush_work_fn),
> -		COMPLETION_INITIALIZER_ONSTACK(fwork.done),
> +		.done = COMPLETION_INITIALIZER_ONSTACK(fwork.done),

Eew. Why is the completion initialized seperately instead of being
initialized as part of kthread_init_work_onstack() ?

>  	};
>  	struct kthread_worker *worker;
>  	bool noop = false;
>  
> +	debug_kwork_assert_init(work);
>  	worker = work->worker;
>  	if (!worker)
>  		return;
>  
> +	kthread_init_work_onstack(&fwork.work, kthread_flush_work_fn);
>  
> @@ -1194,12 +1319,13 @@ EXPORT_SYMBOL_GPL(kthread_cancel_delayed_work_sync);
>  void kthread_flush_worker(struct kthread_worker *worker)
>  {
>  	struct kthread_flush_work fwork = {
> -		KTHREAD_WORK_INIT(fwork.work, kthread_flush_work_fn),
> -		COMPLETION_INITIALIZER_ONSTACK(fwork.done),
> +		.done = COMPLETION_INITIALIZER_ONSTACK(fwork.done),
>  	};

Ditto.
  
> +	kthread_init_work_onstack(&fwork.work, kthread_flush_work_fn);
>  	kthread_queue_work(worker, &fwork.work);
>  	wait_for_completion(&fwork.done);
> +	destroy_kwork_on_stack(&fwork.work);

Thanks,

        tglx
