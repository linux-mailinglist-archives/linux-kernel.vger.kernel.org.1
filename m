Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B908D275727
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 13:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIWL35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 07:29:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41819 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgIWL35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 07:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600860596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=puu3LR6PBVkJbaIlQWrIFXp+CHL9X+avvkTO38uPYuA=;
        b=EZ7OhJZhlTYZg3IoNnQGLg+QOThwXG8zJCD2OItgOuQeTBgH+5Pa/H9OqWI0xSradgO58x
        HAx3IqmyMXrGMrYnqw0CaWf0I3A++ytPdC7/Lr6mo9pKvx4DxnGN0Je+uFQVq3Y3ltZ3g0
        NIx5OKvHl7fMvhf5DrY+tg8eGKWeaTA=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-YO8HwCvvO7KsPI3zoDa1KQ-1; Wed, 23 Sep 2020 07:29:54 -0400
X-MC-Unique: YO8HwCvvO7KsPI3zoDa1KQ-1
Received: by mail-oo1-f71.google.com with SMTP id a21so10172708oos.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 04:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=puu3LR6PBVkJbaIlQWrIFXp+CHL9X+avvkTO38uPYuA=;
        b=TNBMAHm3vrDRxf7w8saXiPuluqce9xb/rkLMpL1WmT86fHZgLdQXXsiMnmjsSQ5m6N
         c1+2VsDB8ncWuWGfL/F1mvUa292JO1C5Zm6DrLkOtZRP3wLgZoRSYeCkZie2UCzspDYV
         ReWTUJpTvC35cFhnool9tITBGN1Z2X0ubnP2NHv88Keu1uvFNSeuJBEFLJNBTXHaLSi9
         a5TVt7aBryirORpQi0bibGtksA3EjoM1Ze9VWnlXLEcgbdvlxYOdpZU5RtsfnbK7tYQo
         72e6xm0NaS++KItmu+fR7L4ZIRXAP5Z8qM0VVTxBbnm993v6M8IRZZqOu9sZYV4bDhkM
         CgWw==
X-Gm-Message-State: AOAM531UPZhQMNMmlbt3mhoCzj8ZfMJqBtVVl2gGamOwxMlEe+kdbfwD
        ZWjnP83msdhOWj+n6ZTGlpZeUjCRY+rSp5Hu+V1FGQpF9byDPDm6Y0v8nz0DFSpSFmZQistQ3mx
        uhVz6QJnEqWtY1xZm+CGcwCwKS39IPkPwGVDY3Aqs
X-Received: by 2002:a9d:3ca:: with SMTP id f68mr5367788otf.330.1600860593957;
        Wed, 23 Sep 2020 04:29:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpHbmO/24vw0t0dO0Z48Fo9ja7x9xin6XTNYYbw55FKRewu8qtDKfTiW2oZqiFX3+OgoxgQGeq71niS4pG3qE=
X-Received: by 2002:a9d:3ca:: with SMTP id f68mr5367775otf.330.1600860593748;
 Wed, 23 Sep 2020 04:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200922133731.33478-5-jarod@redhat.com> <20200923041337.GA29158@0b758a8b4a67>
In-Reply-To: <20200923041337.GA29158@0b758a8b4a67>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Wed, 23 Sep 2020 07:29:43 -0400
Message-ID: <CAKfmpScApsp7MXRdHS=V3LFVaJTPrhL7qmb4J_EKH=8KVDh-rA@mail.gmail.com>
Subject: Re: [RFC PATCH] bonding: linkdesc can be static
To:     kernel test robot <lkp@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kbuild-all@lists.01.org,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Thomas Davis <tadavis@lbl.gov>, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 12:15 AM kernel test robot <lkp@intel.com> wrote:
>
> Signed-off-by: kernel test robot <lkp@intel.com>
> ---
>  bond_procfs.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond_procfs.c
> index 91ece68607b23..9b1b37a682728 100644
> --- a/drivers/net/bonding/bond_procfs.c
> +++ b/drivers/net/bonding/bond_procfs.c
> @@ -8,7 +8,7 @@
>  #include "bonding_priv.h"
>
>  #ifdef CONFIG_BONDING_LEGACY_INTERFACES
> -const char *linkdesc = "Slave";
> +static const char *linkdesc = "Slave";
>  #else
>  const char *linkdesc = "Link";
>  #endif

Good attempt, robot, but you missed the #else. Will fold a full
version into my set.

-- 
Jarod Wilson
jarod@redhat.com

