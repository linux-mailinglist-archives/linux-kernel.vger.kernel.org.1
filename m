Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6994D21731C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 17:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgGGP42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 11:56:28 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45390 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgGGP41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:56:27 -0400
Received: by mail-oi1-f193.google.com with SMTP id j11so32597969oiw.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 08:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NCjRnARbr1X8HdhzuPrbBUvApsiMNIB+sJAlPqOMZu0=;
        b=bHtHfMQwBZcAKI5N606S5lIAMwHQEFdpzugDnoVY7c1mewElTMhVvLzdsUdKiPF2cy
         cPAzb0vU/ZQubNjqRCLYj/sucdMbB9kfTiwcxifdWlpSDa43CaaqpXFYODUz7o/ZdTkp
         9wP2Tx4RxxKrjgZ5lkAGZC+hN0NloaEF0PaXH3SVbK1aYhmHLEoTR9UUoDNVF0WiXkQX
         LJWZ51lSFZRFbSDEdoVJds6WDqtLYsNZvJPN1Y1inli99tGaGepJN7iCPbBnvWc4SUK2
         V8YZhVyJbFbFPugxMYyaELrd8R+1T3eZYJeTmbkTqExkFiV3CkxU7mNeIroeMqG/w+wU
         fWcA==
X-Gm-Message-State: AOAM530nDdw26Dw5uZJ8ObNV/3SzQ1Tb8kzA5qOC18G4dXwaPaiG/cXZ
        PwDFltyKYUS6oPz2Jk9w6uf3YQEwIRW+CtQyAMs=
X-Google-Smtp-Source: ABdhPJycD20badF50r3gZ0VFnYTjpBMRzp88oAnSeW9v7jdnx+d0oH4x5ss7im4Lkf+hEXpqf+NUv2pwUY9ZMMu7nCg=
X-Received: by 2002:aca:4a89:: with SMTP id x131mr3948863oia.103.1594137387019;
 Tue, 07 Jul 2020 08:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200701194259.3337652-1-saravanak@google.com>
In-Reply-To: <20200701194259.3337652-1-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Jul 2020 17:56:16 +0200
Message-ID: <CAJZ5v0gPKHSpC+9BNt_n_wP+8Lmekb1VapfgHPwenHopekHV=w@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Fix dpm_list ordering issue due to fw_devlink optimization
To:     Saravana Kannan <saravanak@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 9:43 PM Saravana Kannan <saravanak@google.com> wrote:
>
> When commit 93d2e4322aa7 ("of: platform: Batch fwnode parsing when
> adding all top level devices") enabled batch processing of fw_devlink to
> optimize the parsing time, it caused a suspend/resume regression due to
> the use of deferred probing early on at boot.
>
> This series fixes the regression by avoiding the use of deferred probing
> when optimizing fw_devlink parsing.
>
> Saravana Kannan (3):
>   driver core: Don't do deferred probe in parallel with kernel_init
>     thread
>   driver core: Rename dev_links_info.defer_sync to defer_hook
>   driver core: Avoid deferred probe due to fw_devlink_pause/resume()
>
>  drivers/base/base.h    |  1 -
>  drivers/base/core.c    | 44 ++++++++++++++++++++++++++++++------------
>  drivers/base/dd.c      |  5 -----
>  include/linux/device.h |  5 +++--
>  4 files changed, 35 insertions(+), 20 deletions(-)
>
> --

Geert, any chance to test this series on top of 5.8-rc?  It is
expected to fix the suspend/resume regression reported by you.

Cheers!
