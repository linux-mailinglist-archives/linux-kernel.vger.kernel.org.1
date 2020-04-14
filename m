Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9A31A7BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 15:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502488AbgDNNC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 09:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2502439AbgDNNB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:01:59 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF81C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 06:01:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d77so12868869wmd.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 06:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=YVNWdCQPKJKUDqzVBB1EjscpuxC/BVDNlLQR4zPQltE=;
        b=F+NDxTzt0jSNyYuibeNcpYS29kH/dH9SgCKN6b+K3wMYaZUuxlLfgfyGcAbP2h0qdZ
         v5ty2KiP40jcS2YPnLUs9N3wLbBGFlPsmxLBz9vYkJmAglbzu5s+mOrpAJ5SHAH1gCk/
         RbLkmcGHtlfzo0bULOJlIvArXgTW/oEjAnUAiJ0LCi4ZBNTgD1NgT8uDdMRaxaKs0iUW
         GAi8PV/bvtqXnJSi3/taYGo2up50KspNB97UU4DtyFS78WE7jbTDyHVMSY2dQLxInGjw
         UQht2jQM0IoMKbzEzH6Mc/oo535EjsNaJEY0ODfgPfo0e+H/6DJngLZRx793PprZeo1D
         rvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=YVNWdCQPKJKUDqzVBB1EjscpuxC/BVDNlLQR4zPQltE=;
        b=NiMZa24GW/hQW4qOYqzTEjDaCQc0lwBxMGgWQMgG6cX8lk3mp6k123kOLm079G7a83
         qh7ysAOQlyQykc3ROlKeBtEEb5Hx0lyvCAjXyx+EaeZBzyqZYdZuLZQY4nS00ahYQEoa
         ZahYQ64FRvdLCDtNGY0T28ram5XWG8gHSeyi9ES2fALHMvf+ge8uvGxzAEh0f/yzg66k
         e7oTxQ1qyQPEqmclJhNkgJPwlzYdovmtoLKjSkZeG9vAyNg9IXqEK0ns0Oouoto1MKWJ
         8PrXvOjQ7ykNU4rloeDzoowLaXpi8XpJyEyKhmGtvZm6Yvnqk64ZZfSATFH/Cyqep3EI
         Q/1g==
X-Gm-Message-State: AGi0PubRuAQCFVfmCCHr67Ol8gOFmbsRH9GWbHvR4ywOp8KKld8mFdqV
        /QuzkNG63UZXY2yusyaz3hOjgA==
X-Google-Smtp-Source: APiQypIOrOF7YYEaKaXDccoLPvbc0JkxGKYNccCQyRAQHIKq/YkGUH67S+Cjj2L2nU6/ItuV/nM6cA==
X-Received: by 2002:a05:600c:414b:: with SMTP id h11mr23316590wmm.9.1586869315652;
        Tue, 14 Apr 2020 06:01:55 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id h10sm21260991wrq.33.2020.04.14.06.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 06:01:54 -0700 (PDT)
References: <20200330234535.3327513-1-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, narmstrong@baylibre.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 0/2] clk: meson8b: allow the HDMI driver to manage "hdmi_sys"
In-reply-to: <20200330234535.3327513-1-martin.blumenstingl@googlemail.com>
Date:   Tue, 14 Apr 2020 15:01:53 +0200
Message-ID: <1jh7xmte4e.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 31 Mar 2020 at 01:45, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>
> Martin Blumenstingl (2):
>   clk: meson8b: export the HDMI system clock
>   clk: meson: meson8b: make the hdmi_sys clock tree mutable
>
>  drivers/clk/meson/meson8b.c              | 6 +++---
>  drivers/clk/meson/meson8b.h              | 1 -
>  include/dt-bindings/clock/meson8b-clkc.h | 1 +
>  3 files changed, 4 insertions(+), 4 deletions(-)

Applied, Thx
