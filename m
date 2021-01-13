Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7691B2F4F14
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 16:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbhAMPpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 10:45:52 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:42761 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbhAMPpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 10:45:51 -0500
Received: by mail-ot1-f51.google.com with SMTP id x5so2267699otp.9;
        Wed, 13 Jan 2021 07:45:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=BdqXQGPD/2NkmrUn+nwTJIVFrUkOiALOYcPswXSNO90=;
        b=dlzY/AyhiUD2BqVw3MDVVz70yqlz7W11PS5GSW0UmNFjDMmNZgPGkZIj4FyQnmZz/y
         IidVipE+ngNWaqCUImcczpy9oebCslwxouOgW/zAun2jAorp8pue1jKwpt+gMxQ6IzpA
         s6BDshEghq8oVMdoJU4IW8uP2IJ4xNr4dH+Hrf66I0GEUYWZFor/g/1xik8F8P976cpg
         RkALOJPvYHWb5M4h/JSl5UjZ/DaWO1kpqVYtKwPYH9gKYfy1knIIc1U6EKHNbE5Hi7aK
         6mN0G0oXCQCJZDsUYXrk28NISILzBK8HxGE1hlvwK1tDD7isYehHMBoJjRlS0EE1CsWX
         3zvw==
X-Gm-Message-State: AOAM533UtFg9Wvbs5DYi2u9wE6Y2TH7bjvvln/nnnWVpuy4/ziwJVyXp
        4mwmNRlaLb8/+Y9STsqkT6+YWoAOXA==
X-Google-Smtp-Source: ABdhPJy4hkTHovaDGHQtQFCzHl7/SUzB/mHRgEcMFxcZ7l5Zny0qeiF6qMQ2g2l+BQXq5hJIOLfSPg==
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr1626364otc.145.1610552710748;
        Wed, 13 Jan 2021 07:45:10 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t13sm453609oih.26.2021.01.13.07.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 07:45:09 -0800 (PST)
Received: (nullmailer pid 2506186 invoked by uid 1000);
        Wed, 13 Jan 2021 15:45:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Troy Lee <troy_lee@aspeedtech.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Ryan Chen <ryan_chen@aspeedtech.com>, leetroy@gmail.com,
        openbmc@lists.ozlabs.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        chiawei_wang@aspeedtech.com, Joel Stanley <joel@jms.id.au>,
        Guenter Roeck <linux@roeck-us.net>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20210113070850.1184506-2-troy_lee@aspeedtech.com>
References: <20210113070850.1184506-1-troy_lee@aspeedtech.com> <20210113070850.1184506-2-troy_lee@aspeedtech.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: hwmon: Add Aspeed AST2600 PWM/Fan
Date:   Wed, 13 Jan 2021 09:45:04 -0600
Message-Id: <1610552704.291941.2506185.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 07:08:45 +0000, Troy Lee wrote:
> We add binding for supporting a new AST2600 PWM/Fan hwmon driver.
> 
> Changes since v1:
> - dt binding with DT schema format
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> ---
>  .../hwmon/aspeed,ast2600-pwm-tachometer.yaml  | 137 ++++++++++++++++++
>  1 file changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-pwm-tachometer.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/hwmon/aspeed,ast2600-pwm-tachometer.yaml:108:2: [warning] wrong indentation: expected 2 but found 1 (indentation)

dtschema/dtc warnings/errors:

See https://patchwork.ozlabs.org/patch/1425628

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

