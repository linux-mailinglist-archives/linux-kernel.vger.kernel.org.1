Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC86220252
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 04:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgGOC20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 22:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgGOC2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:28:25 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A47CC08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:28:25 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id by13so430527edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NzQjEy96mwvK5RqK1HselxgI2oA5I911Qdx2GNiQhg0=;
        b=pd8yJsIzUV+lmtpXyBfCDr7n3+H80zSFriHlcIPUQEshJKvvGy7eE8F14z2Me5kfma
         VchPpX69Esx3VqPLBaPtWBzKR87WMmuAAWVk6Zxbb59t8akiJqxXSK2gY6bFjn29yKdB
         u5gQKb2NXD0jidguQUC5MRpGj0zHsrpcgQuBsGynE5bZ8s9cVj6Q8jAbJceW4ZopqgQo
         IvkF1Gx536gA5Y4BkC0O7XTgAUc4PVIK4icnKvo1lQlDCDz3x4NjAf2shtmOTNMFbH8c
         +IGUMuuj3R2wNaCqM1RuDMeE1vo+SB1yNukyNP1BaeyfimEuy9EkvDvAtPydf4lgXJ5S
         7CCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NzQjEy96mwvK5RqK1HselxgI2oA5I911Qdx2GNiQhg0=;
        b=NcCl3h/oSB17DHqvyBj3Wn5gu4ZFjqf1DQCLWq0TE1lDdSyfzNQW88Q4v9aa8kuWW/
         6EJ8dlUJsfI/4AgNDi83H6WkaY68P8m6uiHZvZbVX4SFGLZQBPY7cpYok7n7JoTKMQJK
         ZGm8HBmZJFn2MG2SHnuufSUihsU5lfAPKTKIBy/a6PsGFV2FVSaPDFEKxHm+p5Cz67qI
         bI72wtOpI77uMXGDMWmmLQHPA+4RWCMB7faiqgjFk9moYCOlIccrF6v0diJ1ttv9hJiM
         KVvwSz7l2Cn8gOzMQkDlN219P9swwMM1qvNBO+ws0orNYmZ2FLLP6fbewSfjPEDg39xo
         2D2g==
X-Gm-Message-State: AOAM531igJjZE9lS09/wiw1SxYyDGrRqtsztWJWPOXpFpAtEk99vkQSN
        FAztoRj2QZm5DAnxgUhuyU4w940ozD7UyzVxzOg/Rqc=
X-Google-Smtp-Source: ABdhPJwC+iS+MYu3jbSKussTXFfhjkiopLyiCmfWTihVgPblMmDRROS4S+1ydwyZ0bTIgA2yjuH02BgGUJUMI4Q0zDU=
X-Received: by 2002:a05:6402:742:: with SMTP id p2mr7142885edy.135.1594780103839;
 Tue, 14 Jul 2020 19:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200715021846.34096-1-yuehaibing@huawei.com>
In-Reply-To: <20200715021846.34096-1-yuehaibing@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Jul 2020 22:28:12 -0400
Message-ID: <CAHC9VhTPhtx-t7_WucUyKg=y1g_0OiFFs1RdvfuixOUoytWmvA@mail.gmail.com>
Subject: Re: [PATCH net-next] cipso: Remove unused inline functions
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 10:21 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> They are not used any more since commit b1edeb102397 ("netlabel: Replace
> protocol/NetLabel linking with refrerence counts")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/net/cipso_ipv4.h | 12 ------------
>  1 file changed, 12 deletions(-)

Looks good to me, thanks for the patch.

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
