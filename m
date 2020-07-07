Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0251216CFC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 14:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgGGMkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 08:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbgGGMkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:40:07 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B479C08C5E0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 05:40:07 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e8so15425407ljb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 05:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gBIdGRLf5Cnr5tv5YyMZkrd+hNTUnC4qnI3yzrVPz4s=;
        b=zZbgmRNEN+Cc2hDtQX4Dm++WQhE8xQ1v3PBJo3ZQkSoPi1uYxkQ0Y29tM+h5uKGgxk
         R8up+SY/8shg5vXKAKBYFVvPefxK3DJU2owMhFJAiPknsu5GBf7xv+NAp6iuN1YwAbbx
         JBrdLrAEF0nsFHEocS3BfUTnMuCiln9uvZrgQ5KcOD8dKfletfW5Zmi66OduL8C1mDfd
         aeR0RB0IEkQNAiVbxOhPycMRNU10M38wRQ3fSm4M7bBoT0G0Q6UUdE/qvQevtWiL0jWp
         lsrncyKGCtDTzWPim/17xR0UDZgms1JWq55rkqAn7E74ohJsp382XEzEAd3ELD1v2jrU
         JtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gBIdGRLf5Cnr5tv5YyMZkrd+hNTUnC4qnI3yzrVPz4s=;
        b=S+kWD4cC/0/bgguvrw4YzEkadc3Wx6yXAiyRarmAEZrC7EJu3t3PY1rYMge8MMrPhe
         VE7qZ9Iou/9x4DB1OgiFMpGEIyBGHxlJwNR1uHD6C/lK+/XabBk0L90GbbbcIursS9B7
         0m1rrUaZ4UNucuYZuuo/KXom973xpBib40vMkRU2AfSGbmWf1Hr4cnRoWOZB7ESlmBT2
         wtWQENvIsZfiereiAhVuvL1yBD3EIqHrQGtgTYqkPAzCP2TbnmRkPt/Gh5Z1ykoYw1+U
         bH1P7IaJTdqggc+Clk2Vfp605uBpnvYm02l63coKYJGGvmEh+zS+W+/bN9IKte4fcmeb
         mD4A==
X-Gm-Message-State: AOAM531yzM9+umsfxBSmSBMyRvDBjSJMTBbED9tqV8ucZkYMv71eAiUC
        BJbOOmoSWd14/h2927yF1AwMuzZvHf+7YEzPp9yP8w==
X-Google-Smtp-Source: ABdhPJxDXru6RgwaBVIBtujonT5DdydJbJILVYEaNJo44eej7MQdGO5rlBUNjRspneYJmwhSKBueSL0fK+zw5ir6UWc=
X-Received: by 2002:a2e:810a:: with SMTP id d10mr24438178ljg.144.1594125605584;
 Tue, 07 Jul 2020 05:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200625064619.2775707-1-lee.jones@linaro.org> <20200625064619.2775707-5-lee.jones@linaro.org>
In-Reply-To: <20200625064619.2775707-5-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jul 2020 14:39:54 +0200
Message-ID: <CACRpkdYPdO94x2dRLgKXioaSi3NbrG_ieDUA00QbdUyhfrCmvg@mail.gmail.com>
Subject: Re: [PATCH 04/10] mfd: db8500-prcmu: Remove incorrect function header
 from .probe() function
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 8:46 AM Lee Jones <lee.jones@linaro.org> wrote:

> Not only is the current header incorrect, the isn't actually a
> need to document the ubiquitous platform probe call.
>
> Cc: <stable@vger.kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
