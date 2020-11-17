Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E378F2B5D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgKQKxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgKQKxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:53:42 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F668C0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:53:41 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id ei22so261312pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eoTk62fG1p6UDGcKcSRWi441yJuEvIVC/FAEJYzXB0s=;
        b=Wo0Dlp+dx7AT/DG5eeqZicKGozHqLr0FXfj3Jq6o7ZJWX4S4RlyscQ3IJMJ6jmeq87
         HwxvF9yCnuYcBw4+5MhcKPbgE9VPjLRCR7y4i4IXoIJ/bG65v8hn60ulVh/43KZhz6ld
         o4hLRyHItZ3bywd85CVH8c4ObB9eq1tox3RcAKtHTI/KHzIklCVIPSO75T6a0PJhynNt
         uvGeY/g7kUX531jzp28lp96ykmHHdj/bEUylG3nsBUdwjYgguCSK3486dujGqaDtY9Nk
         fM8/4v7kYrUdHOhZV2yciW7bdR0r2bWTWhYlbYmn6jzJaKE+Q/XEDPgWbxdnh1oZq6Ad
         Cepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eoTk62fG1p6UDGcKcSRWi441yJuEvIVC/FAEJYzXB0s=;
        b=Fu8O2RwW2A3O1xZ/FCIYrqh4lN7KEeXdd8W7T3epUZ62Gn6HeE1UoY7iK30GWJKZnf
         H02SwTTRklJcI7TkqOw662rqFQRYPIeuWKm3oiDXP2Yy4UhnC2e5k2rMm5561IflSTa/
         /r7N5bLZZiwZqy96iAQtxalD1jYLMD72CNlERiTznr7c+wA/XjhMyYN5L4zpDKVid1F9
         LUt4GaYkn9xkJ/9zOdD6EowPdkHOuyhdmoJk65JZdm9FNx4ThOZ3tRyJ/NhF5jZ/aM3f
         Y7KHwaPt/NHgQnVmFwK2MTBr48QT1wP4/wgG1CW6p3C+BfDM4N5xmIgix+fqPP149j3d
         EoLg==
X-Gm-Message-State: AOAM5325HBKaF0QpQ5Jkk3CosGUTXKBVyzPQSrUQyECX+uJHGRUYctsv
        UlPqRe66nUhVbFkxfRR4+eEUZQ==
X-Google-Smtp-Source: ABdhPJyOoYskSc8gqE5zjtjNoP5i7gk+vAHTpwo4TvMYNmRwXwsEH8xBLh/4JxVFcjdxniSRHMGohg==
X-Received: by 2002:a17:902:8b8c:b029:d6:df70:fa21 with SMTP id ay12-20020a1709028b8cb02900d6df70fa21mr17037852plb.15.1605610420966;
        Tue, 17 Nov 2020 02:53:40 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id 205sm18348955pge.76.2020.11.17.02.53.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2020 02:53:40 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:23:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, sudeep.holla@arm.com,
        rjw@rjwysocki.net, vireshk@kernel.org, robh+dt@kernel.org,
        sboyd@kernel.org, nm@ti.com, daniel.lezcano@linaro.org,
        morten.rasmussen@arm.com, chris.redpath@arm.com
Subject: Re: [PATCH v3 3/3] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
Message-ID: <20201117105337.vjwtig3qxpc6owmw@vireshk-i7>
References: <20201102120115.29993-1-nicola.mazzucato@arm.com>
 <20201102120115.29993-4-nicola.mazzucato@arm.com>
 <20201106092020.za3oxg7gutzc3y2b@vireshk-i7>
 <0a334a73-45ef-58ff-7dfd-9df6f4ff290a@arm.com>
 <20201106105514.bhtdklyhn7goml64@vireshk-i7>
 <7f73bcd6-0f06-4ef0-7f02-0751e6c4d94b@arm.com>
 <20201109065742.22czfgyjhsjmkytf@vireshk-i7>
 <2fa8a5c0-f66d-34bc-7f1c-8462e7532e0a@arm.com>
 <20201117101128.6uapqg56arwqmm5p@vireshk-i7>
 <0858962e-3a30-d177-594b-bb8e3149dd8d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0858962e-3a30-d177-594b-bb8e3149dd8d@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-11-20, 10:47, Nicola Mazzucato wrote:
> Freq-invariance has been mentioned. I suppose the fix will depend on which
> strategy we prefer to solve this.

I am not sure how FIE will use this information, as I thought the
problem is about knowing the current frequency on a CPU instead of
which CPUs are related. Anyway, EM is good enough to get this stuff
going.

> As a reminder, two solutions:
> 1) dependent_cpus cpumask in cpufreq and involved entities pick this info

Yeah, this one. And it will be called freqdomain_cpus. Add support for
freqdomain_cpus in core, update acpi-cpufreq to reuse it instead of
adding its own and you can have it in other drivers then.

-- 
viresh
