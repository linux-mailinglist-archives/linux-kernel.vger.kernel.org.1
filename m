Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEA82A13E0
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 07:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgJaGoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 02:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgJaGoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 02:44:24 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D486C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 23:44:24 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id l2so10724280lfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 23:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=xyF23DQz+tdywEjKjSIPF+aZ33+DGYbhUGjULH3r3UM=;
        b=Vnnz5LP9razainW5wlgowWD1Wri+eqvUN0R7TqSrS1zF8em3O72tCISyQbSEB5SJWy
         Z51MTUc9pHMsWTexU7k86k07LvbW6dHJG0ZFAZjaN7dNU6uzDeEk+ymMVwL54dHV6xX3
         UDwXQN6waGHmBxJelpyna6WuJMXcDuJIfTDODzfutVWE2oBGKmeXF5NmkRki0dBqyNh0
         302RSnrMRBc33Aa5BehWut2umEpmREjAMXoYh3n1siQWN96rt2e4tAqW7mJJAyGjkRua
         qlrZNV/1csGh9bN1EPnsV89KnrtUcDR6Kp32zXsvQBzyrt8BD+CSZ1iENKDNe8Vb3WXi
         xL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xyF23DQz+tdywEjKjSIPF+aZ33+DGYbhUGjULH3r3UM=;
        b=p35kjclpYMf4NDkqNyS8yF1kaIBpj5jIyXSDv7Km6A4IAKzK44ek7m6r/eR4UyA6IW
         eyPFgKxwaa8A/L/KHLswgJT6UZVMeEwD/e2XS4p3/mEpmw0ldmd4QhlHUUSaU18bSWHp
         RO2CUsmLon1Kk2Lxk6a0xzsuuR6Z1iU28OV3Iy4/6fqzZxjCPrK4geYWKwZDmZIDmQ/y
         /t8N1+LDmeZL+0FHcGwYuSthTH8xR3xgyaZBboK9LX+NCdo1aSuR4vYkTOiOI2RKKMvE
         oHJd/MQ8wQmleomjjAp7vspW5YlEY2IiHYuxcJSBMW3UFIhQA8WnQWQrUpYMacHdCUYj
         rgBQ==
X-Gm-Message-State: AOAM531juVw4ehPeJtZlS+u+24TIftrisfTP0/eWbo0cAgFBjJq0ivAp
        XPwQHLJjpNNEd9UkWSjryS40Ggud/FM0WlQYpx/HPCM7tlMJ3r1L
X-Google-Smtp-Source: ABdhPJxHzntJfZGkhm2SSuugVZkkAJS/WgjbopewG37WDCcye8MuInw730JaSNIDJeefxgbKYsisxZvJlW9lezYWVnQ=
X-Received: by 2002:ac2:4847:: with SMTP id 7mr2406099lfy.463.1604126658571;
 Fri, 30 Oct 2020 23:44:18 -0700 (PDT)
MIME-Version: 1.0
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Sat, 31 Oct 2020 14:44:07 +0800
Message-ID: <CAGP6POKB=dbeyGSCG2qgjZGq-wKcPBOjOLLuzeWME=Pbax7uhg@mail.gmail.com>
Subject: Has the linux-kernel already implemented the functions in apollo-kernel?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The apollo-kernel (https://github.com/ApolloAuto/apollo-kernel) is a
patched Linux Kernel based on official Linux Kernel 4.4.32 with some
modifications on the kernel level, especially for the scenario
necessary to run the Apollo (https://github.com/ApolloAuto/apollo)
open autonomous driving platform software stack.

According to the official description as shown
<https://github.com/ApolloAuto/apollo-kernel#what-is-the-difference>,
the major difference from the original Linux kernel is as follows:


- Realtime patch (https://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO)
- Latest e1000e intel ethernet driver
- Bugfix for Nvidia driver under realtime patch
- Double free in the inet_csk_clone_lock function patch
(https://bugzilla.redhat.com/show_bug.cgi?id=1450972)
- Other cve security patches


However, considering that Linux Kernel 4.4.32 is a fairly old version,
so I want to know whether the modifications/fixes applied/added have
been already available in the current Linux kernel.

Any hints will be highly appreciated.

Regards,
-- 
Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials, Xingtai Polytechnic College
NO. 552 North Gangtie Road, Xingtai, China
