Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C342BFBDA
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 22:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgKVVzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 16:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgKVVzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 16:55:48 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A348DC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 13:55:48 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id lv15so14766755ejb.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 13:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NglbjUg/AZr0OKAOaLT2UcZf0xk/vqD/qRJfSLaWvVE=;
        b=o5oORT9CjWoHe0l8ljN9fk2iM6wBRJ702OjZ5frGuSktu17e1p4/Krme2ijOP5UJpZ
         LK9kbaGXvqfwwhav2ILI9dwQZwt0UwvJ785EZ6dAJZU98xjmcJfj5uKisPy/xMg5HlTe
         7+JIVZo3zIV+6S/sR1+1RePvwz+KXilG65pBrnmdkFeU9cYamw2mwlOcCQ47dyamcwvP
         S6t60bqk+m4huHpGoPS4JQH/j9wqyvTJQF3WBm5MGYPUwTxPCihnLIqKVdpe/3JDnX5N
         +YRhvKun1alXweBqckz8zOoM2Bd3noJzALJ0gSt1kaXcpoaxiG/sArVpKJ/JAI/bA4PM
         22Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NglbjUg/AZr0OKAOaLT2UcZf0xk/vqD/qRJfSLaWvVE=;
        b=KS3aoG5XS5KOTmoi8v04+UBSgmnH3zng4YngNu+8ffnDREc7kU8tP0xabRJxBAZFOu
         a9Q0vS/C3Hs4/WGKNrKrZuEh2O+f57rlovCrpiWPzdc7P6g466nLnmKh2Wg1lZqe83Nw
         6NFl7jHYa8aKIHeBvd/KR8pR3YcuY2J4L4SFptnDk4zvCZT3i0PP5KD6lfzGAokYpFir
         oWVFAfw8kWu3zoTNvMAXZgs/58mZrvygw3X24ozSc2nAeytrTWBZhgDR49WlaCcA2siv
         BGfdSwW8GgZ8Wdu8aY2qI7Ja0M+2W4vSSMM4+pA5jIZGYRZt3SFYAUBAldRgoeYsgqqa
         BmnQ==
X-Gm-Message-State: AOAM530c4UHRe9cMNxMFb1yfL6K4SNHelrGX/Qw6OM48dCWvMgLRANmn
        LeA3lFXnSTVFTkskmz7a8lA1zs8frOO/nfZsm1vFnfSv9YI=
X-Google-Smtp-Source: ABdhPJzqvbKWp6V/2RVgyExg8QSPIjfWuWLg8UIZPsai9ug5Gk7t77urciW9g1x8tFey+54aK4TStfYxNHjRniuVt/E=
X-Received: by 2002:a17:906:c821:: with SMTP id dd1mr10384090ejb.216.1606082147377;
 Sun, 22 Nov 2020 13:55:47 -0800 (PST)
MIME-Version: 1.0
References: <1605667700-16681-1-git-send-email-yejune.deng@gmail.com>
In-Reply-To: <1605667700-16681-1-git-send-email-yejune.deng@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 22 Nov 2020 22:55:36 +0100
Message-ID: <CAFBinCDYOutJ+kDuEP_9GkqjRo0=TLOHCdVnZwR5N=NZ4PmLyA@mail.gmail.com>
Subject: Re: [PATCH] soc: amlogic: replace devm_reset_control_array_get()
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     khilman@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>,
        jbrunet@baylibre.com, p.zabel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 3:48 AM Yejune Deng <yejune.deng@gmail.com> wrote:
>
> devm_reset_control_array_get_exclusive() looks more readable
>
> Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
