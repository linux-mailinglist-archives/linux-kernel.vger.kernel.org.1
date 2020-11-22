Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987BA2BFBDC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 23:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgKVV6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 16:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgKVV6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 16:58:53 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B5FC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 13:58:53 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id q3so15112617edr.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 13:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iETOeqXGmNqlviqJArheckaE1gU0xbXAL1OaafL93pE=;
        b=qnOAFZ4zDJ7HmZT+alrVLLh6n+AGbEc+kRjpKaY0bZo+a4czr333jnx4AsXgqve74O
         iV8MHAK1xo871+kwgZJEUt2Nt+uI5tXKGHwa9A3Biqt7dEvPKjOTa2Afjvk9phWeoAcb
         u6G4BhwBVxpTHaX4xSYVN0oCMEO+M43OlE1pLkeUZ6OXNV7AcDeBdcHHSU1eNzDzZXAL
         pbuzsrXlM4E8oRODhTRYDZo2y3s6kGLqMsL7RT1k5f3/QddiEjxvHLQXpvrttf83ILp3
         y3JN1nZyDBwZrqzwxw1jN3AI7utDovnkV1bBZ3Kf8cu24opoTbjF2ZrtheqNGISArc7N
         Cz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iETOeqXGmNqlviqJArheckaE1gU0xbXAL1OaafL93pE=;
        b=hwrma55weucU8oQPGc8xmbYJhN10rMshHfjqRWPeXrrADGeYJBXNjegDRcekM1doSz
         R6DEkerghA4hkfmUeV+J5WYfXLjpJV4U14a9vn3UA1zp2vKiwzWFKr65vCs8u51Kv/ts
         jYmT/0C74r09zQK6ezZumVumjkQojoJOL0lzXt0MVD4s7SUeBgWpQZDGyLB/NiJn1b5h
         t5nL+Obe6YeRmeVCZ9kshQ9TZAmkuYOvDe0AOv8KGJEd2u14fr4yd73byqmEZJqIEiSN
         YTPuTtB+UhnU3YRJzWxucXj8I4mzhK49Tln5GeBoM1iofdOZds7slN4gYazO4INJouoW
         i2ow==
X-Gm-Message-State: AOAM531d5kZvp3GzTj31eannVhBr0RoTUJflLJpfCaGLA/4XtdSOblXn
        lsXZP1rPePnX9Sgts+K4XqZuQQ94mnK7Sjb8jvM=
X-Google-Smtp-Source: ABdhPJx8AHTu+8lRjvvsDw1xPAePlr/xWSlw6xqBpALbAeJCssskj+x4w0zb+ZnzJzf2rh+Z8GUYTzUFpgIzLzCg1Ew=
X-Received: by 2002:aa7:c889:: with SMTP id p9mr43326461eds.110.1606082332064;
 Sun, 22 Nov 2020 13:58:52 -0800 (PST)
MIME-Version: 1.0
References: <20201120152131.3918814-1-narmstrong@baylibre.com> <20201120152131.3918814-2-narmstrong@baylibre.com>
In-Reply-To: <20201120152131.3918814-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 22 Nov 2020 22:58:41 +0100
Message-ID: <CAFBinCDSQdKqYBzBTH4GYeUCtChycvALK8X3XHf44qQp=Ed31A@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: meson-axg: add PWRC node
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 4:22 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This adds the power controller PWRC node and the corresponding ethernet power domain.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
