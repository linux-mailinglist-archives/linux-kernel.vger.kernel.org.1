Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1342B248F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 20:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgKMTeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 14:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgKMTet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 14:34:49 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E43C0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 11:34:49 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id ay21so12094094edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 11:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FfDhl4nuyUb6HYPUKcekq3JcuHxWGBlQZla0xXcl2nY=;
        b=V1NkWsgoVDl8+qr4orj3g19djymyEKrOG9kBJDVoL2aIoDvjfrJldK3I0abqrCeTTY
         khFhxaldEPGwhjeCRqZRAsC5f6A09YJdZGHXo9Eq4oLmqyPyjKn0ftTbt3nUnIMqe+3h
         3uEoxB8eOPKRRU7S4UZaqpQfXXC3GOIsPU6xjxZ9uP4kUWT9bmbn86M5rRi10TErSLMk
         XA5FtucBCfUawH4KaWr81u2J0+n41lUbjVKQ1HgYAhnMJLfvPDfCZBNeSRBFAP6wCTZv
         tb71DRNTlg/W2esmabQ8xDw6ZKq0P0R1gvMGapEsDMmM+C4tA87RvfeNmFpmwIVoGc9W
         gulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=FfDhl4nuyUb6HYPUKcekq3JcuHxWGBlQZla0xXcl2nY=;
        b=iagPWbPfnWrusODmx2vLr6Q4A9zzaZAsXNEMoxMrd6c5JuIXRizcIkpLs7cbweSDpz
         hw0GEbcGsN/MXak4xpfecCWLJ9oghubEf4JPjH2150jHUgn7WbUvjR8fkwi92Nn7Db78
         UWq/KPqcG31IhIwUwZ3qST42x38dsQib6RGpEcnQXO2OW6xp6ieO02pzYnnOJNxQbp1n
         9o5IPykcKe5OFTqEcqhY6/aNokhGJWi2DlpoSq+yhnnzsrM+byV1ZKqeiIajRCbPI1gA
         Q9uM4opiXxnGAcbAPKyum4/kks2viWXblcczEvRZgRJSpKSlGVfzQq8lYH6/KNcTJ2Pq
         QSyw==
X-Gm-Message-State: AOAM532aPxwAb/QmQ2LSR3Ok2HLgnr13OiDyzoh3CtEGc95Fr5qGgcOi
        doZPpGEXdndxkfovJb+PwrF2q+mSm0vWOdEtLo8=
X-Google-Smtp-Source: ABdhPJwcfruMf++uaMxQvevTL0gOQ0s+FvZ+UjoHmVAfhQ686uMdqx5+ceow3WNNCSVvo+ClLQIgnOV8R4PY0uIUxnA=
X-Received: by 2002:a50:8acc:: with SMTP id k12mr4251747edk.257.1605296085393;
 Fri, 13 Nov 2020 11:34:45 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab4:a846:0:0:0:0:0 with HTTP; Fri, 13 Nov 2020 11:34:44
 -0800 (PST)
Reply-To: robinsonevelyn997@gmail.com
From:   Evelyn <kouleaboudoulai@gmail.com>
Date:   Fri, 13 Nov 2020 11:34:44 -0800
Message-ID: <CAGz00sorpCL8nQ=6fZRA5o2RbdKwFYXb0fm+H9zHiNK84xv38g@mail.gmail.com>
Subject: =?UTF-8?B?2YXYsdit2KjYpw==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2YXYsdit2KjYpyDYudiy2YrYstmJLiDZg9mK2YEg2K3Yp9mE2YMg2KfZhNmK2YjZhdifINii2YXZ
hCDYo9mGINmK2YPZiNmGINio2K7Zitix2J8g2KfYs9mF2Yog2KXZitmB2YTZitmGLiDYo9iq2YXZ
htmJINij2YYg2KrZg9mI2YYg2YPYsNmE2YMNCtmE2K/ZiiDYudmE2KfZgtipINis2YrYr9ipINmI
2YbYp9i22KzYqSDZhdi52YMuINmI2KPYsdmK2K8g2KPZhiDYo9i02KfYsdmD2YPZhSDYtNmK2KbZ
i9inINmF2YfZhdmL2Kcg2YTZhNi62KfZitipLiDYs9ij2YPZiNmGINmB2YoNCtmB2Yog2KfZhtiq
2LjYp9ix2YPZhSDZgtix2YrYqNmL2Kcg2KXYsNinINmD2YbYqiDZhdmH2KrZhdmL2Kcg2KjZgy4N
Cg==
