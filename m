Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CF329F8AD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 23:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgJ2WxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 18:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2Ww7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 18:52:59 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2DAC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 15:52:59 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id oq3so4178328ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 15:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SSvtK1seUiofFljm9M7onzJ+bzt6ciiv9yFFnlQSEE0=;
        b=s2I8l58MM4nXPF7o62oC8D5eqTQOHVa1hDHK/9kltWY8pT25wy6ZgVT1OveA3jCW70
         2tLIp+xqA/OENK7Ipj252EOCfWxEDs3hVrbF9Y92NWIp0iygh53lvz4zB4lezJqDog+J
         9Pct5Sa9ED83XXA6cNUv+JUo4J958lsXzejx0TxWe/RCP1EULbxcOR0LcGxMgI7fSkDX
         ktFxBwkYMvgRDQSQ8DQqZ6R2HVAnWPNxg6lN3tZ/hmK+7iEuh7HVZnWkOC4d3AlClLgk
         43OCBnVgLzBAV2IvEyqsduO++O1kZ59xIOeCyhAMP9LussA5gbISPIg8iJVetLton9KK
         tHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SSvtK1seUiofFljm9M7onzJ+bzt6ciiv9yFFnlQSEE0=;
        b=p3vOu/mwnqZH4lRJ7hlV2tG14eS8YhkcuW845A+gNVyrlYwT/oEOQ+VBDxUtttSTJ5
         +LS882kRMftafZKqkmP+fsXtTszEc0u40P8eM5WOJ16J3W3Nauu4Fdwqch4Zb5nw/PIM
         dFHfCY1XzIJuGEjJgRl5m3+NQ/l8MVIgFx8girBq0/Njzo6FwdALNTsmqMzBJmeZeFIw
         upzt0L9UMJ6Rg+Bc+L41nWHPMRBkMQkG+vN6+9KYIoDwvIp0uWeHGGfYy1o1ZeGPf/K7
         t8+909QbvAsD5i2Mgo280GKjycIecnaXi+xAZVfs7YdF1ioUKZI3MEFfYnavB+vEqi4E
         PktA==
X-Gm-Message-State: AOAM530osFRKihcrsLuRrEH2dFoqTSQdkLKe5uHQXIcWAJCn5SKjm1ed
        l5apJq0hi38CUZANstGnM3cU5yjUShMyD/OQgHXm0CWM8Rw=
X-Google-Smtp-Source: ABdhPJzh1EaxywpQ+/weCrp3GQf+7jJvYsDBlJLVC55ylvQjzYrMaePOraUqYSq8btUyo4VO4xJd0eUe9ynUCbjsWbE=
X-Received: by 2002:a17:906:70cf:: with SMTP id g15mr4506466ejk.323.1604011978492;
 Thu, 29 Oct 2020 15:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <87sg9wodp1.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87sg9wodp1.fsf@nanos.tec.linutronix.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 29 Oct 2020 15:52:42 -0700
Message-ID: <CAPcyv4hBSwdDocpgFh2=qbVQN=Mc+15cW4cV5m_S-SxVCYY=mA@mail.gmail.com>
Subject: Re: [Build fail] i386 & nvdimm is unhappy
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 3:44 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Dan,
>
> x86 32bit build fails with the config below with this:
>
>   ERROR: modpost: "phys_to_target_node" [drivers/nvdimm/nd_e820.ko]
>   undefined!

Acknowledged, I'm on it.

Wonder how 0-day missed this or I missed the 0-day report?
