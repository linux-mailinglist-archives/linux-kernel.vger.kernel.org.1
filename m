Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCC82CCB91
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 02:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgLCBTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 20:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbgLCBTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 20:19:23 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487A3C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 17:18:43 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id h6so372511vsr.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 17:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kGk3UCp1Tf4kBKun3QYINFGXC5lQ2C20tiUmNqsliQI=;
        b=QGvcq9ZS60K1/tvzfFsr0sIX96WndOSuY5t/NDgPmEh35ubHpo5RQU0J6Agu/Vp23o
         jTWOMypKzClaq9aGZKscHQAeOHzbhd0B7eKTp8xGIDeRzr81NDb6kR1ISR9KLZN0rcaA
         A5K3yHQTgWkpfeNBBHjhepRO41sKVd2GZtbZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kGk3UCp1Tf4kBKun3QYINFGXC5lQ2C20tiUmNqsliQI=;
        b=p6M7hCZ6Z8Zf7OBtMlpuNFVQ3dUV46P8xivbYXbK4cxoJWBJ/Hiw7/epn8QPj5ShFU
         2t8cO2VlQGH+2ge9gf3u34lRjKOKiWPqXg4vxXhk5SsDa/O8yQCb7IcAql9NHDmZ/hHb
         6y+egzOq+ea45uVjlO0QNp/FiSBZc6I9hlE3sVAFTdHs/DUqMG+1kYb69xVI4ZWHPKyB
         K+KIK6ZK8vIPpweQcLtlKsw9cL+qls4c2UadTr7fiEYlwkvFhBYsN5DmaLSKwgPrGki6
         Vu7FSF0WzSMzfMUI5dvfYarFkcaUHEaKb8ixnJtHMLp5k15x6Ld63WCC21G41Rww39/C
         RZ2Q==
X-Gm-Message-State: AOAM532jCD1yrGSAjmaY96XR8YileEBkxf/zY0mnyfmYFhbvBS5cu20z
        438HQtv7tlFp0Wjn1/MNTjAIb1y/XiRlog==
X-Google-Smtp-Source: ABdhPJyt+OkspOOEQHw3Kt/InDN2p8JSaAhyUZTuqwFVxALEUwkMsa6nWCqWH/DwzOzD/SxPpCHd7g==
X-Received: by 2002:a67:2907:: with SMTP id p7mr756268vsp.21.1606958319628;
        Wed, 02 Dec 2020 17:18:39 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id 6sm41126uac.10.2020.12.02.17.18.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 17:18:38 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id u7so355753vsq.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 17:18:38 -0800 (PST)
X-Received: by 2002:a05:6102:21c4:: with SMTP id r4mr745450vsg.37.1606958318382;
 Wed, 02 Dec 2020 17:18:38 -0800 (PST)
MIME-Version: 1.0
References: <20201203011649.1405292-1-swboyd@chromium.org> <20201203011649.1405292-3-swboyd@chromium.org>
In-Reply-To: <20201203011649.1405292-3-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 2 Dec 2020 17:18:26 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XyDT=Z_nNYwPKr6RrNrrdGNMAKRWcd0tXxdb3wW2zK0g@mail.gmail.com>
Message-ID: <CAD=FV=XyDT=Z_nNYwPKr6RrNrrdGNMAKRWcd0tXxdb3wW2zK0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_spi: Drop bits_per_word assignment
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Simon Glass <sjg@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 2, 2020 at 5:16 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This is already handed by default in spi_setup() if the bits_per_word is
> 0, so just drop it to shave off a line.
>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_spi.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
