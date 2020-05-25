Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18D21E0D96
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 13:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390298AbgEYLpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 07:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388696AbgEYLpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 07:45:43 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FBBC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:45:42 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v16so20453664ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bWYfxIAWJy3heGwDbod2HfNErYY2yOdF0+bL0dgrzOk=;
        b=ZGX/K/ApUSKg8rZuZKsuLGDrw3GNIs+G+ygQ5FYxc+f7sdmr6BxHPxN0JBA4xJ4kZX
         fsO+UZPl02rsYbv0Us+s2H+Mg1QHvlXzLhlMSbef8ICm8jdk7PRAc9Zj2ZRZhAJPbd7R
         V2VUKRCs5dKzZKNG1N/cRFLVjTWhH0cxM4jqyhNOXgmpc1BF1R3B6KCHUsLzwvy+o0j+
         sMKKS6i6LBRgYYrDOZpwXc18rqSl3VzFKa/qXE1p6fmvRTbr7DZcN9l+usBvUFUEB2rx
         omrSIACxU0AMJLlSA8O+9sQxDj/yJ/aD2UF6vHu1pteXHE1gO4igJpa6y7K7i5OSXpNU
         fPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWYfxIAWJy3heGwDbod2HfNErYY2yOdF0+bL0dgrzOk=;
        b=osahd4Ml6zhh3BAxgk1jIuYnNugQYyKXca+Vhs30l8Rogsb4hKb3J94XMW3su4p0Vc
         0COmrdkMfgIxckR8Y9buV+UjZUXkvAVn9S30VZFDmAG5tJKGX60qaM2kmsmwkIiE75M2
         MTpRhS4oFYEgX2UUBc1LTlSRdhbodyex60GNFHysKuAWJOESkmgPgrmLdEgJEMqS4TD8
         DD7pwmP0PCVT90H79MwByJCnhuH9I+KfVQzbchuJxB0Te4tTKYSzbomH+RlOLBwfOsdn
         srH6ivuoWnHbiVSpsJ4Kn+JpZk3EDIR9BV+llr9dqqUpo5CJHqX+NhVHveBIDnmKyFhM
         lSlQ==
X-Gm-Message-State: AOAM530ExJBNT01mzGTpIZjRRFf/dM8KHS0vQPyXeA9ds4tq3obQUdrE
        QudmKgVkbs65ZFW4n3jz73Z8M39hM80oAtsQXDyuQg==
X-Google-Smtp-Source: ABdhPJw8cSdCakQSy2dqjj6yyyZN64NworOexXRkNzpRiGe3QJZW72eboLCSuHgq9tN2jx02+4qrZc6d73S0DPYFHwg=
X-Received: by 2002:a2e:8703:: with SMTP id m3mr14359579lji.286.1590407140649;
 Mon, 25 May 2020 04:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200523170859.50003-1-sudeep.holla@arm.com> <20200523170859.50003-4-sudeep.holla@arm.com>
In-Reply-To: <20200523170859.50003-4-sudeep.holla@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 13:45:29 +0200
Message-ID: <CACRpkdadgix8LTvKY41NM5mjVa+YUXkwVcurYn6PnCLTZBnfEg@mail.gmail.com>
Subject: Re: [PATCH 3/8] soc: integrator: Switch to use DEVICE_ATTR_RO()
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 7:09 PM Sudeep Holla <sudeep.holla@arm.com> wrote:

> Move device attributes to DEVICE_ATTR_RO() as that would make things
> a lot more "obvious" what is happening over the existing __ATTR usage.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
