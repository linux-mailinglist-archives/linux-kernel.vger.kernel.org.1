Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C46E274D49
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 01:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgIVXZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 19:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgIVXZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 19:25:08 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421F0C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 16:25:08 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id md22so1835816pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 16:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RetUavQOIt57WfxMeCm4pX+acU/jkghzKkK6NLzs3ro=;
        b=Vtw2iUAVLGa7zvVYRZMoItF5ZoUP10/9ShsNIkEUA9NUbdFi27UfemA5GJqyGhF7TW
         Y4wJWUEkj8gfdPL80NwgY3808Oz9rrJDjVdCaZkfVxtJ0MSM+IVdjAJZumtvL2aAEmsQ
         nGiLWHCEe2n7qigHx/Pwts3XzFafF4j+/Q/IWV8hSAsKrybLn1PbL3+qWVZsN86KtTsn
         jKCu0VaJ+TBxjsgWL+Z3qETeCEmCOgxigcR19ocpxlZfv7535M36557ZvPcm1vYW/Ted
         9cZmZGiHr0j1texpbZH5uPiqQYZ9Ymrrkup3L8N3cOxLGZSls1mr0LHqXzqJpWWU0rHW
         tUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RetUavQOIt57WfxMeCm4pX+acU/jkghzKkK6NLzs3ro=;
        b=RbgWymR4zVz4pwxViVLdQr79CQ7x6nws94IxLPc/vxK9Jnj6brRgBMvT3uouDh6YjP
         Y2JVK9og99U2oRpJz24PRyg7hcs7fRidP/7pF7G3Dr4JNkwUAI+vtg5iJkbBTdSI8Cbw
         fxXNK+sFLtr7kApFkugYilZoOErWtfO/oNuOGPi7xxYmHWwbGPCm3rz0EgIjHEV56zzr
         hm43jp9wnLOOVVHzEaGiLQQED7IjNO3UTBWXrns9st+6meAhhOMpSeAaFW4XT5ja1zA+
         3TXpOfOjIMTEU9Rh4NuzU0QQ7euugNiheGY35nIFtveM4NKe3/hUCLZ/3z3hyRfewxbD
         FBiA==
X-Gm-Message-State: AOAM531ztmLz05gIu4sD1VKyg9k+RGw/U4CxxzKI1NnFBN1kjTrA+GqK
        lfPJ8hhAgae2IrvMG48v0H8pPg==
X-Google-Smtp-Source: ABdhPJzn0uUoJaJ8ALwwXvEB7emz1aIfDqNy+IyBfoiUttzOkGxWKYX4JEsQFExgalgQstqLPG48GA==
X-Received: by 2002:a17:902:eac2:b029:d1:e603:af72 with SMTP id p2-20020a170902eac2b02900d1e603af72mr6755369pld.48.1600817107728;
        Tue, 22 Sep 2020 16:25:07 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id b15sm15874672pft.84.2020.09.22.16.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 16:25:07 -0700 (PDT)
Date:   Tue, 22 Sep 2020 16:24:59 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Jarod Wilson <jarod@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Thomas Davis <tadavis@lbl.gov>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 4/5] bonding: make Kconfig toggle to disable
 legacy interfaces
Message-ID: <20200922162459.3f0cf0a8@hermes.lan>
In-Reply-To: <20200922133731.33478-5-jarod@redhat.com>
References: <20200922133731.33478-1-jarod@redhat.com>
        <20200922133731.33478-5-jarod@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020 09:37:30 -0400
Jarod Wilson <jarod@redhat.com> wrote:

> By default, enable retaining all user-facing API that includes the use of
> master and slave, but add a Kconfig knob that allows those that wish to
> remove it entirely do so in one shot.
> 
> Cc: Jay Vosburgh <j.vosburgh@gmail.com>
> Cc: Veaceslav Falico <vfalico@gmail.com>
> Cc: Andy Gospodarek <andy@greyhouse.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Thomas Davis <tadavis@lbl.gov>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Jarod Wilson <jarod@redhat.com>

Why not just have a config option to remove all the /proc and sysfs options
in bonding (and bridging) and only use netlink? New tools should be only able
to use netlink only.

Then you might convince maintainers to update documentation as well.
Last I checked there were still references to ifenslave.
