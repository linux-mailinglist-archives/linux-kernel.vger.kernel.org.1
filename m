Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC4C30416E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406055AbhAZPCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406015AbhAZPCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:02:02 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3989EC061D73
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:01:22 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id s18so6787037ljg.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lirWGcwxQ/9sPMV+iwf/h9oS1/CrHerBIWG2c3EGSGk=;
        b=oxDNjk3iYXpmm6bruISbusuPot9758mJ8Dgv+nZKud8ztqpQNcDycw29k3Ecz0PiyL
         o42TBWfTSj49+9TPcA+9BZ3Zim6TnBDn56Ya7bmFqDxaz0wH8t9qCSXFJezTPjfiRwaB
         O6bJhXI6k27/dPyMOVaiNgRVN/zh8XTY05LAa0W6F2iIsY65mUpDEvUDWbKPts4L4neT
         UlP7PrSI5Q/gg5m8VV4LRpepfajeLsAioMA8gRGlOYAe5ItJpoAKB2veaJUXnDlyjpbl
         uzlUiwlNAa5t4lx/ZS9G6uSjCBSLmozFkbTwd7jb14OdgxmDinoWOCAHfVC5eMwuA4le
         p0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lirWGcwxQ/9sPMV+iwf/h9oS1/CrHerBIWG2c3EGSGk=;
        b=ARdRjDkOg8MiZnxJwY/50CSVTWjJ6TQqT4uTX6akEdBOI34p7PlJBdYd6vSJdkRIB2
         AgaU8v0tpXnVOI6YZ+KxSUaHCTMna/Lcpnm3CyySQcMGRJ8v66051h8QLizLSFTrvKG9
         jph1hpBIRvpstffep0z5aKRUKdOWJjYf4FvfV/0dQQ2JfwUWhDHofuptXvDTQKjGinrY
         Jyd7pqLa4Gs8pL07ICcoNF3LuNjBHZmZL1RuOKy5/kzK9LPRkBkKWnlTrj4rdhekGbMq
         A/LN4tTUhdO5Q488fPHZkemT6504QDOYkrEv7OFfzehPzd+8Rj/ycwOrIgqTZkCX1jqs
         28PQ==
X-Gm-Message-State: AOAM531k5fM6bc0Y1WGDjALUNlOjYZDz0mntbIR7R1+TjXF955ZeOKpA
        8NPDgE0r5VzsUW1wVgBt/1JdtyFOkLaUXqrGQdII8g==
X-Google-Smtp-Source: ABdhPJw7GgZKBeeQTizTG5WDVnMhfRi/N35rHmdXVZj4220Qaw571LqXQu07Fhyh4yYgtdx58u66xSSMeVVEqT4HoEo=
X-Received: by 2002:a2e:b4cd:: with SMTP id r13mr3179920ljm.273.1611673280673;
 Tue, 26 Jan 2021 07:01:20 -0800 (PST)
MIME-Version: 1.0
References: <20210126050817.GA187797@x1>
In-Reply-To: <20210126050817.GA187797@x1>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Jan 2021 16:01:08 +0100
Message-ID: <CACRpkdafPAJXYar=n2En7GC=gVQ74iOejH4j5cDu3Co3PR8h=Q@mail.gmail.com>
Subject: Re: pinctl.rst instead of pinctrl.rst?
To:     Drew Fustini <drew@beagleboard.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 6:08 AM Drew Fustini <drew@beagleboard.org> wrote:

> I was having trouble finding the pinctrl rst documentation until I
> realized it is named pinctl with no 'r':
>
> Documentation/driver-api/pinctl.rst
>
> Is there a reason for this?

No.

> Is it worth me submitting a patch to rename and change tree-wide
> references?

I would rather rename it pin-control.rst in that case.

Yours,
Linus Walleij
