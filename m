Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3C42938AF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405159AbgJTJ7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729522AbgJTJ7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:59:40 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECE5C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:59:39 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r10so762543pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NENYQ/eLjN+kod9n/Z7W2983/x5NgkU6/c+e1AeVxFs=;
        b=CBFdSEfJP5VkIIITqJlKx4yDwQWRMUByg7hRU3V6oQnIZFayB9saU8yPWEeqqVarA7
         Svg2TyX6boRcM9lNiOQmUR3MO1lysPy/JwSRhGTjgy1mfseoHM4waskxFWVxxpvq0mrC
         e0fXiVkRLhvyOqzBfor+B/yYUYjPMbMA+bwuOSgWaND1nQFCUqfql7XI6pSu/WraFedX
         4TXma4aAGudK6Nl0lri5gQdkFxVAo50aktjFPDcshE1wvhdweeWbi56L+t23seEjF1Nq
         YnlOmDc+LlD590ZPWEnWPd0zlSJ82h4gzkhJq0YZHy1+J+vCnic325VPjAahqqPkYKTV
         uKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NENYQ/eLjN+kod9n/Z7W2983/x5NgkU6/c+e1AeVxFs=;
        b=T2ckS8TlJAgLBoeRAAsJrus3AOdDHLjVssX3AwEnyx7kESEIpt9AN4vu3ELD/rY88l
         x8iOigAacMqeKNChDFkPfJUy1gnMV/ze7NqjAMVVPm9zYXrFYWEngsE7AKd9EPGjJq9G
         2jWVN+8d24ntqh91aCfmsaszk2CZip/se9xHO61qrN/krIMDjg0b8hp8UF0Z24+q1ocS
         sV1ROJyuvXghCklXqVzBJs8EajqaNn4cVjzx2DLQqirtVtHzflkJicjNafClWSFFVz1k
         QgqCrWGaLO0iiv5rDpfgU+F9ZIiBfSIS9CPTbQ0UmygLVA43cawY25c8kdlV3W1jcnVX
         VaNw==
X-Gm-Message-State: AOAM531kCpLebNLLpxNALCIljnvPwQ30qCIPgBnZv7WYvJP6mLJR1Xz6
        PONBBMuSWRVnwKBsXiU3r7cqYw==
X-Google-Smtp-Source: ABdhPJxzVYB15h5YaGeEL9se/fR4WCYPH/ZQqp3XJb26uBr6gmCf2vPkZ3wlfY2tWdVPgvsG2FFQfQ==
X-Received: by 2002:a63:ea0b:: with SMTP id c11mr2013473pgi.213.1603187978786;
        Tue, 20 Oct 2020 02:59:38 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id m3sm1407008pjv.52.2020.10.20.02.59.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2020 02:59:37 -0700 (PDT)
Date:   Tue, 20 Oct 2020 15:29:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, nks@flawful.org,
        georgi.djakov@linaro.org, Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH V2 1/2] opp: Allow dev_pm_opp_get_opp_table() to return
 -EPROBE_DEFER
Message-ID: <20201020095935.2ttoked5tozvcr24@vireshk-i7>
References: <20201019091723.GA12087@bogus>
 <20201019092411.b3znjxebay3puq2j@vireshk-i7>
 <20201019101241.GB12908@bogus>
 <20201019103535.ksp5ackoihamam4g@vireshk-i7>
 <20201019141007.GA6358@bogus>
 <20201020050557.a3b2nk33eeyxnvl2@vireshk-i7>
 <20201020055431.ln7d57x76f7z6j5k@vireshk-i7>
 <20201020093745.GA10604@bogus>
 <20201020094134.natqnyp4zpfw3p5p@vireshk-i7>
 <20201020095205.GB10604@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020095205.GB10604@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-10-20, 10:52, Sudeep Holla wrote:
> On Tue, Oct 20, 2020 at 03:11:34PM +0530, Viresh Kumar wrote:
> > On 20-10-20, 10:37, Sudeep Holla wrote:
> > > On Tue, Oct 20, 2020 at 11:24:32AM +0530, Viresh Kumar wrote:
> > > > On 20-10-20, 10:35, Viresh Kumar wrote:
> > > > > On 19-10-20, 15:10, Sudeep Holla wrote:
> > > > > > On Mon, Oct 19, 2020 at 04:05:35PM +0530, Viresh Kumar wrote:
> > > > > > > On 19-10-20, 11:12, Sudeep Holla wrote:
> > > > > > > > Yes it has clocks property but used by SCMI(for CPUFreq/DevFreq) and not
> > > > > > > > by any clock provider driver. E.g. the issue you will see if "clocks"
> > > > > > > > property is used instead of "qcom,freq-domain" on Qcom parts.
> > > > > > > 
> > > > > > > Okay, I understand. But what I still don't understand is why it fails
> > > > > > > for you. You have a clocks property in DT for the CPU, the OPP core
> > > > > > > tries to get it and will get deferred-probed, which will try probing
> > > > > > > at a later point of time and it shall work then. Isn't it ?
> > > > > > >
> > > > > > 
> > > > > > Nope unfortunately. We don't have clock provider, so clk_get will
> > > > > > never succeed and always return -EPROBE_DEFER.
> > > > > 
> > > > > Now this is really bad, you have a fake clocks property, how is the
> > > > > OPP core supposed to know it ? Damn.
> > > > 
> > > > What about instead of fixing the OPP core, which really is doing the
> > > > right thing, we fix your driver (as you can't fix the DT) and add a
> > > > dummy CPU clk to make it all work ?
> > > >
> > > 
> > > I really would avoid that. I would rather change the binding as there is
> > > no single official users of that binding in the upstream tree.
> > 
> > But how will you solve backward compatibility thing then ?
> > 
> 
> I am just betting on the fact that no users upstream means no backward
> compatibility needed. If someone raises issue we need to add backward
> compatibility with dummy clk as you suggested.

Okay. I would have done a change in the OPP core to fix the issue, but
the current code looks correct and we shouldn't change it to satisfy
buggy users. I hope that makes sense.

-- 
viresh
