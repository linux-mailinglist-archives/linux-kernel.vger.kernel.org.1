Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663C73016AF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 17:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbhAWQOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 11:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbhAWQOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 11:14:48 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1363C0613D6;
        Sat, 23 Jan 2021 08:14:07 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id j25so4325130oii.0;
        Sat, 23 Jan 2021 08:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aGOwdo7IiEjB/o8PzIQ44cs8SlfL93ZRbT69u9ZgBSA=;
        b=vBfeVFCOy6eV/pI2NrmOSdW6HDuYebvlWjjpg3Zc3Bl+xLB0PPQUw2FXULxuLp03mX
         z9Wj9DWEi8zTyhwvjdA3feOpjdwaWcSuCHtRKlENDryeqOG2zCGWMB3/8ykTyZ0r5HV7
         sAgv5E/OfpqrR0+kUmAg6kh1N3I+wwpuwiagAP+C4sqnD+N9ihP7HlfSc7540kce76Qp
         wkhWgyQKihteORYFEDPUBy/pC/9SCfggequ9pfvktOk0iUUWwUoFbzrWJcxzVUymoPZN
         iQUQ3nYFj9f3cxJwKwg13Vnbj/cuucvoQAqK7v3QJvBYDBJJah2F3FP1QWudGTAMKnqm
         iDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aGOwdo7IiEjB/o8PzIQ44cs8SlfL93ZRbT69u9ZgBSA=;
        b=mnoaRBVtAZphLrAVFV/W/oZqud1S7T9evEDo9OM2tvuL2hs2OvCR8xM5Bmc7if4x5E
         4EsqH6yLg4ML0rRgPTeHBoSslFwv/FzlVHMpANSvZhQ9RXo1nScuwyjoXfYvi6nHmcgN
         EyZQzu3vYJuJ0Nt1AIG/nz6BSzrAoBsq+t/cdBDVKZLP/k5Ioy/fpsezRu08mK8n8CDW
         tHo46jT7QQUAzey5d7B8EROeGcuesLeo7S4qDbV6iRXYDZNMplS79tvSwovi4ArsYw0w
         HbmM8ECExsvNjfJ5x9n/KY6t1RHH3sJEpUUAT1qaJGQ796+1Vg6QkaU85CUFGo8/o1Nz
         22Cw==
X-Gm-Message-State: AOAM533BfOmClIBfDU6IJXiZmdESRMKAIdu5Egidm//MuAS5lGgF+4Kk
        bLAqZ76/CJI07NDOumnby4c=
X-Google-Smtp-Source: ABdhPJwUX1wZ0HjqJqPPmC6y8f3rdsNa8J0yV/pB7b5Xzuxhi7oi8U92QTpcFe8nyjssXaaj3SuVKQ==
X-Received: by 2002:aca:b5d6:: with SMTP id e205mr6465360oif.15.1611418447275;
        Sat, 23 Jan 2021 08:14:07 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r8sm2406529oth.20.2021.01.23.08.14.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Jan 2021 08:14:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 23 Jan 2021 08:14:05 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Troy Lee <troy_lee@aspeedtech.com>
Cc:     openbmc@lists.ozlabs.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        chiawei_wang@aspeedtech.com, leetroy@gmail.com
Subject: Re: [PATCH v2 4/4] hwmon: Support Aspeed AST2600 PWM/Fan tachometer
Message-ID: <20210123161405.GA50622@roeck-us.net>
References: <20210113070850.1184506-1-troy_lee@aspeedtech.com>
 <20210113070850.1184506-5-troy_lee@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113070850.1184506-5-troy_lee@aspeedtech.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 07:08:48AM +0000, Troy Lee wrote:
> Add Aspeed AST2600 PWM/Fan tacho driver. AST2600 has 16 PWM channel and
> 16 FAN tacho channel.
> 
> Changes since v1:
> - fixed review comments
> - fixed double-looped calculation of div_h and div_l
> - moving configuration to device tree
> - register hwmon driver with devm_hwmon_device_register_with_info()
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>

checkpatch says:

total: 0 errors, 9 warnings, 26 checks, 779 lines checked

This is a bit much. Please run checkpatch --strict and fix the issues
it reports. Please also fix the issues reported by 0-day as well as
the issues reported by the bindings robot, and resubmit.

Thanks,
Guenter
