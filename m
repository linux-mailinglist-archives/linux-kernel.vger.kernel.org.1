Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D649D2FECF6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731132AbhAUOeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:34:11 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:35545 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbhAUOdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:33:37 -0500
Received: by mail-lj1-f180.google.com with SMTP id p13so2727249ljg.2;
        Thu, 21 Jan 2021 06:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:to:cc:references:from:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=APW156g847GApT5w4zwnqo1cY8IWq1gEgYTuU+r1B+I=;
        b=feU/wbc9lE5lD5dBv+Krx9tth3LUkl+rdVckS8dRVCFoiUN6maRW8zmTtnaAsdvj62
         QANqKnIQKON9+oExL9rxp1BlhQhmmLqfB/VN0HVL8xoo0PC3f5TjuaZurID16TAweafT
         6aZh/LsYy2hCPPtLtWoIRq71JKA5/qoOR4FATBcAjwgx5PP/fOi/1kug/C9nBBzpLF1i
         ds0Bg68B/lkCKXAJisDthG21o/d0aU4ZJFjByDA9qHoswBqLS6L2PRO8a6EUgmyJ7blI
         JDiqZnD2V4BJaCBurXLIw8sIfIPLwAO5MzzJtU4i9H3FhFlx94n2a7Kpp2gyKdfg3xYq
         DfRw==
X-Gm-Message-State: AOAM530sFTO+fv1Tn/jy5tb3O2Ci71lqX+uU+CzAxpX464zgWPPJFaSS
        MDfkiIUpFxwtXc34uIt1UoPCoAvwn78=
X-Google-Smtp-Source: ABdhPJzibql/N2jqZ9Ae9+ulUhlOJtia8NssNCW5luj8xFPlSeUaIBgM/gExQy/3nyo/TAYtJ0oMzw==
X-Received: by 2002:a2e:b896:: with SMTP id r22mr6140648ljp.234.1611239442732;
        Thu, 21 Jan 2021 06:30:42 -0800 (PST)
Received: from [10.68.32.148] (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.gmail.com with ESMTPSA id f21sm548520lfe.6.2021.01.21.06.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 06:30:42 -0800 (PST)
Reply-To: efremov@linux.com
To:     Gaurav Kohli <gkohli@codeaurora.org>, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        stable@vger.kernel.org
References: <1601976833-24377-1-git-send-email-gkohli@codeaurora.org>
From:   Denis Efremov <efremov@linux.com>
Subject: Re: [PATCH v1] trace: Fix race in trace_open and buffer resize call
Message-ID: <f06efd7b-c7b5-85c9-1a0e-6bb865111ede@linux.com>
Date:   Thu, 21 Jan 2021 17:30:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1601976833-24377-1-git-send-email-gkohli@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch (CVE-2020-27825) was tagged with
Fixes: b23d7a5f4a07a ("ring-buffer: speed up buffer resets by avoiding synchronize_rcu for each CPU")

I'm not an expert here but it seems like b23d7a5f4a07a only refactored
ring_buffer_reset_cpu() by introducing reset_disabled_cpu_buffer() without
significant changes. Hence, mutex_lock(&buffer->mutex)/mutex_unlock(&buffer->mutex)
can be backported further than b23d7a5f4a07a~ and to all LTS kernels. Is
b23d7a5f4a07a the actual cause of the bug?

Thanks,
Denis

On 10/6/20 12:33 PM, Gaurav Kohli wrote:
> Below race can come, if trace_open and resize of
> cpu buffer is running parallely on different cpus
> CPUX                                CPUY
> 				    ring_buffer_resize
> 				    atomic_read(&buffer->resize_disabled)
> tracing_open
> tracing_reset_online_cpus
> ring_buffer_reset_cpu
> rb_reset_cpu
> 				    rb_update_pages
> 				    remove/insert pages
> resetting pointer
> 
> This race can cause data abort or some times infinte loop in
> rb_remove_pages and rb_insert_pages while checking pages
> for sanity.
> 
> Take buffer lock to fix this.
> 
> Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>
> Cc: stable@vger.kernel.org
> ---
> Changes since v0:
>   -Addressed Steven's review comments.
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 93ef0ab..15bf28b 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -4866,6 +4866,9 @@ void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu)
>  	if (!cpumask_test_cpu(cpu, buffer->cpumask))
>  		return;
>  
> +	/* prevent another thread from changing buffer sizes */
> +	mutex_lock(&buffer->mutex);
> +
>  	atomic_inc(&cpu_buffer->resize_disabled);
>  	atomic_inc(&cpu_buffer->record_disabled);
>  
> @@ -4876,6 +4879,8 @@ void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu)
>  
>  	atomic_dec(&cpu_buffer->record_disabled);
>  	atomic_dec(&cpu_buffer->resize_disabled);
> +
> +	mutex_unlock(&buffer->mutex);
>  }
>  EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
>  
> @@ -4889,6 +4894,9 @@ void ring_buffer_reset_online_cpus(struct trace_buffer *buffer)
>  	struct ring_buffer_per_cpu *cpu_buffer;
>  	int cpu;
>  
> +	/* prevent another thread from changing buffer sizes */
> +	mutex_lock(&buffer->mutex);
> +
>  	for_each_online_buffer_cpu(buffer, cpu) {
>  		cpu_buffer = buffer->buffers[cpu];
>  
> @@ -4907,6 +4915,8 @@ void ring_buffer_reset_online_cpus(struct trace_buffer *buffer)
>  		atomic_dec(&cpu_buffer->record_disabled);
>  		atomic_dec(&cpu_buffer->resize_disabled);
>  	}
> +
> +	mutex_unlock(&buffer->mutex);
>  }
>  
>  /**
> 
