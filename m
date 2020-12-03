Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C562CDA2E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 16:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbgLCPhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 10:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgLCPhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 10:37:25 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC75C061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 07:36:45 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id dm12so1124167qvb.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 07:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LBBArEA3xlqMeYxNBtq8/0wDXI6qatH3Q3aO6jvxWvM=;
        b=uG4D2Ki5mZSGa25UaIvO2cacx8Zs99UUrD/Kl1mOL98VlwyopZo+tZwgX09aLkl6yI
         624z7Pd996dYFq8J9MMCVAMA3EPPi2HDhjUDobYcccufuGUYCIFEGzl5NLxI+LNWWGq+
         PtQ5LvLu+tC75HxQtdCivuoic2h5Hw5TQQHGQz28YN1RNMxSqZ6IWan7khBPFhUuHyax
         afMTpNNSEbuDrfEHrdpOOUHEQSsbYdTREP5kP4vC+iLw0IRO+Z+LGUcMC7lSBb8BEb56
         MUBbXC7Wwhu4nPWmXTIPwIeIF4JIS7BY4Lb0zrQA/d6O+p7wpsbapvF7AVSrU8wOs9rB
         pdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=LBBArEA3xlqMeYxNBtq8/0wDXI6qatH3Q3aO6jvxWvM=;
        b=KL0GdgeyKKDBYwHi2dcGeNAQ72emjO8fzuY5eweKzbavrMOKqZIloEdUPjrCbF2h7W
         G4LOdzWaN/12+ssf2OuYWv3FSu9DZZpaYfIxcwbWyShY56znGq5MAscdUF0NZvCZdrrM
         X/srkz+/6AnmqkAnrT+FluMpeYGK9saK6mOFPH7RsMe1MOLEbBYuculVbf+mS2qUYEKy
         jmx+AdSavxFEHhnegSzt98RXEr1dncv09ykhJ3cCOxGNw3ucjp8erlHEbtLfgwkzZKk8
         G2e4sMJcV3ZRLrKu9VLBelz+NXWpV/8cnDoI/uaM7KO1qGbI2VjZxriXFQ+I4bwRnYTJ
         BwUA==
X-Gm-Message-State: AOAM533PZYADW6TSqI5ZwNd+kd3351ybJZNPKl8QXe+pkgjZNcnWP9pC
        ZcEzhFqCp/7uXnF1incSevw=
X-Google-Smtp-Source: ABdhPJzj5p50QKuHUvlezC7Gcn5V9KpOBMPN4ah6UZE9xk8aLTwpPMLrhVU8lDMZVNE2G3RkqJvvnA==
X-Received: by 2002:a0c:db11:: with SMTP id d17mr3629590qvk.39.1607009804360;
        Thu, 03 Dec 2020 07:36:44 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id g18sm1458290qtv.79.2020.12.03.07.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 07:36:43 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 3 Dec 2020 10:36:14 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     NeilBrown <neilb@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] workqueue: cut wq_rr_cpu_last
Message-ID: <X8kF7h0836Eu717u@mtj.duckdns.org>
References: <20201203102841.2100-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203102841.2100-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Dec 03, 2020 at 06:28:41PM +0800, Hillf Danton wrote:
> +	new_cpu = cpumask_any_and_distribute(wq_unbound_cpumask, cpu_online_mask);
> +	if (new_cpu < nr_cpu_ids)
> +		return new_cpu;
> +	else
> +		return cpu;
>  }
>  
>  static void __queue_work(int cpu, struct workqueue_struct *wq,
> @@ -1554,7 +1546,7 @@ static int workqueue_select_cpu_near(int
>  		return cpu;
>  
>  	/* Use "random" otherwise know as "first" online CPU of node */
> -	cpu = cpumask_any_and(cpumask_of_node(node), cpu_online_mask);
> +	cpu = cpumask_any_and_distribute(cpumask_of_node(node), cpu_online_mask);

This looks generally okay but I think there's a real risk of different
cpumasks interfering with cpu selection. e.g. imagine a cpu issuing work
items to two unbound workqueues consecutively, one numa-bound, the other
not. The above change will basically confine the !numa one to the numa node.

I think the right thing to do here is expanding the
cpumask_any_and_distribute() so that the user can provide its own cursor
similar to what we do with ratelimits.

Thanks.

-- 
tejun
