Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3AD2DB3AF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 19:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbgLOSYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 13:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729389AbgLOSXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:23:42 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A188C0617A6;
        Tue, 15 Dec 2020 10:22:59 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id c12so15316672pgm.4;
        Tue, 15 Dec 2020 10:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H+MPl6V5JmDOoXGskKZtv6rWjxRnogZLJ4kW84SY9ds=;
        b=Ebq9jvq8lsnSaUmi4uDwBNEzptpKOUGzLuy1ucPrNHux/8Y6bKrlb4Y3OTCeoXaqOz
         Th8DD3ssxdLs00KurYGlFmZdUazjSVoRdRDWI20jCVUgjbEB8e+5yiTbRMxSTQNjwUdL
         PGm13hLW/tTRDvQp/L/SnBZngEZbCsvOaDeudsv7RSRu5i38JgyfPNVujdm/uWXQkrc+
         8hxKrrsOxNgyTYdzgGFSrj4u9eJtivO5+sOhY78Bw2YKbYspakOOnL/DbtUwaqYrNx2d
         QkUwrlJ9q56ISbwYEC0RiEgctz94p6h0WO8mQ6acSFProI5zlAfhyOpCkM2ggt0Tgq4w
         zdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H+MPl6V5JmDOoXGskKZtv6rWjxRnogZLJ4kW84SY9ds=;
        b=t3ZyNU6w62211u8heSo0ubGUghuapqSxCLhg5YI+UGQfNZSFTmDwuDrtevkE41wRgy
         BhvUCPBeqokceZgYumDoDU1pxn8jbvEaPq8Wb5OZ7o/5q1w+EsTpu/X5gyi+8AKgeYrG
         NLLcd2zPYz5cNqtybY/qxRJOTfqyAW2MjTgzsw4xCEUsyku2rOXEt9MYjIs1sjPDo8Fa
         rGdnU+6k6l6Qif3r+FFBu2BIN9QGQvfgceLDBO+Hp+ef5IGfdAJVFyM+N9S1b2rZkXwx
         t24Z5TiJ/q/f/GQenu3aJgjuhxNqjGQ991jrvw2zXgX7jYb5VdyaIUZAUnrmmi3451YP
         3+lg==
X-Gm-Message-State: AOAM5307ZZHhRcBIaQJJerUCYIDOKNgf/w49UcuzVA7Sx3OVDkH/VYrR
        /4QXUDXevGOvb0Wpy+HbLfik+aldiSY=
X-Google-Smtp-Source: ABdhPJz1X6MFvy6BAR9qAePvaIKqYUS4US4TnynOlAcH4zfO1oowWMECqvCCcOynwU9C4TBuFZpmuQ==
X-Received: by 2002:a63:df01:: with SMTP id u1mr19774627pgg.427.1608056579002;
        Tue, 15 Dec 2020 10:22:59 -0800 (PST)
Received: from [10.230.29.166] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a26sm25249447pgd.64.2020.12.15.10.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 10:22:58 -0800 (PST)
Subject: Re: [PATCH V2 1/2] dt-bindings: power: document Broadcom's PMB
 binding
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20201214180743.14584-1-zajec5@gmail.com>
 <20201214180743.14584-2-zajec5@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5ddb9273-a27b-78f8-71ec-e82b5150fc18@gmail.com>
Date:   Tue, 15 Dec 2020 10:22:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201214180743.14584-2-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/2020 10:07 AM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Broadcom's PMB is power controller used for disabling and enabling SoC
> devices.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
