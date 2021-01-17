Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46B92F94BA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 19:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbhAQStI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 13:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbhAQSsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 13:48:51 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE3CC061573
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 10:48:11 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id q2so27023807iow.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 10:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mi63zrn/yhLxbCT3j7ObqnTSzO7hqzxdnEj7AfgzXoo=;
        b=2MTfSPDh6m0S5aWFRMQERePlFp5gGbf5Ds55pzTh3Vlqlb70ay8lSMc8DiGipcz+ke
         J3ymOvjxAtxFIXDmZyoS/xlW2Ns/YZPVjBnIfjoVy6WZaplDICONBRxFm+W0R2ybPkmK
         5pwjK+qmwuPbwy4sIwWUnlMJGLFY0Y7iQWvaOBLlO2A7A9IztHegb1JD5OT8hxDh7zCE
         bMt4soJM0BdJ4GHhgKnYFOTfLQJBSx83kqEFb9JPZZfBI4Bh9LtBlQOi7nR/biLCap6R
         CpMk9pFqoWW6vlHcwsbO5eslqbxbVgvXjSXVr07eawChY2HXm43la5LGg0vb5E+6ZkRy
         aFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mi63zrn/yhLxbCT3j7ObqnTSzO7hqzxdnEj7AfgzXoo=;
        b=pq/wM5SjdEC5FL6c5MWE0YON38iK4BOcMxc9p93cX37vvBRhAZwuj3Tvo/ri9axix3
         rlbGcqkNvpAL8nhaaB4Pq4Ak75zp/TaHVPrfkHHql8l/30NRC2BxxNjBEtRP9NXUtXSH
         OKAMSHFf8TZwabOwEDgO/mdsh7TT4Yq6bvL/D/XoJBd8N3ialvdikASKhehPo30G/P4I
         rNUV5Kmc0xdNQKvavzBNYfdKc9Y7xbIS+uNlvNmQEk0J1A5Kr5D4XGJ8Ip1H95u39kIn
         LvVG9I/PSOr1x5godc01RsaHFQN0jWl9hn4Lsk15WXKOlWsajDLVqj3TJY/MuW08OSIQ
         LY3g==
X-Gm-Message-State: AOAM532/pphS0olSU+cJ15Za1VEHlquyDsGH8asPK0t6rkUA668sgNDO
        HTArMezYFSKCoEz9GmTdkgImXvDL7W+YSA7QdcNSvQ==
X-Google-Smtp-Source: ABdhPJzx9497gUCCuXjVKppvJCD58MTyPY2fTfFroIIoNy6WPe2x4ciz2mGcUdzB5bs/z3AmWmiKoCZgMUsZCFoe5pw=
X-Received: by 2002:a92:cf44:: with SMTP id c4mr18007127ilr.207.1610909290701;
 Sun, 17 Jan 2021 10:48:10 -0800 (PST)
MIME-Version: 1.0
References: <20201130184200.5095-1-scott.branden@broadcom.com>
In-Reply-To: <20201130184200.5095-1-scott.branden@broadcom.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Sun, 17 Jan 2021 10:47:59 -0800
Message-ID: <CAOesGMjzUfNOEd4U20sAiyEFkYPai8asAC=kaWHG-PR0XE3pEQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/13] Add Broadcom VK driver
To:     Scott Branden <scott.branden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Desmond Yan <desmond.yan@broadcom.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Broadcom Kernel Feedback List 
        <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 30, 2020 at 10:42 AM Scott Branden
<scott.branden@broadcom.com> wrote:
>
> This patch series drops previous patches in [1]
> that were incorporated by Kees Cook into patch series
> "Introduce partial kernel_read_file() support" [2].
>
> Remaining patches are contained in this series to add Broadcom VK driver.
> (which depends on request_firmware_into_buf API addition which has
> now been accepted into the upstream kernel as of v5.10-rc1).
>
> [1] https://lore.kernel.org/lkml/20200706232309.12010-1-scott.branden@broadcom.com/
> [2] https://lore.kernel.org/lkml/20201002173828.2099543-1-keescook@chromium.org/


I've been following this series for some time, and I think the code is
ready to go in.

Greg, mind queuing this up in the misc tree?

Scott/Greg, feel free to add my Acked-by on the series:

Acked-by: Olof Johansson <olof@lixom.net>


Thanks!

-Olof
