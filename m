Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500E02476C0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 21:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404295AbgHQTld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 15:41:33 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44297 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbgHQTlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 15:41:14 -0400
Received: by mail-io1-f65.google.com with SMTP id v6so18739498iow.11;
        Mon, 17 Aug 2020 12:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hLPrmS2NJ7VsWN+XXLJey6iV7KyNLRkPQhyYhJ663W8=;
        b=ujP2ORDzxqQGOXBfuiVBseYw7S/YFGF3rL5aRdFJrZRvOLMizDyEd+myeLZZdtFtHn
         HwWByQa+thSgaVhOeS9d3tqieUqe0mvnHoiIYj07kot0xCgbrBdSXnghvUi48PFOMuQw
         UoFlqk/ZOto5B8dJfg2b7yohwtRSOSzrg8QUKbr1DEI70s0xdCmf72m4FsbF+hiVRx5U
         squAIRxRYvINfJxk7+5aruJsJVAnI8W+5guj7rL4FT5Kf1LDVnA+oci4l8b0utbcGtba
         O/zII66A5nxhZocbS4ATIXeDtP8Q4clDNwD2tZzw2/CipIjfxrqJIvDIKCYMlnlCa+rN
         vbsA==
X-Gm-Message-State: AOAM532NNoQ9ed7uom+d7Mjgu7HerTQzb4DMuBZ17Vn7AXDhnMINn2Zb
        3N4D57+uXAt6cPbc3k1P0g==
X-Google-Smtp-Source: ABdhPJzxM6ImTNHL4gOHTrB9xWUNIUlIDo7NCIfWLAKSs5BAbjVGvpKzl0Df18aazKXVcwjl5na3Ww==
X-Received: by 2002:a02:770e:: with SMTP id g14mr15532405jac.94.1597693272622;
        Mon, 17 Aug 2020 12:41:12 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id c1sm10322232ilk.28.2020.08.17.12.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 12:41:11 -0700 (PDT)
Received: (nullmailer pid 1423992 invoked by uid 1000);
        Mon, 17 Aug 2020 19:41:09 -0000
Date:   Mon, 17 Aug 2020 13:41:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jack Lo <jack.lo@gtsys.com.hk>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v8 2/2] devicetree: hwmon: shtc1: add sensirion,shtc1.yaml
Message-ID: <20200817194109.GA1423962@bogus>
References: <20200815012227.32538-1-chris.ruehl@gtsys.com.hk>
 <20200815012227.32538-3-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815012227.32538-3-chris.ruehl@gtsys.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Aug 2020 09:22:27 +0800, Chris Ruehl wrote:
> Add documentation for the newly added DTS support in the shtc1 driver.
> To align with the drivers logic to have high precision by default
> a boolean sensirion,low-precision is used to switch to low precision.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  .../bindings/hwmon/sensirion,shtc1.yaml       | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
