Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B552C0140
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 09:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgKWITG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 03:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgKWITG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 03:19:06 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20082C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 00:19:06 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id m65so12757780qte.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 00:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d34JGaM1ueBD2F2F6axmebzq/GoYrIAB04I9Xtt5E5U=;
        b=go00I6YEpq3e+ILhuooBc9PUESyoBmrGkYrh5//GgDgf3S0f1U/GgL1B2gVdu9ojLn
         /wdaBETB0WoAdvqlGWDm4Z4eq+5z0s/qOUdHB5k1n/hU0Cmo0M2q0MSjCwyUYtEFNMUB
         A2CCYutGMK2Ip31HSUaP/xpxuzHQYXiDGDrxqSSMQD8gh+7/Is6gcMBHiI4oXrXET4G7
         MLm0twQjgZr08AvRKyPk1CxTrMQBK9t9EBJoocvFJNx9sy4QL13xznjfTXEp5hm/ILRt
         DDli0y72PXV+6jbPJIyz/qTcDuUpdwPczYewhDIj0oiE3zcTE5TlLuohWN8J5hmESDFS
         zw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d34JGaM1ueBD2F2F6axmebzq/GoYrIAB04I9Xtt5E5U=;
        b=OZT6O36enbkjCrD4RcqR6NMrz0W+mc65Ff+KEsZu3txB/ZooLVrfkOlmARjO921nDx
         7YNaOEB9uqNtEIWBRKHLce/Rc1MenhmbjboM/U005DsaN+av7h/AoZ4ND1ih67/N1EEm
         zrsn72oHfNnsrdnS0D+u79+q2k1fz4T8SF4ESR+nkRhLhztqpzUeqap/bAEAYIsYo6Iu
         GMI1M7zFRrxYbqFWBc4CWbU1SoPt3KeibPiUr8xO+Jet+QUxOic3fwEjC5lmFa1sxePy
         ePXHH1QMfzY5gkk7oh3xVtGvLQnKkAPve5R+LWrYPSKFwj8kbkNG9T/b5dPT6TLAU1NM
         m2RA==
X-Gm-Message-State: AOAM530SkA1kgRES52rK+W6R/5DQrN11lZM7zDoQ6dH90ZDWO4qCtbMZ
        ZaUX3FxeC0vI7Oqv+/Cg0XimFt/CKirTmtk4gGQ=
X-Google-Smtp-Source: ABdhPJwALaFQo0lBpGaC93Fwp9tKYrp5lWlwAtXbXrPN9LXwJT979t8mW9Zcnmy/UeGZQx/m6GgvHMwtgvpej5P7LFY=
X-Received: by 2002:ac8:6c49:: with SMTP id z9mr9209534qtu.82.1606119545439;
 Mon, 23 Nov 2020 00:19:05 -0800 (PST)
MIME-Version: 1.0
References: <20201014065443.18512-2-lizhe67@huawei.com> <20201119025050.38472-1-lizhe67@huawei.com>
In-Reply-To: <20201119025050.38472-1-lizhe67@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 23 Nov 2020 09:18:53 +0100
Message-ID: <CAFLxGvzkzM770a+YufAw_o6viY47x7aB3unmHVWfjCd797LubA@mail.gmail.com>
Subject: Re: [PATCH 2/2] jffs2: fix can't set rp_size to zero during remounting
To:     Zhe Li <lizhe67@huawei.com>
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>, qiuxi1@huawei.com,
        zhongjubin@huawei.com, LKML <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org, wangfangpeng1@huawei.com,
        chenjie6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 3:59 AM Zhe Li <lizhe67@huawei.com> wrote:
>
> Maintainer ping?

Didn't I reply to this series?
/me double checks sent folder.

-- 
Thanks,
//richard
