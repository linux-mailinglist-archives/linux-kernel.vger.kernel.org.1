Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D05304F30
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 03:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392420AbhA0BmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390273AbhAZSrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:47:52 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629ADC061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:47:12 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id h15so7780321pli.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VPwgXgFqNGkyAT4I2faAQzFZ/NTwi7dZ5sVT5oD6JPw=;
        b=eFfvlwAn3lbwGAz0xzWPehLR9zNPgwTdTEID8ALGkoxN7spGHtH4qzH9CBWG289rJR
         sXkBAclZxO7YnFXuS0n8o8RZav4shQiR0om5sfhd+/AgxukvdCvNrWTdcn+RRCgVQjzw
         pP57h+W7DnXg1JG172gXKXpZCm9lYltLhVmN6hDeVItBwLBw9tm5M7IUT/aKwuUY+Rux
         sKpCl4kldAr7jM4sh4SkyAF+zaqlFXRRfUo8cEfn+RU5aI2FBUnn2RzwcUx97XPLC0gM
         zcvWambS8Nz38JbWjTzxbRloqY0UoV366banFcYNV974OFZk5qy+ybdE4xjbvLgRSKVE
         HAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VPwgXgFqNGkyAT4I2faAQzFZ/NTwi7dZ5sVT5oD6JPw=;
        b=rSEnH1Mp7Kk5IUq4QzpXLZ5+cWo5GpeIFuoxlUEIlBPRxKH0yNhILB0Z8kxkyu34wL
         OXp0qxPWf3eLSCCbn469BLr5gaoWFgycXZZiLp2r7EEG1vKbIaYKEi1xFR/jleK3DNHB
         SNucOdwHQVNUZuYl7FjuXV/9yKlsVt3yeE+qutTOGMdVeDiF4xYCDN9uACX4bxXN8dhi
         Ijs1IP60ani2D41CuqYLeU7ivKl4oTXxyH3ZBWtNYSh/8fwmKLE5aTwLwGpvGsJBryoA
         dt1eEDXHLsiGWncNM3pjm7p/2RRkFTleiBnA2UCPqTRg0GWO6/fMpoZtu/EmD36ly/fk
         uL4g==
X-Gm-Message-State: AOAM531WiuFuw+dgFA3GDaVLYztZ2hu7iYrWBDzChIuRHyCjF3xsKKJP
        eEnpHdkmPnu6vmovXBKqu6xVmCEXrlRw30HnV+U=
X-Google-Smtp-Source: ABdhPJzHyKhh/DfLKf34PQr3syLT4045ewNp5WVGOYs3bapKpv/AZtyGJ+VRiSPzC+TmayHn5mSwsQ==
X-Received: by 2002:a17:90a:1503:: with SMTP id l3mr1180911pja.41.1611686831417;
        Tue, 26 Jan 2021 10:47:11 -0800 (PST)
Received: from [192.168.0.104] ([49.207.195.86])
        by smtp.gmail.com with ESMTPSA id z3sm19281195pfb.157.2021.01.26.10.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 10:47:10 -0800 (PST)
Subject: Re: [PATCH v3 12/12] [PATCH v3 12/12] usb: misc: usbtest: update to
 use the, usb_control_msg_{send|recv}() API
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Bixuan Cui <cuibixuan@huawei.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Zqiang linux-usb @ vger . kernel . org" <qiang.zhang@windriver.com>,
        linux-kernel@vger.kernel.org
References: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
 <20210126184043.915235-1-anant.thazhemadam@gmail.com>
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Message-ID: <640bd2a0-89c2-b01b-4827-5d2f05b2fb90@gmail.com>
Date:   Wed, 27 Jan 2021 00:17:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126184043.915235-1-anant.thazhemadam@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like the subject line got messed up for patch 12/12.
I'm sorry about that. Do I have to resend the patch?

Thanks,
Anant

