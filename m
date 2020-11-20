Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4782BB4EF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 20:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbgKTTMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 14:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbgKTTMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 14:12:20 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1CBC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:12:19 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id y22so5338426plr.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aaGl6ENhV+1nPNZxVybs/FqyHjk4NVv4G31ODZymJco=;
        b=Cul6ov3K/VrA/M6yoYFsMyWnWv5RABcGfwZSulkK5F9T6qnjBZrn7I4r88vJw2gyv9
         19Syq6s/L48amcXSrIKJ6jzuDkyWBs8JdGegXCGCpIwMf/ifUGZ0JEO61rQk5EQ1UpLz
         Gv3v6r8IwmCi/5QffwPcHWRM8ZO6JeS3b1ftRlC7g2f03C6HqXvQr8qzHa31WxbWjfiZ
         qTQwLGKi4YYNjFWAs+8MIXlaYM7ezRPoL4eDylmDaB4bpW2mipRJdJNAhVmkojJE5I99
         b+Bnt2ptITKxsM0MswcGuzopqovb/hesx3Nfwl553aplVEz1pq3PCwKRv1RUA4znX1p4
         C3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aaGl6ENhV+1nPNZxVybs/FqyHjk4NVv4G31ODZymJco=;
        b=Q6txt1LEtCQlpmPwTSDqJBvT19fngXR92epWTOy+tCkYz0ZNUeIqnxQzGihArOntD3
         UXf7A8KcmDnW8oWhkTB/N57GWPJY+mlsPM2DO0tQNNSCR6hQ59U6n/tFgUVqyH/MejCC
         Ev+9ZbOTuNW8MKAtJO78PIucwhOzGDTEZJkcQj6X35DGhOI1R9DoKfjeC9yIut9ozzPu
         4FIjwBwayiYC/7EkfD7AJSfBdN9y6kFmrM0+YIZB1RLb+QZxwxrw5UM5XMERGuxBIsn+
         GdCGv9av2jrbNIHLuQgwm0/4tj/J/zRSVEU7U0p+JChuZZ3OI2gXpKdieDDm+PIxtf7R
         rDZQ==
X-Gm-Message-State: AOAM5316+ZL8wFqb82V7Rc8khdYhu7jVhkI7EGPEuX8gnos5oB9oSPFi
        gN+io3heO7x+Kq2Ouju+dat5lQ==
X-Google-Smtp-Source: ABdhPJxJF5h3qSdDs+4Ydk1ojFx8QCmkTkP0nPcN5ISznYDLvh/GoUqEpAEfJg9xGZKLCBF3ihkrQQ==
X-Received: by 2002:a17:902:24b:b029:d6:cd52:61e3 with SMTP id 69-20020a170902024bb02900d6cd5261e3mr14944214plc.2.1605899538860;
        Fri, 20 Nov 2020 11:12:18 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id x13sm4659006pfj.54.2020.11.20.11.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:12:18 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Cc:     Artem Lapkin <art@khadas.com>
Subject: Re: [PATCH] arm64: dts: meson: enable rtc node on Khadas VIM1/VIM2 boards
Date:   Fri, 20 Nov 2020 11:12:14 -0800
Message-Id: <160589952950.11499.16597042753112987237.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201116064147.12062-1-christianshewitt@gmail.com>
References: <20201116064147.12062-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 06:41:47 +0000, Christian Hewitt wrote:
> Enable the rtc node on VIM1/VIM2 boards so users can simply attach a power
> cell and use the on-board RTC without modifying the device-tree.
> 
> Cold boot with no cell attached is gracefully handled:
> 
> VIM2:~ # dmesg | grep rtc
> [    7.716150] rtc-hym8563 1-0051: no valid clock/calendar values available
> [    7.716957] rtc-hym8563 1-0051: registered as rtc0
> [    7.729850] rtc-hym8563 1-0051: no valid clock/calendar values available
> [    7.729877] rtc-hym8563 1-0051: hctosys: unable to read the hardware clock
> [    8.126768] rtc-hym8563 1-0051: no valid clock/calendar values available
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: meson: enable rtc node on Khadas VIM1/VIM2 boards
      commit: a735defaf1ee74e9f06a616162f1ba6f26555d38

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
