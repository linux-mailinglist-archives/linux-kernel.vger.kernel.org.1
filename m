Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2CF2853F5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 23:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgJFVit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 17:38:49 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34157 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgJFVis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 17:38:48 -0400
Received: by mail-ot1-f68.google.com with SMTP id d28so310105ote.1;
        Tue, 06 Oct 2020 14:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VXvrI2x6b8MeVNJBRJLTPFfh0KlQpZ5q38fF1cR1cAU=;
        b=U5xMqaV3Mtr6fUXKG8++7rPnqsKNjo5nvB3rzyG3I5W2Um+3yPqwuSgvndaNpmymzb
         OLmpUi6TX2J799b4EAVT1aPJRLUGZyELFdpUVI3RWqRc72EWRFerSlxd9MvLFDwJGJUb
         1UM6II6OLXwtV8lsrruHFgKA1LKEDy4GkCWNxsYQSwYtJcYtxs1GXv5AWlQPtPY758v4
         d1znJlOKkx1I6ZlkgC1Iqk18Qqwr6xowDTPzuq/Plr3rkNP2+mc4N2855Gz3r0xZOzQQ
         eqLwADC96mqPp4/TMslZuoVl2N2+Y9G/LfbeVhJu0IvstK1FFhBEYX42U4m+bYvzhZXO
         wApg==
X-Gm-Message-State: AOAM532LQ04Y7GRlVAzrzqK+276ALvWj5utNYFS+dZxelbsgjbNemv+r
        HaKrZOADKEGSUAkIc0LFmQ==
X-Google-Smtp-Source: ABdhPJx6Pqm69KRrvVs9ibZcmeMg64Cr1CtCQPGqwV0ckv7HoDx/3pQI8VaMtgJXuTEKgYWiwE4wMQ==
X-Received: by 2002:a05:6830:200a:: with SMTP id e10mr4059127otp.335.1602020326490;
        Tue, 06 Oct 2020 14:38:46 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 71sm1880430otm.81.2020.10.06.14.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 14:38:45 -0700 (PDT)
Received: (nullmailer pid 2892270 invoked by uid 1000);
        Tue, 06 Oct 2020 21:38:44 -0000
Date:   Tue, 6 Oct 2020 16:38:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        rtanwar@maxlinear.com, linux@roeck-us.net,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        jdelvare@suse.com, songjun.Wu@intel.com, p.zabel@pengutronix.de,
        cheol.yong.kim@intel.com
Subject: Re: [PATCH v5 1/2] Add DT bindings schema for PVT controller
Message-ID: <20201006213844.GA2892213@bogus>
References: <cover.1601889876.git.rahul.tanwar@linux.intel.com>
 <b540b49ca47d75c5f716f8a4e4eed0664a1116bf.1601889876.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b540b49ca47d75c5f716f8a4e4eed0664a1116bf.1601889876.git.rahul.tanwar@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Oct 2020 17:27:45 +0800, Rahul Tanwar wrote:
> PVT controller (MR75203) is used to configure & control
> Moortec embedded analog IP which contains temprature sensor(TS),
> voltage monitor(VM) & process detector(PD) modules.
> 
> Add DT bindings schema for PVT controller.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  .../devicetree/bindings/hwmon/moortec,mr75203.yaml | 71 ++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
