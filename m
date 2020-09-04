Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493CC25DDA3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 17:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbgIDPYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 11:24:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730818AbgIDPYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:24:15 -0400
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6726D2074D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 15:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599233054;
        bh=Yxplbxuim3UDb+I7XMO4inJ9jEGTvWmyLCzhew7HEXI=;
        h=From:Date:Subject:To:Cc:From;
        b=0qKH2jIBKNeN8OfK6crv12heMS7DxRVIMQYfy6b+am2KCsEoRo5RHLfMA7IzdJvCi
         ds/orGX3P1lkvuHIX40+vBafE54MeyJYvT9jnyaOFeEFFRlCEg5Z2FpVQ3LVhRZzxK
         a88UoTxAPR1uHZKG4VHw83pUYInXZl8Q/bXeI/P4=
Received: by mail-vk1-f182.google.com with SMTP id s127so1743371vkg.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:24:14 -0700 (PDT)
X-Gm-Message-State: AOAM532IbJbexZiC26BoXwd8rWk2siUljBZ1HGx5lP2mvJsWVG6r/rnW
        O+tNfTJzmndR1j3lTBUAAitISd0exw/vaKDJT9A=
X-Google-Smtp-Source: ABdhPJwaKjM9nt6Q7usJijC2V1M6V+XTmGf5vBBZMWYajW8XO2tpDiKRn/FMEU2e2yoHM5SkFi9xGjfgqWRzVRjqHhg=
X-Received: by 2002:a1f:ab02:: with SMTP id u2mr5882925vke.80.1599233053578;
 Fri, 04 Sep 2020 08:24:13 -0700 (PDT)
MIME-Version: 1.0
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Fri, 4 Sep 2020 09:24:02 -0600
X-Gmail-Original-Message-ID: <CAB=NE6VTTOcrH0mZaR2wVdzWFjYctzegeKFuSnx4NsssaKTHZA@mail.gmail.com>
Message-ID: <CAB=NE6VTTOcrH0mZaR2wVdzWFjYctzegeKFuSnx4NsssaKTHZA@mail.gmail.com>
Subject: Dynamic source include for kconfig
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Masahiro,

I ended up needing to do a dyanmic include of kconfig files to support
custom / private vagrant boxes in a project I maintain.  I figured out
a way to do it, and not sure if it was intended, but it works:

https://github.com/mcgrof/kdevops/commit/404a55326198787758fac88af3c60dcaecf599fc

A new helper for this sort of thing might be neat, if one follows a
convention. Thoughts?

 Luis
