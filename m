Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FEA2DC27A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgLPOvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 09:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLPOvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:51:36 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DDAC06179C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:50:56 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id s6so11417350qvn.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CW7WDALiSasnaXHys4EKilGidvZ239pn/Iq2rOY/qQY=;
        b=KbB274BF+77WWUUSIlTZDNXbeBpvgfrIKVsEvNyxO8G4PbTC/4NvFJb09YERHSErq3
         1D1mUr80qHw1mcqwjpkygZVf4ku9nl7d8TVy6o5yblcNtquNURYErdPZwCxouBjmBa/r
         K91ogAxfgxGhT71cmWzmX5mpUbsRchBIcH61ge5g3wZlFtn4RMlUjJtBMhZU46jG3ZsA
         HsHE+Ps/wu7ESZwz0zpyyUuCwyJJUROZDq7nQSmNO7xgOJdW0/JvqJyvBd8ILq3FUAGm
         OyHowg9+o1b5gJkJnoBYRY+CZ0SZgLfmVZ8q9Y+AkLK7aolgTv3A5mIywVNi7QBY/rNM
         zJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=CW7WDALiSasnaXHys4EKilGidvZ239pn/Iq2rOY/qQY=;
        b=FIUDX6+eJ3Y6Ee1Ze0stWCp7r581GacMPUq7OslgJDNXu83bXTx7V31kShIjmtxkMX
         R75wZ/ASk+Rnnqwy26wyxXFcvgMeP5FecAXqfLI/a59wfZ8ia4UTggHeR37ZCD/YuH1N
         Mhwt72GhwG4LP1i2hBgqkjAtuJincFBtZ8lFLCqnCWwOqooLrPte4Rccg8F5IZaNVDtF
         ZadF7pItcjiSvZ7+afdH8b32tbIXDRXq20+G2uW+NRF1MZbBRs/bge+eo+J6xUT4uBa3
         xC5qOJIgXGB84oHkd4GhvoynUuMwTN5Z8JzPO9HFXtgJNmDX6hKARJbxizm1XIqeq2t+
         LLGA==
X-Gm-Message-State: AOAM531iM7XG+PeeGC9iAnQPZS8mCefOEBgez4cCAhL/bToSwjaHmg2v
        5AE5TXRkZ+z3OW9vRhzBTv8=
X-Google-Smtp-Source: ABdhPJxgMLRnzWVsWKDtI+Gy7Vk0MiHGzVLPSnw0ZvpA3HZ+WOKAQMtmGIewqxI0VPYx5UzRbHSc8w==
X-Received: by 2002:a0c:83e1:: with SMTP id k88mr18077442qva.60.1608130255588;
        Wed, 16 Dec 2020 06:50:55 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:cbde])
        by smtp.gmail.com with ESMTPSA id z26sm1144541qki.40.2020.12.16.06.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:50:54 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 16 Dec 2020 09:50:22 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 07/10] workqueue: Manually break affinity on hotplug for
 unbound pool
Message-ID: <X9oerhmw7/qWWczn@mtj.duckdns.org>
References: <20201214155457.3430-1-jiangshanlai@gmail.com>
 <20201214155457.3430-8-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214155457.3430-8-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 11:54:54PM +0800, Lai Jiangshan wrote:
>   * An unbound pool may end up with a cpumask which doesn't have any online
> - * CPUs.  When a worker of such pool get scheduled, the scheduler resets
> - * its cpus_allowed.  If @cpu is in @pool's cpumask which didn't have any
> - * online CPU before, cpus_allowed of all its workers should be restored.
> + * CPUs.  We have to reset workers' cpus_allowed of such pool.  And we
> + * restore the workers' cpus_allowed when the pool's cpumask has online
> + * CPU at the first time after reset.
          ^
          for the first time

-- 
tejun
