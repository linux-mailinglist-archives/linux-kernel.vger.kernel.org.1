Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002FF2D2E7F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgLHPmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730167AbgLHPmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:42:47 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD389C061794
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 07:42:06 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id g18so12513514pgk.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 07:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jmDvSPRVcyFiUTh9P/9tgxR63Fy7Ex8sd1a89ZzSMyc=;
        b=d6sGHdDKnkJinKcYD9aW5HuYKEFF3OfjEUqAtYD5wc6upJs5m5wpSzwGzVpVxBgzA8
         /PSxlxqYS/Bzj04qXWkVIoxjj67Y81tl/oWZbDECCLvYS8kd7bE75u/yzA+ioVIBzJLB
         snBKRKoHWVzQ2Rl/6CG5GA0OANMhp6YSB0tXM9+wP+O/DCezuqoXEGczNczF9NtkjQCk
         1fsQGReKEPEJm2+8+1bo0eOYZaafbstyt+SrGP3Vw/aCP0Mn87SqUOvYQLkH9xdEzi4Q
         Gc732c3U7Xk7FoMpa2ZHBFWWdN4BsocaYjbfElOkDxhhbzrNkXawJnbQIcbJarlIHCW2
         GIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jmDvSPRVcyFiUTh9P/9tgxR63Fy7Ex8sd1a89ZzSMyc=;
        b=q8D4MWtAdGpI+VG4zSMJGxqdcCj/FJKzNM942bcHjsPN04DgXvpICN1ozUR2+e06MV
         zJWFH+x8WsFmkU+JD7I1qjSPCUjroMAsblVbyuBs9Nuk9pgLg+QgooB03Uu0PQUPH11I
         A4gM5SvoNlno2IRDFt+WlJ4+qgJxsuOrOUGPCX3k5bcOTaWLf5MoYgILKDSytm2Hz8Y/
         NG7NjspOCXQATLEmwA0S2DP9VduMAjvZizR3RjXJuYzlKQM4mpUGwZKzAAUSZfzyf6XY
         wYX6/c7RfbGYtFWp2BvV/UlIsn8i8cf+oATds1jgCw68NIl0C9/uOIBOeliW3KmqWGIJ
         qU5A==
X-Gm-Message-State: AOAM530iHmPQiKtEcnL3sGRF8lMJBkjKt5L/Kk3GRJdc08Y2Pv1T4N40
        teQIGopSbqEu0duTupcHBSaG
X-Google-Smtp-Source: ABdhPJy583cwUkBWFf5ggCavTrTu465iNtib6m3+T2n3nlybT7JEEZweJdzcPVW4TJ9udxotaMWd4Q==
X-Received: by 2002:a17:90a:178b:: with SMTP id q11mr4791029pja.132.1607442126108;
        Tue, 08 Dec 2020 07:42:06 -0800 (PST)
Received: from work ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id f7sm3680833pjs.25.2020.12.08.07.41.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Dec 2020 07:42:05 -0800 (PST)
Date:   Tue, 8 Dec 2020 21:11:55 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net,
        jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@somainline.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        nks@flawful.org, lgirdwood@gmail.com, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, bjorn.andersson@linaro.org,
        phone-devel@vger.kernel.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        robh@kernel.org
Subject: Re: [PATCH 11/13] dt-bindings: cpufreq: Convert qcom-cpufreq-hw to
 YAML binding
Message-ID: <20201208154155.GC9925@work>
References: <20201126184559.3052375-1-angelogioacchino.delregno@somainline.org>
 <20201126184559.3052375-12-angelogioacchino.delregno@somainline.org>
 <20201130172305.GA2661895@robh.at.kernel.org>
 <20201203111427.GA3937@thinkpad>
 <d66e05be-4ea1-dfb7-40ee-bfe417ab1a77@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d66e05be-4ea1-dfb7-40ee-bfe417ab1a77@somainline.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 01:13:52AM +0100, AngeloGioacchino Del Regno wrote:
> Il 03/12/20 12:14, Manivannan Sadhasivam ha scritto:
> > Hi,
> > 
> > On Mon, Nov 30, 2020 at 10:23:05AM -0700, Rob Herring wrote:
> > > On Thu, 26 Nov 2020 19:45:57 +0100, AngeloGioacchino Del Regno wrote:
> > > > Convert the qcom-cpufreq-hw documentation to YAML binding as
> > > > qcom,cpufreq-hw.yaml.
> > > > 
> > > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > 
> > There is already a patch floating for this. Please see:
> > https://lkml.org/lkml/2020/10/20/676
> > 
> > Thanks,
> > Mani
> > 
> Oh, I'm sorry, I wasn't aware of that, didn't want to step on you.
> 
> Should I rebase patch 1345789 (patch 13/13 of this series) on top of
> the one that you pointed out and drop this one?

Yes please.

Thanks,
Mani

> 
> - Angelo
> 
> > > > ---
> > > >   .../bindings/cpufreq/cpufreq-qcom-hw.txt      | 173 +---------------
> > > >   .../bindings/cpufreq/qcom,cpufreq-hw.yaml     | 196 ++++++++++++++++++
> > > >   2 files changed, 197 insertions(+), 172 deletions(-)
> > > >   create mode 100644 Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml
> > > > 
> > > 
> > > 
> > > My bot found errors running 'make dt_binding_check' on your patch:
> > > 
> > > yamllint warnings/errors:
> > > 
> > > dtschema/dtc warnings/errors:
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml: properties:clock-names: [{'const': 'xo'}, {'const': 'ref'}] is not of type 'object', 'boolean'
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml: maintainers:0: 'TBD' is not a 'email'
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml: ignoring, error in schema: properties: clock-names
> > > warning: no schema found in file: ./Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml
> > > Error: Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.example.dts:150.3-151.1 syntax error
> > > FATAL ERROR: Unable to parse input tree
> > > make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.example.dt.yaml] Error 1
> > > make[1]: *** Waiting for unfinished jobs....
> > > make: *** [Makefile:1364: dt_binding_check] Error 2
> > > 
> > > 
> > > See https://patchwork.ozlabs.org/patch/1406857
> > > 
> > > The base for the patch is generally the last rc1. Any dependencies
> > > should be noted.
> > > 
> > > If you already ran 'make dt_binding_check' and didn't see the above
> > > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > > date:
> > > 
> > > pip3 install dtschema --upgrade
> > > 
> > > Please check and re-submit.
> > > 
> 
