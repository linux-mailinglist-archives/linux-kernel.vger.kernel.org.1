Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5929F1FAD09
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 11:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgFPJsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 05:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgFPJsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 05:48:08 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24032C03E96A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 02:48:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x13so20037923wrv.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 02:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YJhllO4Kw1J0lTqgGNFCN8u51U+dY+0Qg1YUtifz2DQ=;
        b=Iqt3U+EfoGwvBO6gas6vWDONtJcu2N7OabeDosatCNXRpqIICI/AjsCW8QzOB5T2JW
         +WmzTSoalx3YRc9j98uetf0Sj/G3aJVxXRQyBl1hksCpwFHP58WKdMc3KHYMcCQHUnMl
         cAUrneMR1ctDU75iXTrOL+XHK2lQsWkh2CtlCJ6olN5YqdQVcZxBjvhYKEn17zsb9Dl6
         gbiKcLBuSB1yFzPdk/soPZZbcfzAQprsSj9xOINTAlVDBk1mJrVeIAlJB93n1TvblA0J
         +/wCrtG3RUhzaNIVOUtRKLK3mr/WaUd4Lylf9SMJtZzZN98FkPruwhHkpkb7zaGmpTge
         5VnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YJhllO4Kw1J0lTqgGNFCN8u51U+dY+0Qg1YUtifz2DQ=;
        b=WLSEusHHQT56srcJDE6F7lV82uKccRaqjULICJcWBeC3fkVx6eW7gQeViZ1BZFrzXg
         fMi1fn0xuBqSIxcieaUdkAMbA3E2R5F8nWCAO4kC5uiTPQvFfEm8VlTjAYU2R0EDh/1N
         9eaQDBjSACyd/gqHzShXbb8/LLyHr3eWncq2Od+0J1sUExJQ3EviaYDJe/fJQHg4eeXL
         R76I/bsuJa+dZBgpcYjff8JqMsiiAR/4SjD1kfK/IYktSZZLzdG51sWrfC2xl4jHNIOx
         09XTh5vFT5uxwqdwc7XRBz7iZrzR1e2Qe+BqGtSdT4jBLxxY5N63wStrzdT2/wohe6SZ
         D32w==
X-Gm-Message-State: AOAM530ULk/foslAMdQA0Zhhdx07fyxImc7yy+CsuTiLmF3gDiFnPJ6P
        zRuCXdGFadxNc/XIeGz5em9c7w==
X-Google-Smtp-Source: ABdhPJxETXYc1b9IwZwaRsxXKvkaimQeMqws2xB6B3SE1nYCRT49lzWEH9qFjPJvIMNqDEW6+58+fg==
X-Received: by 2002:adf:dd06:: with SMTP id a6mr2208922wrm.142.1592300886614;
        Tue, 16 Jun 2020 02:48:06 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id n23sm3107753wmc.0.2020.06.16.02.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 02:48:06 -0700 (PDT)
Date:   Tue, 16 Jun 2020 10:48:02 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, rafael@kernel.org, arnd@arndb.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org
Subject: Re: [PATCH 2/2] cpufreq: Specify default governor on command line
Message-ID: <20200616094802.GA139416@google.com>
References: <20200615165554.228063-1-qperret@google.com>
 <20200615165554.228063-3-qperret@google.com>
 <20200616043143.obk5k3rv737j5dnd@vireshk-i7>
 <20200616083107.GA122049@google.com>
 <20200616092759.rjnk3lef4tedfust@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616092759.rjnk3lef4tedfust@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 Jun 2020 at 14:57:59 (+0530), Viresh Kumar wrote:
> There is another problem here which we need to look at. Any governor
> which is built as a module and isn't currently used, should be allowed
> to unload. And this needs to be tested by you as well, should be easy
> enough.
> 
> With the current implementation, you take a reference to the default
> governor when the driver is registered and drop it only when the
> driver goes away. Which means we won't be able to unload the module of
> the governor even if it isn't used. Which is wrong. The solution I
> proposed had the same issue as well.
> 
> You need to figure out a way where we don't need to keep holding the
> module hostage even when it isn't used. I see two ways at least for
> the same:
> 
> - Do that from the existing place: cpufreq_init_policy().
> 
> - And I think this can be done from governor-register/unregister as
>   well.
> 
> Second one sounds good, if it is feasible to do that.

Good point.

I'm thinking something along the lines of:

---8<---
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0f05caedc320..a9219404e07f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2340,6 +2340,11 @@ int cpufreq_register_governor(struct cpufreq_governor *governor)
 		list_add(&governor->governor_list, &cpufreq_governor_list);
 	}
 
+	if (!strncasecmp(cpufreq_param_governor, governor->name, CPUFREQ_NAME_LEN))
+		default_governor = governor;
+	else if (!default_governor && cpufreq_default_governor() == governor)
+		default_governor = cpufreq_default_governor();
+
 	mutex_unlock(&cpufreq_governor_mutex);
 	return err;
 }
@@ -2368,6 +2373,8 @@ void cpufreq_unregister_governor(struct cpufreq_governor *governor)
 
 	mutex_lock(&cpufreq_governor_mutex);
 	list_del(&governor->governor_list);
+	if (governor == default_governor)
+		default_governor = cpufreq_default_governor();
 	mutex_unlock(&cpufreq_governor_mutex);
 }
 EXPORT_SYMBOL_GPL(cpufreq_unregister_governor);
--->8---

should do the trick. That removes the unnecessary reference count, and
feels like a good place to hook things -- that is how cpuidle does it
too IIRC.

I'll double check the locking/synchronization, but that shouldn't be too
bad (famous last words).

Cheers,
Quentin
