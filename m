Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265372C42C7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbgKYPUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:20:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42098 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbgKYPUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:20:49 -0500
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1khwb9-0007Kr-PN
        for linux-kernel@vger.kernel.org; Wed, 25 Nov 2020 15:20:47 +0000
Received: by mail-wr1-f72.google.com with SMTP id w17so878520wrp.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:20:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1MLMHISOaIgeTutRvpuwhXxO602bfmP5K9rHz4FiRbk=;
        b=XRRt2UhNydJn0rv9RdSeZa4k382fX5ghit41uJDCyY1J8J2UWq/FH6F6LqsRra0XrS
         91I6z1wRYAnscV0Ler4mm8aQUX6q2ND7fe/SOIrrYkTw025cmA7trSQLkAIsuyd7Uztx
         qtWP4hoQSUc8cLliPk2DWLUg1z2tyk4B26DSkaYxgHWagm0GrpmC7UAXTefQ2I2NgeIb
         Ne8/v58Yq7ex96ycMpHFEFF4T7OUd+wOb0g/+ieH5TVz3SGe1AdnBxnhhhiVtP9xvoKZ
         23HrVRVEsYYW+ds835hNzUOCfwNZoMUjDlfJZf3z62fOYLV3/TLZrTZgLfcP1QumCYQv
         r5Jg==
X-Gm-Message-State: AOAM5308ov8s+Gw9d+bE0BFUa3QMUWjmF3JyYHcWshW1pQIqMsqypBZN
        x9NEPOcSzIBsgvxExxs1CwpX2v2cCIKj3B3vbgbb4MTnNvgHJw/8l6ILet0w0y/oQryt9d/av0C
        PSCjTBYQC3X12NaHOZBNZRes3Kh83tJb17IhyBqsJMg==
X-Received: by 2002:a1c:21c1:: with SMTP id h184mr4622244wmh.106.1606317644471;
        Wed, 25 Nov 2020 07:20:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNl3QW6kYs2TIKJGqJ7Hpd3zDYSdJfygEszsCEVOuPl+mFLvTEXyKWiO90gc5dVPV8CMfqbQ==
X-Received: by 2002:a1c:21c1:: with SMTP id h184mr4622220wmh.106.1606317644221;
        Wed, 25 Nov 2020 07:20:44 -0800 (PST)
Received: from localhost (host-79-35-122-236.retail.telecomitalia.it. [79.35.122.236])
        by smtp.gmail.com with ESMTPSA id i11sm5262891wrm.1.2020.11.25.07.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 07:20:43 -0800 (PST)
Date:   Wed, 25 Nov 2020 16:20:42 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Dan Murphy <dmurphy@ti.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: trigger: fix potential deadlock with libata
Message-ID: <20201125152042.GC73489@xps-13-7390>
References: <20201102104152.GG9930@xps-13-7390>
 <20201125124648.GJ29328@amd>
 <20201125141517.GA73489@xps-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125141517.GA73489@xps-13-7390>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 03:15:18PM +0100, Andrea Righi wrote:
...
> > I'd hate to see this in stable 3 days after Linus merges it...
> > 
> > Do these need _irqsave, too?
> > 
> > drivers/leds/led-triggers.c:   read_lock(&trig->leddev_list_lock);
> > drivers/leds/led-triggers.c:   read_unlock(&trig->leddev_list_lock);
> > drivers/leds/led-triggers.c:   read_lock(&trig->leddev_list_lock);
> > drivers/leds/led-triggers.c:   read_unlock(&trig->leddev_list_lock);
> > 
> > Best regards,
> 
> I think also led_trigger_blink_setup() needs to use irqsave/irqrestore,
> in fact:
> 
> $ git grep "led_trigger_blink("
> drivers/leds/led-triggers.c:void led_trigger_blink(struct led_trigger *trig,
> drivers/power/supply/power_supply_leds.c:               led_trigger_blink(psy->charging_blink_full_solid_trig,
> include/linux/leds.h:void led_trigger_blink(struct led_trigger *trigger, unsigned long *delay_on,
> include/linux/leds.h:static inline void led_trigger_blink(struct led_trigger *trigger,
> 
> power_supply_leds.c is using led_trigger_blink() from a workqueue
> context, so potentially the same deadlock condition can also happen.
> 
> Let me know if you want me to send a new patch to include also this
> case.

Just sent (and tested) a v2 of this patch that changes also
led_trigger_blink_setup().

-Andrea
