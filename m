Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED261F5171
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 11:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgFJJqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 05:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbgFJJqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:46:53 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B73EC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:46:52 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id e4so1663336ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=veq+9NOWY9jhOHWHfiSDBHJjCR3y8kFCK6ZQ7IkSXyU=;
        b=eocK2D5fg8ysvRo0qAQELuhikgf34yW+RuZF/BmE2TJGjRV13nf2A6HeCRQ7FKHtuV
         EDzYm0aR2R7QwSPASpqa3kqqk7z3M795lh6Sc0eTTAWV6bhE8QwyFwI90ilpCJFDLNmo
         9RDWqA0YMEI35jjTBJZ4R3ptB8+HE2ImnV2X3kB71j9vTfu46Y9wSLBHALV0ZcqyAi1b
         Xz065zwjZ4t0HfcIPOPx5uPrZB5kcfCI899S3wNso0KrO/SEbFORlAcVKQPiUYSmtw10
         gI65A0Y5V0m2FfCdbDp+WkVNAAMC+9pXmSmvDmJlcVgOmWn+o61dioIjkcYQ3JOMCBKQ
         gvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=veq+9NOWY9jhOHWHfiSDBHJjCR3y8kFCK6ZQ7IkSXyU=;
        b=OD+k3Exo0Wv3zc+vIluzfkxya9oZJe/II/CvbyiJazlgYI8YXYglxv9CkhlzHZeIDc
         JoxXV4SIF5dOu3z8AqNJNA1YTohE6pQmigOdaM1TUgBMlaWDdlHjmSeabitbeG4e+inY
         Z6f5/o4AAckbfZ2aVxaej6yEsucPbiJki+159FXsjjNPL35ZwQOHJGDTt4cFPp8ueCY2
         caUMsUu0futl5DOcfnQebGUIzebwNaxno+T6z9cdrWbF91BF7ld8j3tE451B8C7oCdFR
         WNZ238kcLspBkD6ZTFShWIPERw08Xbau7pi/VXnCPFZ2pL1PSQWfYY7WuGKVp4iONDQK
         SjjA==
X-Gm-Message-State: AOAM5326NojpA1rVu7Tegg7zbBDs2lOENd3Hu1NlUGJ29LsD46OOfHfk
        sCZv2UdqF7zZzzrR45+BZQ+E8cLKyrizGfki+acYqQ==
X-Google-Smtp-Source: ABdhPJx6ZhHz1m36PS68+yVtfRWfuYn7CcqJNRHrV/4hYK/YvqbJYUu3WP3KpaP9b+35/qNyI+xerrZ0ItZHfnFCHbQ=
X-Received: by 2002:a2e:974a:: with SMTP id f10mr1351794ljj.283.1591782410483;
 Wed, 10 Jun 2020 02:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200605224403.181015-1-sebastian.reichel@collabora.com> <20200605224403.181015-4-sebastian.reichel@collabora.com>
In-Reply-To: <20200605224403.181015-4-sebastian.reichel@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Jun 2020 11:46:39 +0200
Message-ID: <CACRpkdazmx7g9_gc4daqivUmM7HpR20k0HVeiGW=PaZVwDq7xQ@mail.gmail.com>
Subject: Re: [PATCHv2 3/6] power: supply: gpio-charger: add
 charge-current-limit feature
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel@collabora.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 6, 2020 at 12:44 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> Add new charge-current-limit feature to gpio-charger.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

That's really neat and useful.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
