Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE22245DFD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 09:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgHQHdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 03:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgHQHca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:32:30 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB81C061344
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 00:32:29 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id g19so16657497ioh.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 00:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=coRFPJbKc7ywpJ/3lZow7TORgJ25yZLIlsHXIN7jxzI=;
        b=tNKStXXBprrwJHyJVh8NMGU+XD/0G/4WKH47mbhpwKE5Z6rUlmgshyAEzqbJncPpcU
         rcC87eSlhXpk+Z2a5TSf8ZcQXN8a5uCph2e7RrhB7fIE4V83bm7yahnQ+xyeUVvrUyM4
         lykuFoQpx6RtkQKUW664Zfrx9e63X4S5cxa2kRaMjc4MNWWTPc5c9qOBg7tW+qCx0PNI
         IUkErl6rHI/4UhdfAst2zcAWE4GiNkjw+V40iQLu44pN5lNZQIZ7Atzk9qYEMmkEwl2b
         y9OiDJtGUpzZM6gjZyfua6XC2nvhby0JbCsJx8qg1u/l9qnWHZmPZ5+fjbgsz9E1LTuC
         lgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=coRFPJbKc7ywpJ/3lZow7TORgJ25yZLIlsHXIN7jxzI=;
        b=LctchFDvO5uUxUagZHDtfvxW7HO5f7EVnSxJJZXuxyfMtOEUHF9UYqBl44EsMCZy3W
         1ywutX/t0Op6bF2ye2nan6nnJ2gjS4atYjBCFcb9yEKM4tPw/Dl98i/ZZXx365bZupNZ
         T81ocJ7JA6hfcEO8xzIHEYtkZAvUIEI/sktRF3vGlbVr8oGuHitRrMgMCCXtd+JmfDBv
         1Rj/rHcBwNtjq6KDBlqz32uRjTDiSqAbAOLJiCZVj2axy+/M/oDJOiYq+xFdYKA8AyNY
         4yA8leIfVz47s0TsRrns+JDdMpqnHNW7C91QvQ4z6vd5kQi8rhH1MvMvp6o2Pls7LEL5
         TAVA==
X-Gm-Message-State: AOAM533nkjXCyAz0ovQthCBGJxBtYVut2ivRdmExRUKLG1mQ37wenNKO
        hXQTBy9Y6gdYDp7/GYpLQQcRDuyCKaiqgs6bPJ/V4A==
X-Google-Smtp-Source: ABdhPJyiQfEySyRQED1xZDsTrTIji8ZHp7mV/pCtyczHBll+qmrXXvVx94yMgeUGA+HSb+ucUVNCLkMo9+g8Mg+yu04=
X-Received: by 2002:a5d:8cce:: with SMTP id k14mr11326563iot.13.1597649547058;
 Mon, 17 Aug 2020 00:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <1597644455-8216-1-git-send-email-jiaxin.yu@mediatek.com> <1597644455-8216-2-git-send-email-jiaxin.yu@mediatek.com>
In-Reply-To: <1597644455-8216-2-git-send-email-jiaxin.yu@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Mon, 17 Aug 2020 15:32:15 +0800
Message-ID: <CA+Px+wVFKNLYhYpchR-zmNkxaj2_fVYM_xUt7w73pp+KcNkR3A@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] ASoC: mediatek: mt6359: add codec driver
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, howie.huang@mediatek.com,
        eason.yen@mediatek.com, shane.chien@mediatek.com,
        bicycle.tsai@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 2:08 PM Jiaxin Yu <jiaxin.yu@mediatek.com> wrote:
>
> Add the mt6359 codec driver.
>
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>

LGTM, thanks.
