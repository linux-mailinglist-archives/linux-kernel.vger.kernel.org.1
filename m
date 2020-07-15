Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90A32202E4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 05:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgGODYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 23:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgGODYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 23:24:46 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B37AC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:24:46 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id 72so1398687ple.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dVCx6htI5TVOttkAFatlrmjAYqmh13a2xgOrYQfZR+o=;
        b=swLmgPhgBkDkXHB/JCDnmiyyNjJolmWYhYsntkr0xHe4LMexlvYTmAWGgYhQ52XXMx
         77/GNPg4XlDSFiQPuBKfklkXHtRs315SnYFjmBb5SkdIUA5ddzIxTexeK9XaGMO6vL6X
         RvnFWLUDT1WK+2e/7XiZXjenGX+bfaVa/qvbcgRj8wXEQgTwzcAr6W4SoFO9P6a6qYt6
         jyVhgBDQqKYlWDyTUupWhICo3wbaUV+c4L0oXsnSMHixRrGNwmToGMRnsSQ8Hp8PHMP1
         cmfzVcyGxhKFcdrHjKo3uZF3z6YUJlmaKkaFv2GCFRcOEsVOVbROg1rtTM4vj7WfpM/r
         oalw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dVCx6htI5TVOttkAFatlrmjAYqmh13a2xgOrYQfZR+o=;
        b=K/TyJ9xTY303zGi66fnMBXhuH0w8bCOJb1uYc+eeQ+rRjG4553B+401sXH/z2kVjtS
         aNUq3DvKTa1OtbqfbeHhWTpGAw1YWzEB1fWYfvZ2dZuazUhiFYHFhKvsjaMOz/NL98hN
         tZDI6RPeNJS5WIiI3s77q7fC1uLohFq5oj50G0Zu/3Y1qIYcbOugjZ+odt81IdH1j27P
         E00V83m55Qo2dHFPd58aKB0MQoD7I0hyEWcVM2FKyJX5u2pMiO9QvvNcyNaE9DdQZx7v
         HLlUkPl8+5bUfdxwOj9+7AKlq+YIzZyMeGfa2O1sschvlAYeEdM59M0dMENQjh84DHcJ
         2tvw==
X-Gm-Message-State: AOAM533rvb2yPah8ojw0uRNF2FsZszd47qP93dK11xKmu73oDYuytl7p
        pmz+tz+QvmLyJrjC6cy4yW39Tw==
X-Google-Smtp-Source: ABdhPJzI/jGv+9mdtKCgglTH9INVPVH2hbHvJSR+Iok++HVt4l15rbmwjqQqKczIoGyPr81tGVFXZg==
X-Received: by 2002:a17:90b:e8d:: with SMTP id fv13mr8170265pjb.128.1594783485893;
        Tue, 14 Jul 2020 20:24:45 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id d5sm398825pju.15.2020.07.14.20.24.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 20:24:45 -0700 (PDT)
Date:   Wed, 15 Jul 2020 08:54:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Grover <andrew.grover@intel.com>,
        Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>,
        Dominik Brodowski <linux@brodo.de>,
        Denis Sadykov <denis.m.sadykov@intel.com>
Subject: Re: [PATCH 09/13] cpufreq: acpi-cpufreq: Remove unused ID structs
Message-ID: <20200715032442.gh2cliiddhv35fdj@vireshk-i7>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-10-lee.jones@linaro.org>
 <CAJZ5v0iB0K6H28DSDQj9T7k_kV10THxV6-HwN9qfmkLsYNHfiA@mail.gmail.com>
 <20200714210340.GJ1398296@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714210340.GJ1398296@dell>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-07-20, 22:03, Lee Jones wrote:
> On Tue, 14 Jul 2020, Rafael J. Wysocki wrote:
> 
> > On Tue, Jul 14, 2020 at 4:51 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > Can't see them being used anywhere and the compiler doesn't complain
> > > that they're missing, so ...
> > 
> > Aren't they needed for automatic module loading in certain configurations?
> 
> Any idea how that works, or where the code is for that?

The MODULE_DEVICE_TABLE() thingy creates a map of vendor-id,
product-id that the kernel keeps after boot (and so there is no static
reference of it for the compiler), later when a device is hotplugged
into the kernel it refers to the map to find the related driver for it
and loads it if it isn't already loaded.

This has some of it, search for MODULE_DEVICE_TABLE() in it.
Documentation/driver-api/usb/hotplug.rst

-- 
viresh
