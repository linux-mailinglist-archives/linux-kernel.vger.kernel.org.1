Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5DF2E69FF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 19:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgL1S3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 13:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbgL1S3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 13:29:22 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D77C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 10:28:42 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g185so177258wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 10:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mjW3/q0lVCljlllJ6ZMktDcPybhk2GgzF/uSDg3ACeg=;
        b=pL9krZSpTJDehyFTt0OC3FZqPWGpSDJf+d4XLJmNFoA3BT7EMrugYBT6uLayv0Gnqq
         jQtz6Nd8Y+kbjPx7+8h788NxynFA+0SCGiNrSAYXUT216PJ8DqMFI047MYxrNPVEzYMR
         GlvTcRJ8vNH+WkiZHRrj66KawJTJbs2Ecj/rq7EjPQtBF1DxA90VS9pZ46NvkzJjk1j4
         Trvu/SdgzqGMWrxzeqCK2Ve3HCqf6IAi6eXlFnN6i1lo3IgUKGAqoNXIJ7VZ2jDlrvRs
         PHowQBhpt+0z7C/HJrxATT/rSemtLuWYHONa2/fcC/cVHMQ5DdEGiReOQ7kf8OPPVLGw
         LNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mjW3/q0lVCljlllJ6ZMktDcPybhk2GgzF/uSDg3ACeg=;
        b=IDO6OQynM6GKqKiKw+1LWO1C5TLfcz+Mi2+Ee/h/idSeEyMr07x0mB13Tm3JHVCAAB
         8YidWB74VYqKsJobYD+DT/NVgVLMivAet2LeilTZGzTDroA67/wxmQCS9vqfSkx8i7AK
         IOKBT5GFah3KCVDTWtG1xpMu4exYxVJH69Cksm/b+tJ9jnFYjHnJKsCsQhZhX+YLcNVp
         Vi7lapbu2xDmg5lJx6wnMXI1yJ91rEzgz/XM8VK8h1gz6wGeB/I8ng1Gz8QDM6epfkzM
         rmztoNS3VeFrYfcGr+IQK+RRRVBhs+zzxXb1pmAFzL0NjDYbfZpjilhAomPTjXDYWP0G
         r7eA==
X-Gm-Message-State: AOAM533wuJjL3bgDAmx5aZpAMjyRJH95MU6N+rFh1HTP+um2S2SBz+YM
        Uj5xW/Jjh/0IZbBQQc3W4Q==
X-Google-Smtp-Source: ABdhPJxmB56KJx0kSILOSB/Pbmd15HsvVb4tjufU7iawRO1BS+eDDG5KQKwkRxfiw3+X/zrX4WhtlA==
X-Received: by 2002:a1c:43c6:: with SMTP id q189mr157379wma.7.1609180121012;
        Mon, 28 Dec 2020 10:28:41 -0800 (PST)
Received: from localhost.localdomain ([46.53.251.87])
        by smtp.gmail.com with ESMTPSA id t10sm55130108wrp.39.2020.12.28.10.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 10:28:40 -0800 (PST)
Date:   Mon, 28 Dec 2020 21:28:38 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, deller@gmx.de
Subject: Re: +
 proc-wchan-use-printk-format-instead-of-lookup_symbol_name-fix.patch added
 to -mm tree
Message-ID: <20201228182838.GA38914@localhost.localdomain>
References: <20201223021834.9n93L%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201223021834.9n93L%akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 06:18:34PM -0800, akpm@linux-foundation.org wrote:
>
>      proc-wchan-use-printk-format-instead-of-lookup_symbol_name-fix.patch

> --- a/fs/proc/base.c~proc-wchan-use-printk-format-instead-of-lookup_symbol_name-fix
> +++ a/fs/proc/base.c
> @@ -384,15 +384,8 @@ static const struct file_operations proc
>  static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
>  			  struct pid *pid, struct task_struct *task)
>  {
> -	unsigned long wchan;
> -
>  	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
> -		wchan = get_wchan(task);
> -	else
> -		wchan = 0;
> -
> -	if (wchan)
> -		seq_printf(m, "%ps", (void *) wchan);
> +		seq_printf(m, "%ps", (void *)get_wchan(task));
>  	else
>  		seq_putc(m, '0');

These patches change '0' to '0x0'.

Also /proc/*/wchan shows '0' for everything which is strange.

I'm not sure if we should care as wchan is obsoleted by /proc/*/stack .
