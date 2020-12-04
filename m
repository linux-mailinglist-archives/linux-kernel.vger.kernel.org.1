Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A7A2CF76B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 00:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgLDXZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 18:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLDXZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 18:25:16 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A33BC061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 15:24:36 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id bj5so4000817plb.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 15:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dp4a4I+CGeFhV9BXWLgWJG8THoDXEJYYnGVTWyWsFu0=;
        b=bXts64vtazkEv2OjbCqbdaD9U8GVsVJnQmEDL9b6088YJRpesI6caMXbOdtWkpdB+Q
         19RLwmCuAsjnnGiofDhFpbgMy8T09aytIJIG2joIsHqotjSr+Cz/uMhhX4cFbVONxbMk
         0hpY+kDJNklJHHxbNr53xeznEV6SgeWq20JQ1u5ISV2jkdoYwoGpLbcJFNwKv33/vWqW
         iNFPk7ZHhFqpYSR8ywqZHipoQUewxd8aT1ckSZpYhwm9mpNewavasN5LTwD/nbyiQuLm
         FhK7CBHyZDs7vG0xBtF5KCvfD6dM9NAcjWZrLyZNLjGi9wF1+vIR9MAekJgtxj1lU/z6
         plng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dp4a4I+CGeFhV9BXWLgWJG8THoDXEJYYnGVTWyWsFu0=;
        b=tIFDJQKfqYtYmYxAY2reCpzFkdq+Ton30Odfa6oPznkErvwTO61VTcYa7E9IhHSxur
         9j2R1GNG7uqtkPXqVgJLcqyDdMLSB77Dipgf7tcsG4+CzUUxpH7Y2BGWnJq0MroToeQq
         lBqS76PHbbKg3Mxdoouu/RGHaiR5b0RUQZ5Xsf0vYr07PfyhGB3PCehMeYopCRfVNM0k
         /YU+xOI8XsuYgJYNmA+jegkP8KHR1F3zdmc4Lf64H88N1J4KNRCeeF0dlTdpQKJpfYoL
         dvBCiOcW1PJyDcWnGkq0/PnRIGAcanZDlmwkuekM9+JWaRiEDfB8QNqQCMs6v9BR8YWR
         yhWw==
X-Gm-Message-State: AOAM533SnkOieChUnJ0abxrTIEQJg/H0j4UChDucC8XnE/2rpV+x0J5/
        AfQfyIoAGK6GvZymeWE31GKnpA==
X-Google-Smtp-Source: ABdhPJze8kI8LCo+CNtM8rZfjc3ETpwe4yoo4ibkkStpdGcu1RwnDl8O28MicEKOlPuVWLpM0VL5uw==
X-Received: by 2002:a17:902:bcca:b029:da:61e3:a032 with SMTP id o10-20020a170902bccab02900da61e3a032mr5822157pls.63.1607124275801;
        Fri, 04 Dec 2020 15:24:35 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id t16sm4921930pga.51.2020.12.04.15.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 15:24:35 -0800 (PST)
Date:   Fri, 4 Dec 2020 15:24:28 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     akpm@linux-foundation.org, jeyu@kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, luto@kernel.org,
        dave.hansen@linux.intel.com, peterz@infradead.org, x86@kernel.org,
        rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, elena.reshetova@intel.com,
        ira.weiny@intel.com
Subject: Re: [PATCH RFC 01/10] vmalloc: Add basic perm alloc implementation
Message-ID: <X8rFLHGSqJ7JCZ/N@google.com>
References: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
 <20201120202426.18009-2-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120202426.18009-2-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020, Rick Edgecombe wrote:
> +struct perm_allocation {
> +	struct page **pages;
> +	virtual_perm cur_perm;
> +	virtual_perm orig_perm;
> +	struct vm_struct *area;
> +	unsigned long offset;
> +	unsigned long size;
> +	void *writable;
> +};
> +
> +/*
> + * Allocate a special permission kva region. The region may not be mapped
> + * until a call to perm_writable_finish(). A writable region will be mapped
> + * immediately at the address returned by perm_writable_addr(). The allocation
> + * will be made between the start and end virtual addresses.
> + */
> +struct perm_allocation *perm_alloc(unsigned long vstart, unsigned long vend, unsigned long page_cnt,
> +				   virtual_perm perms);

IMO, 'perm' as the root namespace is too generic, and perm_ is already very
prevelant throughout the kernel.  E.g. it's not obvious when looking at the
callers that perm_alloc() is the first step in setting up an alternate kernel
VA->PA mapping.

I don't have a suggestion for a more intuitive name, but in the absence of a
perfect name, I'd vote for an acronym that is easy to grep.  Something like
pvmap?  That isn't currently used in the kernel, though I can't help but read it
as "paravirt map"...
