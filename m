Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCE81FD7D6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 23:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgFQVrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 17:47:08 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:46722 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgFQVrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:47:07 -0400
Received: by mail-il1-f196.google.com with SMTP id h3so3789095ilh.13;
        Wed, 17 Jun 2020 14:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QOtalIRl7dJtF8bawMxSj4onvGztmuE6KHSorPmNNiQ=;
        b=V148A2qW713f52gffD0TFLqQYonwvq7M6y00yZ5tS2MSy1wpkoFE4Rpu0PMhAFJfJ3
         0t0X1kEtwn04RXn254y01KmWWizOh4ZuQANggRBqq1upBHFeaf3x031fLLWm3suv7aQo
         9+YfnihUUPMwsd0+U2y8jzjKLWDGtDPpFQ6JFasz1ZcWvYXXajgjyRWIVcIL8I+s6JYv
         q2giZS7+DVveD81xdVCx9tmg+4gK0tNXoxUu3uw2I9QcHXdrxMfyuJAxphTQlBc2PL8Q
         pyHkrbH4ZaWRwl3rBrgQ7F3XkDvQkDltKG3EWI1A8xgGP1QE3rHEMFwPhNYQ/os263/8
         m4HA==
X-Gm-Message-State: AOAM5331VadJxlE6EUnfZWo6GuV/BI7mWTjjcPgapnAVcvI/0i5gM1Vw
        oMl2fSMRqWRTDgHuGRvNsw==
X-Google-Smtp-Source: ABdhPJyBDSEi43mBE+erhCt9ul6yKVvlnJFELUx209pjl/BDlB/3MXyAjCZJbUAeEV6872L5HmPo+Q==
X-Received: by 2002:a05:6e02:1203:: with SMTP id a3mr1011013ilq.30.1592430426606;
        Wed, 17 Jun 2020 14:47:06 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id c62sm484926ill.62.2020.06.17.14.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 14:47:06 -0700 (PDT)
Received: (nullmailer pid 2884760 invoked by uid 1000);
        Wed, 17 Jun 2020 21:47:05 -0000
Date:   Wed, 17 Jun 2020 15:47:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Jones <rjones@gateworks.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] dt-bindings: mfd: gateworks-gsc: add 16bit
 pre-scaled voltage mode
Message-ID: <20200617214705.GA2884703@bogus>
References: <1591714640-10332-1-git-send-email-tharvey@gateworks.com>
 <1591714640-10332-2-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591714640-10332-2-git-send-email-tharvey@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Jun 2020 07:57:19 -0700, Tim Harvey wrote:
> add a 16-bit pre-scaled voltage mode to adc and clarify that existing
> pre-scaled mode is 24bit.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
