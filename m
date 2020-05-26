Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5721C8173
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 07:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgEGFSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 01:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725601AbgEGFSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 01:18:24 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD580C061A41
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 22:18:22 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j21so2296743pgb.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 22:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EjwpJVR1oS9DdS7pegxHcKxChjnzSaTIkyZTVhILaoo=;
        b=slcpKIceAq3cfjYgNr8Zhq1cKoLAoXXqoHotEAb2xiQ35kfA512G47MwpKhZXuM/7e
         CPnlmatcZzVIRfNzpy00KH25stfePubouqjpWYnEmzYbZ4ABGq0cZy3Nmuh7tvH2wUGL
         a5veNcqHV2kXAgW7D+G/lGfw7VAQcdJhiOQnGPFvP3w7C1vRRwMk7rCHjG23Uw3Q0w1u
         jBhgWVFKipZ/m5hr6AzK9WoqH9NgDiX0dGl4AWiRoCTXvB4aa07ZvnHrV99m3lGg3wsh
         //8wutcZlOEfr0/AnEAjs7Cc4yZV4yYPA2Db4R7sXaVoPjV+1d9BSXEk4soUalWD6wMI
         L1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EjwpJVR1oS9DdS7pegxHcKxChjnzSaTIkyZTVhILaoo=;
        b=TOMVWTcWl+l9u6e4znPHPqzKMsA2ZngyEI4/EQBeBuOgscnAcQyQUswNXwEfX0XkHf
         VX/K91eapLZcxrMJczDXPZE03NKWyrxAi2Wf72X3QSEEj1d2ImapWLigXDKEEbe+nVLo
         5Sw9jQ3j4CTpgATM0yEK01VTDnikMiVVyXu+sp1z+KL8Di6LByT7e8bIjXL6XFtwZtnX
         wluv6VRXedeBFykNuo9eKUpcanl4IYoNzIg8F4ImrCeVfSaF7h4UroPK7Tj/e6pSI4+L
         Z42ZeJujmQ8Q/fRcSdzbPaJ2JA/lGEsMWGAW5nJMfcued1XV4TOgP82btSjvAMlyJotX
         mMIA==
X-Gm-Message-State: AGi0PuZ2jeqDrT9lg24SuNG6OTCxrJAstA+OKVw3gC+ZWH55Q8fC1C89
        xZ/qAgsK5PKrGFieVpkEnr4j/g==
X-Google-Smtp-Source: APiQypIEmsP8B+EwGLQga6A4T0mFxXwfh7oJIQ8PZk2O+MdkKuUNTJ0xX+z5cnzD4HZ+G174irQzXg==
X-Received: by 2002:a62:3181:: with SMTP id x123mr11697759pfx.109.1588828701997;
        Wed, 06 May 2020 22:18:21 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id v127sm3499629pfv.77.2020.05.06.22.18.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2020 22:18:21 -0700 (PDT)
Date:   Thu, 7 May 2020 10:48:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rjw@rjwysocki.net, Mian Yousaf Kaukab <ykaukab@suse.de>
Cc:     linux-pm@vger.kernel.org, andy.tang@nxp.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, shawnguo@kernel.org, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] cpufreq: qoriq: convert to a platform driver
Message-ID: <20200507051818.xi43yfusjktemd5r@vireshk-i7>
References: <20200421083000.16740-1-ykaukab@suse.de>
 <20200428110125.lobyrsbma6astfmq@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428110125.lobyrsbma6astfmq@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-04-20, 16:31, Viresh Kumar wrote:
> On 21-04-20, 10:29, Mian Yousaf Kaukab wrote:
> > The driver has to be manually loaded if it is built as a module. It
> > is neither exporting MODULE_DEVICE_TABLE nor MODULE_ALIAS. Moreover,
> > no platform-device is created (and thus no uevent is sent) for the
> > clockgen nodes it depends on.
> > 
> > Convert the module to a platform driver with its own alias. Moreover,
> > drop whitelisted SOCs. Platform device will be created only for the
> > compatible platforms.
> > 
> > Reviewed-by: Yuantian Tang <andy.tang@nxp.com>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> > ---
> > v2:
> >  +Rafael, Stephen, linux-clk
> >  Add Reviewed-by and Acked-by tags
> > 
> >  drivers/cpufreq/qoriq-cpufreq.c | 76 ++++++++++++++++-------------------------
> >  1 file changed, 29 insertions(+), 47 deletions(-)
> 
> @Rafael,
> 
> Though this looks to be PPC stuff, but it is used on both ARM and PPC. Do you
> want to pick them up or should I do that ?

Applied now. Thanks.

-- 
viresh
