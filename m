Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50F82074AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 15:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403957AbgFXNf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 09:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389340AbgFXNfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:35:25 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD707C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:35:25 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id e11so1792427qkm.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uoB5KRg8W/rBRcPeqsiq1sK8kQ9m+x8MqUPbKiljmN8=;
        b=t76J2RYq2Dx/47ov0cp/ejT2Jku1fjola5lzE/ns2ysQgYuCsTT2YsGjuvwZSnYmY+
         VlWe33fmd6fX4fU+7fHPfboDhr8QZUngK00aMNmMCD12ouOsn6tjZWbCPvH6B3+DHBZh
         7gSDtuC3dtd5UmiZLeZDZwpLm/z1xGgL83NYC4EElcO8jVWCCBO+VwaAlZgADZV0Gncr
         SZmnKCsmf3A+HbTOMPtIwb9gHIcIwLnAlxOeuCU6pszxXnxUG/Uan0wKSxqZpps5d7FL
         qc8B8/W1CRuuOI6dtqQ5D9zT3GszRyT6zqoMRVJmZvDt3qBi0uiIEyXy/xpB5kq0RCch
         aT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uoB5KRg8W/rBRcPeqsiq1sK8kQ9m+x8MqUPbKiljmN8=;
        b=PHB7jVMKw1WR0QOcjm0k9KuGs22vyd/PFPsmvvPr0ftEDZiyzvvsnSw19+aNFqpCim
         JHF+QguVz8TsR2i2+X1JjrCSMPH4ZMTlAa6gh/dYq3PTr608iKcFHpPbvqECHWD5FDua
         KiAXrxW3O6xjnG+jczYFmYlwlv3vdz5lEbUBW58nmIAtHnHh52lbmbDINwZXuPGBDzqa
         ueh1vweTtNz1RYSfzh7241IwJCSGHIA7e0Us/nn+wqVGfjQX6WEF+GaqeETxSY8SFxAd
         r50z8/hQd+tp2BmxrM8WXUiBcuJlBPZ5Le8iyFqWk+Rn/z7AnabfPjN4mx+pnnyV4Uhw
         dBBw==
X-Gm-Message-State: AOAM533XzZ16RN8aVVmPxeZSB+FkahwIAHRWQ+6f1X7+t0qkwZ2skIQB
        tO0AAaf7QlnM8G88pWM7aztW91Wb8zYKwD3tQqCpww==
X-Google-Smtp-Source: ABdhPJzH0vNujZ5a8J2Gcx/MQZIyLmMeSxc+A6oWIpdxHR5THIHAnBK89llEzaTrgezwlk7kMbfrNdHgbPohpeTah44=
X-Received: by 2002:a37:9c81:: with SMTP id f123mr1842421qke.21.1593005725127;
 Wed, 24 Jun 2020 06:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200623040107.22270-1-warthog618@gmail.com> <20200623040107.22270-4-warthog618@gmail.com>
In-Reply-To: <20200623040107.22270-4-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 24 Jun 2020 15:35:14 +0200
Message-ID: <CAMpxmJWL984EOyjJ9eDA=2RH0hFxcFjgRGkF51GFP649d9A4tQ@mail.gmail.com>
Subject: Re: [PATCH 03/22] gpiolib: cdev: minor indentation fixes
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 23 cze 2020 o 06:02 Kent Gibson <warthog618@gmail.com> napisa=C5=82(a)=
:
>
> Make indentation consistent with other use to improve readability.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
