Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C70B2EE772
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 22:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbhAGVI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 16:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbhAGVI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 16:08:56 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFB1C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 13:08:15 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id j1so4353318pld.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 13:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RPSS4+wIGvp/3YQYbCUE3lZcjQcE7GevEzI6hP5X/bw=;
        b=QcHURJUskZnmGtmirPpDXam1+nD3tS58vO+VwHrt5QfpZAT7OkPqMK1Z5s4W/HNPmf
         7ddcAQFcWD8RlCEXgL5kPn7aJq51foNk1f1ewKIh2dAdzREaU0UWbMRUfCZjWMIa97OP
         VuvgVhCAg18OWqacs6ABqF8JJ1a4cjtiqQUl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RPSS4+wIGvp/3YQYbCUE3lZcjQcE7GevEzI6hP5X/bw=;
        b=dp2Eyi5Kqq0fCLJtB3vQH5r6h5rtmmXvo6Mwx6UZPF4hIZg5gPTxD1z5rHDXdpKUg6
         WbJA4UwZchZ8A1/boc+RiWSVRx/3qrlMQUDb2Or6jZII3azGZTXpMw+hYfjVKFCzKOJG
         AR7g5qLXaDovDRisBqouoKTfPJh2J/3uoOJ3srp1b3rod5ZeyfcZZ7V7hwsIR+cYE2+1
         pOydMGkTuh3uSrqqqzpKmrlpFnCSxo1aTSBYMHB+E4cSkFG/WVISec1Lx8QlvSrlaJE1
         s1vjlH7kyXuSe6WiucwxqVPIMdyKPXnyBiJwYOEA+7CEMBk9QN4h+iMixcr313F+ho7y
         m1WA==
X-Gm-Message-State: AOAM530B7zac1qyv0n3LF85MbnR3QqzDc2iQBsf8DZ/Pb5UWCF9C3Hmb
        sQpwASCi7rwFlRC68ZvRrPr96w==
X-Google-Smtp-Source: ABdhPJyNhZorRAZXybiTjz8m9XRI5n8wBsWWi8f4w0GjKoH//cf7R8VzKbRIfqr+XwNPjJh7ntRq3A==
X-Received: by 2002:a17:90b:283:: with SMTP id az3mr367695pjb.84.1610053695540;
        Thu, 07 Jan 2021 13:08:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c18sm6473506pfj.200.2021.01.07.13.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:08:14 -0800 (PST)
Date:   Thu, 7 Jan 2021 13:08:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        yzaikin@google.com, adobriyan@gmail.com, vbabka@suse.cz,
        linux-fsdevel@vger.kernel.org, mhocko@suse.com,
        mhiramat@kernel.org, wangle6@huawei.com
Subject: Re: [PATCH] proc_sysclt: fix oops caused by incorrect command
 parameters.
Message-ID: <202101071307.6E0CF2FCA@keescook>
References: <20201224074256.117413-1-nixiaoming@huawei.com>
 <202101061539.966EBB293@keescook>
 <5ad6d160-3a4e-28bd-4e89-cb01a1815861@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ad6d160-3a4e-28bd-4e89-cb01a1815861@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 02:14:18PM +0800, Xiaoming Ni wrote:
> On 2021/1/7 7:46, Kees Cook wrote:
> > subject typo: "sysclt" -> "sysctl"
> > 
> > On Thu, Dec 24, 2020 at 03:42:56PM +0800, Xiaoming Ni wrote:
> > > [...]
> > > +	if (!val)
> > > +		return 0;
> > > +
> > >   	if (strncmp(param, "sysctl", sizeof("sysctl") - 1) == 0) {
> > >   		param += sizeof("sysctl") - 1;
> > 
> > Otherwise, yeah, this is a good test to add. I would make it more
> > verbose, though:
> > 
> > 	if (!val) {
> > 		pr_err("Missing param value! Expected '%s=...value...'\n", param);
> > 		return 0;
> > 	}
> > 
> Yes, it's better to add log output.
> Thank you for your review.
> Do I need to send V2 patch based on review comments?

Yes please. :)

-- 
Kees Cook
