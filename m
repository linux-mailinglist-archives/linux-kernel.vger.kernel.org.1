Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E7E2DC22F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgLPObY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 09:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgLPObY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:31:24 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18CBC06179C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:30:43 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id 143so22612860qke.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qaDzrcpcSTwZW8tytURJAh2eSg1jyIVH/9nK8nDNqDU=;
        b=T1Zr3h4Iq8vWNDTKlJ1EtZlPyKSWSN1243m1QoE2SGB8sg+qzV33NbCQtLAZxopB43
         sfnWoH9nTXqCNcvUePaAWpRk5J86we3mhnhdijN241xCgx/7Cfktp9tCUc/Cg4rvJHXM
         92fH6UHEmMoklxfddTUFqsV+ctn0+hsYxulAzUHxkWao3o7323vDV6XEah1BYTgd2eG7
         jZCE6Wfof2hKquiy8fF9FsPfA+EcjOui+ijmJI+p10LTVUgO4WfWe5nYA3X+9TzVbG2R
         otKkBWk587AZ9gQKnH2vkB2LjWInVoXwWCOhCUJpFezjiJxyBPGvmg90yjdqMwZvF3UZ
         nvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qaDzrcpcSTwZW8tytURJAh2eSg1jyIVH/9nK8nDNqDU=;
        b=sVbBAVbFVYbYw8zS8TJbQhTg5ejkeIDoPHQE0PTdNL3Rx9XSuWVJJvn99QMUXdD+Mf
         sRn+gb0Xq1CB7KbTBEY5thYzBcy+PLNdi+fCaTmWGMBfXTnxjGRv2qt8GTklCbviUyUs
         R+QuXnc5ThUV6rHiL9oP4H+AzHnoNGf8NYN20Cbuv6wRvRQUuWLdBui+8Y14mcyB1zOF
         8vM9gxFkhBJbbWaukPTX3iCxXp52I4lvYFGB+VCyU+sIge4356Z2TVxNUYfhsJGsMUK6
         jN15ePK3GKNRQYnRCVtHVXpj7exY5KCCbYU3qofsad7ry0u3NlF3Osft4dfu7qIsxau3
         rQjw==
X-Gm-Message-State: AOAM531hJQiQeKqVJdX8FJ1yq7+c5m+SfT/jH0odh5uV8xR7Tr4NM2yy
        hWoi3NOKwRU+/PAm1whVMqU=
X-Google-Smtp-Source: ABdhPJyjomTrQaZA4W3xx1tHyVM+QiK01PdVqgXYvj+haKVRT0Un8g4HYWbMPsFpZjGiml6cdsjAYQ==
X-Received: by 2002:a37:d205:: with SMTP id f5mr21462025qkj.248.1608129042744;
        Wed, 16 Dec 2020 06:30:42 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:cbde])
        by smtp.gmail.com with ESMTPSA id o5sm1035306qti.47.2020.12.16.06.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:30:41 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 16 Dec 2020 09:30:07 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Hillf Danton <hdanton@sina.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: Re: [PATCH 00/10] workqueue: break affinity initiatively
Message-ID: <X9oZ79F+xB7NMsUt@mtj.duckdns.org>
References: <20201214155457.3430-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214155457.3430-1-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 11:54:47PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> 06249738a41a ("workqueue: Manually break affinity on hotplug")
> said that scheduler will not force break affinity for us.
> 
> But workqueue highly depends on the old behavior. Many parts of the codes
> relies on it, 06249738a41a ("workqueue: Manually break affinity on hotplug")
> is not enough to change it, and the commit has flaws in itself too.
> 
> We need to thoroughly update the way workqueue handles affinity
> in cpu hot[un]plug, what is this patchset intends to do and
> replace the Valentin Schneider's patch [1].
> 
> Patch 1 fixes a flaw reported by Hillf Danton <hdanton@sina.com>.
> I have to include this fix because later patches depends on it.
> 
> The patchset is based on tip/master rather than workqueue tree,
> because the patchset is a complement for 06249738a41a ("workqueue:
> Manually break affinity on hotplug") which is only in tip/master by now.
> 
> [1]: https://lore.kernel.org/r/ff62e3ee994efb3620177bf7b19fab16f4866845.camel@redhat.com

Generally looks good to me. Please feel free to add

 Acked-by: Tejun Heo <tj@kernel.org>

and route the series through tip.

Thanks.

-- 
tejun
